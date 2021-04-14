Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC035EDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349493AbhDNGyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349530AbhDNGxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:53:47 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82B9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:53:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t140so13703709pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FpXG6BxL1eix7ZuvEbTaKFw6E4r9hjxDvOS4dYSkAY=;
        b=ZrC/mbRqviwCrp5s59OqqAyhvEdMRY3USfk7e6ubgSvZVNx2+4IzlpYBZnp6NjL6nJ
         EQAbg1Wrn0hW8AwBhkp8kJbeWwvXuo8eLX5AA66ahZgvxqh/xIPVYbYadIMrumBClMOg
         t5OxvcggD/+s7eVHhjKwCFsyK0Iutbox1Fco8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FpXG6BxL1eix7ZuvEbTaKFw6E4r9hjxDvOS4dYSkAY=;
        b=dMB2CFp30uazp2XSi18zJ9poJSqjjZmveNoK4AoZ6AmKyYloIX+0fdGlEHeMLGuY1x
         1yZEZ8dXDazXqZ3uHfWb+2nZCnFiYmKQV4IMmF3o8tLz1FEqyquQgki3XwlUXYx8BSTT
         kNZXwsnMmXo3NNEbbhubMArMBGAXKIC6SHkZ9VvhiM4VmLPY3uSheFPAlfXPWjpjgNdb
         yCSj0eGrr7lFyUgV4P8KUuhwjkAy1zQZD4sXWbll7GJXHIXsnpDTBJzbUjl7iLojDggu
         elj79eU6ReEGb3XvECX4ZPq9SHCwyMOCiIQ1J//BTRh9S52lBB+r2lTWE6Zg5kBYsAkw
         YaJw==
X-Gm-Message-State: AOAM5323q3hXv/M2tpK2t/z4uqTZGdbmqIqyLqcPanIoNpANZIPp2/DA
        41NoJkvhG2AP4nvA0kCYMZ3aaraz4kcdjPa/BPyApA==
X-Google-Smtp-Source: ABdhPJwv5wFKRCqUakt5uMuQOtM3jnC4w4KH5JJ4cnCysJqWAMdTHJUlU295rpEldhiJ0+2ZGtABHZuVwB4BTv7H190=
X-Received: by 2002:a63:525c:: with SMTP id s28mr35660389pgl.317.1618383206183;
 Tue, 13 Apr 2021 23:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210413120210.3671536-1-ikjn@chromium.org> <51761f1db840c51bad17f5f275b4ce1a@walle.cc>
In-Reply-To: <51761f1db840c51bad17f5f275b4ce1a@walle.cc>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 14 Apr 2021 14:53:15 +0800
Message-ID: <CAATdQgCYoeEKfvQPNUxzMA+o4Xwtt80SoMmfweTAB1MCijyC6A@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: macronix: Add block protection support to mx25u6435f
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Michael, thanks for the review.

On Tue, Apr 13, 2021 at 8:26 PM Michael Walle <michael@walle.cc> wrote:
>
> Hi Ikjoon,
>
> Am 2021-04-13 14:02, schrieb Ikjoon Jang:
> > This patch adds block protection support to Macronix mx25u6432f and
> > mx25u6435f. Two different chips share the same JEDEC ID while only
> > mx25u6423f support section protections. And two chips have slightly
> > different definitions of BP bits than generic (ST Micro)
> > implementation.
>
> What is different compared to the current implementation? Could you give
> an example?

Two chips have different definitions on BP and  T/B bits.
- 35f has 4 BPs without T/B, BP3 behaves like T/B bit.
- 32f has 4 BPs plus T/B on CR.

# MX25U6435F

 BPs | BP3=0 | BP3=1
---------------------
 000 | None  | 1/2
 001 | 1/128 | 3/4
 010 | 1/64  | 7/8
 011 | 1/32  | 15/16
 100 | 1/16  | 31/32
 101 | 1/8   | 63/64
 110 | 1/4   | 127/128
 111 | 1/2   | All

# MX25U6432F

  BPs | T/B=0 | T/B=1
---------------------
 0000 | None  | None
 0001 | 1/128 | 1/128
 0010 | 1/64  | 1/64
 0011 | 1/32  | 1/32
 0100 | 1/16  | 1/16
 0101 | 1/8   | 1/8
 0110 | 1/4   | 1/4
 0111 | 1/2   | 1/2
 1xxx | All   | All

It seems that 35f has a unique definition on bottom protections than others.
Assuming there's no way to distinguish between mx25u6435f and 32f,
This patch simply takes the common parts only - BP[2:0]
without using T/B or BP3 at all.

But the current swp implementation implies that "BP with all ones"
is to be 'all' protection while in this approach it's 1/2,
A hidden BP3 should be involved for 'all' protection.

>
> > So this patch defines a new spi_nor_locking_ops only for macronix
> > until this could be merged into a generic swp implementation.
>
> TBH, I don't really like the code duplication and I'd presume that it
> won't ever be merged with the generic code.

Agree, I hope I could make a more generalized version into swp.c.

Honestly I expected that I just needed to add one line of SPI_NOR_HAS_LOCK
to flash_info to support mx256432f (this was the main purpose of my patch)
before I read the datasheets. :)

>
> You also assume that both the WPSEL and T/B bit are 0, which might not
> be true. Please note that both are write-once, thus should only be read.

yep, that also should be considered,
I'm thinking just not to support WPSEL=1 case for now.

>
> See also:
> https://lore.kernel.org/linux-mtd/346332bf6ab0dd92b9ffd9e126b6b97c@walle.cc/
>

Thanks, let me try it.

> -michael
