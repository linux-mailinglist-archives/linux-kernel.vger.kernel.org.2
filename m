Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700773DE445
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 04:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhHCCO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 22:14:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41481 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233546AbhHCCO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 22:14:26 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id BFC5B5C0170;
        Mon,  2 Aug 2021 22:14:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 02 Aug 2021 22:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-id:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=EY/qN5uHXz1UU/DqCSwm4dCJ+qLyDdaY4qJGkkdoc/M=; b=h4zLHHot
        g2yv59x/Nit1MoUGQcmabI99D5cZfoU3fyGF8YZE7ZNdgRCTVVPJHo9rwI/JRNv2
        2Mfnvk+tKlxrOD8Ljfky9fgsW+ZwKWVmLD0HzDFMq7jtSHmmOGCfasS6/1VEVwZd
        WQCkSEsEq0+WmxVvHzygkCjhLda1j7Kuy25UCXDWiEg7cMUaHuMD82hVvVHeYU9s
        6IMYe3APtwO6eZJDmilwQuxn+f2cUspmy3NdsngQA0/hq+0ibrtyFPDVpih+9VkO
        rUSQp6cMev40cgy5n36Fj+RQnik2p2vHyGuAaXhJKs9erDOnTYx0/FmY4PUru8At
        fA7cX2ONQ+0Bkw==
X-ME-Sender: <xms:d6YIYc_Q_DwfEbuy-1gaikOylEijaioFaKjPbryqoxn7q9kzlYB-rA>
    <xme:d6YIYUv-CGQO5rKtX8aTZSit4Yv6PtMsAN5PT0zXPd8CFHNadJOLohJ0ezzHWGl3X
    eE6UGvGrlsj53w6Gkc>
X-ME-Received: <xmr:d6YIYSAA0BqZ7ITmyykZTg-R9rV2SmnN08aSAt9LBWABwBDYjKe8zxsr_HsDYYxRjDvUB0lXaA2ch5TG4h2xayGYg2Ua1gWfzWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieefgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefffejiefgheevheefvefhteeggfeijeeiveeihfffffdugfefkeelfffhgfeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:d6YIYcc5EG3BjhK_M5eGRmmEXzdGXAxtQBaKn-d3aprYq4lKF5Yp1w>
    <xmx:d6YIYRMoiRWhL6vMindGfRPvVSAthrwEV0y2tUrOxCstJ-KzI5v6MQ>
    <xmx:d6YIYWm-0VHP4SirfaqI_qPJjNmZg04uOVyqnSBxvniM5haI_PwB6g>
    <xmx:d6YIYaYEHEtgAHvEJF3lHzpbBbrtirPpt13XG4FN9CurMQ3CjsqG4g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Aug 2021 22:14:12 -0400 (EDT)
Date:   Tue, 3 Aug 2021 12:14:07 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 1/4] nubus: Simplify check in remove callback
In-Reply-To: <20210802065224.n2tarfx6hzfamdyp@pengutronix.de>
Message-ID: <efc9599-82db-5343-a377-ed53bdb928c6@linux-m68k.org>
References: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de> <20210730191035.1455248-2-u.kleine-koenig@pengutronix.de> <dd248ad3-87b-ead8-957d-aea36cb01058@linux-m68k.org> <20210802065224.n2tarfx6hzfamdyp@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-1637780939-1627949988=:28"
Content-ID: <fca194e9-4926-3b59-a4c0-aa43688049ee@nippy.intranet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-1637780939-1627949988=:28
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <8ba6725c-fdf-1438-4fad-ee38d77f32d3@nippy.intranet>

On Mon, 2 Aug 2021, Uwe Kleine-K=C3=B6nig wrote:

> >=20
> > BTW, aside from nubus, zorro and superhyway you can find the same=20
> > pattern in many other busses. You may want to patch the following=20
> > methods too.
> >=20
> > acpi_device_remove
> > apr_device_remove
> > ccwgroup_remove
> > gio_device_remove
> > hid_device_remove=20
> > ibmebus_bus_device_remove
> > macio_device_remove
> > memstick_device_remove
> > ntb_remove
> > pci_device_remove
> > pnp_device_remove
> > ps3_system_bus_remove
> > rio_device_remove
> > slim_device_remove
> > soundbus_device_remove
> > ssb_device_remove
> > tifm_device_remove
> > vdpa_dev_remove
> > vmbus_remove
>=20
> Did you find these by hand? Or using a coccinelle match?
>=20

I used grep and visual inspection.

> Anyhow, thanks for the list, I'll add it to my todo list but if you're=20
> motivated don't consider these cleanups as my property. (Please Cc: me=20
> though to prevent duplicated effort.)
>=20

I went looking for the other examples of this pattern because I wanted to=
=20
understand it better. Then I realized that I might as well make a list=20
since I was searching anyway.

When skimming that code, I took the impression that the dev->driver =3D=3D=
=20
NULL test probably comes from old code written before the 'remove'=20
functions became bus methods. See also commit 594c8281f905 ("[PATCH] Add=20
bus_type probe, remove, shutdown methods.")

Back when I wrote drivers/nubus/bus.c, apparently I copied-and-pasted the=
=20
old pattern from drivers/pci/pci-driver.c, even though that pattern was=20
already obsolete.

So I do see the value in this cleanup but I'm afraid I'm too busy to help=
=20
further. If you don't want to finish it perhaps you can get the janitors=20
to do so.
---1463811774-1637780939-1627949988=:28--
