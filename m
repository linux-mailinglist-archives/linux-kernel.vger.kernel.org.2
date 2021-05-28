Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F5394638
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhE1RL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbhE1RLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:11:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFC6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:07:08 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 6so2992471pgk.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BGK4uUtY/47ELdZTjRTXwT+LtePr9wzh99tC7Z5sRvA=;
        b=WHrn8xms18dad5rtvGjozvYLe69er9+pUzUsaXen4aLEuDnY/8uWbNLLT9980klYmx
         5j2EB7Qz7TlTP62H8lfAij6Hr6b2oerMbBMUASKM17hI/QIWBf7qJSIniJAYhbFVxi4m
         x6GQNMub41labn+NEj8Hu+XZeEC479Ip2ZsZzsImUXVCDm/C/Sjnq/0E1MUkw8jXpGRY
         gu9AFJRHC5Zm3YU4E4ZbfzuIImmcNIS8fuUphvqYXxn0pJfj5vOUF7w+43hQgnIR3l+v
         N8Ybz9hGb7A6J2tlm/dASzxsOTuE2I5DGgTxXUH0h1NJ6BerX2RgANzyBmNXK0H7EEUY
         TQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BGK4uUtY/47ELdZTjRTXwT+LtePr9wzh99tC7Z5sRvA=;
        b=oqvRT/H7WooBf7Z/Aw9UhNnBy6dryA0cgQegGTOnj0mcRg8FSrp74cGShvBXk48FmD
         8LvfJ/HnOt1my29mh+LLfcxUd1DUV9u5v4LYxxeHwD6/2lt6T1DCoppbK5sr1Ym9bnKQ
         eGQRiFWEtmYhTsQJFt8cCX08VLC29YK22nUcLVI4+0NAJAHA3CQhfwGSp4yLPSSNJKjg
         Zi+HYiJwPILll7xxEaZhnq21Tg1IO1t2VflXTvuLI5NltXJ5rZkgFc7UcgRKbMnY7d/W
         bKdtpF1r5yF6i6DPcN9jaAxT94jksckHCfkLZEgusMphVrhm70+aQGWgVMdrnQjfHE5u
         AGMA==
X-Gm-Message-State: AOAM530z+lPtOHEiGPGCsXmZiadZrgSnfF4dp99bmTgSiyvK5OPqYz8O
        W7sw4qlYBrvJXP8k1VuueII=
X-Google-Smtp-Source: ABdhPJz/JAziGiAdfqsYZltBtOymO6kYNHITPYnCn2zPIBzEejzjFDSRxD4b5QqF8IrIo2WmvsSmUA==
X-Received: by 2002:a63:f00b:: with SMTP id k11mr10049482pgh.154.1622221627956;
        Fri, 28 May 2021 10:07:07 -0700 (PDT)
Received: from [192.168.0.15] (c-73-158-171-241.hsd1.ca.comcast.net. [73.158.171.241])
        by smtp.gmail.com with ESMTPSA id f7sm4791492pfq.8.2021.05.28.10.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 10:07:06 -0700 (PDT)
Subject: Re: Sealed memfd & no-fault mmap
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Simon Ser <contact@emersion.fr>
Cc:     Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
 <20210429154807.hptls4vnmq2svuea@box> <20210429183836.GF8339@xz-x1>
 <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
 <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
 <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
 <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com>
From:   "Lin, Ming" <minggr@gmail.com>
Message-ID: <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com>
Date:   Fri, 28 May 2021 10:07:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/2021 11:42 AM, Linus Torvalds wrote:
> On Wed, May 5, 2021 at 3:21 AM Simon Ser <contact@emersion.fr> wrote:
>>>
>>> Is there some very specific and targeted pattern for that "shared
>>> mapping" case? For example, if it's always a shared anonymous mapping
>>> with no filesystem backing, then that would possibly be a simpler case
>>> than the "random arbitrary shared file descriptor".
>>
>> Yes. I don't know of any Wayland client using buffers with real
>> filesystem backing. I think the main cases are:
>>
>> - shm_open(3) immediately followed by shm_unlink(3). On Linux, this is
>>    implemented with /dev/shm which is a tmpfs.
>> - Abusing /tmp or /run's tmpfs by creating a file there and unlinking
>>    it immediately afterwards. Kind of similar to the first case.
>> - memfd_create(2) on Linux.
>>
>> Is this enough to make it work on shared memory mappings? Is it
>> important that the mapping is anonymous?
> 
> All of those should be anonymous in the sense that the backing store
> is all the kernel's notion of anonymous pages, and there is no actual
> file backing. The mappings may then be shared, of course.
> 
> So that does make Peter's idea to have some inode flag for "don't
> SIGBUS on fault" be more reasonable, because there isn't some random
> actual filesystem involved, only the core VM layer.
> 
> I'm not going to write the patch, though, but maybe you can convince
> somebody else to try it..

Does something like following draft patch on the right track?

1. Application set S_NOFAULT flag on shm mmap fd

	#define S_NOFAULT       (1 << 17)
         fd = shm_open(shmpath, O_RDONLY, S_IRUSR | S_IWUSR);
         ioctl(fd, FS_IOC_GETFLAGS, &flags);
         flags |= S_NOFAULT;
         ioctl(fd, FS_IOC_SETFLAGS, &flags)

2. Don't SIGBUS on read beyond i_size if S_NOFAULT flag set in inode.
    Use zero page instead.

---

[RFC DRAFT PATCH] shm: no SIGBUS fault on out-of-band mmap read
---
  include/linux/fs.h |  2 ++
  mm/shmem.c         | 44 +++++++++++++++++++++++++++++++++++++++++++-
  2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..a9be7cd71b94 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2202,6 +2202,7 @@ struct super_operations {
  #define S_ENCRYPTED	(1 << 14) /* Encrypted file (using fs/crypto/) */
  #define S_CASEFOLD	(1 << 15) /* Casefolded file */
  #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
+#define S_NOFAULT	(1 << 17) /* No SIGBUS fault on out-of-band mmap read */
  
  /*
   * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -2244,6 +2245,7 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
  #define IS_ENCRYPTED(inode)	((inode)->i_flags & S_ENCRYPTED)
  #define IS_CASEFOLDED(inode)	((inode)->i_flags & S_CASEFOLD)
  #define IS_VERITY(inode)	((inode)->i_flags & S_VERITY)
+#define IS_NOFAULT(inode)	((inode)->i_flags & S_NOFAULT)
  
  #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
  				 (inode)->i_rdev == WHITEOUT_DEV)
diff --git a/mm/shmem.c b/mm/shmem.c
index 5d46611cba8d..856d2d8d4cdf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -38,8 +38,11 @@
  #include <linux/hugetlb.h>
  #include <linux/frontswap.h>
  #include <linux/fs_parser.h>
+#include <linux/fs.h>
+#include <linux/fileattr.h>
  
  #include <asm/tlbflush.h> /* for arch/microblaze update_mmu_cache() */
+#include <asm/pgalloc.h>
  
  static struct vfsmount *shm_mnt;
  
@@ -1812,7 +1815,27 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
  repeat:
  	if (sgp <= SGP_CACHE &&
  	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode)) {
-		return -EINVAL;
+		unsigned long dst_addr = vmf->address;
+		pte_t _dst_pte, *dst_pte;
+		spinlock_t *ptl;
+		int ret;
+
+		if (!IS_NOFAULT(inode))
+			return -EINVAL;
+
+		_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
+					 vma->vm_page_prot));
+		dst_pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, dst_addr, &ptl);
+		ret = -EEXIST;
+		if (!pte_none(*dst_pte))
+			goto out_unlock;
+		set_pte_at(vma->vm_mm, dst_addr, dst_pte, _dst_pte);
+		update_mmu_cache(vma, dst_addr, dst_pte);
+		*fault_type = VM_FAULT_NOPAGE;
+		ret = 0;
+out_unlock:
+		pte_unmap_unlock(dst_pte, ptl);
+		return ret;
  	}
  
  	sbinfo = SHMEM_SB(inode->i_sb);
@@ -3819,6 +3842,23 @@ const struct address_space_operations shmem_aops = {
  };
  EXPORT_SYMBOL(shmem_aops);
  
+static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+
+	fileattr_fill_flags(fa, inode->i_flags);
+
+	return 0;
+}
+
+static int shmem_fileattr_set(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	inode->i_flags = fa->flags;
+	return 0;
+}
+
  static const struct file_operations shmem_file_operations = {
  	.mmap		= shmem_mmap,
  	.get_unmapped_area = shmem_get_unmapped_area,
@@ -3836,6 +3876,8 @@ static const struct file_operations shmem_file_operations = {
  static const struct inode_operations shmem_inode_operations = {
  	.getattr	= shmem_getattr,
  	.setattr	= shmem_setattr,
+	.fileattr_get	= shmem_fileattr_get,
+	.fileattr_set	= shmem_fileattr_set,
  #ifdef CONFIG_TMPFS_XATTR
  	.listxattr	= shmem_listxattr,
  	.set_acl	= simple_set_acl,
