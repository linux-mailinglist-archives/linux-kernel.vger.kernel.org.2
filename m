Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F8F35EC13
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 07:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347138AbhDNFGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 01:06:09 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21341 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347126AbhDNFGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 01:06:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618376744; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZdqeNSHZbb/Zk8m80iLwXl6b0+SNxv7kfk8ls47Us9gzfjAxEBrcukffgbYR+moD1/wfi80n/zwQVzbbFlK0nFfbxXJEzoNLXroTDwcaw5t+/Oi1rmrEpLqDtZXTGhWNL6Jlu684vh4r2UEP9F9Swj6uXCOd94gY97GZxaLRW8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1618376744; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=H/A60C8925QktAN4A0UmiS9hPF4vmMzZEGOIUltYo+8=; 
        b=XtZE7Xg5SPe6Ozev/lBuDkCOOw62rAkdPvoHMWKoidJuwjhPeQP7voQlzpj2T7sfnjDl9qCB+ru/VfZczWkL/kF7mDIethpmVG4MUEzFbhcatwXmpyffLbr02yci7hN7SmwBo0VgBYuwnUQyd7nSa7sJprSI2rZmTZKYeky2PAc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618376744;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=H/A60C8925QktAN4A0UmiS9hPF4vmMzZEGOIUltYo+8=;
        b=P+Q8uoLm1aI62lfdho/QdK4Ah0zDIYDGm0CJwl5jtuO03CsKeDT7X+2n3guo72Yr
        WUtuttT3gzynzB4HoI6MdsLAgfyEnZANkGOfiTWRbKbORtdqYnB1pdeCc64ZAmtCUaZ
        +dHZeu2Fe3fiIVrk/Fsl5d8LXSHKAsA7R6BpA2p0=
Received: from anirudhrb.com (49.207.201.215 [49.207.201.215]) by mx.zohomail.com
        with SMTPS id 1618376741670362.6507896787574; Tue, 13 Apr 2021 22:05:41 -0700 (PDT)
Date:   Wed, 14 Apr 2021 10:35:35 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, mail@anirudhrb.com
Subject: Re: [PATCH v2] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
Message-ID: <YHZ4Hy22Mt+KtlMH@anirudhrb.com>
References: <20210413104242.31564-1-mail@anirudhrb.com>
 <20210413165138.GI4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413165138.GI4332@42.do-not-panic.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:51:38PM +0000, Luis Chamberlain wrote:
> On Tue, Apr 13, 2021 at 04:12:42PM +0530, Anirudh Rayabharam wrote:
> > The use-after-free happens when a fw_priv object has been freed but
> > hasn't been removed from the pending list (pending_fw_head). The next
> > time fw_load_sysfs_fallback tries to insert into the list, it ends up
> > accessing the pending_list member of the previoiusly freed fw_priv.
> > 
> > In commit bcfbd3523f3c ("firmware: fix a double abort case with
> > fw_load_sysfs_fallback"), fw_load_abort() is skipped if
> > fw_sysfs_wait_timeout() returns -ENOENT. This causes the fw_priv to
> > not be removed from the pending list.
> > 
> > To fix this, delete the fw_priv from the pending list when retval
> > is -ENOENT instead of skipping the entire block.
> > 
> > Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> > Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> > Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> 
> Thanks for your patch Anirudh, but please also see this reply to the
> issue:
> 
> http://lkml.kernel.org/r/20210403013143.GV4332@42.do-not-panic.com

Hi Luis! Thanks for pointing me to this. I completely forgot to check
the existing discussion on this issue.

> 
> The way you patched the issue is just a band-aid, meaning we keep on
> moving the issue further and it seems that's just the wrong approach.
> 
> Can you try the patch in that thread, to verify if the UAF goes away?

The patch in that thread doesn't work. But I think I know what's
missing. The root problem here is that all code paths that abort fw load
don't remove it from the pending list. For example:

	_request_firmware()
	 -> fw_abort_batch_reqs()
	   -> fw_state_aborted()

In the above code path, the fw_priv is aborted but not removed from
pending list. So, the patch in the above thread fails because the load
is being aborted after it has been added to the list.

So, to fix the root cause of this issue we should make it so that all
aborts remove the fw_priv from the pending list. Perhaps we should add
a list_del_init in __fw_set_state() just before calling complete_all().
This way, all code paths that abort will delete the fw_priv from the
list.

The patch in the above thread also makes some changes to the error
codes. Since it isn't directly related to the UAF, the error codes
change should be a separate patch right?

Thanks!

	- Anirudh.
