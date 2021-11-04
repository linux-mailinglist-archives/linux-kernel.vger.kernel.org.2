Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049734456B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhKDQEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:04:42 -0400
Received: from sonic315-54.consmr.mail.gq1.yahoo.com ([98.137.65.30]:42634
        "EHLO sonic315-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhKDQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1636041715; bh=A4QQTOs6LO/zdkt3DbWSFH3J2TrDPxsCMFwPMziDcFw=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=rOwADDtv/s9tyogyH3tCbnEudgknU5FZM7e3cJn+KBmVXq1IRX3987UFuS4HAFtjGl1UjYcXJLb/lyanP4SLyw/wvF53Hm2DtmxafTqwtJRusG40ccfhcVPwikbytLMka6e1sL+1nKDx0IRDTsHdAtf/IgRL/5ce69wHzPRPUQ5k/5C4yWnBH2zkfsCfLJkSBhWfexDeXHXWza6XTZwAxeGXJ0DyOPxyZqWQWdgwoTjRtpHoF9BKiJL6mXQ+yhOi10AZ35x9L5mz5578GjWCvtSkfRsASrVXao6xftHB0ZdOpX7zlahGagMCqL/i7Jz0CLe4wliU1jZXC7nBMkYr2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1636041715; bh=jHEzGXPxocEWihpkwx5Dt3agTAo8yEzKpyfcBfU+JHl=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=dZwQJRAvD+5t3QAOJVutdCkb1bpUEMBwoWbCkczb9j4s2J9bLFBdCgjMlRYDTEAMhTA0G3iM9Yj0jukpdtnJm4vz/9p1Zs4J5JMzIq/1z0jA0Rgj4I0B9e6Lk8rv980h0DbDcANnbzljL6qUzxviI1fb5LrQul2Zdu2S5I7NiYDhr/7tlHrqOC9E7He9ACmK0HJQaUOJSmgW7dKCp2XwVPi+Q17uuRSDRU8FHOeC9r0OfS/Aau+EtD5UIIIJwkVWHe0D7dowUYUfRscEewOlzBs9A5WBpQK5lKbcAAwztG7mbVlyHumuurXl4UhKUMoH2OgiZ0aQlVRUfisfbAn6Mg==
X-YMail-OSG: Hym_0zMVM1llO6KpRnFXNxnZdLIVbHLHTYHSojw5k3i_fBinsDJ5LpFV0F6aq4l
 0ERkeZP8kydaDc5y.tFVEzbTM_W7uK3kOtT4PlnJlDen_QnJ5D74VEib7HO2Lz3BZfSS1OQtSjzO
 ea6dF4BCFwXG5je81bdx5S.V_3J5dOLy5_UHgqiPEIWS8ylt.c6KRZ7SfDuk64Rcl35b0fcUbVH8
 LD32r63BW0pRCYqzkM.pWadnoqHT9CT7vhTMDqYTXlLGJuQfOxyCXJcksS_vtIsTczsqlXFaudEm
 _CxjaAfRglTNP_uMVd_i0Qlj.6dfU5FqWKxl2I9ya8ECoR957uoGGs_T0jW4RbvpOU696gw47s2f
 TZEjQJN3tqDmN9aUPE8PRgJtfXo_jqCZm.VAy1s48yMh04XllndGjAXKAxPEuBjpxcHMwSiaqbMl
 a.Htiz9suoXiDTZ3QWCT5hyqBhGoBLgwEuOVV8_n_AN9aigi0rlewrI.wF_fkkoQP4606KFEU8.U
 DXmVQhhxSiqZhBqBJ1eqUYomavKvljDQSrGDS.zB_C3_b2y9a99qLuoJWbiTtS9uTgRJBhhAxXU5
 9Gy7XjnwT3WkISw.w2YCOujdWQu.Q5MxcLJ7rb3Nu87vLR_azqig1naz5US2jpur02ljtxCoMOqo
 vECzNCLyDSuzKiwKbL3pR0uZw_gNAReN_bIKjCRg1pqX0ietDKB4Fdb1QKgGly0XsRguXvM1XZQp
 KoHPbGemx9b5MTmrVb3IQgS_V.z1vGlBvtpwLKQ97Xo7NS8WTLok_EIo.0vY1_5gl2ym6n70T4Js
 fBS4YL633JR00CT7hD96CWS3yHL8h7_qjApAuBEDv.K2P.V7NH3uNC5NL89pAkkbJ65_kAR9RmXK
 .5ClnyXe96FRHXGbSk9XJg2zriP35P1ql2YmEOmgOgio5j4MFWCvm2WV7o2_PKND4Ycv6uO_LWsS
 m.F3.4.IHjiCY13I2ZJoEL3aaikIIMyNj7nmsbBulbBRq5olG2Z5X_QbKMRjx8KfUHBQSPt1kPhY
 35k43WTWUxdkzdVr2NE8l.67SUul1y8cLsUhDPmetyIjEYSSr8VZkv__wm.KbTp3YMsUd.6DdxgO
 .PLiZBjiMV37WtmxRl7y3ib3_XEX8jn76NiUG2MxSqbygfgNw8RduyiXCl1G7xMCGa6vJF8RbThf
 _7OPaTxCDbIUYwrRdqBKV1fWZHdPNhXSk..pkgX33DBCh9k2ErrVtS7IDu5.KL5NK4aQpbQcZlzp
 6MKMiuQMry3UVM7EB_hL79QdG8B8tAeeUxkqgcHXnpQugqQcP6O7x46X74.0f.9.nxBb8oeYRAYj
 HcBOkbu8OFJARf7UMowPlPYrS4UTJcWfOdexLJs5bBkxsFBzuPj2ygTb2SHOA7Z2SZuZwHFa8Fvu
 pMYLiLs2QsSCJXdxEtf91_5jbPgM7yq.uTgspv4iEUMAxxdBJA3HnwFs_Lr7kHcKWavKEs.b1E_q
 c..eBJwvyL7dAnodmmxG3UC2pTlursqP4ns270heM_MSk9smHOGaUOp2RNUkCLga04Aa_dsPBSmi
 FYISDAfl2TzGodhSvzA549FSOD7kA6uln0_jFqpTSnfJoZPSrLgiie5ddqn3yMWC3sl_GVzsiF6L
 FfRK21tgSOV4KgK1YB2fwdp2YJR_NPZijriJv42S5LMuohfMK9c.X_kWNRu93dQ9FCL.wmuubM8G
 qfy5Zx1WoQw60pdyjDeH2uU9aSZGzXw5hVJQI1vW3yLJQHTmY3PvQURtjLHGQztpC10dno_3Qc4I
 At4sQR9413RnPb__NkrfUQiohXco_vYoFrThcPY3WIXIaOJ9eR7jWpXjYOJMEXt74_7Z5O2p8bmm
 LP7mPsYUd1BbB4fLiWNMdAnk4BARRz3M3rKJ7YuLoEQBtLohnD8FFlysqL9wcNuF1WJbH2fj5Xq0
 DeEvWckIvXgMe86nE7qmfzsMTWZiveFeFDibaC3BaVBon.BprgnKbqY6Iuha4ok1TgXwgTeeaZYk
 XEza31qphzAn53LM81l8.LNubm95h424l_M.fxiZdxiHVC9MZ0NU9SQswqeQTN01z6udXOJ38sYL
 u3dZ59bEVBZFOtP8lTfmJqc8C_KMmJapy0U_ZVrEOA2Ix737r3qTr0My9z1EKDJcmfDXY7NIw.6u
 ERx.y36XR9KiG5moOdbVWguw9NEtwWnimjlO5Ha4UftvVEh_NYqlRjCmSmqj_hPD_ntHHbYKapb_
 wsQNSCCuFLP3w12a4._SfJeFitXRS_y_3JTWaE3fAfpH9_gzpoSMP9hkJHGRJuA--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 4 Nov 2021 16:01:55 +0000
Received: by kubenode533.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b08266b863854ae84c65f4db47020d7f;
          Thu, 04 Nov 2021 16:01:55 +0000 (UTC)
Date:   Thu, 04 Nov 2021 12:01:51 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: No HDA sound output with AMD IOMMU on master
To:     Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1636040759.fnw68jgcw1.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1636040759.fnw68jgcw1.none.ref@localhost>
X-Mailer: WebService/1.1.19266 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At some point between 86f925fded03 and 5f4e450cd96b, the built-in sound=20
card on my ASRock B450 Pro4 has stopped working for me. All controls are=20
unchanged (no new or removed controls, all outputs are unmuted), but=20
when I try to play sound, I hear a click from the output powering up but=20
no sound otherwise. While attempting to play sound, the following lines=20
are output to the kernel log:

[   15.081961] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x14ac00000 flags=3D0x0000]
[   15.081982] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x14ac00040 flags=3D0x0000]
[   15.082253] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x14ac00080 flags=3D0x0000]
[   15.082581] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x14ac000c0 flags=3D0x0000]
[   15.082914] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x14ac00100 flags=3D0x0000]
[   15.083247] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x14ac00140 flags=3D0x0000]
[   15.083580] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x14ac00180 flags=3D0x0000]
[   15.083914] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x14ac001c0 flags=3D0x0000]
[   15.084246] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x14ac00200 flags=3D0x0000]
[   15.084579] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x14ac00240 flags=3D0x0000]
[  749.373925] amd_iommu_report_page_fault: 5917 callbacks suppressed
[  749.373933] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x1f2000000 flags=3D0x0000]
[  749.373952] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x1f2000040 flags=3D0x0000]
[  749.374248] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x1f2000080 flags=3D0x0000]
[  749.374574] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x1f20000c0 flags=3D0x0000]
[  749.374907] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x1f2000100 flags=3D0x0000]
[  749.375240] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x1f2000140 flags=3D0x0000]
[  749.375572] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x1f2000180 flags=3D0x0000]
[  749.375904] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x1f20001c0 flags=3D0x0000]
[  749.376238] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x1f2000200 flags=3D0x0000]
[  749.376570] snd_hda_intel 0000:0b:00.3: AMD-Vi: Event logged [IO_PAGE_FA=
ULT domain=3D0x0016 address=3D0x1f2000240 flags=3D0x0000]

Note that I first attempted to play audio around 15 seconds in, then=20
tried again about 730 seconds later.

Adding mem_encrypt=3Doff to the kernel command line does not fix the=20
issue, but adding mem_encrypt=3Doff amd_iommu=3Doff to the kernel command=20
line does fix it. I am not using any other IOMMU-related parameters such=20
as iommu=3Dpt.

I have not yet tested it, but it seems reasonable that this issue is=20
probably related to the recently pulled "ALSA: memalloc" series of=20
changes.

Let me know what further information or testing is required. I can do a=20
full bisection but it is somewhat time-consuming due to the manual=20
nature of the tests.

Thanks,
Alex.
