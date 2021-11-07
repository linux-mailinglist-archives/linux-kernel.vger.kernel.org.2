Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F57544732E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhKGOGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhKGOGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:06:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B252C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 06:03:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r12so51754475edt.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 06:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6sj1X95855j0rHhxAtqzBn1OgQs+JRxo8r/k2zLWbw=;
        b=jIWTCzx3JSwLNqCZ0yso0oIR9Y9fhln2u1zG5UtjkD/111wmQ8UmSNz9FJRidVQ/4C
         XWWtA1G3OWsfhiVqJ+5V9svtjP84+Fd+U7KX5mzKbMD3m5VZdVDaSjYzeGf49oEvztsZ
         TTnuqLPxL2apVtmCAe8SZiCNTiKiyB15mRpy/t7lcH8OhyAE+0G0Rhl3Ms7VraD4rJ1V
         jTsBzkIROOC5vmn7EpEFlc1Rm/2ZQ2VO7LxAr79Wy42oJEpis0lUNkCVe1/oihwhVDQN
         TTGXOZ6Z/d1ptod2qcjON1wZEThbRQmNnKVvbn+1b1WztNFeArfG0qVwXcWO8A2OYFXX
         PtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6sj1X95855j0rHhxAtqzBn1OgQs+JRxo8r/k2zLWbw=;
        b=8Gd+2Muen3v++dS0+MoIbGUvO1DcbTMV+Otghy0vai5nzGlKzoHtphfcYOZJmLkBGc
         V5l7PlcWxlJmdJ+vWIueG1GJ0e2q+ukEDRd04LaBMynA+nBKosNPNLlDRkWGMZrw65VU
         wr+5Tlrzj8+0qDtrp3Ru/Z69oTpJ0r6qxPj6HBjTNHkOlrWmt/eXXVLHIEoqEg34+F/y
         Bd2asH0uw7RmFRTgT/MM+QhkgfxVOlZZKNQQXPQGEKq1nlSVgbAwfKcH/bng2+47oYoO
         8GAfl1FhqnzSDVhTdrD4U9l9TsaE72LdynITGtQzkUCeeDNQTCR1ds6b4z7IvJ9VKf49
         O+Mg==
X-Gm-Message-State: AOAM5332VEs2+O39BSuhbmfdbM2X0Y12yirwHKfByFALME8pSDOv2Xsi
        upS4wnBI4X6nh/iMcwujfFc=
X-Google-Smtp-Source: ABdhPJz83LuCrauw4wOnWjxpB5Vsm7eXFWJhAN2Oij80vNBFJ6uSPVFmo4gokEyhw0aJULGKiU5Pjg==
X-Received: by 2002:aa7:cc96:: with SMTP id p22mr98182457edt.91.1636293803988;
        Sun, 07 Nov 2021 06:03:23 -0800 (PST)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id m11sm3963008edd.58.2021.11.07.06.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 06:03:23 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Sun, 07 Nov 2021 15:03:18 +0100
Message-ID: <2284999.BhpMBdGVLH@localhost.localdomain>
In-Reply-To: <YYfUywXdy3eyssyf@kroah.com>
References: <20211101191847.6749-1-fmdefrancesco@gmail.com> <6109499.H5l3i5aCOD@localhost.localdomain> <YYfUywXdy3eyssyf@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 7, 2021 2:29:47 PM CET Greg Kroah-Hartman wrote:
> On Sun, Nov 07, 2021 at 02:15:59PM +0100, Fabio M. De Francesco wrote:
> > On Sunday, November 7, 2021 1:38:35 PM CET Greg Kroah-Hartman wrote:
> > > On Sun, Nov 07, 2021 at 12:43:51PM +0100, Fabio M. De Francesco wrote:
> > > > On Monday, November 1, 2021 8:18:47 PM CET Fabio M. De Francesco 
wrote:
> > > > > Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> > > > > report_del_sta_event(). This function is called while holding 
> > spinlocks,
> > > > > therefore it is not allowed to sleep. With the GFP_ATOMIC type 
flag, 
> > the
> > > > > allocation is high priority and must not sleep.
> > > > > 
> > > > > This issue is detected by Smatch which emits the following warning:
> > > > > "drivers/staging/r8188eu/core/rtw_mlme_ext.c:6848 
> > report_del_sta_event()
> > > > > warn: sleeping in atomic context".
> > > > > 
> > > > > After the change, the post-commit hook output the following 
message:
> > > > > "CHECK: Prefer kzalloc(sizeof(*pcmd_obj)...) over
> > > > > kzalloc(sizeof(struct cmd_obj)...)".
> > > > > 
> > > > > According to the above "CHECK", use the preferred style in the 
first
> > > > > kzalloc().
> > > > > 
> > > > > Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for 
kalloc() 
> > and 
> > > > kzalloc()")
> > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > ---
> > 
> > > > > [...]
> > 
> > > > Please let me know if there is something that prevents this patch to 
be 
> > > > applied. I have no problem in changing / adding whatever it is 
needed.
> > > 
> > > Nothing needs to be done, I am waiting for 5.16-rc1 to be released
> > > before I pick up this patch, and others that will be targeted for
> > > 5.16-final.  Only then will I queue them up, as the automated email you
> > > should have gotten when you submitted the patch said would happen.
> > > 
> > > Just relax, there is no rush here :)
> > > 
> > 
> > Oh, sorry Greg. There must be something that I haven't understand about 
the 
> > development process... :(
> > 
> > Obviously I agree that there is no rush here :)
> > 
> > As I said, this morning I read git log and saw patches that seemed more 
> > recent; thus I thought that was the case to ask. I just (wrongly) thought 
> > that the v3 of the patch got unnoticed or dropped  because of some 
requests  
> > that I had missed. 
> 
> Be sure to notice what branch commits are being applied to.  There are
> different branches for a reason :)
> 
This is what confuses me:

--- git-log output ---

commit 8a893759d0075ea9556abcf86a4826d9865ba4bf (origin/staging-testing)
Author: Phillip Potter <phil@philpotter.co.uk>
Date:   Sat Nov 6 23:16:36 2021 +0000

    staging: r8188eu: remove MSG_88E macro

--- end of git-log output ---

Aside from the "Date" field, I know that this patch has been sent to the list 
during the last night and that it goes to the same branch (staging-testing) 
to which my patch should go. I know I'm still missing something, but I cannot 
understand what it is... :(

Anyway, never mind. I don't want to bother you with this silly questions :)

Again, thanks,

Fabio


