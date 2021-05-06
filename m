Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAF374FEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhEFHUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEFHT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:19:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A380AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 00:19:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i13so4587360pfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ff6iClsWGOy2S69S3t4caAKrwDBzIMs9yWLn5gps7VU=;
        b=1nj1YicF1Nrd74sETWXvmza4aB8KIMQv+jFBpSry5u0//OZEWNQ6KGo2cDQHusIm9Q
         aHGJ9VwgbqW6yVmZmvQYMmVH+FhQMj9WQ+EiM963Cd6pgMrOPo1JCJHZYWzuQ6gPo/bh
         2AbbhVKT3K4C/HGGDJSQjD29dOFHv4cQiBvivnfgZVIuRsHBQ4RQpaUVoY5ccjgI1Kwd
         5wG/DDsGK2qXQUBnj2Xpd14Ip4bCrQSKZhOX5qgzdmLyi0/GZ1P3xv/ypK+K1bRIdCa0
         tmFjujgL5q8cb56ZDCCwUACSst+znlhSjHjG80zoBij6QLf0np2xAZ1gp6xfz7EBaaL/
         9InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ff6iClsWGOy2S69S3t4caAKrwDBzIMs9yWLn5gps7VU=;
        b=alZwo3Pzi3W+/+UqStVdtt9KyhQJQ17fRiJZT8NSeEX7sk4ySPUHgznF5MYnwUbeV2
         E48emDXewxrmSUBtpzU5zIsLiFoVt0Q1z2NW7kdb85B4ZW7m5W7xDdymqOi6MTecnsOw
         tu/ytUXIeSepprafofkG4J5grihLSqai5zbxowwq4rgWUV6JFgqIatb3DMiNo5vfMy4o
         q82OhH5tT3Ga24xF6pPUlTm/Q38m7toMo4hVE2VstfQIzHRHFUJpkCnHUXcvcQkowKSA
         WcZhj0j+0lImBBt1TXXpgOaQsZWOzvT/cJllZ2b330AeIPfGJ0qBF3g4ZfFSFnyeof5f
         +bCQ==
X-Gm-Message-State: AOAM5337y/wEs2EWUGcCAsLYHc6yeufpP3kWG4Ydn0/29ehftjjzhQMx
        2FKzSet/6r+62kiIqa8PMQmqpw==
X-Google-Smtp-Source: ABdhPJxpAJhWX5TTFyynpL+sjUHgdm5DptIpWf5u41d4l2+6z1Wg4UYRdxCjIrhVTIu4yb/ngKmP4g==
X-Received: by 2002:aa7:81d8:0:b029:28e:6e31:7c9a with SMTP id c24-20020aa781d80000b029028e6e317c9amr3116972pfn.56.1620285540533;
        Thu, 06 May 2021 00:19:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k8sm1389832pfp.99.2021.05.06.00.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:19:00 -0700 (PDT)
Date:   Thu, 06 May 2021 00:19:00 -0700 (PDT)
X-Google-Original-Date: Thu, 06 May 2021 00:18:58 PDT (-0700)
Subject:     Re: [PATCH] riscv: remove unused handle_exception symbol
In-Reply-To: <20210501185359.64043-1-rouven@czerwinskis.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        kernel@pengutronix.de, rouven@czerwinskis.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rouven@czerwinskis.de
Message-ID: <mhng-84f8c8d7-96c4-4c9c-a254-5fa19a390bbf@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 May 2021 11:53:58 PDT (-0700), rouven@czerwinskis.de wrote:
> Since commit 79b1feba5455 ("RISC-V: Setup exception vector early")
> exception vectors are setup early and the handle_exception symbol from
> the asm files is no longer referenced in traps.c. Remove it.
>
> Signed-off-by: Rouven Czerwinski <rouven@czerwinskis.de>
> ---
>  arch/riscv/kernel/traps.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 1357abf79570..6810fc9c775d 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -25,8 +25,6 @@
>
>  int show_unhandled_signals = 1;
>
> -extern asmlinkage void handle_exception(void);
> -
>  static DEFINE_SPINLOCK(die_lock);
>
>  void die(struct pt_regs *regs, const char *str)

Thanks, this is on for-next.
