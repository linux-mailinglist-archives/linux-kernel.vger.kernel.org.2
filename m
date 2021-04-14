Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A9835F07C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhDNJMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:12:13 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21350 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhDNJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:12:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618391506; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QMHhcgxPPNSCRuRZ5p+tWwJVttj2dn1QIO1Y2jmBl88zrYvBWCNsd8kb2PHIvZLLCwgxO4ahzjCJxNRBgAykX2Irt1ORYrNSSSv2VlGGSjbratWoxEV4KOV4NC4XcjjE2uZrAvwvZbJFO3wA3lafeKBNWnmNJfdEvrU3wc5AuzY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1618391506; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Zi1pCymnws3KmFT5eK4yZ89uZWqTyFy2eL+2AksUNN0=; 
        b=YciDOzjttUtvUCGybR7ATK7OPEY5epjZVNzw54JEIjObqDejay4aSzzVBynj88Db8Ud9fO0Zt5SXbPxsHdW8ULI2JWUqKp4xL1SAa/HYBIQllFi7kktZW0ms0ZhLraiVadJ4+5Q+AKQ5Or8Fz8urlAF3artOyB7+doRWgaqCeB4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618391506;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=Zi1pCymnws3KmFT5eK4yZ89uZWqTyFy2eL+2AksUNN0=;
        b=wERjucwUFIrHGI8K6wfPVMWoDPa6kRz5g1vin9cHzBVfNCxSXNm2IGYG4F9G8QCa
        z8cKhmk5CYIQP79yXK/qjAtzXuVjVSTyL38J95HdHbrMT1UrddO31vk074uq8u0G8q1
        dnqgplMoFl504D4UmLbjuvISWh5+sObi9W+ly9qo=
Received: from anirudhrb.com (49.207.201.215 [49.207.201.215]) by mx.zohomail.com
        with SMTPS id 16183915039067.846894114221527; Wed, 14 Apr 2021 02:11:43 -0700 (PDT)
Date:   Wed, 14 Apr 2021 14:41:37 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
Message-ID: <YHaxySNDxXIRp+eH@anirudhrb.com>
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

I have now sent a v3 that is more along the lines of the patch suggested
in the above thread.

Thanks!

	- Anirudh.

