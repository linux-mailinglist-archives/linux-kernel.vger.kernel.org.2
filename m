Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF863910DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhEZGtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:49:24 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:46792 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhEZGtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:49:23 -0400
Received: by mail-vs1-f48.google.com with SMTP id q6so167573vsp.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WCk+Lm6KZXZoIAY4GErskDfU9tkMKa8aGeK6Ro9QmU=;
        b=pg7wmv7kRcp7hT3qmQLpkWNdNd9/31QD2Y7f+Vx/ODMT8jarl7z43EbwiTQ4CM7Dfw
         WGnVbbjs7y1QlG/S7/vdEAsAzaGBhZ3gFR4I2pVvff+4y1Blbx0ohxXJSgBnMYnTSXqF
         mk1Wugzf1+g/r02UPBpAcEdzds0ycWIdvCULhQlXzcSVijSnEdMOqdlJn98U8zpvI2bQ
         V+9eBrxfuFKUMFJX3amY0xUg15JX7touCGbxBFHxJH7zh4VUIbDjK7URgEXo8MQxjNcI
         nHjDcP9KF8+UPKv2TRfzEK1KvXChahfq+9Km14yvRQDcPPyJ5JsMAyUnKY+ps6tLEo4w
         r+NA==
X-Gm-Message-State: AOAM532wc7W2bymAVxGuk2C8HxFRVSrZmV4eLC2CMemBEXQMpP2qByVr
        lm7a3NsUCFoj2xlXoSfsrf+hD0enfqK3WHwcCy3LZUM/
X-Google-Smtp-Source: ABdhPJwvOFwELymYnoQHY72P8yzFEXxgYmnod7AWlMaGSRUKELZEDwPkLt2RaHRR/bb7PRjI4a0ciyh2yo/iLuomaJo=
X-Received: by 2002:a67:4386:: with SMTP id q128mr12515959vsa.40.1622011671135;
 Tue, 25 May 2021 23:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <fc397a7074d627e22974ef8927910ad08744db5c.1621988847.git.fthain@linux-m68k.org>
In-Reply-To: <fc397a7074d627e22974ef8927910ad08744db5c.1621988847.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 May 2021 08:47:39 +0200
Message-ID: <CAMuHMdW9_Tg+pttOMzCce+tjQ2w_GOxtvVVMB=g_S4-T0CSYEg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS, .mailmap: Update my email address
To:     fthain@linux-m68k.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 3:01 AM Finn Thain <fthain@linux-m68k.org> wrote:
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Thanks, will queue in the m68k for-v5.14 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
