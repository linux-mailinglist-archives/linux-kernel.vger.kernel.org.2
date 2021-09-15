Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61840CCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhIOTBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 15:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhIOTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:01:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813DC061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:59:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j13so7243317edv.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dUAnM7XafL3HEwdhqn1xHOeagiNkEafdquQLQJNCzu0=;
        b=km4+wUdcqE5jNctpfK8IFrlxKqFM66CgmaIF667vNGEr/lbF38h8/swwP7+1u1zLJv
         ZcbRjtiHy04rlHWRmJntzQx+R2KM0Ewcgdu7f7splur4G1Yk35U90ty1MV5qNbH/2rHF
         L3lbDnsG156i6+TJK8b6Z3TOEzGy4lexv2dRqb9djGCepn7cBfUdsuwDbzOsMSRf54kB
         v4gnX1Fyl7EHAkZFO3UofRyEnACRaf1SYJyqequ/vkCHnhFTVwbFuved6dNaCK2t19dv
         lmRReQ32lSAhKHHLwnU3ypDvO4+XqK9fKFNZHi7x+5CM9C8BSDDuLqMGi+kikl7g6lf1
         Ka/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUAnM7XafL3HEwdhqn1xHOeagiNkEafdquQLQJNCzu0=;
        b=2ZQXRB1Iu+LY6a8xGRAONq8+ePD9pqMsKF/emQS/kjWxCA9q8j2y1rnvr+zx+Sy/B6
         VZ/Sqk12jY/WLxZU4OLgXlCgcCOkv89ockltkTBvUTYLP2UhBE7Bd+1+cgs6Q5ija8LO
         ov2IuYQbqI2BY1JLggOUn9oPU8oygYNLlkJDEDJImO7spaV5gYbh9uTUT2wApGAgXXl6
         ntCKDy5U2iz6AQ6WKUxMNmB4r/e5wn4ZoAtwSphZdBBEOS2Q+VgqMnx0D1HgqdMtr9hr
         7FQ17DGevSrmT5So+Cm6WQzM3uuK9BzdBQ2I0Iyg4dKlenKkouQG/CNT8SmYchUJ8xhA
         pQRg==
X-Gm-Message-State: AOAM532jJ4dSI2N1A27jBD8JaGu5H2lKVFjvyNuZ4xD3pXe3bHrTgytk
        ZQvr/isPFVb2oE93Lt9kKH0=
X-Google-Smtp-Source: ABdhPJx+y/NF9DDn83K85OIC57v2kqNoBDSDg72fVr7qXWp1XRUnkFIf5uMPibRVDdsFylZoNJ60FA==
X-Received: by 2002:a17:906:ed1:: with SMTP id u17mr1675134eji.304.1631732387312;
        Wed, 15 Sep 2021 11:59:47 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id k21sm343768ejj.55.2021.09.15.11.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:59:46 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     linux-sunxi@lists.linux.dev,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Issue with fw_devlink=on on 5.14
Date:   Wed, 15 Sep 2021 20:59:46 +0200
Message-ID: <33995494.1UIDBzYVPQ@kista>
In-Reply-To: <CAGETcx_6muHgmDAviMf-UBvriePwc+o5408nDeNd_v3zR_x9TQ@mail.gmail.com>
References: <5570111.f9yF5Hohu3@kista> <CAGETcx9_dy4qdmZ-+X+WLsezPKWfZzmRU8QmhKOu6FdZcysWDA@mail.gmail.com> <CAGETcx_6muHgmDAviMf-UBvriePwc+o5408nDeNd_v3zR_x9TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/cc linux-kernel@vger.kernel.org

Dne sreda, 15. september 2021 ob 20:36:11 CEST je Saravana Kannan napisal(a=
):
> On Wed, Sep 15, 2021 at 11:23 AM Saravana Kannan <saravanak@google.com>=20
wrote:
> >
> > On Wed, Sep 15, 2021 at 11:07 AM Jernej =C5=A0krabec
> > <jernej.skrabec@gmail.com> wrote:
> > >
> > > Hi Saravana!
> > >
> > > I noticed that in kernel 5.14, at least on Allwinner H3, deinterlace=
=20
driver
> > > doesn't load anymore if fw_devlink is set to on. If I set it to off,=
=20
driver
> > > loads and works without problems. If I remove interconnects property =
in=20
DT
> > > node and use driver hack instead, it also loads and work ok.
> > >
> > > For reference, I speak about this node:
> > > https://elixir.bootlin.com/linux/v5.14/source/arch/arm/boot/dts/sun8i=
=2Dh3.dtsi#L153
>=20
> Oh the dts file please. Not dtsi. I need the full picture of dependencies.

I just dumped DTB from the board I use for testing this:
http://ix.io/3yZB

>=20
> -Saravana
>=20
> > >
> > > Do you have any clue why it doesn't work?
> >
> > Kinda busy today and I'll take a close look later, but if you delete
> > "interconnect" but it works, then it seems like you have no driver for
> > your "mbus" interconnect? Is that expected?

Ah, you're completely right. There is no MBUS driver (yet), since current=20
purpose of that node is to determine DMA memory offsets and for that you do=
n't=20
need a driver.

There is already WIP driver for it, though:
https://github.com/crust-firmware/linux/commit/
db34316a0194dbf0fcb8eba677ef11085a06a340

> >
> > If you have a driver, then make it use the proper driver model (probe
> > a platform device).
> >
> > If you don't have a driver for it, I'm assuming you have
> > CONFIG_MODULES enabled. Otherwise, fw_devlink=3Don is smart enough to
> > know not to block on devices that'll never be probed.

Correct, modules are enabled.

> >
> > If you do need CONFIG_MODULES enabled, then use
> > deferred_probe_timeout=3Dxxx so that fw_devlink doesn't wait for more
> > modules to be loaded past xxx seconds.

It's not what I want, but more that we broke default configuration and=20
CONFIG_MODULES=3Dy should really work. Is there any other way to fix this b=
esides=20
providing dummy MBUS driver? I doubt it would be accepted for backporting.

> >
> > Also I like to look up emails on lore, so when emailing me about
> > fw_devlink (or any Linux stuff in general I suppose), it'd be nice if
> > you can cc LKML.

Noted.

Best regards,
Jernej

> >
> > Thanks,
> > Saravana
>=20


