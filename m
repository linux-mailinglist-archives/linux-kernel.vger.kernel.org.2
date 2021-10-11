Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ECB42876C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhJKHJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:09:05 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:40566 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJKHJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1633936023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4A5IbiON99sAmaO5rSffIZ7vgzdOWfa8UnMZX6no8SI=;
        b=XZSyyuZJbarDtRPi2do9RZJzBnzxlFdszrY04nDqWis73okxBzpJoCfh+RA8SLDvuciTLZ
        9hsVmEICvl3JjYKdA4KeElflamaETDHsW00Be2UMnIKCK70wPJeseVi5tjogKlBOy4AFgd
        +KVsAJZtmvzYHOzpzms4Kioebl+/rpw=
From:   Sven Eckelmann <sven@narfation.org>
To:     openwrt-devel@lists.openwrt.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Adrian Schmutzler <dev@schmutzler.it>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: nvmem: Defining cells on mtd created by mtdparts
Date:   Mon, 11 Oct 2021 09:06:56 +0200
Message-ID: <14722734.oMan5NXi5u@sven-desktop>
In-Reply-To: <18728084.NGlc0Rocea@sven-desktop>
References: <18728084.NGlc0Rocea@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart27234856.iIAV7Kigx3"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart27234856.iIAV7Kigx3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: openwrt-devel@lists.openwrt.org
Cc: Ansuel Smith <ansuelsmth@gmail.com>, Michael Walle <michael@walle.cc>, Adrian Schmutzler <dev@schmutzler.it>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mtd@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-kernel@vger.kernel.org
Subject: Re: nvmem: Defining cells on mtd created by mtdparts
Date: Mon, 11 Oct 2021 09:06:56 +0200
Message-ID: <14722734.oMan5NXi5u@sven-desktop>
In-Reply-To: <18728084.NGlc0Rocea@sven-desktop>
References: <18728084.NGlc0Rocea@sven-desktop>

On Sunday, 10 October 2021 14:53:13 CEST Sven Eckelmann wrote:
[...]
> Since there are most likely more devices out there which use mtdparts, I would 
> guess that there might already be a strategy out there which can be used to 
> define the nvmem-provider for mtdparts defined partitions. At least I saw that 
> Bartosz Golaszewski added all the mtd devices automatically as nvmem provider 
> in c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem 
> API"). So there might also be something for nvmem-cells to find the correct 
> mtd instead of relying on the fixed-partitions registration + of_node (which 
> doesn't exist because it comes from mtdparts and not devicetree).

Ansuel Smith just proposed in OpenWrt [1] a workaround. It basically adds a 
minimal fixed-partitions parser to the mtd cmdlinepart parser (responsible for 
the mtdparts=) that tries to find the matching (size + offset) fixed-partition 
from the devicetree. The code in mtd_device_parse_register
(add_mtd_partitions -> add_mtd_device -> mtd_nvmem_add) will then 
automatically take care of the rest.

Kind regards,
	Sven

[1] https://github.com/openwrt/openwrt/pull/4664#issuecomment-939567963
--nextPart27234856.iIAV7Kigx3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmFj4pAACgkQXYcKB8Em
e0b9eBAArC/EsvvrKk2y7/99MES/Eds+2b37/9dxuvOPOxULMobk3Gu1VC1qhKv4
Z2zYdWP1rGz14r+DqYD9YhSvw1wM8WMN6hT3A2QWErF36fPngvahOLXZjoagaDVN
PQQ+G8KKV/5WtNGjiah8zMWBcXC0zzLVRkxLsZ2BwuSVXsFo0qJereWknxw7F/Qf
dw86a5Yf7JbcPaL4oJg/522oC+6O8CLwakwmyjp5ZLDDqo/z+p4DgqDM8OVphX5v
0MsYCT0YfvEJyVOZfkiUKljqIwyEgJbAtJDxIYAX6Riauz+cEmy6diArVOnNro8/
EEQuoyJq6Vu9By2E/pnsDahrk1DIkd5pi1hnR8qTMf/VTD2YC85DWg1y7qKdpf8g
pQ8HsH/5ZCgPcQJFXU50RNaxlHQq8BJVbGcO8SHKUSZY29lo17pafWwMfRKLO1fh
Qhyk8l19iwmmQ09Uho1xbNE5CBzSP1RH76/4HTEFDXPYSOCu1zDuf5FSlSQZjTop
KClni0PvXPqeDRRtkoMLO2/LIjE3S8cCsRF37zqJdN6Ko9drwk/Vsp1BEIkzBzB9
hNihrk6JeaKhQ6Ogmtcw7pIMwrI8TXgvWlYqvaEt7KPHU0HKXOXdkS+4jO1nyaZD
k4dLtPx5LW4kgHcY0JqaFLOZfTMwPiPL05cPTEp+WkyR7rJCktk=
=iCmG
-----END PGP SIGNATURE-----

--nextPart27234856.iIAV7Kigx3--



