Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E243FDD89
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244707AbhIAN5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhIAN5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:57:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB00C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 06:56:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h9so6869018ejs.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRrNhgrDIwSehOjM+0QWWad7e+b+lvVLJyyUCl9/Exk=;
        b=FewNOuSfaXBPf5PjzcdFZgDeR+uXL3OAdSKgY1radiJb0OnEwmABD866so4RSH96Iz
         PBSqXj/lVJs0NSGYjeucv81XG/L0GBO3ytFxLGqDvL2rm8xczWiyIDoHWQlB2UFWPAD7
         AfkW3KS1y+E6EvfBl3nVFaOlsKEp+n9NB0/JIE6wRcOgcWZjnKzr1rkS/YDoN5OZHQxZ
         bv2BkbLlZj+UiN+knYKxTXfOfYDqCyyheI7ka2b9QFQ2if58ZbIFqhPrx+mUSfzmNyFe
         9vjOIgFzR+8MOLauC57u82SGh/+nvGje5Voo4X/ryP0p9pJWnWUtqmgSDRCIXMcvyT6a
         em3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRrNhgrDIwSehOjM+0QWWad7e+b+lvVLJyyUCl9/Exk=;
        b=cZcytqJ/EYnnJiFjzPxu9/cLtfrDZx5+kvLgJRz3hAuqE65iwqVW5KuDFKNQiks/Uu
         D2Y4fE2ynD9+jsL1ck/FX64gCTbaNfrtJxMSEGmSUUc4G4XFgIB500L7pc7zrYTUdwHT
         CJpoxFug3Yw9pGhTvwIGZubyfBAPr1pnFuAvhReseuMvnK9bJE1cvOjafWSeSjuwRduO
         tFoo5VrSz6Ofr3sPEtqMfP96jhOcNNkC/mHcWRqYISznFSZLFBP3flD0N2otHgmuQZWE
         PkYd/UFTbSisP39od5ZtYVluwaP76+zG9jxoPOc1PVZRKJqBUarP+LXYoFkmG3truI40
         WGjg==
X-Gm-Message-State: AOAM530TwLN1TkyhcOjiUfSmRiaUm8E1+HgN65Ro+2ClmPYfDjv0DQgY
        SvNnGXb5i0KLiSH2TJxu7gs=
X-Google-Smtp-Source: ABdhPJx/c4ausu3jMt9m8i3ag5V/dPMIynN1X73PIVTKfku986poAoon7KEdUGEkoyOhKqDMx2BLKw==
X-Received: by 2002:a17:906:b14d:: with SMTP id bt13mr37365394ejb.39.1630504582933;
        Wed, 01 Sep 2021 06:56:22 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id bt24sm20384ejb.77.2021.09.01.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:56:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alex Elder <elder@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH v4] staging: greybus: Convert uart.c from IDR to XArray
Date:   Wed, 01 Sep 2021 15:56:20 +0200
Message-ID: <8914101.vIO1HAjRha@localhost.localdomain>
In-Reply-To: <794b3ff8-0240-ff14-8721-cdf510f52be3@linaro.org>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com> <6155058.TBsaUTXu4T@localhost.localdomain> <794b3ff8-0240-ff14-8721-cdf510f52be3@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 1, 2021 2:09:16 PM CEST Alex Elder wrote:
> On 8/31/21 6:50 AM, Fabio M. De Francesco wrote:
> > I was wrong in assuming that trivial patches to Greybus are welcome as 
they 
> > are for other drivers.
> 
> This is not a correct statement.

Yes, I agree: it's not a correct statement. Please let me explain what I was 
trying to convey with that consideration...

The Mutexes were there around idr_find() and I decided to leave the code as 
it was. Who am I to say that they are not necessary? I must stay on the safe 
side. First because I don't know how the drivers work (can that critical 
section really be entered by different threads that could possibly share the 
gb_tty that is retrieved by xa_load()? Even if xa_load() always give you back 
the right gb_tty, how do I know if in the while other threads change its 
fields or destroy the object? I guess I should stay on the safe side and 
leave the Mutexes there, exactly were they were.

These are the reason why v1 was indeed a trivial patch. But v2 *was not* 
because you wrote that you were pretty sure they were unneeded and you asked 
me to leave them or remove them and in either case I had to provide a reason 
why. 

I guess that in v1 I should not provide a reason why they are still there, as 
well as I don't have to provide any reason on why the greybus code (line by 
line) is as it is: it is out of the scope of my patch. Am I wrong?

Your note about the possibility that the mutexes could be removed pushed me 
beyond what I need to know to accomplish the intended task. 

Anyway I tried to reason about it. I perfectly know what is required to 
protect critical sections of code, but I don't know how drivers work; I mean 
I don't know whether or not different threads that run concurrently could 
really interfere in that specific section. This is because I simply reason in 
terms of general rules of protection of critical section but I really don't 
know how Greybus works or (more in general) how drivers work.

I still think that if I stayed within the bounds of my original purpose I 
didn't have to reason about this topic and that the v1 patch was trivial.
v2 was not!

I'm sorry because I'm still not sure if I was able to conveyed what I thought 
and still think.

> But as Johan pointed out, even for a trivial patch if you
> must understand the consequences of what the change does.
> If testing is not possible, you must work extra hard to
> ensure your patch is correct.

Again, I don't see any possible harm with the mutexes in place :)
 
> In the first (or an early) version of your patch I pointed
> out a bug.  Later, I suggested
>  the lock might not be necessary
> and asked you to either confirm
>  it was or explain why it was
> not, but you didn't do that.

This was beyond my knowledge and perhaps unnecessary (sorry if I insist on 
that :)).

> I agree that the change appeared trivial, and even sensible,
> but even trivial patches must result in correct code.  And
> all patches should have good and complete explanations.
>
>	- Alex

Is v2 correct with the mutexes restored where they were? I guess it is.

Thanks for you kind review and the time you spent for me. I appreciated it, 
seriously.

Fabio	


