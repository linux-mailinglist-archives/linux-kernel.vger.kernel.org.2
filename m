Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A515C32C3CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhCCX7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 18:59:45 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:56594 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbhCCTij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:38:39 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHXIO-000RuW-N5; Wed, 03 Mar 2021 12:36:32 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHXIN-00Grlm-E2; Wed, 03 Mar 2021 12:36:32 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210213130042.828076-1-christian.brauner@ubuntu.com>
Date:   Wed, 03 Mar 2021 13:36:31 -0600
In-Reply-To: <20210213130042.828076-1-christian.brauner@ubuntu.com> (Christian
        Brauner's message of "Sat, 13 Feb 2021 14:00:42 +0100")
Message-ID: <m18s7481xc.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lHXIN-00Grlm-E2;;;mid=<m18s7481xc.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+pEkaRQEHDxGQEeFVuZBpYD2ocYNqs1yc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSexyCombo_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00,XM_Body_Dirty_Words
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
        *  1.0 XMSexyCombo_01 Sexy words in both body/subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 499 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 9 (1.9%), parse: 1.07 (0.2%),
         extract_message_metadata: 15 (2.9%), get_uri_detail_list: 3.4 (0.7%),
        tests_pri_-1000: 11 (2.2%), tests_pri_-950: 1.35 (0.3%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 87 (17.4%), check_bayes:
        85 (17.1%), b_tokenize: 10 (2.0%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 59 (11.8%), b_finish: 0.91
        (0.2%), tests_pri_0: 357 (71.6%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 1.82 (0.4%), poll_dns_idle: 0.48 (0.1%),
        tests_pri_10: 2.3 (0.5%), tests_pri_500: 9 (1.8%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [GIT PULL] idmapped mounts for v5.12
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Hi Linus,

> This series comes with an extensive xfstests suite covering both ext4 and xfs
> https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
> It covers truncation, creation, opening, xattrs, vfscaps, setid execution,
> setgid inheritance and more both with idmapped and non-idmapped mounts.
> It already helped to discover an unrelated xfs setgid inheritance bug which has
> since been fixed in mainline. It will be sent for inclusion with the xfstests
> project should you decide to merge this.

And yet chown is broken (details below), and in a very predictable way.

This is not considering that the entire concept is giving people a
loaded footgun, that is very difficult to use safely.


When the user namespace was implemented the two kinds of uids were very
carefully separated from each other by type, so it would be take
deliberate action to mix them.  These changes introduces a third type
of uid and does not use the type system to keep them separate.  In just
a little bit of looking since I realized this problem I have found two
bugs in chown where the wrong values are compared.

We now have the following types of uids and gids:
- The userspace values.
- The kernel values that are used for comparisons.
  (The old fashioned kuid_t and kgid_t)
- The values used for interfacing with the filesystems
  underneath a mount.
  (The beneath mount kuid_t and kgid_t)
- The values stored in the filesystem.

The third type is new, and the code mixes old fashioned kuid_t and
kgid_t with the below mount kuid_t and kgid_t.

Starting with chown_common the code does:

int chown_common(const struct path *path, uid_t user, gid_t group)
{
	...
	uid = make_kuid(current_user_ns(), user);
	gid = make_kgid(current_user_ns(), group);

	mnt_userns = mnt_user_ns(path->mnt);
	uid = kuid_from_mnt(mnt_userns, uid);
	gid = kgid_from_mnt(mnt_userns, gid);

retry_deleg:
	newattrs.ia_valid =  ATTR_CTIME;
	if (user != (uid_t) -1) {
		if (!uid_valid(uid))
			return -EINVAL;
		newattrs.ia_valid |= ATTR_UID;
		newattrs.ia_uid = uid;
	}
	if (group != (gid_t) -1) {
		if (!gid_valid(gid))
			return -EINVAL;
		newattrs.ia_valid |= ATTR_GID;
		newattrs.ia_gid = gid;
	}
	if (!S_ISDIR(inode->i_mode))
		newattrs.ia_valid |=
			ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_KILL_PRIV;
	inode_lock(inode);
	error = security_path_chown(path, uid, gid);
	if (!error)
		error = notify_change(mnt_userns, path->dentry, &newattrs,
				      &delegated_inode);
	inode_unlock(inode);
	...
}

Here security_path_chown is expecting the old fashioned kuid_t and
kgid_t but looking at the top of the function we can see that
security_path_chown is getting the kuid_t and kgid_t from below the
mount.

The Tomoyo lsm cares.


Notice that ia_uid and ia_gid in struct newattrs are below mount values.


Now looking in notify_change:

int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
		  struct iattr *attr, struct inode **delegated_inode)
{
	...
       	if (inode->i_op->setattr)
		error = inode->i_op->setattr(mnt_userns, dentry, attr);
	else
		error = simple_setattr(mnt_userns, dentry, attr);
        ...
}


int simple_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
		   struct iattr *iattr)
{
	...
	error = setattr_prepare(mnt_userns, dentry, iattr);
	if (error)
		return error;
	...
}


int setattr_prepare(struct user_namespace *mnt_userns, struct dentry *dentry,
		    struct iattr *attr)
{
	...
	/* Make sure a caller can chown. */
	if ((ia_valid & ATTR_UID) && !chown_ok(mnt_userns, inode, attr->ia_uid))
		return -EPERM;

	/* Make sure caller can chgrp. */
	if ((ia_valid & ATTR_GID) && !chgrp_ok(mnt_userns, inode, attr->ia_gid))
		return -EPERM;
	...
}

static bool chown_ok(struct user_namespace *mnt_userns,
		     const struct inode *inode,
		     kuid_t uid)
{
	kuid_t kuid = i_uid_into_mnt(mnt_userns, inode);
	if (uid_eq(current_fsuid(), kuid) && uid_eq(uid, kuid))
                                             ^^^^^^^^^^^^^^^^^^
		return true;
 	....               
}

The comparison of uid and kuid in chown_ok is nonsense.  As the kuid is
the old fashioned kuid.  While the uid is attr->ia_uid is the below
mount value.

I found these both within just a couple of minutes by creating
a type vfsuid_t and vfsgid_t and using it for the values stored in
struct inode and struct iattr.

There are probably more cases of inappropriate mixing.  I stopped as I
don't have the energy or the inclination to dig through and find more.

Unfortunately what I found was that the current design of using kuid_t
and kgid_t for both the old fashioned kuids and for the new below mount
values is so error prone that even the author of the change while
performing a lot of testing can not get it right.

Christian do you think you can add a type for the below mount values
and separate everything by type quickly?

Otherwise I think the better part of valor would be to revert this code
and come back it has made not error prone.

Eric

