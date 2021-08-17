Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62DB3EF02E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhHQQbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhHQQ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:29:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34564C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 09:28:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id bo19so32303694edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Uq2l7hqjwwkcGAhoOcZ4h9vCm3YfoxhlGasvmZN7Js=;
        b=ZbU+xCvxYpLIMcprfxhfUI2Aoe/CInM6n8lkNHDrCfJX5vOVSaLyYuchnTqq9w3rEv
         tFedeq/mDoXHBDMOKB4411WB8I0ceFucimNy8CMxXlWKdm1z2jJTotB7DbgjdXTD9O+G
         l+r82FTekchZ/IV+tTUdxZuBBQxfRWsUsjl4M66sWulNA7d1YP+t0ppHhb/n0H8dLxu9
         yg4V7ulG3GuOXu6OJVWIuFdXN9gU2Ez7AMzFa2eMkg3RUE7g1RabsEvtWjmyx0Bo1T2s
         3P7frCKt0Ff4n8qMjBCmkCN8OE9uDpubstLkO/wADGVD1xOk+T9HojeBxMvBvPQ9IeZ/
         PaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Uq2l7hqjwwkcGAhoOcZ4h9vCm3YfoxhlGasvmZN7Js=;
        b=lSmlmkpGYAe/OZqdc8UdJjYHaBcYJrIyw7vFYzLHO6Q88NOmfwSW8FKTCw6P/9smzJ
         TpLG+cqAuHNPp3k6F/QSau2Kyi9OosXPnnimIQeQ6gsvoIHUF5ILzAAalT0gMgknca4c
         wAVku0vLohTHqcpmLiXReVrYm+W8Bz7k9Hz2f7qOAuf5M5HGej2EP+0pXf0Y9cW8IAQL
         cbhlACkwHxj2BvOvFFcvJ/mDgVA8Z3sDVVkpCTsgxs30f/UtwXpUPdr2mPJ2bcf0O9l9
         //+R/B/66cixdydEUETYp7ekFPPRgF+2nP96FvpU7r3KRoYplpLYBy0qlNaotofGhGOo
         AvAA==
X-Gm-Message-State: AOAM530pkh3QaTO7FpklikWGWUcUTA43D2/Bk7d2Bn+Igh0VUMG/xNBC
        0nQ6PFDg10DmL/q7rWWPX9YX9Lzi4wAomQo35FNvYw==
X-Google-Smtp-Source: ABdhPJyjAicBj+Zkhl9MPlRn/9cal3SriOfxu/ZVcX7jZc7v1JYp6W+gP3bVaSV0iEWah9ngtzNCpXdJcymqWK2FgAM=
X-Received: by 2002:a05:6402:70a:: with SMTP id w10mr4991545edx.213.1629217685800;
 Tue, 17 Aug 2021 09:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210801234509.18774-8-ezequiel@collabora.com> <20210806200537.394260-1-miquel.raynal@bootlin.com>
In-Reply-To: <20210806200537.394260-1-miquel.raynal@bootlin.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 17 Aug 2021 13:27:54 -0300
Message-ID: <CAAEAJfDqEu0XtZ_FvVUM31p5PumPmK0x-r8sFWXzENDqf5zj_g@mail.gmail.com>
Subject: Re: [PATCH 3/3] mtdblock: Warn if the added for a NAND device
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bonjour Miquel,

On Fri, 6 Aug 2021 at 17:05, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> On Sun, 2021-08-01 at 23:45:09 UTC, Ezequiel Garcia wrote:
> > There is a surprisingly large number of tutorials
> > that suggest using mtdblock to mount SquashFS filesystems
> > on flash devices, including NAND devices.
> >
> > This approach is suboptimal than using UBI. If the flash device
> > is NAND, this is specially true, due to wear leveling, bit-flips and
> > badblocks. In this case UBI is strongly preferred, so be nice to users
> > and print a warning suggesting to consider UBI block, if mtdblock
> > is added for a NAND device.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.
>

Any chance you respin this one?

It appears somehow this made its way to the patch:
"Untracked files not listed" sorry about that -- could you remove it?

While there, you can fix the typo in the commit title:
"mtdblock: Warn if the added for a NAND device" -> "mtdblock: Warn if
added for a NAND device"

Thanks a lot,
Ezequiel
