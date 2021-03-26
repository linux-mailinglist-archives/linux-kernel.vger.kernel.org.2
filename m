Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B7734A94E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhCZOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhCZOJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:09:41 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611D3C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:09:40 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 7so5283640qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzjZseiEUmTZfFHAmjQMrOVkpZ6x0+tzMj08xpQ6yq0=;
        b=KVheVgeJgZecx/FFd5VWNdrlusRUfZqjFCSCFNU+yEWLfZDDkzrUQw4D5mfROjl+cJ
         VAtacQfxoWUP4cQIHd4CH8zpMIlRrg0p/ciswCFtEFfHL3Ftcp5vad+NiXJ/dWBLJU0k
         9DVjbh+S2Oa/rBKWybpZ2Ec+hCvJ9U2M46q/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzjZseiEUmTZfFHAmjQMrOVkpZ6x0+tzMj08xpQ6yq0=;
        b=Bw+hSCmmx3uTykyRG0PliOCRIxXiySYpxbpBqbZVztISGQarC9IpMKJHiArlMKYGCG
         UUhR+/8IUUQ0l9vm9xe+7yi7VeK+L+Y5nkqXEWV4xB62uyvBspDS4kYueDxNMTW3Dp13
         6CqmyPH0lbl2cbObhOirjqh1aTQOKeCuaX1OxNEByYET6RQld5ln+vbn7QBrjoA0z08H
         A0Zhv0GW4Vzrog6TliYjw2w3wl7k9Gkp7dhObO0QXs7InZifX9meOKyFAJv/ativcE0p
         LeQzP9AVdffhfv3ZiqMKOR33Enqc0v+eu2Gp8x8GrM4Cmyj7CDiLGRSp6/XembBXcwrw
         1TFw==
X-Gm-Message-State: AOAM530xAg753zN9wIVhNaeQ4BM7XDfs9+mKB8ag53H1f5pH2tJLrqdA
        PSblEUijJefM9Dmp8qAtCOVjLlErgIwi58GE7ZQNAg==
X-Google-Smtp-Source: ABdhPJwaf4OTlnKY7d9JSvR8Dg8uARN8GSBpSDdvSTiGtYqRE3barT8RBbOhXjke/03Ligvu08fyH3kHIc4T84rqaZI=
X-Received: by 2002:ae9:f70a:: with SMTP id s10mr13328039qkg.468.1616767779533;
 Fri, 26 Mar 2021 07:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210213095724.3411058-1-daniel@0x0f.com> <20210215112409.1a755bf0@xps13>
 <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
 <20210215121653.4edd86c4@xps13> <CAFr9PXmVehtcm6FjBqi_hmEAj1rgtxMvarisjPmWhgjruVj++Q@mail.gmail.com>
 <20210322193213.18520b9a@xps13> <CAFr9PX=mL9UWcr-yWbYa5NXS-R=yHeGgM+hd_MKOa2XiBUAJOQ@mail.gmail.com>
 <20210323113233.3523d66b@xps13> <CAFr9PX=KMZuzp61Hq=2WdHyEzE=6J7HEPWZxPs7FEqiH-G8wFw@mail.gmail.com>
 <20210323150603.6b942a60@xps13>
In-Reply-To: <20210323150603.6b942a60@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 26 Mar 2021 23:09:28 +0900
Message-ID: <CAFr9PXntCmdrmg+i3BB1j-aY4VbE=2iqyLcoSr9cX2090jGiGQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Sorry for the constant pestering on this..

On Tue, 23 Mar 2021 at 23:06, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > # nandbiterrs -i /dev/mtd1
> > incremental biterrors test
> > Successfully corrected 0 bit errors per subpage
> > Inserted biterror @ 0/5
> > Read reported 4 corrected bit errors
> > ECC failure, invalid data despite read success
>
> This is not a valid behavior. There is something wrong with the way ECC
> status is read/retrieved. The read should indeed report 4 corrected bit
> errors, but then the data should be valid. Here it means that the
> introduced error appears corrected but in fact is not.
> We need to understand what status are available and write the
> appropriate vendor code.

I looked at the datasheet again and the encoding for ecc status seems
a bit funky.
The chip seems to have only two bits for ECC status with this encoding:
0 - Read success with 0-3 flipped bits.
1 - Read success with 4 flipped bits.
2 - Uncorrectable.
3 - Reserved.

This looks almost the same as the Winbond chips with 0 and 1 being successes
but with no totally error free status.

Anyhow, if 4 bits were corrected is returned for 1 then nandbiterrs
reports "ECC failure, invalid data despite read success".
If I return 3 bit errors for 0 and -EBADMSG for anything else
nandbiterrs doesn't complain anymore but is this right?:

# nandbiterrs -i /dev/mtd1
incremental biterrors test
Read reported 3 corrected bit errors
Successfully corrected 0 bit errors per subpage
biterror @ 0/5
Failed to recover 1 bitflips
Read error after 1 bit errors per page

When running nandbiterrs the status is always 0 before injecting the
error and then sometimes 1 and sometimes 2 after the error is
injected.

Thanks,

Daniel
