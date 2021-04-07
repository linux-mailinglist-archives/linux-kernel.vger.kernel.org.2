Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C3356BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351943AbhDGL7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhDGL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:59:52 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859F7C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 04:59:43 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c3so18319037qkc.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 04:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wD+7QjxW8Yy8u2YJJtpm9de9zmFgNbvMAMPJpbXhd3s=;
        b=RithvaeISWOYFMKOs+4g/yzDzcC1QR5HGBFNusZbLRrcUOYrNhj5Iv6cvmCYM00LDj
         HYWg2/ulQV4CwT8We2hte5vfPOY6QOFgQnEvGnIl4zx2OPts88+FM89qm82iyJlz1url
         r3BggoDlxf7mJd0/sO+tRA9OpxRyxDqbl9JuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wD+7QjxW8Yy8u2YJJtpm9de9zmFgNbvMAMPJpbXhd3s=;
        b=S3rkTHyZH/XE+jWUZpnjQpKleb7HGQfMhbKDRkcNk0PJu/XlTwNw8KfYzAOgUUJe3d
         1NKV/2b66T8S5Hrhf5n6HhVTZqNhz7wCG3HwrVEHnmjLDZ+Ffm/Fd9NGKSSewx2kuc6N
         xNhelwW0RHCHY0zWYJIiNXIrgW/jGN5OylOAb3lTOeQBZ+ilhfkdON+sQfHWkKgPkS0n
         bh3SPiYe4iKss3o4heG+uvAY3YF0Z4UELAz2gJsqvhNmdqymHpHmR38UBMMJtqpHdvCG
         5DZpFNYy2l6Z6l1K4mRMgLvNImq/olrLQacxJTKcC3k0x/msS2g160DTlp/yMvVa9rlH
         oudQ==
X-Gm-Message-State: AOAM531qSyBkgGEv7RzyUB0q5+i/oVTJaEfRNiqSHuMDeUbd4xXkS9g0
        qy4gjGC2t6UMGsw7eOsxrGJQ9KcSZB1oX4HDeVKUeA==
X-Google-Smtp-Source: ABdhPJz5ySbfYXXZwpf33xxO36joDp/Mzky80FMCiS4DEuWAntYABJySYm1p3wPpOyinS8r/oOgTBoLnXTuzBQ2PnaI=
X-Received: by 2002:ae9:f70a:: with SMTP id s10mr2795952qkg.468.1617796782806;
 Wed, 07 Apr 2021 04:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210213095724.3411058-1-daniel@0x0f.com> <20210215112409.1a755bf0@xps13>
 <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
 <20210215121653.4edd86c4@xps13> <CAFr9PXmVehtcm6FjBqi_hmEAj1rgtxMvarisjPmWhgjruVj++Q@mail.gmail.com>
 <20210322193213.18520b9a@xps13> <CAFr9PX=mL9UWcr-yWbYa5NXS-R=yHeGgM+hd_MKOa2XiBUAJOQ@mail.gmail.com>
 <20210323113233.3523d66b@xps13> <CAFr9PX=KMZuzp61Hq=2WdHyEzE=6J7HEPWZxPs7FEqiH-G8wFw@mail.gmail.com>
 <20210323150603.6b942a60@xps13> <CAFr9PXntCmdrmg+i3BB1j-aY4VbE=2iqyLcoSr9cX2090jGiGQ@mail.gmail.com>
 <20210407100204.08d894ca@xps13>
In-Reply-To: <20210407100204.08d894ca@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 7 Apr 2021 21:01:01 +0900
Message-ID: <CAFr9PXk-PNWBa9VPriP3nLUqdhtm6uPnbG3n4_rRCdF5YvS7OQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Wed, 7 Apr 2021 at 17:02, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> You may look at micron_8_ecc_get_status() helper to guide you. But
> IMHO, if there are 0-3 bf, you should probably assume there were 3 bf
> and return 3, if there were 4, return 4, if it's uncorrectable return
> -EBADMSG otherwise -EINVAL.

Understood.

> We should verify that this does not mess with UBI wear leveling
> though. Please check that returning 3-bit errors no matter the
> actual number of flipped bits does not lead UBI to move the data away
> (I think it's fine but we need to be sure otherwise the implementation
> proposal is not valid).

Ok. I'm not sure how to check that yet but I'll look into it.

Thanks for all of the help on this.

Cheers,

Daniel
