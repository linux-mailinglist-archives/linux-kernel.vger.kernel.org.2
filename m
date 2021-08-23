Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BED3F4C31
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhHWORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhHWORL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:17:11 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34368C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:16:29 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f22so9627599qkm.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVV/F1yIspN9pwe7wVu7K1lHM6uOf9PUbo3fvoPR78k=;
        b=BHe5Uy77OInHLOm4iEIYrErWvk0WVVL/wJnxS2zd9iIxsSnJJ4Ryim0bf0wwqEKv9V
         OusQI7ap/FQQX7GN4DV6TZtIIXJZUp1wGpr0zjIXt477qquA98U8AzCoDmmdqHyPSSQO
         D7rXWJDl5RSZc3OnCgag96jN0Nrmf3npWdcRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVV/F1yIspN9pwe7wVu7K1lHM6uOf9PUbo3fvoPR78k=;
        b=R7g9vPZTZamLuO+FTwqyrV9f89vYCC2wqg7X+bcrMe5XotZz4uKzUCCIGMzf50T5ND
         qBVEuAhAQEDVq+kjObRb6+QZ2/+hSYAJrrX9EwWo2eAeXu4JaNlrFbIrq72rs1gtl8o/
         mq6kQm3LPwU4mM4oFGVEKfQXw951hIQR6oOKLthsU75QI75F7YtLUYeWxQCRb41pPQn3
         BZ2SlKOMqu18qlzUR/paRbzHV3WI817Tg7l0N4bGQV4QdL/l2eigfVD4guVgzNfo4m6p
         uzz70TPedVm2eLRDbpr9P+fbU4Umay7MLT97Mm4CHuH8wNdd0FksIGqGx6VlMHUOXDpc
         7ocA==
X-Gm-Message-State: AOAM5316l3nAE95pnJWOqPUTx3NKNwAOJpzwWZq/zXshOAHKsbZVQBeJ
        8QtTjMYcuHYGzT+OyZrOXQh5fxIZvv4Zd46/FSmTs0T9XmfJzQ==
X-Google-Smtp-Source: ABdhPJyWKRlQQofpj3Dewg6Zpl/82XJA0PNZcT2HQgaPxd1fZmUXKhh9E8s+3qwvLOL/tozROPLQ+SSik6PiTlAkHuE=
X-Received: by 2002:a05:620a:1210:: with SMTP id u16mr21437885qkj.390.1629728188209;
 Mon, 23 Aug 2021 07:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210811084924.52293-1-daniel@0x0f.com> <20210816101143.2a64d7b9@xps13>
In-Reply-To: <20210816101143.2a64d7b9@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 23 Aug 2021 23:19:02 +0900
Message-ID: <CAFr9PXnna+b3ChVUftT7YbU1kYR=5JDcik3bMNqzKK-LW=GQzw@mail.gmail.com>
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

> > +     /*
> > +      * The datasheet says *successful* with 4 bits flipped.
> > +      * nandbiterrs always complains that the read reported
> > +      * successful but the data is incorrect.
> > +      */
> > +     case FS35ND01G_S1Y2_STATUS_ECC_4_BITFLIPS:
> > +             return 4;
>
> This is a real issue. Can you use the nandflipbits tool from the
> mtd-utils package (you should take a recent version of the package) and
> try to observe what happens when you insert a 4th bitflip in a section?
>
> I generally believe the tool more than the datasheet :)

Maybe I'm using it incorrectly but I can't get a 4 bit flipped
situation to happen.

I erased the paged so it's all 0xFF:

# flash_erase /dev/mtd0 0x8000000 1
Erasing 128 Kibyte @ 8000000 -- 100 % complete
# nanddump --bb=dumpbad -s 0x8000000 -l 1 -c -p /dev/mtd0
ECC failed: 0
ECC corrected: 6234
Number of bad blocks: 0
Number of bbt blocks: 0
Block size 131072, page size 2048, OOB size 64
Dumping data starting at 0x08000000 and ending at 0x08000001...
ECC: 3 corrected bitflip(s) at offset 0x08000000
0x08000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|

Then used nandflipbits to flip a bunch of bits in the first byte and
then a few other bytes:

# nanddump --bb=dumpbad -s 0x8000000 -l 1 -c -p /dev/mtd0
ECC failed: 0
ECC corrected: 6246
Number of bad blocks: 0
Number of bbt blocks: 0
Block size 131072, page size 2048, OOB size 64
Dumping data starting at 0x08000000 and ending at 0x08000001...
ECC: 3 corrected bitflip(s) at offset 0x08000000
0x08000000: f0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000010: eb ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000020: ef ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0x08000060: ef ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|

Anyhow,
I think we should probably return -EBADMSG if the 4 bit flips status
appears as nandbiterrs always complains that the data is wrong.

Cheers,

Daniel
