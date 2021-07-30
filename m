Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E363DB732
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhG3Kg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbhG3Kgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:36:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7864C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:36:48 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id y4so8958133ilp.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tc+l6IEqpvy1hdws8BKtGV49kuQokwaVCXGVVOzHHCc=;
        b=gwO2/D0xsalGvz2CGTqlI5nm0Ipv5QR5Owe3xhWXsiN+xXgeVzFhXTEbNglSQ7sHWt
         ogbEfYZ2kw3ABHTpHmRfEnkKvfOHPFwwLfekbbwkUAku7HMDZimVqaTrxMhop38pxVgZ
         bEnxVTr21N2qcUtpOj77A9wlRnk09haiJ0oE1JCG/VlJ5peDuDkv5/JmQ2+fkCcA3UiD
         si8Y+rqWWY5P7bfhgQXQSXH6yX4b7/zsmi8UCc67BbfcKKp9LXkzZCeQEtDwei5jTGkX
         geqiQ7E7DXJQiBFPG3N3L66fkfwsHgr/eAlEXy1MqEw4pOH0ZE0JUJt9wMgEZLls/2xE
         ZA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tc+l6IEqpvy1hdws8BKtGV49kuQokwaVCXGVVOzHHCc=;
        b=YrAraiqahfCQL4uBql6z6XXMJm7E3ka3GONNH4HDtKWFSf/IcO238ioWUHAwWawV/P
         oMddVQ7ILtK4QgdrOxQQwpfSSIz2C8RAFWK4cnv8Wze5CR+1UA5Nnpuoqp3jo2+ErXLy
         M6p6qmCubKX32j4A30aYj8eeKSy4bswI04HoDwJL+BcJc61fbqIaXZsHhJzsp1QGS0DW
         shBli2QEuE3u+wb21Hwlhp5mzAkqkpN6Bi3Ev5oAAUZ0CjhgijlNRZ/9abtRmMlBD2UR
         xOUldJL87UagnY8m2Yhj2dDquathnTkxhMgRXBFRwZkUQ/MgYtPqOoDKGtv17EKPU+ec
         8nEg==
X-Gm-Message-State: AOAM533JDuv+czC2MXFDvfO0WUIWfmH1kDEh5fDpLllhPX3IkxA+D+Bo
        Z4vWHFl1DKEKNTOcng7tIR4=
X-Google-Smtp-Source: ABdhPJyRLLc8gWjjiLY6kweLh2zR6BL6YXchhv94St08qL7mdSeO62rur2kxt2Dch93iUe7LrcXlNA==
X-Received: by 2002:a05:6e02:1e06:: with SMTP id g6mr1428038ila.41.1627641408428;
        Fri, 30 Jul 2021 03:36:48 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o13sm592826ilq.58.2021.07.30.03.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 03:36:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5D79327C0054;
        Fri, 30 Jul 2021 06:36:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 30 Jul 2021 06:36:47 -0400
X-ME-Sender: <xms:PtYDYYtFOz-tNWzRCZkXKQRJY3cfXwMhICGU2zbJNOB1DSHqBQDbBg>
    <xme:PtYDYVea0Ro5pwZe_mBE1wjkEYbsEffknNeEuhHriurrryxjMQhvsl-bBigM8kLbO
    0LW0w5IeD0Ty8cXIQ>
X-ME-Received: <xmr:PtYDYTw5fW3TtSNNFR9uq9tQFPfFPyoEqRkefBNiT2pYH6f1ePAlexyRI_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheehgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtggdttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeuueekfffhhffhveehvdfhfedvfeffgeeguefhfedvvdffuddvgfeiveetudef
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:PtYDYbOy8C8xACDWMNrVNfV-OWry_9XOD33Rwnf5ssEqhratqwkf8Q>
    <xmx:PtYDYY-sUN15Fd45FiSHPugab4m4n7-bQzEGs4FkaUu-pOqn27_Kzw>
    <xmx:PtYDYTWPHE2bkcJcgSC_8gB3yFoUNF1l05vFaY1SQgKrXFPB_-89LQ>
    <xmx:P9YDYXkVA_eL-ie9VapksLHW4ZWl4G_FA4CJuekW66CzkrfOX7Pq4w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jul 2021 06:36:46 -0400 (EDT)
Date:   Fri, 30 Jul 2021 18:36:20 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep/selftests: Fix duplicate included
 locking-selftest-softirq.h
Message-ID: <YQPWJD6CRL78DENY@boqun-archlinux>
References: <1627640682-14225-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627640682-14225-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 30, 2021 at 06:24:42PM +0800, Jiapeng Chong wrote:
> Clean up the following includecheck warning:
> 
> ./lib/locking-selftest.c: locking-selftest-softirq.h is included more
> than once.
> 

Those inclusions in the file are used as poor man's template, IOW, the
header files redefine some names so that we can use one template to
generate many similar functions.

So no need to fix, thanks! But if you have a better idea to generate
functions, please let me know ;-)

Regards,
Boqun

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: cae2ed9aa573 ("[PATCH] lockdep: locking API self tests")
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  lib/locking-selftest.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> index 161108e..6010445 100644
> --- a/lib/locking-selftest.c
> +++ b/lib/locking-selftest.c
> @@ -1252,7 +1252,6 @@ static void rwsem_ABBA3(void)
>  #include "locking-selftest-wlock.h"
>  GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_wlock)
>  
> -#include "locking-selftest-softirq.h"
>  #include "locking-selftest-rlock.h"
>  GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_rlock)
>  
> @@ -1306,7 +1305,6 @@ static void rwsem_ABBA3(void)
>  #include "locking-selftest-wlock.h"
>  GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_wlock)
>  
> -#include "locking-selftest-softirq.h"
>  #include "locking-selftest-rlock.h"
>  GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_rlock)
>  
> -- 
> 1.8.3.1
> 
