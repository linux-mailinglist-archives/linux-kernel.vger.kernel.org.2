Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FD23895EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhESS5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:57:54 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21340 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhESS5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:57:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621450580; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RbxLJCHc9AtpzfRDZOuWQPZ4rX6hiharBEuk0jewMgnEE2nC6rQkSxkLHFMAn+6VWtOvUW/Qy4ZGFa4OCLi3W69mvVszGcjnWWAc+MOr6klq9HcBgkmwsiJmtchrnxq5Y9faEb9st6i4Tc5zRNjTkF2k9kAMrE8QII+Fr1lmg58=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1621450580; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=kPdwiwE6lZBN2kAHXvK07bmx9Y+Is8JOiZE4Jiblt2A=; 
        b=DJwPb10rLbRLyvfmwb9i2pmRpu/TNg03wmm0Fya0oMHK9J6nzQ3i8SaQFMl4KmSNzJmYkv2ZgksjxRczxxa4VUldqsyd8GTwD2SSeqHn7bFdL324loVysHoZnbRfnRuowIzH0uO5EZFHYDDVCzUZ4wcmxpT0x+tKsqT0ZtmJozw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1621450580;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=kPdwiwE6lZBN2kAHXvK07bmx9Y+Is8JOiZE4Jiblt2A=;
        b=mUs0JgSiDZcuWtMykbTy1/tjFFJAVUxj+XsMWmawwvuxtrPV2kiqXlih79ssbJxd
        BsfLC5GdLKlQoU+Rql+zqbcsRiMF9FNlXiJShZAbYb90kNnejkhWZpiF4AVwGVslDq1
        pEl4aav3GgdLZ8pHCMARPajI4DZ6wVhpQRtTEoDE=
Received: from anirudhrb.com (49.207.58.139 [49.207.58.139]) by mx.zohomail.com
        with SMTPS id 1621450578322369.60726490083687; Wed, 19 May 2021 11:56:18 -0700 (PDT)
Date:   Thu, 20 May 2021 00:26:12 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
Message-ID: <YKVfTKkxrn72TDqe@anirudhrb.com>
References: <20210518155921.4181-1-mail@anirudhrb.com>
 <20210519091047.1477-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519091047.1477-1-hdanton@sina.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 05:10:47PM +0800, Hillf Danton wrote:
> On  Tue, 18 May 2021 21:29:20 +0530 Anirudh Rayabharam wrote:
> >This use-after-free happens when a fw_priv object has been freed but
> >hasn't been removed from the pending list (pending_fw_head). The next
> >time fw_load_sysfs_fallback tries to insert into the list, it ends up
> >accessing the pending_list member of the previoiusly freed fw_priv.
> >
> >The root cause here is that all code paths that abort the fw load
> >don't delete it from the pending list. For example:
> >
> >	_request_firmware()
> >	  -> fw_abort_batch_reqs()
> >	      -> fw_state_aborted()
> >
> >To fix this, delete the fw_priv from the list in __fw_set_state() if
> >the new state is DONE or ABORTED. This way, all aborts will remove
> >the fw_priv from the list. Accordingly, remove calls to list_del_init
> >that were being made before calling fw_state_(aborted|done)().
> >
> >Also, in fw_load_sysfs_fallback, don't add the fw_priv to the list
> >if it is already aborted. Instead, just jump out and return early.
> >
> >Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> >Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> >Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> >Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> >---
> >
> >Changes in v4:
> >Documented the reasons behind the error codes returned from
> >fw_sysfs_wait_timeout() as suggested by Luis Chamberlain.
> >
> >Changes in v3:
> >Modified the patch to incorporate suggestions by Luis Chamberlain in
> >order to fix the root cause instead of applying a "band-aid" kind of
> >fix.
> >https://lore.kernel.org/lkml/20210403013143.GV4332@42.do-not-panic.com/
> >
> >Changes in v2:
> >1. Fixed 1 error and 1 warning (in the commit message) reported by
> >checkpatch.pl. The error was regarding the format for referring to
> >another commit "commit <sha> ("oneline")". The warning was for line
> >longer than 75 chars. 
> >
> >---
> > drivers/base/firmware_loader/fallback.c | 46 ++++++++++++++++++-------
> > drivers/base/firmware_loader/firmware.h |  6 +++-
> > drivers/base/firmware_loader/main.c     |  2 ++
> > 3 files changed, 40 insertions(+), 14 deletions(-)
> >
> >diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> >index 91899d185e31..f244c7b89ba5 100644
> >--- a/drivers/base/firmware_loader/fallback.c
> >+++ b/drivers/base/firmware_loader/fallback.c
> >@@ -70,7 +70,31 @@ static inline bool fw_sysfs_loading(struct fw_priv *fw_priv)
> > 
> > static inline int fw_sysfs_wait_timeout(struct fw_priv *fw_priv,  long timeout)
> > {
> >-	return __fw_state_wait_common(fw_priv, timeout);
> >+	int ret = __fw_state_wait_common(fw_priv, timeout);
> >+
> >+	/*
> >+	 * A signal could be sent to abort a wait. Consider Android's init
> >+	 * gettting a SIGCHLD, which in turn was the same process issuing the
> >+	 * sysfs store call for the fallback. In such cases we want to be able
> >+	 * to tell apart in userspace when a signal caused a failure on the
> >+	 * wait. In such cases we'd get -ERESTARTSYS.
> >+	 *
> >+	 * Likewise though another race can happen and abort the load earlier.
> >+	 *
> >+	 * In either case the situation is interrupted so we just inform
> >+	 * userspace of that and we end things right away.
> >+	 *
> >+	 * When we really time out just tell userspace it should try again,
> >+	 * perhaps later.
> >+	 */
> >+	if (ret == -ERESTARTSYS || fw_state_is_aborted(fw_priv))
> >+		ret = -EINTR;
> >+	else if (ret == -ETIMEDOUT)
> >+		ret = -EAGAIN;
> >+	else if (fw_priv->is_paged_buf && !fw_priv->data)
> >+		ret = -ENOMEM;
> >+
> >+	return ret;
> > }
> > 
> > struct fw_sysfs {
> >@@ -91,10 +115,9 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
> > 	 * There is a small window in which user can write to 'loading'
> > 	 * between loading done and disappearance of 'loading'
> > 	 */
> >-	if (fw_sysfs_done(fw_priv))
> >+	if (fw_state_is_aborted(fw_priv) || fw_sysfs_done(fw_priv))
> > 		return;
> > 
> >-	list_del_init(&fw_priv->pending_list);
> > 	fw_state_aborted(fw_priv);
> > }
> > 
> >@@ -280,7 +303,6 @@ static ssize_t firmware_loading_store(struct device *dev,
> > 			 * Same logic as fw_load_abort, only the DONE bit
> > 			 * is ignored and we set ABORT only on failure.
> > 			 */
> >-			list_del_init(&fw_priv->pending_list);
> > 			if (rc) {
> > 				fw_state_aborted(fw_priv);
> > 				written = rc;
> >@@ -513,6 +535,11 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
> > 	}
> > 
> > 	mutex_lock(&fw_lock);
> >+	if (fw_state_is_aborted(fw_priv)) {
> >+		mutex_unlock(&fw_lock);
> >+		retval = -EINTR;
> >+		goto out;
> >+	}
> > 	list_add(&fw_priv->pending_list, &pending_fw_head);
> 
> This looks like prepare_to_wait().
> 
> > 	mutex_unlock(&fw_lock);
> > 
> >@@ -526,20 +553,13 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
> > 	}
> > 
> > 	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
> >-	if (retval < 0 && retval != -ENOENT) {
> >+	if (retval < 0) {
> > 		mutex_lock(&fw_lock);
> > 		fw_load_abort(fw_sysfs);
> 		  __fw_load_abort();
> 		    fw_state_aborted();
> 		      __fw_state_set();
> 
> Is this your finish_wait() part? See what you add below.
> 
> > 		mutex_unlock(&fw_lock);
> > 	}
> > 
> >-	if (fw_state_is_aborted(fw_priv)) {
> >-		if (retval == -ERESTARTSYS)
> >-			retval = -EINTR;
> >-		else
> >-			retval = -EAGAIN;
> >-	} else if (fw_priv->is_paged_buf && !fw_priv->data)
> >-		retval = -ENOMEM;
> >-
> >+out:
> > 	device_del(f_dev);
> > err_put_dev:
> > 	put_device(f_dev);
> >diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> >index 63bd29fdcb9c..36bdb413c998 100644
> >--- a/drivers/base/firmware_loader/firmware.h
> >+++ b/drivers/base/firmware_loader/firmware.h
> >@@ -117,8 +117,12 @@ static inline void __fw_state_set(struct fw_priv *fw_priv,
> > 
> > 	WRITE_ONCE(fw_st->status, status);
> > 
> >-	if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED)
> >+	if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED) {
> >+#ifdef CONFIG_FW_LOADER_USER_HELPER
> >+		list_del_init(&fw_priv->pending_list);
> >+#endif
> > 		complete_all(&fw_st->completion);
> >+	}
> 
> Fine, apart from what you are fixing, you are adding something like
> finish_wait() into the waker's backyard. Why are you calling
> complete_all() on the waiter side?

Sorry, I don't really get your point here. I did not add complete_all().
It was already there. Could you please elaborate?

	- Anirudh.

> 
> > }
> > 
> > static inline void fw_state_aborted(struct fw_priv *fw_priv)
> >diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> >index 4fdb8219cd08..68c549d71230 100644
> >--- a/drivers/base/firmware_loader/main.c
> >+++ b/drivers/base/firmware_loader/main.c
> >@@ -783,8 +783,10 @@ static void fw_abort_batch_reqs(struct firmware *fw)
> > 		return;
> > 
> > 	fw_priv = fw->priv;
> >+	mutex_lock(&fw_lock);
> > 	if (!fw_state_is_aborted(fw_priv))
> > 		fw_state_aborted(fw_priv);
> >+	mutex_unlock(&fw_lock);
> > }
> > 
> > /* called from request_firmware() and request_firmware_work_func() */
> >-- 
> >2.26.2
