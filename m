Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE2447308
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhKGNSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 08:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhKGNSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 08:18:44 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2CEC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 05:16:02 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r12so51424172edt.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 05:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Je5hDQMIRJ/aKOcOoapBhm7Gdjtc8kk4qY79WTxgwEE=;
        b=nu4IDGR8phkVeLe2ckx2wCGZQ1g+XDvFXgFPhi6MqYK5wfYtORWmpV5mR/mGQUB2wj
         u9tLyagbX8Bb1nr7C0zGL4BIFHe8I83v8seK8q83qU4kaazbjzHq/RiCm8qn66NI0+KW
         4UuwtI1vSKajEYFHjA++sudhh4imUsKBwWmktoLxtP1YoVilbmTEzrTljnr+uU2VIw5X
         7Gqixw5Yr8VeVhiU9S4mgoTNfbFDBe2760qXGtppZRIkC/71RxDBvSTEYI6/QwE5O73k
         rlBsfJFZKjbgfrp91/pYnX2NFrAsMTpTPUbfB5fK4o9Ov2mdxuyml01nlITU1Y2zH0H+
         IVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Je5hDQMIRJ/aKOcOoapBhm7Gdjtc8kk4qY79WTxgwEE=;
        b=mwoseECmTpKs2Gj1ZjpsxRpdg1IKv1ShmCaESknEXmyS+ZFyA2va97TL09Vms4Utjs
         Q+pbhiyakT/kaZhNm4wyjwa0qaVlpbuaH9GkAUHm5E8NRAlf+Cx9zL6Y0dLZgW5BnLRo
         UOVtZlve6NKnH3QLaxs2LC2Nr1hKGcnIkFfAPbUDJgzUJz9xBF0H8dlGygl9zv5ZFx1X
         n0RPCbkeDCpQs5sXAFovZnmh3A2dYH3t/H2lBAl8YPxF2O0PZpNgaCiOVFRQ1GXOwmbr
         U8BaNj4t85p2viiSx5usjmimSNGVrx2itzlIUlQY/+xdLWIYe/8eD+/hMRJJnvu332pp
         D45Q==
X-Gm-Message-State: AOAM532xglkRv0VqcUI6YuU0p9CBPZAb8sSWyND53sm9QuV7ohvL5PD3
        /O3Uf+eAYoStdHg5l1DLev2otGPURe0=
X-Google-Smtp-Source: ABdhPJwCvEMtUYIGNHunEZRjlRkmwZOofWCSptscM7qAH6EJC+94JC1e0cksu68EhA9c52X7F2LyYA==
X-Received: by 2002:a05:6402:d0e:: with SMTP id eb14mr37141350edb.59.1636290960720;
        Sun, 07 Nov 2021 05:16:00 -0800 (PST)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id hp3sm6890994ejc.61.2021.11.07.05.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 05:16:00 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Sun, 07 Nov 2021 14:15:59 +0100
Message-ID: <6109499.H5l3i5aCOD@localhost.localdomain>
In-Reply-To: <YYfIywQ3AqrWbi8z@kroah.com>
References: <20211101191847.6749-1-fmdefrancesco@gmail.com> <2389191.WthrnW1hFq@localhost.localdomain> <YYfIywQ3AqrWbi8z@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 7, 2021 1:38:35 PM CET Greg Kroah-Hartman wrote:
> On Sun, Nov 07, 2021 at 12:43:51PM +0100, Fabio M. De Francesco wrote:
> > On Monday, November 1, 2021 8:18:47 PM CET Fabio M. De Francesco wrote:
> > > Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> > > report_del_sta_event(). This function is called while holding 
spinlocks,
> > > therefore it is not allowed to sleep. With the GFP_ATOMIC type flag, 
the
> > > allocation is high priority and must not sleep.
> > > 
> > > This issue is detected by Smatch which emits the following warning:
> > > "drivers/staging/r8188eu/core/rtw_mlme_ext.c:6848 
report_del_sta_event()
> > > warn: sleeping in atomic context".
> > > 
> > > After the change, the post-commit hook output the following message:
> > > "CHECK: Prefer kzalloc(sizeof(*pcmd_obj)...) over
> > > kzalloc(sizeof(struct cmd_obj)...)".
> > > 
> > > According to the above "CHECK", use the preferred style in the first
> > > kzalloc().
> > > 
> > > Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for kalloc() 
and 
> > kzalloc()")
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---

> > > [...]

> > Please let me know if there is something that prevents this patch to be 
> > applied. I have no problem in changing / adding whatever it is needed.
> 
> Nothing needs to be done, I am waiting for 5.16-rc1 to be released
> before I pick up this patch, and others that will be targeted for
> 5.16-final.  Only then will I queue them up, as the automated email you
> should have gotten when you submitted the patch said would happen.
> 
> Just relax, there is no rush here :)
> 

Oh, sorry Greg. There must be something that I haven't understand about the 
development process... :(

Obviously I agree that there is no rush here :)

As I said, this morning I read git log and saw patches that seemed more 
recent; thus I thought that was the case to ask. I just (wrongly) thought 
that the v3 of the patch got unnoticed or dropped  because of some requests  
that I had missed. 

Thanks for the explanation,

Fabio

> thanks,
> 
> greg k-h
> 




