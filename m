Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB53A5A47
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhFMUOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:14:08 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40475 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhFMUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:14:06 -0400
Received: by mail-wm1-f43.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so11591298wmd.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RoW78HdbRz9bg85++1AVT5jNn/ssWS7W6V6tF3IYT4M=;
        b=CQDTQHwrw1kO4HaXl6z4wW9fLI4vgVO1zT9hVfdbAj0st7B8rO8Fi0mwFL3Xia8aOp
         VBhfm84jICSgIoqg555Cqf1Q8D3swjtYNn2vOs6FpMUSrVsxX5FTG0S8HVE15ZNG3qUu
         wM6Vmc1iVXQA3mDVRHgmQS6bJpNRb91zp10MI9mWTuHYJ/Euk5MOATk7EgWnh3pjYjTN
         OoubzszeaBemNTw6n1yJ2hadHd5K8Ul8weLoaU2urfBw2EEPuyPo4iignZ9AS1VsVO4M
         jmkNzJOVbkHgoO6Nv9E+7zexp8lbqeF/tFtEEfZcHu2nk+cAN4CPhsk6v+gElykQ3qHO
         TnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RoW78HdbRz9bg85++1AVT5jNn/ssWS7W6V6tF3IYT4M=;
        b=hmNjM3SA1fFv2xOiqKIyvdZichekAwDsgS/wGrHN+8l8+DHK5PNkqVwsz8DW0V0Av5
         ibdl6NqT4UWCiIO/enn7uNlKTItQRSwyQqzWNE5nsQUFnCN2Vjdl7iwibYJEDngtJT9U
         fuqe9n9BOurK2SUklMyttzBEgx5xjVVL2NaPXSg949O3bHKPC4T7Yi5Zxo2NG1ePPkEW
         HWjPXfgwOB2sS6EPA7zzEbnjxx9Ti01hSFcckeIDF1Z5BAfi++GiFdkG+82aSyV1aQNT
         FlFiYg7rqn096fbowGX+WA2k2ZhzdhEvxalik0YAr5vNgPycl9UUarSAJN/qrvwVhlCn
         UcJQ==
X-Gm-Message-State: AOAM533TERGEbsnRezNcHEaesWKeDA6UytyUzqBnkCh5qXa2OakP59l0
        PPGtZaMC+W0Y8Z8hqL4uZ0Y=
X-Google-Smtp-Source: ABdhPJz71OlHNFPhwgKHbPoX01x1Y1ohYDTr7spSQtdUwbj2P3ySZrDgZauLApnkwFpco+503IpoSQ==
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr12751722wmm.156.1623615064411;
        Sun, 13 Jun 2021 13:11:04 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id 89sm14779412wrq.14.2021.06.13.13.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 13:11:03 -0700 (PDT)
Message-ID: <90c958bacfb77080ee524c55f5e1a01696b27017.camel@gmail.com>
Subject: Re: [PATCH 1/1] ep93xx: clock: convert in-place to COMMON_CLK
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 13 Jun 2021 22:11:02 +0200
In-Reply-To: <CAMuHMdVMbik3Zti3eKm1T9tAgY-iinD=om6qBA3DK5JwmqrMtA@mail.gmail.com>
References: <20210525083340.27722-1-nikita.shubin@maquefel.me>
         <20210525083340.27722-2-nikita.shubin@maquefel.me>
         <8cdf2b130ae02ba00324d0a70cbbcd3ba53e1d09.camel@gmail.com>
         <CAMuHMdVMbik3Zti3eKm1T9tAgY-iinD=om6qBA3DK5JwmqrMtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert!

On Sat, 2021-06-12 at 11:18 +0200, Geert Uytterhoeven wrote:
> > WARNING: CPU: 0 PID: 36 at drivers/clk/clk.c:952 clk_core_disable+0xbc/0xd8
> > ep93xx-spi.0 already disabled
> > [<c023ee98>] (ep93xx_spi_unprepare_hardware) from [<c023c35c>] (__spi_pump_messages+0x388/0x620)
> 
> These are issues in individual drivers, not in the CCF implementation.
> All drivers using the clock API should be converted from
> clk_{en,dis}able() to clk_{prepare_enable,disable_unprepare}() first.

You are right!
I'm currently testing a series, which will convert the calls.

-- 
Alexander Sverdlin.


