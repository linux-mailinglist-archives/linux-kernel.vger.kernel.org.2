Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8100428167
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhJJMzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:55:41 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:44420 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhJJMzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1633870416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Ka3hAH/lUJKKNybA9c7wCc0FnlCDlR+9uRO+Z6eg+H0=;
        b=VJ9K1VA9KuQdCdlA57rb7o13icD7R9BYqtPzIMFahl8qbO3p82UeHkA6j5IQVX1fLpk3KQ
        gIk3bTUxxJa5R311DVAmeA4Sz2dB/RvFu3nQXsi4pBwiTFRIGPTJUuSoD+wBITrPSarjxC
        P/WhbRk2+SQSsLrhGjVLLEHXwmQUd4I=
From:   Sven Eckelmann <sven@narfation.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, openwrt-devel@lists.openwrt.org,
        Adrian Schmutzler <dev@schmutzler.it>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: nvmem: Defining cells on mtd created by mtdparts
Date:   Sun, 10 Oct 2021 14:53:13 +0200
Message-ID: <18728084.NGlc0Rocea@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18532926.MoXNmc8o6T"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart18532926.MoXNmc8o6T
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Ansuel Smith <ansuelsmth@gmail.com>
Cc: Michael Walle <michael@walle.cc>, openwrt-devel@lists.openwrt.org, Adrian Schmutzler <dev@schmutzler.it>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mtd@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-kernel@vger.kernel.org
Subject: nvmem: Defining cells on mtd created by mtdparts
Date: Sun, 10 Oct 2021 14:53:13 +0200
Message-ID: <18728084.NGlc0Rocea@sven-desktop>

Hi,

OpenWrt switched [1] their MAC address (from flash) retrieval code from their 
mtd-mac-address based solution [2] to nvmem-cells. The mtd-mac-address based 
solution had the benefit that it could find the correct partition by using 
get_mtd_device_nm - which was label based. So a lookup for a partition which 
was defined via mtdparts was absolutely no problem. This doesn't seem to be
the case for nvmem - at least not how it is integrated at the moment in
OpenWrt.

This means that the performed switch broke the vendor defined MAC addresses 
when the u-boot must dynamically define the partitions via mtdpart - and where 
fixed-partitions are not possible in the DT. The bootloaders used by the ath79 
usually have no devicetree support and cannot modify the device tree (beside 
the problem to get the sources for these bootloaders). These devices will now 
only have random mac addresses.

Since there are most likely more devices out there which use mtdparts, I would 
guess that there might already be a strategy out there which can be used to 
define the nvmem-provider for mtdparts defined partitions. At least I saw that 
Bartosz Golaszewski added all the mtd devices automatically as nvmem provider 
in c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem 
API"). So there might also be something for nvmem-cells to find the correct 
mtd instead of relying on the fixed-partitions registration + of_node (which 
doesn't exist because it comes from mtdparts and not devicetree).

Right now nvmem_cell_get (actually __nvmem_device_get) in 
nvmem_get_mac_address just return -517 (EPROBE_DEFER). So the nvmem_device is 
not yet registered - which absolutely makes sense when mtdparts is used. 
of_nvmem_find will just not be able to find the of_node for this partition
via bus_find_device_by_of_node because there is no such of_node for mtdparts 
partitions.

Kind regards,
	Sven

[1] https://github.com/openwrt/openwrt/pull/4041
[2] https://github.com/openwrt/openwrt/commit/5ae2e786395c7f9db0167ebe875be5df9502d8d8
--nextPart18532926.MoXNmc8o6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmFi4jkACgkQXYcKB8Em
e0Z6cQ/9Fa1wW43nD+xINdgZDbDetWKSlF+in9Sfq3+UKxNp/+isQ+XcukgSTqEN
1grXIVh2NO/yBdJqhmkktWE5j9jnJjN4659vm9wXO/WIHnA6MJBKZ4xM7pI5VXmv
AL1r8veMng4nZahSRSMojMUPjA/oGpNT/oPUwsMakr5Bx6f6TUVaAG6Fc0cr4s51
4Kd5HbUarJcCNMsLy7liIvSLHRnZGjhXhgl7S/sOrJsRzlP6VCPPOU3J/8e7fbIo
NgQO+Q4WD61cNjh6GbUcII/QyMjJTTklAej58FsdUVZtzUntLz9ynXyTZAnTqZDn
luUiaYC2Q/roJgtTN4iFZ3eY43tw4tvlaIyfkJK4I0qkcj7PPmXkZ9IXTKAfrZHs
YL+DU6lUCqG9MhuNP9CmRU6Pd9+YXKPcdlXy7snGq9O2WSezC0TS3TfN2vmpVSwe
41aF7qYpHgRgfup4Zoy7+V5wvjV6MiVgfHcZg8McyQEmp616pFu/yjO3dlfuiLLx
eqf6wxrFDZ51y0EMxtszJX5kKbCDLKLRwxbWVzG3GUS9cL1EJmK9dLrXiE7jPGSz
Nh/oKETVVOkviPlvb0SdnLgNIgRvEgho6x7ofGM+Gxl/BSAOZr+/C4jV6nF4UZ+c
gGwJjcKjowsA0PxxrHD8alsn7eSJrPkS9+kckfSMtbi5ZreTdGs=
=jilJ
-----END PGP SIGNATURE-----

--nextPart18532926.MoXNmc8o6T--



