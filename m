Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95AE3F3F74
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 15:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhHVNWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 09:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHVNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:22:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277D4C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:21:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g21so21753125edw.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zqTECFuRJLYarOpHoCCGqs8juSsxGgWk5yRR8uFe8PQ=;
        b=B0zxd0DrjaauXCH+xSyRZj73jq8+b3uylHtP4zqqDF4bCYYG5qLbEYqOom/Z/x1Xnl
         KDqKU8vv5PqjsHIBs2imIBvph+BPJHQE2wPBvnZtE2U6qsQ15UkUtmKktLRHU6fRSBhC
         z5McxyJM1eqccfMarsX7TYICT7JidPetxYzW2sSzB+RyjYzQjR97V1waKYbrABfsS9Rt
         AmsSBUtZmttjq77ny6qqOk4UIjjLfKw33Dv4nPKpl4/GULkfPgwBmygStXX9dvZuLv4o
         /M0Uu4gkA4Jy+XytmbCR1OOF7nHecmEKxFiBLmjulcNheI7lfOzjJ6rLQp76GAPzibzv
         Pynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqTECFuRJLYarOpHoCCGqs8juSsxGgWk5yRR8uFe8PQ=;
        b=LjIZ6xCMQKKfFxJq3EgeHYmd6pCG/e1PJM7pMQUXP0JwN1T7xrGXiuW46RU5XzqJLU
         mdeIgQe5+t0aPdczWMeiwHT5MDwvyd8ohy55l3VdpvNR2sew5YOT2+a+Y98ynRylvZdB
         PU4beHldM69apc3AMNEo9i22lsWZyRslRmjErMFJG4JWkRVAY03qIGzOmYyoivWjbHLZ
         8Z9q40B1NoqPSxqtx132QVdPisvQAFdJODvRt9WI1IzDzyXsrNVFw3o/5HbW4EmmY4US
         SmphYhn4y7kF/OvMcWuVEuGUID1MRkgN9MX5jvqLWy20cA9BzJ43TS/nsYb/sS4txLXK
         g9Fw==
X-Gm-Message-State: AOAM530ii/omtVRjA0O7Ml6wI4/U2+u8u9KNq0ajZMZVrlYC09zc7E6U
        JMlrQ/5FdJC49pjAJBul5LQ=
X-Google-Smtp-Source: ABdhPJyVzQOLujp1q7XgHum80sFZZy2mfkNtS+ZQOQ8CQhKepPE7wo0EkLi53Kv1t72zSn9O6U2zlQ==
X-Received: by 2002:a05:6402:2302:: with SMTP id l2mr14428895eda.13.1629638492669;
        Sun, 22 Aug 2021 06:21:32 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id v13sm5727689ejh.62.2021.08.22.06.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 06:21:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
Date:   Sun, 22 Aug 2021 15:21:30 +0200
Message-ID: <2244219.zNr1yEsLHP@localhost.localdomain>
In-Reply-To: <YSJFhmTs74PUyo8b@kroah.com>
References: <cover.1629479152.git.paskripkin@gmail.com> <435eea22-da31-1ebc-840c-ee9e42b27265@gmail.com> <YSJFhmTs74PUyo8b@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 22, 2021 2:39:34 PM CEST Greg KH wrote:
> On Sun, Aug 22, 2021 at 03:10:56PM +0300, Pavel Skripkin wrote:
> > On 8/22/21 1:59 PM, Fabio M. De Francesco wrote:
> > > On Sunday, August 22, 2021 12:09:29 PM CEST Pavel Skripkin wrote:
[...]
> > > So, it's up to the callers to test if (!_rtw_read*()) and then act
> > > accordingly. If they get 0 they should know how to handle the errors.
> > 
> > Yes, but _rtw_read*() == 0 indicates 2 states:
> > 	1. Error on transfer side
> > 	2. Actual register value is 0
> 
> That's not a good design, it should be fixed.  Note there is the new
> usb_control_msg_recv() function which should probably be used instead
> here, to prevent this problem from happening.

I think that no functions should return 0 for signaling FAILURE. If I'm not 
wrong, the kernel quite always prefers to return 0 on SUCCESS and <0 on 
FAILURE. Why don't you just fix this?

> > > In summation. if anything should be changed, it is the code of the 
callers of
> > > _rtw_read*() if you find out they they don't properly handle the 
returning
> > > values of this function. You should find every place where _rtw_read*() 
are
> > > called and figure out if the returns are properly checked and handled; 
if not,
> > > make some change only there.
> > > 
> > > Larry, Philip, where are you? Am I missing something?
> 
> Relax, there is no need to get jumpy, people do not have to respond
> instantly to emails here.  Especially when it is not their job to do so.

I should have placed a big smile at the end of the phrase. I was just kidding 
while trying to get their attention. I know there is no hurry and that no one 
has any obligation of this kind. Again, just kidding :)

Thanks,

Fabio

> greg k-h




