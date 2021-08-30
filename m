Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50463FBB4E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbhH3R6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbhH3R6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:58:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE2CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:57:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p38so33049432lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endian-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eTE3MdWDa0ijyIr/n6yzy10jcQzO9lkr6PVD0Y4UoUY=;
        b=uhp0aHQQuxkAg/lbFvL7BhuO82iq14fvJxGbehkYSmUHAZltMXDCpiemhqLKV4JTQL
         4Y4+wwnVqGMTFClUtzA8kXbD9BviIpR6Pgup4dTqjKLj7ArRoPwbE+SA9sCAJTkCNCLl
         T5tsOylKz4vcxwHKfYcESxUYJHWO+sGL+Ri3rwzmrrFBSdXdiOUFMmOEi+n1MCzizohw
         RBnD1mDxmC8NouJQQ8MsdApGnasXep2FFeQJmfSX2nyZ6bAPOnGhVM09N2Hk4ZlwmjVs
         ddx2RWiDkNBPTdeGKuNsPvJ6WiPi8/qYgioe+GLMWbA+j54CB3ByOIKNECKuhOOyNflW
         X+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eTE3MdWDa0ijyIr/n6yzy10jcQzO9lkr6PVD0Y4UoUY=;
        b=aYF6DWsJQYluatbd/aVv9+GCMUTdc21BB9V69K2NTekK0nZ7VHpKyTraXulShnDqOw
         6kxvGR9JLb5krx0w6nzhTqkpYOKLFVeDRf0LMrzZ3+g92CTNPGr0zo//xiu6mafG6x5d
         Uuphk699ZmG48tEY0J+PFpkXAI6QaEpdXn5Htf+yG9FlBmY0+7fcgbw7gv8Ab86wi4NJ
         RPaMGV/YPwkqSboPUFJJZLMQSea5lWx3sbLu20MlB39WXt2M7/3iLH07KMyTHBtpQicv
         iiusvfCt3Or3q8RVf0+iwWDfCFBWNrddWtcwcyshAIiFvDUbCa+k2zB787TY1SDbx2e2
         PFSw==
X-Gm-Message-State: AOAM531jINNreBmplTrSy5LsJNaS/L3DPtXd80xqpssOdc+5brS3T4QG
        I0ObQkJ8A2UnpMd6dUUq5YPZqw==
X-Google-Smtp-Source: ABdhPJz0uZJmum2UPKKohi4c/bbhh7aFZ6f4xzesF2fyfZTtA345efWueCklemI8QebbsyTAuOEF+Q==
X-Received: by 2002:a05:6512:2308:: with SMTP id o8mr18245900lfu.546.1630346228687;
        Mon, 30 Aug 2021 10:57:08 -0700 (PDT)
Received: from gmail.com ([185.213.154.232])
        by smtp.gmail.com with ESMTPSA id h9sm1583193lfv.190.2021.08.30.10.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 10:57:07 -0700 (PDT)
Date:   Mon, 30 Aug 2021 19:57:01 +0200
From:   Fredrik Yhlen <fredrik.yhlen@endian.se>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Horia Geanta Neag <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiko Schocher <hs@denx.de>
Subject: Re: HRNG in CAAM isn't working properly on IMX6 SoloX
Message-ID: <YS0b7ewOB5s/omu/@gmail.com>
References: <YSy/PFrem+a7npBy@gmail.com>
 <CAOMZO5D0m1xCfgFifKz1H+oYQSfxsfuZp4U39rPMACmzv1fvjQ@mail.gmail.com>
 <YS0HFMtAHFuwkKnY@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0HFMtAHFuwkKnY@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Excuse me, I meant Fabio - brain not with me today. :)

Anyway, is anyone with more expertise in this area looking into fixing this?

Best regards,
Fredrik

On Mon, Aug 30, 2021 at 06:28:04PM +0200, Fredrik Yhlen wrote:
> Hi Pablo,
> 
> It seems to be working with your suggested change and PR enabled:
> ```
> root@xxxx:/dev# dd bs=256 count=10 if=/dev/hwrng of=/dev/null
> 10+0 records in
> 10+0 records out
> 2560 bytes (2.6 kB, 2.5 KiB) copied, 14.5987 s, 0.2 kB/s
> root@xxxx:/dev#
> ```
> 
> Thanks!
> 
> Best regards,
> Fredrik
> 
> On Mon, Aug 30, 2021 at 08:49:25AM -0300, Fabio Estevam wrote:
> > Hi Fredrik,
> > 
> > On Mon, Aug 30, 2021 at 8:22 AM Fredrik Yhlen <fredrik.yhlen@endian.se> wrote:
> > >
> > > Hi,
> > >
> > > We're having problems with hwrng on a board with imx6sx (soloX) running Linux
> > > 5.10.x. mainline, and I have tracked it down to this commit
> > > '358ba762d9f1d4ba99ab31ef12bc28014b22f4c9' as being the culprit.
> > >
> > > The caam_jr driver spits out lots of messages when attempting to read from /dev/hwrng:
> > > ```
> > > [29717.629041] hwrng: no data available
> > > [29727.859008] caam_jr 2101000.jr: 20003c5b: CCB: desc idx 60: RNG: Hardware error
> > > ```
> > >
> > > ```
> > > caam_jr 2101000.jr0: 2000025b: CCB: desc idx 2: RNG: Hardware error.
> > > caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
> > > caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
> > > caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
> > > caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
> > > caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
> > > ```
> > >
> > > This also happens on Boundary's Nitrogen6_soloX board when running the same
> > > kernel, and likewise with their latest Yocto release that uses 5.4.100 linux-imx kernel.
> > >
> > > ```
> > > root@nitrogen6sx:~# dd if=/dev/hwrng of=/tmp/random bs=256 count=10
> > > [  113.940735] caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error
> > > dd: /dev/hwrng: Invalid argument
> > > root@nitrogen6sx:~# rm /tmp/random
> > > root@nitrogen6sx:~# dd if=/dev/hwrng of=/tmp/random bs=256 count=10
> > > [  125.300823] caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error
> > > dd: /dev/hwrng: Invalid argument
> > > root@nitrogen6sx:~# du -hs /tmp/random
> > > 0       /tmp/random
> > > root@nitrogen6sx:~# ls -l /tmp/random
> > > -rw-r--r--    1 root     root             0 Dec 16 17:27 /tmp/random
> > > root@nitrogen6sx:~#
> > > ```
> > >
> > > And then no data is available from /dev/hwrng.
> > >
> > > The problem occurs when adding OP_ALG_PR_ON(prediction resistance) when setting up
> > > job descriptor for reading new random data in caamrng.c. There are also
> > > some confusing parts about this commit that I'm not too sure about.
> > >
> > > 1. It's adding a conditional variable named 'pr_support', but I guess this only
> > > indicates if the MC(Management Complex) supports prediction resistance,
> > > since the following check can be bypassed when 'pr_support' is false.
> > >
> > >     /*
> > >      * If SEC has RNG version >= 4 and RNG state handle has not been
> > >      * already instantiated, do RNG instantiation
> > >      * In case of SoCs with Management Complex, RNG is managed by MC f/w.
> > >      */
> > >     if (!(ctrlpriv->mc_en && pr_support) && rng_vid >= 4) {
> > >
> > >
> > > This will eventually lead to the following chain call: caam_probe() -> instantiate_rng() ->
> > > build_instantiation_desc(), where OP_ALG_PR_ON will be used through DECO.
> > >
> > > static void build_instantiation_desc(u32 *desc, int handle, int do_sk)
> > > {
> > >     u32 *jump_cmd, op_flags;
> > >
> > >     init_job_desc(desc, 0);
> > >
> > >     op_flags = OP_TYPE_CLASS1_ALG | OP_ALG_ALGSEL_RNG |
> > >             (handle << OP_ALG_AAI_SHIFT) | OP_ALG_AS_INIT |
> > >             OP_ALG_PR_ON;
> > >     ...
> > >     ...
> > >     ...
> > >
> > > Shouldn't it be named 'mc_pr_support' instead, or something similar?
> > >
> > > 2. PR is unconditionally used in caamrng.c(caam_jr module) when
> > > reading new RNG data. Should this be the case?
> > >
> > > Removing OP_ALG_PR_ON in caam_init_desc() from drivers/crypto/caam/caamrng.c
> > > seems to fix the problem we're experiencing, here's an example:
> > > ```
> > > diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
> > > index 77d048dfe5d0..f085a80b1b3c 100644
> > > --- a/drivers/crypto/caam/caamrng.c
> > > +++ b/drivers/crypto/caam/caamrng.c
> > > @@ -67,8 +67,7 @@ static u32 *caam_init_desc(u32 *desc, dma_addr_t dst_dma)
> > >  {
> > >         init_job_desc(desc, 0); /* + 1 cmd_sz */
> > >         /* Generate random bytes: + 1 cmd_sz */
> > > -       append_operation(desc, OP_ALG_ALGSEL_RNG | OP_TYPE_CLASS1_ALG |
> > > -                        OP_ALG_PR_ON);
> > > +       append_operation(desc, OP_ALG_ALGSEL_RNG | OP_TYPE_CLASS1_ALG);
> > >         /* Store bytes: + 1 cmd_sz + caam_ptr_sz  */
> > >         append_fifo_store(desc, dst_dma,
> > >                           CAAM_RNG_MAX_FIFO_STORE_SIZE, FIFOST_TYPE_RNGSTORE);
> > > ```
> > 
> > We also observe this issue.
> > 
> > Heiko on Cc tried increasing the RTSDCTL_ENT_DLY_MIN value
> > and this seems to help:
> > 
> > diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
> > index af61f3a2c0d4..53c9fa04a24c 100644
> > --- a/drivers/crypto/caam/regs.h
> > +++ b/drivers/crypto/caam/regs.h
> > @@ -513,7 +513,7 @@ struct rng4tst {
> >   };
> >  #define RTSDCTL_ENT_DLY_SHIFT 16
> >  #define RTSDCTL_ENT_DLY_MASK (0xffff << RTSDCTL_ENT_DLY_SHIFT)
> > -#define RTSDCTL_ENT_DLY_MIN 3200
> > +#define RTSDCTL_ENT_DLY_MIN 4800
> >  #define RTSDCTL_ENT_DLY_MAX 12800
> >   u32 rtsdctl; /* seed control register */
> >   union {
> > 
> > Does this help in your case?
> > 
> > Thanks,
> > 
> > Fabio Estevam
