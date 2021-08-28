Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FD33FA50D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhH1Kof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhH1Koe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:44:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8A2C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:43:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m4so5745419pll.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1f+cT+VJAS51jJ+h2gpiKcy14OxlVz6YvCOSyx2MnME=;
        b=oZ3ZLErOjhQyMFCiIQ3EZ8XK1u6SbSR0fl9NnF4wO2FQm2Fx/ccx6zKsPt4wvJd9eC
         jeZOlHYxp5/cEliJy23je/Ywdkg7Sn63IcTLaDZJ3PYGg2NuN5q2amtWc9HqvoUQyYar
         Wmc2dRaixDGBO4J0jdAXvicqWMCen4HRXy7mi6VlkoCqqvyy+31yPuQx/9mCufmGZ471
         9qxWpe0KP6L1gmpwR1FG9JV8qLcqs9rRMnMYbuNHZ+zAfdnP7byMrRuvS/hsnX9rkhth
         ypb4erbAZfIqQv0vtQEhJPKK67trkb3Y1rIDT0jaAwlP/2TZ8NZhXd33FRwOm1hFIKo5
         mP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1f+cT+VJAS51jJ+h2gpiKcy14OxlVz6YvCOSyx2MnME=;
        b=f0SWPK39PibpFJhCI8xB5q7NGhPMO4naoPtpe+68FI24ZJ1dAaRHhXIEaSp8F6VQBn
         SCfnSAkjSb3hUwxppC5GaNMQ9YvfZUXg2Ccdwnva75LXopOAwJ2HdxglqdPDYBr4qgT/
         I5mAOEOJT63yZn4CRusCnqxdvoMJrKXfRed6fd/M3fMBox0IaOhVsyqIyh2WhyvsLCab
         q5XXiqTRAmytItqa7QtXRksW1Cjy0gMCxYFzlP0WrXoDLmfqDIay9YPN2A+c9bJFKDjQ
         jqymri+4PBrJaNLn5XVMKW+HESZv2LVzMlFq5UZL6XyXEtYOCqBItPfBteeELUYQiIDA
         vXOg==
X-Gm-Message-State: AOAM533XMzbF+4x2hG8zIBNR/uHCv0zaEJzgtDdlgyfAjamr9M2Z78yT
        VrxAiHdqKAoxL0bi+npZtdU=
X-Google-Smtp-Source: ABdhPJw4VPobL8ViBRn4tBBCsMoFsY1DfA+hg0jzXCV4L5Ns1x0C4jLZXG8dSosjM/60k8Qp3eRUQw==
X-Received: by 2002:a17:90a:aa85:: with SMTP id l5mr16009069pjq.111.1630147423863;
        Sat, 28 Aug 2021 03:43:43 -0700 (PDT)
Received: from localhost.localdomain (125-237-24-95-adsl.sparkbb.co.nz. [125.237.24.95])
        by smtp.gmail.com with ESMTPSA id q126sm1246922pfc.156.2021.08.28.03.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 03:43:43 -0700 (PDT)
Date:   Sat, 28 Aug 2021 22:43:38 +1200
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     gregkh@linuxfoundation.org, hello@bryanbrattlof.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix docs typos and references to
 previous struct names
Message-ID: <20210828104338.GA8113@localhost.localdomain>
References: <20210828101242.GA6841@localhost.localdomain>
 <20210828102302.d7nhe2bkw6h5quqa@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828102302.d7nhe2bkw6h5quqa@kari-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 01:23:02PM +0300, Kari Argillander wrote:
> 
> Re: [PATCH] staging: pi433: fix ...
> 
> This is version 2. Subject needs to be [PATCH v2]. If you generate using
> git format-patch add "-v 2" in there.
> 
> On Sat, Aug 28, 2021 at 10:12:42PM +1200, Paulo Miguel Almeida wrote:
> > In the comments there where some grammar mistakes and references to
> > struct names that have gotten renamed over time but not updated
> > in the comments.
> > 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> 
> You should have log here what did you change from previous version as
> this is v2. You can also add who ask this change That should be like
> this:
> 
> ---
> Put your version log here.
> ---
> 

I see. Will do, thanks Kari :-)

