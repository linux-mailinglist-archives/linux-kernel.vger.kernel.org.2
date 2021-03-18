Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751A6340D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhCRSmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhCRSlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:41:49 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8D7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:41:49 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4F1bTl5661zQjml
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 19:41:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:mime-version:date:date:message-id
        :subject:subject:from:from:received; s=mail20150812; t=
        1616092904; bh=/8MpJXjSwZIHd+ACBXsSwMrHDdFPO7YYHodxN1N62WE=; b=O
        JofBSDwRmPfs5yRoKTLYR2OGs3g/8+pIKmhHyjsK1xqlSBJ2r+1EnQczGtDfwTDw
        +um4tcTaBtSauWpDs5mJ+U/yj2rkV/NvA/NqCkjzjBcVl3WZ5wM31hhg+eKVHMuD
        vMYJuPwqPVrn1AcviJ6/bm01H5J1V21+Q/LgalD1h4uVY/rk+JJZ4q9s/0zIql4r
        vKUNzw++VlpJaML4g1XkhLKqVwreVsVve3nLCOloimYEhlTYE5CxtY3DcVaBCvGc
        Iv1ZtGliCUzQ6r+sZQJNJBDS9qKhkZw9vDf0OpXePc707uA1rVVCZghvrmi6SLfp
        B/2RA2+ISozedGTvoc+CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1616092905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
        to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
        bh=EIbiBhxSYlZ9YADo8t0y2M3Ch7Nin9sQwBwQ4luE1po=;
        b=KhIkk28SlbLf6YFO5/bBHVbmgh9Pb2KY7OFuz3M6Dw/HUxL90mj8sBQYFeOOjTXvtm2EJH
        HIhRViTdqAqwnpc7ubn6QT26nRltsTF58twdvsPQ0yzov7ZheUkn1rAJDDVHCgyExJcZha
        HJ+Q31oLcSuNI6AfWF5zunqf0UCf4yotya7VMnOR9104hw6117bNHJAw17W3tSE7hra+hm
        RwwNoUIZXaMlpAuXiwCRwytjSzSgJjLca2Mi5JewziZ+9dQ00diOLAOOGDewTq1pNjtmls
        ku1jzBEaLWrt/myPGgwpHhHgHK3ahRAdlO3VaZDm4iQ3uBN5WQZJd2lWyAnhmA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id vISrBX2cMupd for <linux-kernel@vger.kernel.org>;
        Thu, 18 Mar 2021 19:41:44 +0100 (CET)
To:     linux-kernel@vger.kernel.org
From:   Rainer Fiebig <jrf@mailbox.org>
Subject: Building kernels under 5.10 takes twice as long as under 4.19
Autocrypt: addr=jrf@mailbox.org; prefer-encrypt=mutual; keydata=
 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
 SJBEfJI=
Message-ID: <fdbc3b5e-9aeb-126a-1183-05326fd615f2@mailbox.org>
Date:   Thu, 18 Mar 2021 19:42:14 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H4beXjGRKtOO6w7nmMWpkyCOQyCh1xGPk"
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.59 / 15.00 / 15.00
X-Rspamd-Queue-Id: B3737601
X-Rspamd-UID: ca2da4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H4beXjGRKtOO6w7nmMWpkyCOQyCh1xGPk
Content-Type: multipart/mixed; boundary="vbSOjkyfpB1sxi38NKJh515eZh9dUOUah"

--vbSOjkyfpB1sxi38NKJh515eZh9dUOUah
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

I tried kernel 5.10.x and encountered a strange problem: building the
same kernel (5.10.22/23) took roughly twice as long as under 4.19.179.

This is reproducible under kernels 5.9, 5.8 and 5.6. The latter is where
it apparently starts, kernel 5.5 is not affected.

Here's an example:

5.6 built under 5.5, -j4
************************
[...]
  LD [M]  sound/pci/hda/snd-hda-intel.ko

real    11m44,125s
user    38m35,022s
sys     3m17,940s

5.6 under 5.6, -j4
******************
[...]
  LD [M]  sound/pci/hda/snd-hda-intel.ko

real    23m25,834s
user    26m7,738s
sys     2m42,292s

Always after "make mrproper", with -j4, identical .config and everything
else unchanged. It's also there with a default .config.

When I build the kernels under 4.19 or 5.5 with -j4, CPU-usage is 100 %
almost all the time. Under 5.6 and later, CPU-usage goes down to ~30 %
for longer periods during which I see long sections of sorted items like
"fs/xfs" which I had never noticed before.

CPUfreq-governor was "ondemand" in all cases (for 5.10 set via
commandline). The CPU is an Intel Core i3 (Clarkdale/Ironlake; still
fast enough for a snappy LFS-Linux with Plasma 5).

Before writing a bug-report: any ideas what might cause this or how to
narrow the search? A full bisect between 5.5 and 5.6 would be a real drag=
=2E

And please don't say this is a feature now. ;)

Thanks.

Rainer

--=20
The truth always turns out to be simpler than you thought.
Richard Feynman


--vbSOjkyfpB1sxi38NKJh515eZh9dUOUah--

--H4beXjGRKtOO6w7nmMWpkyCOQyCh1xGPk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6yx5PjBNuGB2qJXG8OH3JiWK+PUFAmBTnwcACgkQ8OH3JiWK
+PX6EhAAyN0LpHoAquoJucdi1dWYcsWy7CJuuiEgoEKDhg8ZM4v9ivcBIMbkVf7u
Njk3YuFfn5UVdcHe9nJ6Ce7zsk0nNeXmHE1HGXPIcRFPBaLJ1+N+cUHiHWZIszYx
7mvlTAs+RkLHdp7MiOg1nYSR2tmjX9MwlUQ3iz1Oh3yOsDaHdT5cyKHJ5GJdY9w3
Cr/zEnOzw41/ARKyUUweg6Kg20E2dNejBZ8tw/MWyKODnGaGN3qToUEp+usSlkIG
7q6MYvFsj4PV3LHD0Z+tzQlTUsIxrsGHWxBTLtRiPydYLYTo4T9nkO6MZFq66sTh
a0oHMwcNYW3dzsi9kc3cu7bHxBx603rIW0gsV4WOfyTyd3AQWekitmquEoMuGTQL
1dP/UWSNscGwvEj2gh6tnDdTMe5rjaNbuITsFBt+zkTWb2vi76H7hZj1DU6cTD4w
iSFPUPE1OPeQiura0m06tUbMznoev2Ia+9SzufEe61gO9I5cO4ahlxyPHQjZSdfo
RS0eCVnmQ2d0zwd/swHqbSCTqpuH49k09TJVIo+oszcATz6Z0sHGoP0C0RMmVnd0
h/iJ4LOEz0J+5sQnbuXMYpRdbfbHmYEhfLMT4MkvZ0Jps3afA2h0WfN6JS7GA2o2
YFnDL6J+t0y6gfNmbbgs1kIvXgbaVj9rtW8eqfsU1W8E9iohY8E=
=olfv
-----END PGP SIGNATURE-----

--H4beXjGRKtOO6w7nmMWpkyCOQyCh1xGPk--
