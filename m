Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CE231AB7E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 14:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhBMNCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 08:02:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56725 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhBMNBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 08:01:50 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lAuXb-0005ES-Hm; Sat, 13 Feb 2021 13:00:51 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] idmapped mounts for v5.12
Date:   Sat, 13 Feb 2021 14:00:42 +0100
Message-Id: <20210213130042.828076-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
This patch series introduces idmapped mounts which has been in the making for
some time. Simply put, different mounts can expose the same file or directory
with different ownership. This initial implementation comes with ports for fat,
ext4 and with Christoph's port for xfs with more filesystems being actively
worked on by independent people and maintainers.

Idmapping mounts handle a wide range of long standing use-cases.
Here are just a few:
- Idmapped mounts make it possible to easily share files between multiple users
  or multiple machines especially in complex scenarios. For example, idmapped
  mounts will be used in the implementation of portable home directories in
  systemd-homed.service(8) where they allow users to move their home directory
  to an external storage device and use it on multiple computers where they are
  assigned different uids and gids. This effectively makes it possible to
  assign random uids and gids at login time.
- It is possible to share files from the host with unprivileged containers
  without having to change ownership permanently through chown(2).
- It is possible to idmap a container's rootfs and without having to mangle
  every file. For example, Chromebooks use it to share the user's Download
  folder with their unprivileged containers in their Linux subsystem.
- It is possible to share files between containers with non-overlapping
  idmappings.
- Filesystem that lack a proper concept of ownership such as fat can use
  idmapped mounts to implement discretionary access (DAC) permission checking.
- They allow users to efficiently changing ownership on a per-mount basis
  without having to (recursively) chown(2) all files. In contrast to chown
  (2) changing ownership of large sets of files is instantenous with idmapped
  mounts. This is especially useful when ownership of a whole root filesystem
  of a virtual machine or container is changed. With idmapped mounts a single
  syscall mount_setattr syscall will be sufficient to change the ownership of
  all files.
- Idmapped mounts always take the current ownership into account as idmappings
  specify what a given uid or gid is supposed to be mapped to. This contrasts
  with the chown(2) syscall which cannot by itself take the current ownership
  of the files it changes into account. It simply changes the ownership to the
  specified uid and gid. This is especially problematic when recursively
  chown(2)ing a large set of files which is commong with the aforementioned
  portable home directory and container and vm scenario.
- Idmapped mounts allow to change ownership locally, restricting it to
  specific mounts, and temporarily as the ownership changes only apply as long
  as the mount exists.

Several userspace projects have either already put up patches and pull-requests
for this feature or will do so should you decide to pull this:
- systemd: In a wide variety of scenarios but especially right away in their
  implementation of portable home directories.
  https://systemd.io/HOME_DIRECTORY/
- container runtimes: containerd, runC, LXD:To share data between host and
  unprivileged containers, unprivileged and privileged containers, etc.
  The pull request for idmapped mounts support in containerd, the default
  Kubernetes runtime is already up for quite a while now:
  https://github.com/containerd/containerd/pull/4734
- The virtio-fs developers and several users have expressed interest in using
  this feature with virtual machines once virtio-fs is ported.
- ChromeOS: Sharing host-directories with unprivileged containers.
I've tightly synced with all those projects and all of those listed here have
also expressed their need/desire for this feature on the mailing list.
For more info on how people use this there's a bunch of talks about this too.
Here's just two recent ones:
https://www.cncf.io/wp-content/uploads/2020/12/Rootless-Containers-in-Gitpod.pdf
https://fosdem.org/2021/schedule/event/containers_idmap/

This series comes with an extensive xfstests suite covering both ext4 and xfs
https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
It covers truncation, creation, opening, xattrs, vfscaps, setid execution,
setgid inheritance and more both with idmapped and non-idmapped mounts.
It already helped to discover an unrelated xfs setgid inheritance bug which has
since been fixed in mainline. It will be sent for inclusion with the xfstests
project should you decide to merge this. 

In order to support per-mount idmappings vfsmounts are marked with user
namespaces. The idmapping of the user namespace will be used to map the
ids of vfs objects when they are accessed through that mount. By default
all vfsmounts are marked with the initial user namespace. The initial
user namespace is used to indicate that a mount is not idmapped. All
operations behave as before and this is verified in the testsuite.

Based on prior discussions we want to attach the whole user namespace
and not just a dedicated idmapping struct. This allows us to reuse all
the helpers that already exist for dealing with idmappings instead of
introducing a whole new range of helpers. In addition, if we decide in
the future that we are confident enough to enable unprivileged users to
setup idmapped mounts the permission checking can take into account
whether the caller is privileged in the user namespace the mount is
currently marked with.

The user namespace the mount will be marked with can be specified by passing a
file descriptor refering to the user namespace as an argument to the new
mount_setattr() syscall together with the new MOUNT_ATTR_IDMAP flag. The system
call follows the openat2() pattern of extensibility. The following conditions
must be met in order to create an idmapped mount:
- The caller must currently have the CAP_SYS_ADMIN capability in the user
  namespace the underlying filesystem has been mounted in.
- The underlying filesystem must support idmapped mounts.
- The mount must not already be idmapped. This also implies that the idmapping
  of a mount cannot be altered once it has been idmapped.
- The mount must be a detached/anonymous mount, i.e. it must have been created
  by calling open_tree() with the OPEN_TREE_CLONE flag and it must not already
  have been visible in the filesystem.
The last two points guarantee easier semantics for userspace and the kernel and
make the implementation significantly simpler.
By default vfsmounts are marked with the initial user namespace and no
behavioral or performance changes are observed.
The manpage with a detailed description can be found here:
https://git.kernel.org/brauner/man-pages/c/1d7b902e2875a1ff342e036a9f866a995640aea8

In order to support idmapped mounts, filesystems need to be changed and
mark themselves with the FS_ALLOW_IDMAP flag in fs_flags. The patches to
convert individual filesystem are not very large or complicated overall as can
be seen from the included fat, ext4, and xfs ports. Patches for other
filesystems are actively worked on and will be sent out separately. The
xfstestsuite can be used to verify that port has been done correctly.

The mount_setattr() syscall is motivated independent of the idmapped mounts
patches and it's been around since July 2019. One of the most valuable features
of the new mount api is the ability to perform mounts based on file descriptors
only. Together with the lookup restrictions available in the openat2()
RESOLVE_* flag namespace which we added in v5.6 this is the first time we are
close to hardened and race-free (e.g. symlinks) mounting and path resolution.
While userspace has started porting to the new mount api to mount proper
filesystems and create new bind-mounts it is currently not possible to change
mount options of an already existing bind mount in the new mount api since the
mount_setattr() syscall is missing. With the addition of the mount_setattr()
syscall we remove this last restriction and userspace can now fully port to the
new mount api, covering every use-case the old mount api could. We also add the
crucial ability to recursively change mount options for a whole mount tree,
both removing and adding mount options at the same time. This syscall has been
requested multiple times by various people and projects.

There is a simple tool available at
https://github.com/brauner/mount-idmapped that allows to create idmapped
mounts so people can play with this patch series. I'll add support for the
regular mount binary should you decide to pull this in the following weeks:

Here's an example to a simple idmapped mount of another user's home directory

u1001@f2-vm:/$ sudo ./mount --idmap both:1000:1001:1 /home/ubuntu/ /mnt

u1001@f2-vm:/$ ls -al /home/ubuntu/
total 28
drwxr-xr-x 2 ubuntu ubuntu 4096 Oct 28 22:07 .
drwxr-xr-x 4 root   root   4096 Oct 28 04:00 ..
-rw------- 1 ubuntu ubuntu 3154 Oct 28 22:12 .bash_history
-rw-r--r-- 1 ubuntu ubuntu  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 ubuntu ubuntu 3771 Feb 25  2020 .bashrc
-rw-r--r-- 1 ubuntu ubuntu  807 Feb 25  2020 .profile
-rw-r--r-- 1 ubuntu ubuntu    0 Oct 16 16:11 .sudo_as_admin_successful
-rw------- 1 ubuntu ubuntu 1144 Oct 28 00:43 .viminfo

u1001@f2-vm:/$ ls -al /mnt/
total 28
drwxr-xr-x  2 u1001 u1001 4096 Oct 28 22:07 .
drwxr-xr-x 29 root  root  4096 Oct 28 22:01 ..
-rw-------  1 u1001 u1001 3154 Oct 28 22:12 .bash_history
-rw-r--r--  1 u1001 u1001  220 Feb 25  2020 .bash_logout
-rw-r--r--  1 u1001 u1001 3771 Feb 25  2020 .bashrc
-rw-r--r--  1 u1001 u1001  807 Feb 25  2020 .profile
-rw-r--r--  1 u1001 u1001    0 Oct 16 16:11 .sudo_as_admin_successful
-rw-------  1 u1001 u1001 1144 Oct 28 00:43 .viminfo

u1001@f2-vm:/$ touch /mnt/my-file

u1001@f2-vm:/$ setfacl -m u:1001:rwx /mnt/my-file

u1001@f2-vm:/$ sudo setcap -n 1001 cap_net_raw+ep /mnt/my-file

u1001@f2-vm:/$ ls -al /mnt/my-file
-rw-rwxr--+ 1 u1001 u1001 0 Oct 28 22:14 /mnt/my-file

u1001@f2-vm:/$ ls -al /home/ubuntu/my-file
-rw-rwxr--+ 1 ubuntu ubuntu 0 Oct 28 22:14 /home/ubuntu/my-file

u1001@f2-vm:/$ getfacl /mnt/my-file
getfacl: Removing leading '/' from absolute path names
# file: mnt/my-file
# owner: u1001
# group: u1001
user::rw-
user:u1001:rwx
group::rw-
mask::rwx
other::r--

u1001@f2-vm:/$ getfacl /home/ubuntu/my-file
getfacl: Removing leading '/' from absolute path names
# file: home/ubuntu/my-file
# owner: ubuntu
# group: ubuntu
user::rw-
user:ubuntu:rwx
group::rw-
mask::rwx
other::r--

/* Testing */
1. linux-next:
   All patches are based on v5.11-rc4 and have been sitting in linux-next. For
   each linux-next release that Stephen did I built a new kernel, ran the
   xfstests suite for idmapped mounts and verified that things were passing and
   no regressions could be observed.
   (A __huge__ thank you to Stephen Rothwell for taking care of this series in
    next and for helping me to keep track of merge conflicts!)
   There's one commit from Christoph that I took into my tree 9 days ago which
   fixes a build warning in xfs that resulted from Christoph's ioctl rework
   when BROKEN_X86_ALIGNMENT is defined.

2. xfstests suite:
   The series comes with a large xfstests suite that verifies that nothing is
   regressed and that the semantics for idmapped mounts are expected.
   https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
   It has been sent out together with this series and will be sent for
   inclusion with xfstests-dev should you decide to pull this.

3. selftests:
   The series also comes with a testsuite to verify the semantics of the new
   mount_setattr() syscall.

4. syzkaller:
   A pull-request against syzkaller already exists to fuzz the new features.
   The pull request can be found here:
   https://github.com/google/syzkaller/pull/2411
   and will be merged should you decide to pull this.

5. kbuild did an allmodconfig build for all architectures without any failures.

/* Conflicts */
The series has a few merge conflicts which I list with all their resolutions
below. Most of them should hopefully be straightforward since they just involve
making sure that conflicting changes pass down the mount's user namespace.

In addition to listing all resolutions here I also prepared a branch and tag at
git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/idmapped-mounts-merged-v5.12
which has all conflicting branches merged in and the merge conflicts resolved
in case you want to make use of that. It only misses Andrew's akpm-current
quilt series.

Here are all the merge conflicts I'm aware of and their resolutions. I tested
each resolution by creating a new build and running all the xfstests and
selftests this branch comes with:

######## git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.11-rc7

diff --cc fs/ecryptfs/inode.c
index 55da9a91f51a,58d0f7187997..000000000000
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@@ -1043,10 -1024,11 +1045,12 @@@ ecryptfs_setxattr(struct dentry *dentry
  		rc = -EOPNOTSUPP;
  		goto out;
  	}
- 	rc = vfs_setxattr(&init_user_ns, lower_dentry, name, value, size,
- 			  flags);
+ 	inode_lock(lower_inode);
 -	rc = __vfs_setxattr_locked(lower_dentry, name, value, size, flags, NULL);
++	rc = __vfs_setxattr_locked(&init_user_ns, lower_dentry, name, value,
++				   size, flags, NULL);
+ 	inode_unlock(lower_inode);
  	if (!rc && inode)
- 		fsstack_copy_attr_all(inode, d_inode(lower_dentry));
+ 		fsstack_copy_attr_all(inode, lower_inode);
  out:
  	return rc;
  }
diff --cc fs/overlayfs/copy_up.c
index f81b836c2256,0fed532efa68..000000000000
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@@ -84,10 -84,18 +84,18 @@@ int ovl_copy_xattr(struct super_block *
  
  		if (ovl_is_private_xattr(sb, name))
  			continue;
+ 
+ 		error = security_inode_copy_up_xattr(name);
+ 		if (error < 0 && error != -EOPNOTSUPP)
+ 			break;
+ 		if (error == 1) {
+ 			error = 0;
+ 			continue; /* Discard */
+ 		}
  retry:
 -		size = vfs_getxattr(old, name, value, value_size);
 +		size = vfs_getxattr(&init_user_ns, old, name, value, value_size);
  		if (size == -ERANGE)
 -			size = vfs_getxattr(old, name, NULL, 0);
 +			size = vfs_getxattr(&init_user_ns, old, name, NULL, 0);
  
  		if (size < 0) {
  			error = size;
@@@ -107,14 -115,7 +115,7 @@@
  			goto retry;
  		}
  
- 		error = security_inode_copy_up_xattr(name);
- 		if (error < 0 && error != -EOPNOTSUPP)
- 			break;
- 		if (error == 1) {
- 			error = 0;
- 			continue; /* Discard */
- 		}
 -		error = vfs_setxattr(new, name, value, size, 0);
 +		error = vfs_setxattr(&init_user_ns, new, name, value, size, 0);
  		if (error) {
  			if (error != -EOPNOTSUPP || ovl_must_copy_xattr(name))
  				break;
diff --cc fs/overlayfs/inode.c
index e78d45dfeaee,cf41bcb664bc..000000000000
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@@ -354,7 -352,9 +354,9 @@@ int ovl_xattr_set(struct dentry *dentry
  		goto out;
  
  	if (!value && !upperdentry) {
+ 		old_cred = ovl_override_creds(dentry->d_sb);
 -		err = vfs_getxattr(realdentry, name, NULL, 0);
 +		err = vfs_getxattr(&init_user_ns, realdentry, name, NULL, 0);
+ 		revert_creds(old_cred);
  		if (err < 0)
  			goto out_drop_write;
  	}

######## git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.coredump

diff --cc fs/coredump.c
index ae778937a1ff,27a93f724251..000000000000
--- a/fs/coredump.c
+++ b/fs/coredump.c

######## git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namei

diff --cc fs/namei.c
index dbf53b325ac9,4cae88733a5c..000000000000
--- a/fs/namei.c
+++ b/fs/namei.c
@@@ -1639,18 -1568,14 +1644,16 @@@ static struct dentry *lookup_slow(cons
  	return res;
  }
  
 -static inline int may_lookup(struct nameidata *nd)
 +static inline int may_lookup(struct user_namespace *mnt_userns,
 +			     struct nameidata *nd)
  {
  	if (nd->flags & LOOKUP_RCU) {
 -		int err = inode_permission(nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
 +		int err = inode_permission(mnt_userns, nd->inode,
 +					   MAY_EXEC | MAY_NOT_BLOCK);
- 		if (err != -ECHILD)
+ 		if (err != -ECHILD || !try_to_unlazy(nd))
  			return err;
- 		if (unlazy_walk(nd))
- 			return -ECHILD;
  	}
 -	return inode_permission(nd->inode, MAY_EXEC);
 +	return inode_permission(mnt_userns, nd->inode, MAY_EXEC);
  }
  
  static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
@@@ -3453,11 -3324,9 +3453,9 @@@ static int do_tmpfile(struct nameidata 
  	path.dentry = child;
  	audit_inode(nd->name, child, 0);
  	/* Don't check for other permissions, the inode was just created */
 -	error = may_open(&path, 0, op->open_flag);
 +	error = may_open(mnt_userns, &path, 0, op->open_flag);
- 	if (error)
- 		goto out2;
- 	file->f_path.mnt = path.mnt;
- 	error = finish_open(file, child, NULL);
+ 	if (!error)
+ 		error = vfs_open(&path, file);
  out2:
  	mnt_drop_write(path.mnt);
  out:

######## git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev

diff --cc fs/f2fs/acl.c
index a19e86c9adac,732ec10e7890..000000000000
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@@ -200,6 -200,27 +200,27 @@@ struct posix_acl *f2fs_get_acl(struct i
  	return __f2fs_get_acl(inode, type, NULL);
  }
  
+ static int f2fs_acl_update_mode(struct inode *inode, umode_t *mode_p,
+ 			  struct posix_acl **acl)
+ {
+ 	umode_t mode = inode->i_mode;
+ 	int error;
+ 
+ 	if (is_inode_flag_set(inode, FI_ACL_MODE))
+ 		mode = F2FS_I(inode)->i_acl_mode;
+ 
+ 	error = posix_acl_equiv_mode(*acl, &mode);
+ 	if (error < 0)
+ 		return error;
+ 	if (error == 0)
+ 		*acl = NULL;
 -	if (!in_group_p(inode->i_gid) &&
 -	    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
++	if (!in_group_p(i_gid_into_mnt(&init_user_ns, inode)) &&
++	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
+ 		mode &= ~S_ISGID;
+ 	*mode_p = mode;
+ 	return 0;
+ }
+ 
  static int __f2fs_set_acl(struct inode *inode, int type,
  			struct posix_acl *acl, struct page *ipage)
  {
diff --cc fs/f2fs/file.c
index 8f1e97e7d242,8e53f8898688..000000000000
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@@ -848,9 -853,9 +854,10 @@@ static void __setattr_copy(struct user_
  		inode->i_ctime = attr->ia_ctime;
  	if (ia_valid & ATTR_MODE) {
  		umode_t mode = attr->ia_mode;
 +		kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
  
- 		if (!in_group_p(kgid) && !capable(CAP_FSETID))
 -		if (!in_group_p(inode->i_gid) &&
 -			!capable_wrt_inode_uidgid(inode, CAP_FSETID))
++		if (!in_group_p(kgid) &&
++			!capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
  			mode &= ~S_ISGID;
  		set_acl_inode(inode, mode);
  	}
@@@ -948,13 -960,14 +963,14 @@@ int f2fs_setattr(struct user_namespace 
  		spin_unlock(&F2FS_I(inode)->i_size_lock);
  	}
  
 -	__setattr_copy(inode, attr);
 +	__setattr_copy(&init_user_ns, inode, attr);
  
  	if (attr->ia_valid & ATTR_MODE) {
 -		err = posix_acl_chmod(inode, f2fs_get_inode_mode(inode));
 -
 +		err = posix_acl_chmod(&init_user_ns, inode,
 +				      f2fs_get_inode_mode(inode));
- 		if (err || is_inode_flag_set(inode, FI_ACL_MODE)) {
- 			inode->i_mode = F2FS_I(inode)->i_acl_mode;
+ 		if (is_inode_flag_set(inode, FI_ACL_MODE)) {
+ 			if (!err)
+ 				inode->i_mode = F2FS_I(inode)->i_acl_mode;
  			clear_inode_flag(inode, FI_ACL_MODE);
  		}
  	}

######## git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity next-integrity

diff --cc security/integrity/ima/ima_api.c
index ed410efb3597,1dd70dc68ffd..000000000000
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@@ -184,18 -183,17 +184,18 @@@ err_out
   * Returns IMA_MEASURE, IMA_APPRAISE mask.
   *
   */
 -int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 -		   int mask, enum ima_hooks func, int *pcr,
 +int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
 +		   const struct cred *cred, u32 secid, int mask,
 +		   enum ima_hooks func, int *pcr,
  		   struct ima_template_desc **template_desc,
- 		   const char *keyring)
+ 		   const char *func_data)
  {
  	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
  
  	flags &= ima_policy_flag;
  
 -	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
 -				template_desc, func_data);
 +	return ima_match_policy(mnt_userns, inode, cred, secid, func, mask,
- 				flags, pcr, template_desc, keyring);
++				flags, pcr, template_desc, func_data);
  }
  
  /*
diff --cc security/integrity/ima/ima_main.c
index cb1c56eccd6d,6a429846f90a..000000000000
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@@ -816,22 -809,22 +816,24 @@@ int ima_post_load_data(char *buf, loff_
  }
  
  /*
-  * process_buffer_measurement - Measure the buffer to ima log.
+  * process_buffer_measurement - Measure the buffer or the buffer data hash
 + * @mnt_userns:	user namespace of the mount the inode was found from
   * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
   * @buf: pointer to the buffer that needs to be added to the log.
   * @size: size of buffer(in bytes).
   * @eventname: event name to be used for the buffer entry.
   * @func: IMA hook
   * @pcr: pcr to extend the measurement
-  * @keyring: keyring name to determine the action to be performed
+  * @func_data: func specific data, may be NULL
+  * @buf_hash: measure buffer data hash
   *
-  * Based on policy, the buffer is measured into the ima log.
+  * Based on policy, either the buffer data or buffer data hash is measured
   */
 -void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 +void process_buffer_measurement(struct user_namespace *mnt_userns,
 +				struct inode *inode, const void *buf, int size,
  				const char *eventname, enum ima_hooks func,
- 				int pcr, const char *keyring)
+ 				int pcr, const char *func_data,
+ 				bool buf_hash)
  {
  	int ret = 0;
  	const char *audit_cause = "ENOMEM";
@@@ -869,9 -864,8 +873,8 @@@
  	 */
  	if (func) {
  		security_task_getsecid(current, &secid);
- 		action = ima_get_action(mnt_userns, inode, current_cred(),
- 					secid, 0, func, &pcr, &template,
- 					keyring);
 -		action = ima_get_action(inode, current_cred(), secid, 0, func,
 -					&pcr, &template, func_data);
++		action = ima_get_action(mnt_userns, inode, current_cred(), secid,
++					0, func, &pcr, &template, func_data);
  		if (!(action & IMA_MEASURE))
  			return;
  	}
@@@ -929,12 -937,38 +946,38 @@@ void ima_kexec_cmdline(int kernel_fd, c
  	if (!f.file)
  		return;
  
 -	process_buffer_measurement(file_inode(f.file), buf, size,
 -				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL,
 -				   false);
 +	process_buffer_measurement(file_mnt_user_ns(f.file), file_inode(f.file),
 +				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
- 				   NULL);
++				   NULL, false);
  	fdput(f);
  }
  
+ /**
+  * ima_measure_critical_data - measure kernel integrity critical data
+  * @event_label: unique event label for grouping and limiting critical data
+  * @event_name: event name for the record in the IMA measurement list
+  * @buf: pointer to buffer data
+  * @buf_len: length of buffer data (in bytes)
+  * @hash: measure buffer data hash
+  *
+  * Measure data critical to the integrity of the kernel into the IMA log
+  * and extend the pcr.  Examples of critical data could be various data
+  * structures, policies, and states stored in kernel memory that can
+  * impact the integrity of the system.
+  */
+ void ima_measure_critical_data(const char *event_label,
+ 			       const char *event_name,
+ 			       const void *buf, size_t buf_len,
+ 			       bool hash)
+ {
+ 	if (!event_name || !event_label || !buf || !buf_len)
+ 		return;
+ 
 -	process_buffer_measurement(NULL, buf, buf_len, event_name,
++	process_buffer_measurement(&init_user_ns, NULL, buf, buf_len, event_name,
+ 				   CRITICAL_DATA, 0, event_label,
+ 				   hash);
+ }
+ 
  static int __init init_ima(void)
  {
  	int error;
diff --cc security/integrity/ima/ima_policy.c
index e14426c24a19,9b45d064a87d..000000000000
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@@ -498,11 -522,10 +523,11 @@@ static bool ima_match_rule_data(struct 
   *
   * Returns true on rule match, false on failure.
   */
 -static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 -			    const struct cred *cred, u32 secid,
 -			    enum ima_hooks func, int mask,
 +static bool ima_match_rules(struct ima_rule_entry *rule,
 +			    struct user_namespace *mnt_userns,
 +			    struct inode *inode, const struct cred *cred,
 +			    u32 secid, enum ima_hooks func, int mask,
- 			    const char *keyring)
+ 			    const char *func_data)
  {
  	int i;
  
@@@ -623,11 -650,10 +653,11 @@@ static int get_subaction(struct ima_rul
   * list when walking it.  Reads are many orders of magnitude more numerous
   * than writes so ima_match_policy() is classical RCU candidate.
   */
 -int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 -		     enum ima_hooks func, int mask, int flags, int *pcr,
 +int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 +		     const struct cred *cred, u32 secid, enum ima_hooks func,
 +		     int mask, int flags, int *pcr,
  		     struct ima_template_desc **template_desc,
- 		     const char *keyring)
+ 		     const char *func_data)
  {
  	struct ima_rule_entry *entry;
  	int action = 0, actmask = flags | (flags << 1);
@@@ -641,8 -667,8 +671,8 @@@
  		if (!(entry->action & actmask))
  			continue;
  
 -		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
 -				     func_data))
 +		if (!ima_match_rules(entry, mnt_userns, inode, cred, secid,
- 				     func, mask, keyring))
++				     func, mask, func_data))
  			continue;
  
  		action |= entry->flags & IMA_ACTION_FLAGS;

######## git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-next

diff --cc include/linux/fs.h
index 439f66dcaacf,493804856ab3..000000000000
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -2839,22 -2756,11 +2839,23 @@@ static inline int bmap(struct inode *in
  }
  #endif
  
 -extern int notify_change(struct dentry *, struct iattr *, struct inode **);
 -extern int inode_permission(struct inode *, int);
 -extern int generic_permission(struct inode *, int);
 -extern int __check_sticky(struct inode *dir, struct inode *inode);
 +int notify_change(struct user_namespace *, struct dentry *,
 +		  struct iattr *, struct inode **);
 +int inode_permission(struct user_namespace *, struct inode *, int);
 +int generic_permission(struct user_namespace *, struct inode *, int);
 +static inline int file_permission(struct file *file, int mask)
 +{
 +	return inode_permission(file_mnt_user_ns(file),
 +				file_inode(file), mask);
 +}
 +static inline int path_permission(const struct path *path, int mask)
 +{
 +	return inode_permission(mnt_user_ns(path->mnt),
 +				d_inode(path->dentry), mask);
 +}
 +int __check_sticky(struct user_namespace *mnt_userns, struct inode *dir,
 +		   struct inode *inode);
+ extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
  
  static inline bool execute_ok(struct inode *inode)
  {

######## git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next

diff --cc fs/xfs/xfs_inode.c
index 95b7f2ba4e06,636ac13b1df2..000000000000
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@@ -810,13 -809,13 +810,13 @@@ xfs_init_new_inode
  	inode->i_rdev = rdev;
  	ip->i_d.di_projid = prid;
  
- 	if (pip && XFS_INHERIT_GID(pip)) {
- 		inode->i_gid = VFS_I(pip)->i_gid;
- 		if ((VFS_I(pip)->i_mode & S_ISGID) && S_ISDIR(mode))
- 			inode->i_mode |= S_ISGID;
+ 	if (dir && !(dir->i_mode & S_ISGID) &&
+ 	    (mp->m_flags & XFS_MOUNT_GRPID)) {
 -		inode->i_uid = current_fsuid();
++		inode->i_uid = fsuid_into_mnt(mnt_userns);
+ 		inode->i_gid = dir->i_gid;
+ 		inode->i_mode = mode;
  	} else {
- 		inode->i_gid = fsgid_into_mnt(mnt_userns);
 -		inode_init_owner(inode, dir, mode);
++		inode_init_owner(mnt_userns, inode, dir, mode);
  	}
  
  	/*
@@@ -1167,16 -1159,12 +1166,12 @@@ xfs_create_tmpfile
  	resblks = XFS_IALLOC_SPACE_RES(mp);
  	tres = &M_RES(mp)->tr_create_tmpfile;
  
- 	error = xfs_trans_alloc(mp, tres, resblks, 0, 0, &tp);
- 	if (error)
- 		goto out_release_inode;
- 
- 	error = xfs_trans_reserve_quota(tp, mp, udqp, gdqp,
- 						pdqp, resblks, 1, 0);
+ 	error = xfs_trans_alloc_icreate(mp, tres, udqp, gdqp, pdqp, resblks,
+ 			&tp);
  	if (error)
- 		goto out_trans_cancel;
+ 		goto out_release_dquots;
  
 -	error = xfs_dir_ialloc(&tp, dp, mode, 0, 0, prid, &ip);
 +	error = xfs_dir_ialloc(mnt_userns, &tp, dp, mode, 0, 0, prid, &ip);
  	if (error)
  		goto out_trans_cancel;
  
diff --cc fs/xfs/xfs_ioctl.c
index 3d4c7ca080fb,248083ea0276..000000000000
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@@ -1280,9 -1275,9 +1280,10 @@@ xfs_ioctl_setattr_prepare_dax
   */
  static struct xfs_trans *
  xfs_ioctl_setattr_get_trans(
- 	struct file		*file)
 -	struct xfs_inode	*ip,
++	struct file		*file,
+ 	struct xfs_dquot	*pdqp)
  {
 +	struct xfs_inode	*ip = XFS_I(file_inode(file));
  	struct xfs_mount	*mp = ip->i_mount;
  	struct xfs_trans	*tp;
  	int			error = -EROFS;
@@@ -1470,9 -1461,9 +1469,9 @@@ xfs_ioctl_setattr
  
  	xfs_ioctl_setattr_prepare_dax(ip, fa);
  
- 	tp = xfs_ioctl_setattr_get_trans(file);
 -	tp = xfs_ioctl_setattr_get_trans(ip, pdqp);
++	tp = xfs_ioctl_setattr_get_trans(file, pdqp);
  	if (IS_ERR(tp)) {
- 		code = PTR_ERR(tp);
+ 		error = PTR_ERR(tp);
  		goto error_free_dquots;
  	}
  
@@@ -1615,7 -1599,7 +1606,7 @@@ xfs_ioc_setxflags
  
  	xfs_ioctl_setattr_prepare_dax(ip, &fa);
  
- 	tp = xfs_ioctl_setattr_get_trans(filp);
 -	tp = xfs_ioctl_setattr_get_trans(ip, NULL);
++	tp = xfs_ioctl_setattr_get_trans(filp, NULL);
  	if (IS_ERR(tp)) {
  		error = PTR_ERR(tp);
  		goto out_drop_write;

######## akpm-current tree/quilt series:

diff --cc fs/hugetlbfs/inode.c
index c5c32eb59498,ca9e25427f2d..000000000000
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@@ -760,9 -766,7 +767,7 @@@ static int hugetlbfs_setattr(struct use
  	unsigned int ia_valid = attr->ia_valid;
  	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
  
- 	BUG_ON(!inode);
- 
 -	error = setattr_prepare(dentry, attr);
 +	error = setattr_prepare(&init_user_ns, dentry, attr);
  	if (error)
  		return error;

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/idmapped-mounts-v5.12

for you to fetch changes up to f69e8091c4a2ae291e1f55225e8116fef05dc156:

  xfs: remove the possibly unused mp variable in xfs_file_compat_ioctl (2021-02-03 20:31:14 +0100)

Please consider pulling these changes from the signed idmapped-mounts-v5.12 tag.

In case you don't want to pull everything but only parts I've created for
separate tags:

1. infrastructure patches for idmapped mounts:
   git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/idmapped-mounts-infrastructure-v5.12

2. Tag containing infrastructure and only the fat port:
   git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/idmapped-mounts-fat-v5.12

3. Tag containing infrastructure and only the ext4 port:
   git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/idmapped-mounts-ext4-v5.12

4. Tag containing infrastructure and only the xfs port:
   git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/idmapped-mounts-xfs-v5.12

Thanks!
Christian

----------------------------------------------------------------
idmapped-mounts-v5.12

----------------------------------------------------------------
Christian Brauner (38):
      mount: attach mappings to mounts
      fs: add id translation helpers
      fs: add file and path permissions helpers
      capability: handle idmapped mounts
      namei: make permission helpers idmapped mount aware
      inode: make init and permission helpers idmapped mount aware
      attr: handle idmapped mounts
      acl: handle idmapped mounts
      commoncap: handle idmapped mounts
      stat: handle idmapped mounts
      namei: handle idmapped mounts in may_*() helpers
      namei: introduce struct renamedata
      namei: prepare for idmapped mounts
      open: handle idmapped mounts in do_truncate()
      open: handle idmapped mounts
      af_unix: handle idmapped mounts
      utimes: handle idmapped mounts
      fcntl: handle idmapped mounts
      init: handle idmapped mounts
      ioctl: handle idmapped mounts
      would_dump: handle idmapped mounts
      exec: handle idmapped mounts
      fs: make helpers idmap mount aware
      apparmor: handle idmapped mounts
      ima: handle idmapped mounts
      ecryptfs: do not mount on top of idmapped mounts
      overlayfs: do not mount on top of idmapped mounts
      nfs: do not export idmapped mounts
      namespace: take lock_mount_hash() directly when changing flags
      mount: make {lock,unlock}_mount_hash() static
      namespace: only take read lock in do_reconfigure_mnt()
      fs: split out functions to hold writers
      fs: add attr_flags_to_mnt_flags helper
      fs: add mount_setattr()
      fs: introduce MOUNT_ATTR_IDMAP
      tests: add mount_setattr() selftests
      fat: handle idmapped mounts
      ext4: support idmapped mounts

Christoph Hellwig (2):
      xfs: support idmapped mounts
      xfs: remove the possibly unused mp variable in xfs_file_compat_ioctl

Tycho Andersen (1):
      xattr: handle idmapped mounts

 Documentation/filesystems/locking.rst              |    7 +-
 Documentation/filesystems/porting.rst              |    2 +
 Documentation/filesystems/vfs.rst                  |   19 +-
 arch/alpha/kernel/syscalls/syscall.tbl             |    1 +
 arch/arm/tools/syscall.tbl                         |    1 +
 arch/arm64/include/asm/unistd.h                    |    2 +-
 arch/arm64/include/asm/unistd32.h                  |    2 +
 arch/ia64/kernel/syscalls/syscall.tbl              |    1 +
 arch/m68k/kernel/syscalls/syscall.tbl              |    1 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |    1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |    1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |    1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |    1 +
 arch/parisc/kernel/syscalls/syscall.tbl            |    1 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |    1 +
 arch/powerpc/platforms/cell/spufs/inode.c          |    5 +-
 arch/s390/kernel/syscalls/syscall.tbl              |    1 +
 arch/sh/kernel/syscalls/syscall.tbl                |    1 +
 arch/sparc/kernel/syscalls/syscall.tbl             |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl             |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |    1 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |    1 +
 drivers/android/binderfs.c                         |    6 +-
 drivers/base/devtmpfs.c                            |   15 +-
 fs/9p/acl.c                                        |    8 +-
 fs/9p/v9fs.h                                       |    3 +-
 fs/9p/v9fs_vfs.h                                   |    3 +-
 fs/9p/vfs_inode.c                                  |   36 +-
 fs/9p/vfs_inode_dotl.c                             |   39 +-
 fs/9p/xattr.c                                      |    1 +
 fs/adfs/adfs.h                                     |    3 +-
 fs/adfs/inode.c                                    |    5 +-
 fs/affs/affs.h                                     |   24 +-
 fs/affs/inode.c                                    |    7 +-
 fs/affs/namei.c                                    |   15 +-
 fs/afs/dir.c                                       |   34 +-
 fs/afs/inode.c                                     |    9 +-
 fs/afs/internal.h                                  |    7 +-
 fs/afs/security.c                                  |    3 +-
 fs/afs/xattr.c                                     |    2 +
 fs/attr.c                                          |  126 +-
 fs/autofs/root.c                                   |   17 +-
 fs/bad_inode.c                                     |   36 +-
 fs/bfs/dir.c                                       |   12 +-
 fs/btrfs/acl.c                                     |    6 +-
 fs/btrfs/ctree.h                                   |    3 +-
 fs/btrfs/inode.c                                   |   46 +-
 fs/btrfs/ioctl.c                                   |   27 +-
 fs/btrfs/tests/btrfs-tests.c                       |    2 +-
 fs/btrfs/xattr.c                                   |    2 +
 fs/cachefiles/interface.c                          |    4 +-
 fs/cachefiles/namei.c                              |   21 +-
 fs/cachefiles/xattr.c                              |   29 +-
 fs/ceph/acl.c                                      |    6 +-
 fs/ceph/dir.c                                      |   23 +-
 fs/ceph/inode.c                                    |   18 +-
 fs/ceph/super.h                                    |   12 +-
 fs/ceph/xattr.c                                    |    1 +
 fs/cifs/cifsfs.c                                   |    5 +-
 fs/cifs/cifsfs.h                                   |   25 +-
 fs/cifs/dir.c                                      |    8 +-
 fs/cifs/inode.c                                    |   26 +-
 fs/cifs/link.c                                     |    3 +-
 fs/cifs/xattr.c                                    |    1 +
 fs/coda/coda_linux.h                               |    8 +-
 fs/coda/dir.c                                      |   18 +-
 fs/coda/inode.c                                    |    9 +-
 fs/coda/pioctl.c                                   |    6 +-
 fs/configfs/configfs_internal.h                    |    6 +-
 fs/configfs/dir.c                                  |    3 +-
 fs/configfs/inode.c                                |    5 +-
 fs/configfs/symlink.c                              |    6 +-
 fs/coredump.c                                      |   10 +-
 fs/crypto/policy.c                                 |    2 +-
 fs/debugfs/inode.c                                 |    9 +-
 fs/ecryptfs/crypto.c                               |    4 +-
 fs/ecryptfs/inode.c                                |   85 +-
 fs/ecryptfs/main.c                                 |    6 +
 fs/ecryptfs/mmap.c                                 |    4 +-
 fs/efivarfs/file.c                                 |    2 +-
 fs/efivarfs/inode.c                                |    4 +-
 fs/erofs/inode.c                                   |    7 +-
 fs/erofs/internal.h                                |    5 +-
 fs/exec.c                                          |   12 +-
 fs/exfat/exfat_fs.h                                |    8 +-
 fs/exfat/file.c                                    |   14 +-
 fs/exfat/namei.c                                   |   14 +-
 fs/ext2/acl.c                                      |    6 +-
 fs/ext2/acl.h                                      |    3 +-
 fs/ext2/ext2.h                                     |    5 +-
 fs/ext2/ialloc.c                                   |    2 +-
 fs/ext2/inode.c                                    |   15 +-
 fs/ext2/ioctl.c                                    |    6 +-
 fs/ext2/namei.c                                    |   22 +-
 fs/ext2/xattr_security.c                           |    1 +
 fs/ext2/xattr_trusted.c                            |    1 +
 fs/ext2/xattr_user.c                               |    1 +
 fs/ext4/acl.c                                      |    5 +-
 fs/ext4/acl.h                                      |    3 +-
 fs/ext4/ext4.h                                     |   22 +-
 fs/ext4/ialloc.c                                   |    7 +-
 fs/ext4/inode.c                                    |   21 +-
 fs/ext4/ioctl.c                                    |   20 +-
 fs/ext4/namei.c                                    |   49 +-
 fs/ext4/super.c                                    |    2 +-
 fs/ext4/xattr_hurd.c                               |    1 +
 fs/ext4/xattr_security.c                           |    1 +
 fs/ext4/xattr_trusted.c                            |    1 +
 fs/ext4/xattr_user.c                               |    1 +
 fs/f2fs/acl.c                                      |    6 +-
 fs/f2fs/acl.h                                      |    3 +-
 fs/f2fs/f2fs.h                                     |    7 +-
 fs/f2fs/file.c                                     |   36 +-
 fs/f2fs/namei.c                                    |   23 +-
 fs/f2fs/xattr.c                                    |    4 +-
 fs/fat/fat.h                                       |    6 +-
 fs/fat/file.c                                      |   24 +-
 fs/fat/namei_msdos.c                               |   12 +-
 fs/fat/namei_vfat.c                                |   15 +-
 fs/fcntl.c                                         |    3 +-
 fs/fuse/acl.c                                      |    3 +-
 fs/fuse/dir.c                                      |   46 +-
 fs/fuse/fuse_i.h                                   |    4 +-
 fs/fuse/xattr.c                                    |    2 +
 fs/gfs2/acl.c                                      |    5 +-
 fs/gfs2/acl.h                                      |    3 +-
 fs/gfs2/file.c                                     |    4 +-
 fs/gfs2/inode.c                                    |   64 +-
 fs/gfs2/inode.h                                    |    3 +-
 fs/gfs2/xattr.c                                    |    1 +
 fs/hfs/attr.c                                      |    1 +
 fs/hfs/dir.c                                       |   13 +-
 fs/hfs/hfs_fs.h                                    |    3 +-
 fs/hfs/inode.c                                     |    8 +-
 fs/hfsplus/dir.c                                   |   22 +-
 fs/hfsplus/hfsplus_fs.h                            |    5 +-
 fs/hfsplus/inode.c                                 |   16 +-
 fs/hfsplus/ioctl.c                                 |    2 +-
 fs/hfsplus/xattr.c                                 |    1 +
 fs/hfsplus/xattr_security.c                        |    1 +
 fs/hfsplus/xattr_trusted.c                         |    1 +
 fs/hfsplus/xattr_user.c                            |    1 +
 fs/hostfs/hostfs_kern.c                            |   29 +-
 fs/hpfs/hpfs_fn.h                                  |    2 +-
 fs/hpfs/inode.c                                    |    7 +-
 fs/hpfs/namei.c                                    |   20 +-
 fs/hugetlbfs/inode.c                               |   35 +-
 fs/init.c                                          |   24 +-
 fs/inode.c                                         |   44 +-
 fs/internal.h                                      |    2 +-
 fs/jffs2/acl.c                                     |    6 +-
 fs/jffs2/acl.h                                     |    3 +-
 fs/jffs2/dir.c                                     |   33 +-
 fs/jffs2/fs.c                                      |    7 +-
 fs/jffs2/os-linux.h                                |    2 +-
 fs/jffs2/security.c                                |    1 +
 fs/jffs2/xattr_trusted.c                           |    1 +
 fs/jffs2/xattr_user.c                              |    1 +
 fs/jfs/acl.c                                       |    5 +-
 fs/jfs/file.c                                      |    9 +-
 fs/jfs/ioctl.c                                     |    2 +-
 fs/jfs/jfs_acl.h                                   |    3 +-
 fs/jfs/jfs_inode.c                                 |    2 +-
 fs/jfs/jfs_inode.h                                 |    2 +-
 fs/jfs/namei.c                                     |   21 +-
 fs/jfs/xattr.c                                     |    2 +
 fs/kernfs/dir.c                                    |    6 +-
 fs/kernfs/inode.c                                  |   19 +-
 fs/kernfs/kernfs-internal.h                        |    9 +-
 fs/libfs.c                                         |   28 +-
 fs/minix/bitmap.c                                  |    2 +-
 fs/minix/file.c                                    |    7 +-
 fs/minix/inode.c                                   |    6 +-
 fs/minix/minix.h                                   |    3 +-
 fs/minix/namei.c                                   |   24 +-
 fs/mount.h                                         |   10 -
 fs/namei.c                                         |  512 +++++--
 fs/namespace.c                                     |  484 ++++++-
 fs/nfs/dir.c                                       |   25 +-
 fs/nfs/inode.c                                     |    9 +-
 fs/nfs/internal.h                                  |   14 +-
 fs/nfs/namespace.c                                 |   15 +-
 fs/nfs/nfs3_fs.h                                   |    3 +-
 fs/nfs/nfs3acl.c                                   |    3 +-
 fs/nfs/nfs4proc.c                                  |    3 +
 fs/nfsd/export.c                                   |   12 +-
 fs/nfsd/nfs2acl.c                                  |    6 +-
 fs/nfsd/nfs3acl.c                                  |    6 +-
 fs/nfsd/nfs4acl.c                                  |    5 +-
 fs/nfsd/nfs4recover.c                              |    6 +-
 fs/nfsd/nfsfh.c                                    |    3 +-
 fs/nfsd/nfsproc.c                                  |    2 +-
 fs/nfsd/vfs.c                                      |   50 +-
 fs/nilfs2/inode.c                                  |   14 +-
 fs/nilfs2/ioctl.c                                  |    2 +-
 fs/nilfs2/namei.c                                  |   19 +-
 fs/nilfs2/nilfs.h                                  |    6 +-
 fs/notify/fanotify/fanotify_user.c                 |    2 +-
 fs/notify/inotify/inotify_user.c                   |    2 +-
 fs/ntfs/inode.c                                    |    6 +-
 fs/ntfs/inode.h                                    |    3 +-
 fs/ocfs2/acl.c                                     |    6 +-
 fs/ocfs2/acl.h                                     |    3 +-
 fs/ocfs2/dlmfs/dlmfs.c                             |   17 +-
 fs/ocfs2/file.c                                    |   18 +-
 fs/ocfs2/file.h                                    |   11 +-
 fs/ocfs2/ioctl.c                                   |    2 +-
 fs/ocfs2/namei.c                                   |   21 +-
 fs/ocfs2/refcounttree.c                            |    4 +-
 fs/ocfs2/xattr.c                                   |    3 +
 fs/omfs/dir.c                                      |   13 +-
 fs/omfs/file.c                                     |    7 +-
 fs/omfs/inode.c                                    |    2 +-
 fs/open.c                                          |   35 +-
 fs/orangefs/acl.c                                  |    6 +-
 fs/orangefs/inode.c                                |   20 +-
 fs/orangefs/namei.c                                |   12 +-
 fs/orangefs/orangefs-kernel.h                      |   13 +-
 fs/orangefs/xattr.c                                |    1 +
 fs/overlayfs/copy_up.c                             |   22 +-
 fs/overlayfs/dir.c                                 |   31 +-
 fs/overlayfs/file.c                                |    6 +-
 fs/overlayfs/inode.c                               |   27 +-
 fs/overlayfs/overlayfs.h                           |   45 +-
 fs/overlayfs/super.c                               |   21 +-
 fs/overlayfs/util.c                                |    4 +-
 fs/posix_acl.c                                     |  103 +-
 fs/proc/base.c                                     |   28 +-
 fs/proc/fd.c                                       |    5 +-
 fs/proc/fd.h                                       |    3 +-
 fs/proc/generic.c                                  |   12 +-
 fs/proc/internal.h                                 |    6 +-
 fs/proc/proc_net.c                                 |    5 +-
 fs/proc/proc_sysctl.c                              |   15 +-
 fs/proc/root.c                                     |    5 +-
 fs/proc_namespace.c                                |    3 +
 fs/ramfs/file-nommu.c                              |    9 +-
 fs/ramfs/inode.c                                   |   18 +-
 fs/reiserfs/acl.h                                  |    3 +-
 fs/reiserfs/inode.c                                |    7 +-
 fs/reiserfs/ioctl.c                                |    4 +-
 fs/reiserfs/namei.c                                |   21 +-
 fs/reiserfs/reiserfs.h                             |    3 +-
 fs/reiserfs/xattr.c                                |   13 +-
 fs/reiserfs/xattr.h                                |    3 +-
 fs/reiserfs/xattr_acl.c                            |    8 +-
 fs/reiserfs/xattr_security.c                       |    3 +-
 fs/reiserfs/xattr_trusted.c                        |    3 +-
 fs/reiserfs/xattr_user.c                           |    3 +-
 fs/remap_range.c                                   |    7 +-
 fs/stat.c                                          |   26 +-
 fs/sysv/file.c                                     |    7 +-
 fs/sysv/ialloc.c                                   |    2 +-
 fs/sysv/itree.c                                    |    6 +-
 fs/sysv/namei.c                                    |   21 +-
 fs/sysv/sysv.h                                     |    3 +-
 fs/tracefs/inode.c                                 |    4 +-
 fs/ubifs/dir.c                                     |   30 +-
 fs/ubifs/file.c                                    |    5 +-
 fs/ubifs/ioctl.c                                   |    2 +-
 fs/ubifs/ubifs.h                                   |    5 +-
 fs/ubifs/xattr.c                                   |    1 +
 fs/udf/file.c                                      |    9 +-
 fs/udf/ialloc.c                                    |    2 +-
 fs/udf/namei.c                                     |   24 +-
 fs/udf/symlink.c                                   |    7 +-
 fs/ufs/ialloc.c                                    |    2 +-
 fs/ufs/inode.c                                     |    7 +-
 fs/ufs/namei.c                                     |   19 +-
 fs/ufs/ufs.h                                       |    3 +-
 fs/utimes.c                                        |    3 +-
 fs/vboxsf/dir.c                                    |   12 +-
 fs/vboxsf/utils.c                                  |    9 +-
 fs/vboxsf/vfsmod.h                                 |    8 +-
 fs/verity/enable.c                                 |    2 +-
 fs/xattr.c                                         |  139 +-
 fs/xfs/xfs_acl.c                                   |    5 +-
 fs/xfs/xfs_acl.h                                   |    3 +-
 fs/xfs/xfs_file.c                                  |    4 +-
 fs/xfs/xfs_inode.c                                 |   26 +-
 fs/xfs/xfs_inode.h                                 |   16 +-
 fs/xfs/xfs_ioctl.c                                 |   35 +-
 fs/xfs/xfs_ioctl32.c                               |   13 +-
 fs/xfs/xfs_iops.c                                  |  101 +-
 fs/xfs/xfs_iops.h                                  |    3 +-
 fs/xfs/xfs_itable.c                                |   17 +-
 fs/xfs/xfs_itable.h                                |    1 +
 fs/xfs/xfs_qm.c                                    |    3 +-
 fs/xfs/xfs_super.c                                 |    2 +-
 fs/xfs/xfs_symlink.c                               |    5 +-
 fs/xfs/xfs_symlink.h                               |    5 +-
 fs/xfs/xfs_xattr.c                                 |    7 +-
 fs/zonefs/super.c                                  |    9 +-
 include/linux/capability.h                         |   14 +-
 include/linux/fs.h                                 |  186 ++-
 include/linux/ima.h                                |   18 +-
 include/linux/lsm_hook_defs.h                      |   15 +-
 include/linux/lsm_hooks.h                          |    1 +
 include/linux/mount.h                              |    7 +
 include/linux/nfs_fs.h                             |    7 +-
 include/linux/posix_acl.h                          |   21 +-
 include/linux/posix_acl_xattr.h                    |   12 +-
 include/linux/security.h                           |   54 +-
 include/linux/syscalls.h                           |    4 +
 include/linux/xattr.h                              |   30 +-
 include/uapi/asm-generic/unistd.h                  |    4 +-
 include/uapi/linux/mount.h                         |   16 +
 ipc/mqueue.c                                       |    9 +-
 kernel/auditsc.c                                   |    5 +-
 kernel/bpf/inode.c                                 |   13 +-
 kernel/capability.c                                |   14 +-
 kernel/cgroup/cgroup.c                             |    2 +-
 kernel/sys.c                                       |    2 +-
 mm/madvise.c                                       |    5 +-
 mm/memcontrol.c                                    |    2 +-
 mm/mincore.c                                       |    5 +-
 mm/shmem.c                                         |   50 +-
 net/socket.c                                       |    6 +-
 net/unix/af_unix.c                                 |    5 +-
 security/apparmor/apparmorfs.c                     |    3 +-
 security/apparmor/domain.c                         |   13 +-
 security/apparmor/file.c                           |    4 +-
 security/apparmor/lsm.c                            |   21 +-
 security/commoncap.c                               |  108 +-
 security/integrity/evm/evm_crypto.c                |   11 +-
 security/integrity/evm/evm_main.c                  |    4 +-
 security/integrity/evm/evm_secfs.c                 |    2 +-
 security/integrity/ima/ima.h                       |   19 +-
 security/integrity/ima/ima_api.c                   |   10 +-
 security/integrity/ima/ima_appraise.c              |   23 +-
 security/integrity/ima/ima_asymmetric_keys.c       |    3 +-
 security/integrity/ima/ima_main.c                  |   37 +-
 security/integrity/ima/ima_policy.c                |   20 +-
 security/integrity/ima/ima_queue_keys.c            |    4 +-
 security/security.c                                |   25 +-
 security/selinux/hooks.c                           |   23 +-
 security/smack/smack_lsm.c                         |   22 +-
 tools/include/uapi/asm-generic/unistd.h            |    4 +-
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/mount_setattr/.gitignore   |    1 +
 tools/testing/selftests/mount_setattr/Makefile     |    7 +
 tools/testing/selftests/mount_setattr/config       |    1 +
 .../selftests/mount_setattr/mount_setattr_test.c   | 1424 ++++++++++++++++++++
 343 files changed, 4904 insertions(+), 1757 deletions(-)
 create mode 100644 tools/testing/selftests/mount_setattr/.gitignore
 create mode 100644 tools/testing/selftests/mount_setattr/Makefile
 create mode 100644 tools/testing/selftests/mount_setattr/config
 create mode 100644 tools/testing/selftests/mount_setattr/mount_setattr_test.c
