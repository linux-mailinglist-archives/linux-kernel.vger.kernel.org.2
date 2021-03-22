Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB643443C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhCVMyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhCVMnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:43:21 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9CAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:43:20 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 94so12171361qtc.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=arydSfNJdOno8g+YOjFb3gBNmyUnmYwfHcSK+u9v6E0=;
        b=pvfz1nRDKM+5JSmPf5O61eb8JVdXAor769fw2vp17sNl/zTPQqdHlvp9FM/wReYvxT
         IrFZMfN+HbSqU1k08wYwvc42oC04BNOz21jTf2NAumCQg5gLKZgY6Z7EUGXB4DhoDTmh
         ubvevCPpw+vY/CWR+di+hulwZRFTje64QOKkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=arydSfNJdOno8g+YOjFb3gBNmyUnmYwfHcSK+u9v6E0=;
        b=RuNY7QGPDj2jbsKRZwyeQWcmGkc7DiCqKCVWHvOU63N283iH43eSE7K0qOQ8VJREj7
         KQVjPT9VY/DJ4Q6hTpwbZzPJubcMeOtAx8qQcndX6j4CdQFgYvb2GlxWUGM36Izj4hXD
         WplTls2ENuv5f14VdTan/Zd+T6WDUJwC6ngz21jLcrOXPGpN1nCGIJMC/svvoZVICu8s
         1Kc+bVxRVJbJA+S4mBWPcZ7z+1b5aG92OtJT7l0KTrj9MxjMTkwXkYPqiF8m3eHWjfy2
         soRjkvykQYbbRRWuBexUce1A8fA76rBPsSfRNioyCpU/3KGP5jhDyDrnwTuDs9aWYmQs
         /gGg==
X-Gm-Message-State: AOAM533WebtsVmd6dz0kqpINdOQetOGQwKMFIawSiMke9g/g2bGOqafq
        EUgmbPpn0wYVXeCTaZQPh+8Rzyi9bRTmYYR0NPou7w==
X-Google-Smtp-Source: ABdhPJyw8gIStBNrRZHMMvHuRzb/Apf44gmOg1kbj31cZd/bXDI+mQRHLdAEkxp7QvDhMsWmZcrEhpSPyTLQSliM8yI=
X-Received: by 2002:ac8:7f53:: with SMTP id g19mr9464586qtk.249.1616416999595;
 Mon, 22 Mar 2021 05:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210213095724.3411058-1-daniel@0x0f.com> <20210215112409.1a755bf0@xps13>
 <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com> <20210215121653.4edd86c4@xps13>
In-Reply-To: <20210215121653.4edd86c4@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 22 Mar 2021 21:44:40 +0900
Message-ID: <CAFr9PXmVehtcm6FjBqi_hmEAj1rgtxMvarisjPmWhgjruVj++Q@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Sorry for the resend. Gmail randomly switched to HTML email so the
original version seems to have bounced.

On Mon, 15 Feb 2021 at 20:16, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > "2. Spare area 800H to 83FH is all available for user.
> >  ECC parity codes are programmed in
> > additional space and not user accessible."
> >
> > It would seem that the pages are actually bigger than 2K + 64 or there
> > is some other place they keep the ECC.
> > Or both datasheets are lying. Somewhere else in the datasheets it says
> > that writes to the ECC area will be ignored but that doesn't make a
> > lot of sense if the ECC area isn't user accessible in the first place.
> >
> > I didn't think about it at the time but I can take a dump of the OOB
> > area of my FS35ND01G-S1Y2 to confirm it's all 0xff except for any
> > factory marked bad blocks.
>
> I see. Can you please try the following:
>
> nandwrite -o /dev/mtdx /dev/zero
> nanddump -ol1 /dev/mtdx
> If the entire area is effectively free to be used, you should see 0's
> everywhere. Otherwise you should have ff's somewhere.

Sorry I didn't follow up sooner on this. I needed to order another of
this flash chip to test with as I couldn't destroy the data on the one
I have.

Anyhow:

Erased the page with flash erase (I'm forcing it to erase bad blocks
here as I mess up the marker, I have a hack to allow erasing bad
blocks..)
Everything is 0xFF for that page.

# flash_erase -N /dev/mtd1 0 1
Erasing 128 Kibyte @ 0 -- 100 % complete
# nanddump --bb=dumpbad -n -l2048 -o -c -s 0x0 /dev/mtd1
Block size 131072, page size 2048, OOB size 64
Dumping data starting at 0x00000000 and ending at 0x00000800...
0x00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
....
0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
  OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
  OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
  OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
  OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|

Write zeros into the page and OOB.
Get all zeros back including the OOB.

# nandwrite -o /dev/mtd1 /dev/zero
Writing data to block 0 at offset 0x0
Bad block at 0, 1 block(s) will be skipped
Writing data to block 1 at offset 0x20000
# nandwrite -N -o /dev/mtd1 /dev/zero
Writing data to block 0 at offset 0x0
# nanddump --bb=dumpbad -n -l2048 -o -c -s 0x0 /dev/mtd1
Block size 131072, page size 2048, OOB size 64
Dumping data starting at 0x00000000 and ending at 0x00000800...
0x00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
...
0x000007f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
  OOB Data: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
  OOB Data: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
  OOB Data: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
  OOB Data: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
|................|

Erase the page again and writing random junk into it.
Seeing random junk everywhere including the OOB.

# flash_erase -N /dev/mtd1 0 1
Erasing 128 Kibyte @ 0 -- 100 % complete
# nandwrite -N -o /dev/mtd1 /dev/urandom
Writing data to [  230.506260] random: nandwrite: uninitialized
urandom read (2048 bytes read)
block 0 at offse[  230.514705] random: nandwrite: uninitialized
urandom read (64 bytes read)
t 0x0
# nanddump --bb=dumpbad -n -l2048 -o -c -s 0x0 /dev/mtd1
Block size 131072, page size 2048, OOB size 64
Dumping data starting at 0x00000000 and ending at 0x00000800...
0x00000000: 5e 24 bd 5f d9 c6 ce c5 b1 85 52 4d 27 94 c9 98  |^$._......RM'...|
...
0x000007f0: fa 9f 7f 7d ce 99 33 88 d6 9f 99 7d 84 e7 0c 4d  |...}..3....}...M|
  OOB Data: b1 81 07 6a 8d 47 8b ed 89 88 ac 62 e8 ae 48 54  |...j.G.....b..HT|
  OOB Data: 7d b2 ea 73 f3 29 ba 65 e6 45 cb 8b 1a c6 5b dc  |}..s.).e.E....[.|
  OOB Data: b2 2e 77 56 e0 e1 04 59 86 31 7a e5 bd 43 f9 48  |..wV...Y.1z..C.H|
  OOB Data: 52 05 b2 f1 65 64 59 22 79 50 ec 89 55 6b 6e 23  |R...edY"yP..Ukn#|

I think this shows that the datasheet is right in that the complete 64
bytes of "spare area" is usable.
I have no idea where it puts the ECC though. :)

Thanks,

Daniel
