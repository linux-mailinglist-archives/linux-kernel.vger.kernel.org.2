Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF08E3ACB19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFRMiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbhFRMir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:38:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BB0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:36:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id my49so15639178ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/agSD8eP3pg9HWHU9Iy7NF0HQURMb8oBGT/c+RAp/hc=;
        b=jQ3wangC7h0O/4MOnlme63Mj28FBfCjCkYEQi/Ru7yY0SNgK1MCQyBKjBkiWLT5Iiu
         40gXzeKk2EOy9coC+ApAa65AqyaY6rGjlLkglL4qb48/xpltBhQSizmlaxhUAP6a61fn
         oU4Z2fKkDq2hvFGxFcXFhcBVGf3ytzgTqu0Q06Iah8FV07vi/cygnkQeK0n42r6dbIIr
         ZRjGOVpaeNjlQJfi6PnOqGncus60PJRwI8G+Y/BRZYJ0E2d1TEUvZ43mdPNwaRp6vlzs
         VMgTmLVVByQQFTEqcJQr0ZAJ8okG4i9SCBrI/OX3j/WydSPcJQc5qo66VEGDmQrnTydT
         LkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=/agSD8eP3pg9HWHU9Iy7NF0HQURMb8oBGT/c+RAp/hc=;
        b=aFaKunmVIVJ/8MK73+/PDOQo2CwjZtlPE9lZy730AoS+7pBrqLXp3492TnLaQnYOBb
         xBuRlUaw5jv+Tpzgpcz2e77UZ6IVgLekc2UzWeapFSuV3kjrAMEOHhvjhkcrnS0rgs7i
         aE3REnvuAaIUeZeMJgHTjM6hzvL0dnuzOjuwX1w/DPwebfS9YMLJZiFYWyX1wVdYphUq
         EOz3NHnDPR5/lXEIhvGnEBatvrGmnaE+6xcxX7lp2XRdXi2hBaursTCbtQg/wMqJ322g
         ho3vTfdwTxzdycACvdvhrfowejuijHpOzn0Un7SVm3zoFRVjQF1k9QuDSodQamyXk1yY
         qHGg==
X-Gm-Message-State: AOAM531e/Wsw4Mzabco+FjIFs2t6iuCJ0SBO3FVOS2YdwrKTiVK1IZAH
        wmFoQP9bUzrXp/PfmADIcOI=
X-Google-Smtp-Source: ABdhPJzlDUIDa61MQKfXHtvjePLzsZpWMF/CSH2QAIMEVAg8xeMjYPWNEyMX6ffGiqJZsBoOliq14Q==
X-Received: by 2002:a17:907:a92:: with SMTP id by18mr10796417ejc.224.1624019796972;
        Fri, 18 Jun 2021 05:36:36 -0700 (PDT)
Received: from m4.home (tor-exit-8.zbau.f3netze.de. [2a0b:f4c0:16c:8::1])
        by smtp.gmail.com with ESMTPSA id a22sm981428ejv.67.2021.06.18.05.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:36:35 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.home with local (Exim 4.94.2)
        (envelope-from <cavok@m4>)
        id 1luDje-00032B-6S; Fri, 18 Jun 2021 14:36:34 +0200
Date:   Fri, 18 Jun 2021 14:36:34 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: REGRESSION: v5.13-rc1 does not boot because of "of/pci: Add
 IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses"
Message-ID: <YMyTUv7Jsd89PGci@m4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NwBGr37j3zSa/Qed"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NwBGr37j3zSa/Qed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Leonardo,

Since v5.13-rc1 my NanoPI M4 (arm64 with pcie-attached nvme) does not boot =
any more.

I could bisect it down to your commit 9d57e61bf72336e13e4cd3c31e93ab2626629=
6a8, just
reverting it from v5.13-rc6 makes the boot happen again.

The .dts file I use is arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4v2.dts.

This is the output of lspci -vv:

00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI Express=
 Root Port (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 90
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff [size=3D4K]
	Memory behind bridge: fa000000-fa0fffff [size=3D1M]
	Prefetchable memory behind bridge: 00000000-000fffff [size=3D1M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD=
 Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
	Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 89
	NUMA node: 0
	Region 0: Memory at fa000000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: <access denied>
	Kernel driver in use: nvme
	Kernel modules: nvme

Is there anything I can do to help you understanding why this is happening?

I apologize for not having bisected it earlier.

Kind regards,
Domenico

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--NwBGr37j3zSa/Qed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0znebYyV6RAN/q8htwRzp/vsqYEFAmDMkvgACgkQtwRzp/vs
qYFkURAAkgtQYBKAG/9Xnh5EaIbq/Za/pb0CPrDbuHIEs4V0wS+K6D4dO8WozIl+
Etcn85e4aoiftwV6ZD72N5w+m0DLn8IpHBysLQyPrJKQNZGXImk1DGIgG4TUU1rz
+aUHuSn5eiojfT4jymNo/xOZF6LhQil47OdRVyE2G/f0bZRXxYvWSzB0Y8P1sV1P
hG77y9mSDPwsLEdiGKR+1PHsp7RNtM9SgF1x8/ss70pmU6nUxMPoFrmHaRSfKmO+
qG3PRqmgG8PWYJb5brtNSGNU9I2p9yC7RhNd/kDHuW93xTL4+bI8qix/S5Fr0Azp
KWXDP18qpsLFTPtQ/INfBDR2eAu1ft7H66rvBWkeDWb2fQQQgUSrWCy2Lw+vkKVZ
jXB885sVXadI2M5Nue/4NTaGCYgdPdRv2bIlzUhkftI5Ct8gXOnkaLxtKNn0WzJj
21fCIxAa++3ZwMm3VRQfo+L9/rHkNjXNAPqVkvRFiRbbklZeutxmMtdTnpXKZrdg
4GEyWfVFJi4BToz5DykrXnVbr/CFekoT2zH2xMZ4L3xqinl61am3/Gs8dq7EaMJ4
IFq4OSMyhPrGJRDhzydhd7CB/B0D9hAac1mBIa/QcvtogICu63l4nyxZmZpRwfUu
mCXSJYJ0Py7j5FUudA4D88C6DMQy0J/GuvPvGr0b6Vvh1fgNFuw=
=7rVZ
-----END PGP SIGNATURE-----

--NwBGr37j3zSa/Qed--
