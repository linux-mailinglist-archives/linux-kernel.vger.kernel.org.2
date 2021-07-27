Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934D63D729A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhG0KHo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jul 2021 06:07:44 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:43951 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbhG0KHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:07:42 -0400
Received: by mail-vk1-f170.google.com with SMTP id f4so2647705vkb.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FCUItsUrNsIOTE4P27lKrABY3CasfpkaGPUBOlpzuIA=;
        b=l5cbLd0rlEV7fZYYmBg0uGIZpN3otccZX7MlUkd0ToiAwyDqmBzd2FxbNP4NYbuRdz
         2gz3BLIMIAHnXLq1cdMGfvoSwNRH3goDqob5RGVu+1Tg1YQePb6ufIlVamBOH6ToqTU6
         cY6cXgx9qatgH0E89b8jCzp27jRqIBBN04BSfPBWpVwpjLReT5hqlAcGXb8ADFqAdcbs
         BFJes9JTX2d9UV+AlyeuWfoEXqq2/FveB0mVIWgU7SYgnPTBqJe6/1SZJ8+6UoY27JTC
         WY54hpgD6IhJCdDdyylJKAjP47+iDI0ILoeYEy71HfJ/xHh0g8HXz5O4qvv6M/Dir0M/
         CSmg==
X-Gm-Message-State: AOAM531W/Oc88GMfuEn839+Lu5W4SM38ay/jobTUNCZqBbZ/MqGcbx/Q
        uSPD5ruaNDF6TD/IwrixMutSwCiKmRowMdT3MoznlCE5xXM=
X-Google-Smtp-Source: ABdhPJyJZ2K2v5gkPcV5lyHX5OJ6ojes2JgkZC6Nxg8yjXVY0y3Yn43EJt4tI1HaIXLl75DtR+ZLBeyBHpoziXGZOkM=
X-Received: by 2002:ac5:c956:: with SMTP id s22mr13658214vkm.2.1627380461341;
 Tue, 27 Jul 2021 03:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de>
 <20210727080840.3550927-2-u.kleine-koenig@pengutronix.de> <d74ccd1-116d-9450-5ee4-8d5074998872@linux-m68k.org>
In-Reply-To: <d74ccd1-116d-9450-5ee4-8d5074998872@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Jul 2021 12:07:30 +0200
Message-ID: <CAMuHMdX=K4S3Yd_ybd5C3e40XefMf5kHs1tWs1+VKTgiWEWEDg@mail.gmail.com>
Subject: Re: [PATCH 1/5] nubus: Simplify check in remove callback
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Tue, Jul 27, 2021 at 11:50 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Tue, 27 Jul 2021, Uwe Kleine-König wrote:
> > Apart from that, the compiler might already assume dev->driver being
> > non-NULL after to_nubus_driver(dev->driver) was called.
>
> I don't understand how a compiler can make that assumption. But then, I
> don't know why compilers do a lot of the things they do...

It is one of those recent optimizations people have been complaining
about.  Once you have dereferenced a pointer, compilers may remove
all further NULL-checks, assuming they can't happen, as the code
would have crashed anyway before due to the dereference.
Good luck running on bare metal with RAM at zero ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
