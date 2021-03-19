Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1073426D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSU1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhCSU1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:27:20 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DBAC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:27:20 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4F2Fmz2z1PzQjmm
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 21:27:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:mime-version:date:date:message-id
        :subject:subject:from:from:received; s=mail20150812; t=
        1616185629; bh=Yn+EGfijMuV0u2e9wUiG0X6Xk31A1ogrzbbIgsQjN/0=; b=B
        Sc0gpN8zrLtIHW3KU3HAA9QWwGqjNs19jxuXB7xDXebbAyn9h1IFOcXKzcE4s/nb
        1OcN2M0ciNMP5z3PIGYJDq343ou/oXGWZZ3+wWm/rNA269SgoVpYTG0XlU1dGDgM
        cFcapQiL3uoFdXWqOJ96wv6fK+s12+xtXys7EnhOAtpMhmh4Ux7d0G6LdO6aELgW
        fJAI1pknFxITmKjKt+STQVPFbBI1/Wq+l5UwG9F9dvQnx0sdgjROESWijyAzDd8P
        M8MC5MQTdrH6akrNJewSPT4HjhqagG4bua+ilyPlsQn1aBkurkQa6DN7YwPF1xAy
        OvkxtzMdJWrRTykbwje0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1616185633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
        to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
        bh=WbEphMVsGj9eU5ZZY6cBEC2RQPO+IU1cP3focXUOcUk=;
        b=DSaPPZfw7+T2GE2RPZlign8wUqodk0OKOB3jjMOy1ySWwBb+QCT/YHAdhpMvdr40YLfU5G
        CP2O/QFtBsMktyyA3D1V6oFdj7bHvK/30ZxNEp7hYyvHT5ucWCd/vKjdr+m4DGTh/vOGw4
        q7Aam6O0rbAJdQ7xbGgmDbum1Ed95hwUYUfwrl7axC6X1DWg0XE3/kzZAi8UCVMgOZJkOS
        EIpFs3Hdr6hX+8UyvhWzgGwO1EW4RpXQpn0LFJn8FfKJgCWftvHfn2MJB1zZx+JnQOxeeh
        S8sNse9vYjXUQzbn96J75oXmpIqgNo8bd0MvMNpxtiGjl249wJL7Su+J+LovYA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id sI6TJki5kL1s for <linux-kernel@vger.kernel.org>;
        Fri, 19 Mar 2021 21:27:09 +0100 (CET)
To:     linux-kernel@vger.kernel.org
From:   Rainer Fiebig <jrf@mailbox.org>
Subject: [Solved] Building kernels under 5.10 takes twice as long as under
 4.19
Autocrypt: addr=jrf@mailbox.org; prefer-encrypt=mutual; keydata=
 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
 SJBEfJI=
Message-ID: <f145bb8d-0dcd-bd7a-e80b-2f53dc3ce6d0@mailbox.org>
Date:   Fri, 19 Mar 2021 21:27:39 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="F48i1IcR95jbAHy7TdU7lTov7a4DXplBT"
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -8.03 / 15.00 / 15.00
X-Rspamd-Queue-Id: 748231790
X-Rspamd-UID: 964a70
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F48i1IcR95jbAHy7TdU7lTov7a4DXplBT
Content-Type: multipart/mixed; boundary="C6OtMDowdi3X5EdcdyaqKwqgwywdS9EGJ"

--C6OtMDowdi3X5EdcdyaqKwqgwywdS9EGJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bit the bullet, bisected v5.5..v5.6 and found this:

0ddad21d3e99c743a3aa473121dc5561679e26bb is the first bad commit
commit 0ddad21d3e99c743a3aa473121dc5561679e26bb
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Dec 9 09:48:27 2019 -0800

    pipe: use exclusive waits when reading or writing


[...]
[ Note! This kernel improvement seems to be very good at triggering a
race condition in the make jobserver (in GNU make 4.2.1) for me. It's a
long known bug that was fixed back in June 2017 by GNU make commit
b552b0525198 ("[SV 51159] Use a non-blocking read with pselect to
avoid hangs.").

But there wasn't a new release of GNU make until 4.3 on Jan 19 2020,
so a number of distributions may still have the buggy version. Some
have backported the fix to their 4.2.1 release, though, and even
without the fix it's quite timing-dependent whether the bug actually
is hit. ]
[...]


After updating "make" to 4.3 all is well.

Feynman was right again. ;)

--=20
The truth always turns out to be simpler than you thought.
Richard Feynman


--C6OtMDowdi3X5EdcdyaqKwqgwywdS9EGJ--

--F48i1IcR95jbAHy7TdU7lTov7a4DXplBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6yx5PjBNuGB2qJXG8OH3JiWK+PUFAmBVCUUACgkQ8OH3JiWK
+PUnGQ//b+LX1FHmkDq+WBpiR6v16MPxKR6cJsV9Mki3+t9Uml3Sd2/JMtEMYMWt
G2qNvUFNhlEcM5JPBvZKaEOrhJKi++I7QeCoUDKAHGS6EwW+uNBgA/HE2WrnoAyQ
yTudhO6dBGX2+EhgVEOIMMfXTRBp8jW1gg4QaqiHs7l1hJsy8/UdvlgwJszwU3Fv
7TPzitmFXfAwIEBQwlEnxSVgs7BeDmHkftd6ayV2GuWdy5VLHP18NoTEgQ5Fx3nF
Jfm3KoBL01kNaNhMDOX7acRO60qNscHH72UpAVYzgo85fFLp00hpNJAy00Y4Vm+d
n6mkqx7BrNPmIcmyogkbQh1vVfMuEICGwaaji7S7fAcF66wzQniQCqJycnFUSi+W
ZR2LIRExm50gFE1vGeMZPhstWj1nvm7+HXb0MFH458YarMJ3ywDPBajltyabAL/Q
KqOtwrB37lJZRe+Jd6H1AwaTuw2JDGQP9UvoXmia1AJaCopqDog1u1Kp6FMMUrQC
Ef1OhVxNCk2RCIz370etvHTEv9t0d2DzLAwl09k+NfIjyiNea6PEFY6qYDav3UcV
4ymHp5jX3/E22EOorKtRvGG4+JVixvPlzsAN7FnI2soWAC4UvR9nhU/2YIx2TeaJ
k0jNYGCKtuW4i930zQfs11K5+VDKMw/iUEM+OuHtBHCcNl8u9Mg=
=ekST
-----END PGP SIGNATURE-----

--F48i1IcR95jbAHy7TdU7lTov7a4DXplBT--
