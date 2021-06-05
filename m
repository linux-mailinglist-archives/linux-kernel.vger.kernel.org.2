Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD539C695
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 09:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFEHZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 03:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFEHZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 03:25:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EB0C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 00:23:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u18so9075327pfk.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 00:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fawb/pwqGsJ5FMKKdxYazd2mveTwll19w8a6+VcdOS0=;
        b=GAEoodR+hwXO9l89L0Vp8JQN9nbRvTA9z7tPg7WtdQ/5Vyn+NBSVJP71IwJ3qOSJ1T
         WOLUGWSIaHJblAUVdtX3n2YCvXJv+8uwhSZr42S7wHsQa1kvvOsKj3TABxCOtutN3R0t
         YOQd7BD/XKE1RQeNtl6WasxfbMDyexo5YhSggwSSxoxDdE/OaxYY1JCX6TURVDmFi/Hu
         FXponlt9vqYD+1VzMJrsD2YDlz5jCx0kg1sDOjpGfHQAE1Gvbw61JOGcqkOfD26yMjJ+
         5eOO+AGhcbRAOM0LEnEBsN2QzQ9N+7CiwHUDZ0oizbzwx3sX/r9J5ZnF4AYICVOGdmkA
         OJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fawb/pwqGsJ5FMKKdxYazd2mveTwll19w8a6+VcdOS0=;
        b=nKN59lhgh+xNgK3Y4blcI3ytjokgVNrrSWPG99XEtUIscJsqjhsl+GboyEARUPe2Z9
         /BF5UgFnUe3eHvfeWjoYQMAFTfxWIEF2Ua6cbmcrQsj90PEfv7jN4NXzfi0uO4CbQSJ+
         kcljNDD77dIgUfM9poF46F4yd5FhWG8mFJ9/ixRhwVnWFDI8VRfqdCgxRptGTvVVdHyG
         4zIUFqyAPTSRDuf1PjJKOI4aIKYfKtOe5ba+7DTmbJj0Ja3fNi5UZe7NXF4kYTu/nQTm
         r4dA7It+9gnEUVI3/Bo4KZgm0qbh63CZIY8H7Vd543Eh3VWaJEpCuINcf47BflmSiuPE
         PgFg==
X-Gm-Message-State: AOAM530zId6lTI6LkZ56oUxwJMsA5GPO6BbYyP4M92GT7+pYwRk80IO1
        JnuJoKF8XjlmLJ0gsVr3s88=
X-Google-Smtp-Source: ABdhPJwn2HVKvWOZVOc5ZHpICAPkc4mthNo+45OKnUAHXiOdJ9datqPrG+O+2HTopNeXFK432GxHHQ==
X-Received: by 2002:a05:6a00:ac9:b029:2de:a06d:a52f with SMTP id c9-20020a056a000ac9b02902dea06da52fmr8452051pfl.4.1622877823707;
        Sat, 05 Jun 2021 00:23:43 -0700 (PDT)
Received: from ojas ([182.69.197.102])
        by smtp.gmail.com with ESMTPSA id b8sm3002673pfo.64.2021.06.05.00.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 00:23:43 -0700 (PDT)
Date:   Sat, 5 Jun 2021 12:53:31 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, nsaenz@kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging: vc04_services: Need suggestions on trying to fix sparse
 warning in vchiq_arm.c
Message-ID: <20210605072249.GA5967@ojas>
References: <20210601200513.GA10204@ojas>
 <20210601202307.GC1955@kadam>
 <20210602145000.GA3999@ojas>
 <9ba341f7-17fc-980d-a7a0-2293c75dcf92@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba341f7-17fc-980d-a7a0-2293c75dcf92@i2se.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 08:13:06AM +0200, Stefan Wahren wrote:
> Hi Ojaswin,
> 
> Am 02.06.21 um 16:50 schrieb Ojaswin Mujoo:
> > On Tue, Jun 01, 2021 at 11:23:07PM +0300, Dan Carpenter wrote:
> >> The problem is not the Sparse warning, the problem is that this code is
> >> a mess.  It used to very clearly buggy and I reported the bug.  I think
> >> Arnd found the bug again independently and fixed it.
> >>
> >> A couple weeks ago Al Viro looked at this code.  Here is his write up:
> >>
> >> https://www.spinics.net/lists/kernel/msg3952745.html
> >>
> >> It shouldn't take Al Viro dozens of pages of detailed analysis to try
> >> figure out if the code is safe or not.  Your idea silences the warning
> >> but would make the code even more subtle and complicated.
> >>
> >> The right thing to do is to re-write the code to be simpler.
> >>
> >> regards,
> >> dan carpenter
> >>
> > Thank you for the prompt reply and the link, it was very insightful. You
> > are right, I was definitely going about this the wrong way and missing
> > the larger picture. I'll spend some time trying to understand this
> > codebase as I think that'd be a good start to understand how stuff works in
> > the kernel (even though some of the things in this driver are anti patterns)
> > and hopefully get some ideas on ways to clean this up.
> >
> > Anyways, thanks again for the help, cheers!
> 
> thanks for your interest in cleaning this up. Yes, it's not clear which
> points on the TODO list are the lower hanging fruits. In case you don't
> want to fix checkpatch issues, maybe you can look at points 8, 9, 10, 12
> and 13. Most of them require testing with a Raspberry Pi, but feel free
> to ask if you have problems with it.
> 
> Regards
> Stefan
> 

Got it, Task 10 (cdev to its own file) seems like a pretty good task to
get started with. I'm planning to buy a Rpi 4 so I think I can run tests
on that. 

Thank you so much for the help, I'll get back incase I face any issues down 
the line.

Regards,
Ojaswin

> >
> > Ojaswin
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
