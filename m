Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B9F3DCA0E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 07:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhHAFEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 01:04:22 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51687 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhHAFEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 01:04:21 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8DF235C00A7;
        Sun,  1 Aug 2021 01:04:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 01 Aug 2021 01:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-id:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ixXBiF5JMgE/jUfE+hpqY4FdeRq+epIUTn/nmvE6jJ0=; b=WebSY7C9
        FAHKPgJvFoR1uu08jVMVfCqNSRNPXqlT1nvgNEPi+wugD0d6B8/2/BCeXUhrvrmv
        fjxtRAzVJH0iQFnekwdUPGlQ/MzF0JGatyDJM3hprQCSMowHC178lMG9vCIjKJfi
        lJ2hNJSgWE1agkuC7eVuVq8y+7TeWpI1AakokQ6IYBoJvA80tMPC5xQ5tdIsH5Qb
        KsbSrigE/nxjIrk6Y8i3mbPikRICNfmWrjsHX3VAKDVmzgqGpXv3+sqEMRkx0wad
        A0UtO4vLjRvdrKH4OSG/TRGueUJdLAwV+1HQnmzbkHMbwDd5z7cm+TWyT2udqrbw
        ZTwKlUzD03uRIA==
X-ME-Sender: <xms:SisGYZ_nkbMjsGdEQxUPiAIha876S-oiF171GzIukMvNx1k6O5kieQ>
    <xme:SisGYduUwjsV6ZNzFxxReeJIynLICubzXGITBK-ybYvm35EXJiRjsXM3_5gTUZI9M
    cINJlA1hoLc2ZcDViI>
X-ME-Received: <xmr:SisGYXB72l5pi9X-eGPkFlnHgj1flDVNVs7Xqmqp8m4cg5eWha_hlOSRTbw5RaKm9YR2l3yQ_ZQD9mIu4kAQUFL2-3Jfroibmfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheekgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefffejiefgheevheefvefhteeggfeijeeiveeihfffffdugfefkeelfffhgfeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:SisGYdeaEN6I7PZt29wkpnJ5hCa9pE8Zs4IWef3NyG1FWr-nCTPvSw>
    <xmx:SisGYePbpuRVZ1I7Iei1JcoWyrgy_Ukid-nNGuAUhH8mLmyBmCejcQ>
    <xmx:SisGYfktxFQRdPl5kszdECRQ4VRLeuD4TWlQSgDyW9vczEG22SYh6Q>
    <xmx:SysGYXZirp0_sDutraj3or5wSk9-UGcGF1ftNIaLCcB5tqcf-iI9yA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Aug 2021 01:04:08 -0400 (EDT)
Date:   Sun, 1 Aug 2021 15:04:03 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v2 1/4] nubus: Simplify check in remove callback
In-Reply-To: <20210730191035.1455248-2-u.kleine-koenig@pengutronix.de>
Message-ID: <dd248ad3-87b-ead8-957d-aea36cb01058@linux-m68k.org>
References: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de> <20210730191035.1455248-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-1980221512-1627794129=:27"
Content-ID: <f0cf4098-5fe6-2ba5-457a-fd1b6bf4b24c@nippy.intranet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-1980221512-1627794129=:27
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <422deda6-11f-a1c8-5510-7123c82751b8@nippy.intranet>

On Fri, 30 Jul 2021, Uwe Kleine-K=C3=B6nig wrote:

> The driver core only calls a remove callback when the device was
> successfully bound (aka probed) before. So dev->driver is never NULL and
> the respective check can just be dropped.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Finn Thain <fthain@linux-m68k.org>

BTW, aside from nubus, zorro and superhyway you can find the same pattern
in many other busses. You may want to patch the following methods too.

acpi_device_remove
apr_device_remove
ccwgroup_remove
gio_device_remove
hid_device_remove=20
ibmebus_bus_device_remove
macio_device_remove
memstick_device_remove
ntb_remove
pci_device_remove
pnp_device_remove
ps3_system_bus_remove
rio_device_remove
slim_device_remove
soundbus_device_remove
ssb_device_remove
tifm_device_remove
vdpa_dev_remove
vmbus_remove

> ---
>  drivers/nubus/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
> index d9d04f27f89b..17fad660032c 100644
> --- a/drivers/nubus/bus.c
> +++ b/drivers/nubus/bus.c
> @@ -33,7 +33,7 @@ static void nubus_device_remove(struct device *dev)
>  {
>  =09struct nubus_driver *ndrv =3D to_nubus_driver(dev->driver);
> =20
> -=09if (dev->driver && ndrv->remove)
> +=09if (ndrv->remove)
>  =09=09ndrv->remove(to_nubus_board(dev));
>  }
> =20
>=20
---1463811774-1980221512-1627794129=:27--
