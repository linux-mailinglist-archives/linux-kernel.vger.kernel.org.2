Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBAA37A0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhEKHdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKHdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:33:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C65C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:32:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so28228348ejo.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y0gafmDzR0vFsDlaNMWdxGlmSzULQyTxhSAmzSE7VI0=;
        b=D67R1Rxf8Nc/bvHV8hB6cxH0a0UYTl0OhUniYa68J6Q+V0/t1QHbLaeFcRep8//vnM
         VVmnGy6g6MtsP8IOd+WGPJqMNWhxJg8c27pOzsvQOS/s1CCBpN1gMXD3rH4PMnWb4phQ
         dLmqisoKPpuNgOtpZB2y1sh/6dwKexgvn+14J1A07/mOmMkmuVe/5zYpEvVHWN31QGkl
         nt/wLsypDdJe0Mwo8uaMg8MxM9QnskMQyOeqitsHA3aMFTcWKJP8FVKBaqBP7NcvW5je
         f1K1faLVxYqrGQRi8FiCOJ8QA/wMRumRDRZwTqBBQmdy3S//3718i/7jF77MomyudVBg
         5kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=y0gafmDzR0vFsDlaNMWdxGlmSzULQyTxhSAmzSE7VI0=;
        b=g7Qt3VBq5k+gYYS827RFHf1dt0uZf0BqvDYA0iO41JcbDTCZaAOHee+8Ie4oCsiiaT
         vOb+2ezZjKcEpnhh8su4zA0sz5JdQYLYPe7wSHSnehv3kGMwx1qM+LCJchrMVkNVrRtb
         B6QzxODzwkZxEHo1xyieBrbOzzqH+MR5oGtmvgdZd/rTp5/6+QaPu/edpBLE2Nfud+7c
         1KZyGsuEXOE84aHojuiROmMrEFf0xDzz9bk7DhDWQ0ECJPJfgahSo7/XPRc7JsNZvnYE
         uBIxzSowiZFbuGc9ro7LOcfi4cLoU9SF9IEL/RXj8RWu8aORRTtgvlUA4Kd3rMiA6s1L
         PFpw==
X-Gm-Message-State: AOAM531T04/K/bgdhr8wsOCYREttrvC4/EE3cYIRcc0YpKp6yIjiv7hU
        HLPUFtEfShuq8nsfEICWPnI=
X-Google-Smtp-Source: ABdhPJw/TLKWxESHeaObtsdENg8rS9vhfFnrR1y9S13S/Uh/4CUc5LD6xSnAHmLIR7VuG5qWd9VMDg==
X-Received: by 2002:a17:906:1185:: with SMTP id n5mr30866792eja.468.1620718362191;
        Tue, 11 May 2021 00:32:42 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id w2sm11759389edl.53.2021.05.11.00.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:32:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 11 May 2021 09:32:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, bristot@redhat.com, yejune.deng@gmail.com
Subject: Re: [PATCH 1/2] sched: Make the idle task quack like a per-CPU
 kthread
Message-ID: <YJozF+wmiMYuSa6/@gmail.com>
References: <20210510151024.2448573-1-valentin.schneider@arm.com>
 <20210510151024.2448573-2-valentin.schneider@arm.com>
 <87k0o6int0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0o6int0.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 10/05/21 16:10, Valentin Schneider wrote:
> > This requires some extra iffery as init_idle()
> > call be called more than once on the same idle task.
> >
> 
> While I'm at it, do we actually still need to suffer through this?

No.

> AFAICT the extra calls are due to idle_thread_get() (used in cpuhp) 
> calling init_idle(). However it looks to me that since
> 
>   3bb5d2ee396a ("smp, idle: Allocate idle thread for each possible cpu during boot")
> 
> we don't need to do that: we already have a
> 
>   for_each_possible_cpu(cpu)
>     init_idle(cpu)
> 
> issued at init. So can't we "simply" rely on that init-time creation, 
> given it's done against the possible mask? I think the only thing that 
> might need doing at later hotplug is making sure the preempt count is 
> right (secondary startups seem to all prepare the idle task by issuing a 
> preempt_disable()).

Best-case it works, worst-case we discover an unclean assumption in the 
init sequence and it works after we fix that.

Win-win. :-)

Thanks,

	Ingo
