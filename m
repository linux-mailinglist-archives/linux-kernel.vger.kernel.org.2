Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502CA3F4E18
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 18:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhHWQPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWQPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 12:15:07 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F23AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:14:25 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t190so19773551qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQYAWXyVXeAmMCmsXp8rKcBE+h+Z0WB7Z2sV5nVbunQ=;
        b=OXZRLQaaHAFk9vl2c5Iqw6BB0HgA9JNnvlQB2uveNK8aIYWLQDdFgYgl1Zyxy9cmuJ
         3ijfSGqkCjlPOmCv0trXq+Ahxl5CbKuBWvVZvPsFzTjtttQu4xWAbtlnRhcU/LhXBz80
         fv71f5h+F1HHKmU/MnV+XvU69eKa3euEbLE5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQYAWXyVXeAmMCmsXp8rKcBE+h+Z0WB7Z2sV5nVbunQ=;
        b=kHciZDy9N+m1FEulkV6wLSt28rP31o5BCQD0d0DbvYXpuMxTpOydzR9ZLdVLsy99I/
         OKX5nhkfRJwF5VBskAJPXVT08cSKcSHIEsqiIydwLL0QC/Q9YWA4dYlGF45yGmwmGqJb
         ByEbIWxkdNwuaCMj0Xyqsoerq5WS2+oH3xoqJAGQ0YpqJlCF07zr8tz3XnTvTypWowt8
         9INCJt5x2QQwnJXs/MlyHCB3eN3xMxCt3b874scmOCcU3pDu/58tTb1+RIZtKMIKnGOJ
         VQHm3EkwBopQDldx48boZrxIfsaXx0xGbDYRAGEx0EnMYDvkWodWXEHZTL6YoGAbYPUc
         0GLg==
X-Gm-Message-State: AOAM531BWbiEoOm9aq8Sy1aYPaFNcYC1KX/MkPDOuxgx4ndMgr8W2wG8
        YEtfcaCWJqyHKb2N+emKKYORiDHXEduq3Xxrc7pIFg==
X-Google-Smtp-Source: ABdhPJzG5V1/DgWRHqVfKGJ7gv7zrPwRk9I3szNGp50DeenIGzSdxip4c7soAwDux0nyH+51Tp9A8GRiT4++fkx3fyQ=
X-Received: by 2002:ae9:e84a:: with SMTP id a71mr22043868qkg.159.1629735264120;
 Mon, 23 Aug 2021 09:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210811084924.52293-1-daniel@0x0f.com> <20210816101143.2a64d7b9@xps13>
 <CAFr9PXnna+b3ChVUftT7YbU1kYR=5JDcik3bMNqzKK-LW=GQzw@mail.gmail.com>
 <20210823162148.35a24183@xps13> <CAFr9PXkSeeHNn-KVyrVxp6RRdLYExTgWpheWKLLSZqEo_EHvRg@mail.gmail.com>
 <20210823170354.2dccabd5@xps13>
In-Reply-To: <20210823170354.2dccabd5@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 24 Aug 2021 01:16:58 +0900
Message-ID: <CAFr9PXk3bUU+7gu2DJL_OrW3AwiG2YaTUot4Q-_9BJ0cKQ_pQQ@mail.gmail.com>
Subject: Re: [PATCH v3] mtd: spinand: add support for Foresee FS35ND0*G parts
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, richard@nod.at,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Thank you for your patience on this..

On Tue, 24 Aug 2021 at 00:03, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > ECC: 3 corrected bitflip(s) at offset 0x08000000
> > 0x08000000: fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
>
> How is this result possible? You are dumping with the ECC engine
> enabled, it reports 3 bf (meaning that it is actually running, at least
> the software really thinks there is an on-die engine enabled) but the
> data has not been corrected. I expect the first byte to be 0xFF after
> correction. Only with -n (raw dump) we should see this.

I did a bit of searching to see if a newer/more detailed datasheet has
come about and found some vendor code I hadn't seen before:

https://github.com/100askTeam/NezaD1_u-boot-2018/blob/1f8b282626f0b9f29f96c57d6b1a5d728e523893/drivers/mtd/awnand/spinand/physic/core.c#L46

This says the ECC enable bit is non-standard and in a register that
isn't documented at all in the datasheet.

I guess the spi nand core isn't able to actually control the ECC on
these chips at the moment and flipping the bits is updating the ECC
too.
Or the ECC isn't enabled at all.

I couldn't see an easy way of overriding which register gets updated
so I haven't tried it yet.

Cheers,

Daniel
