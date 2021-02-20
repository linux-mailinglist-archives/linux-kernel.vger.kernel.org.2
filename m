Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE779320430
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 07:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBTGah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 01:30:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:56515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhBTGaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 01:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613802527;
        bh=i+orHWYknbmkAFlKb49VSrdzDr4jIPTYmyhYyjeiasA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JWXvoeFg1Z/OEKTPiAs/LZWsxb0tv+YytkPPP8sb3htienb3N9AedIpt2aMdgKwgp
         C5aH0hovRMZbaODh+ARM7zfKdtYh2bRAP+iTMXyw/78B+sR5c4pFDcHbt94Twdp0LA
         u+JGyUpyjkedkZdubTsx9VZCgGUU3JF7IHUrr5U4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([62.143.246.89]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK4f-1m4M3D3pOz-00rFLl; Sat, 20
 Feb 2021 07:28:47 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [BUG] checkpatch: false positive unwrapped commit description
Date:   Sat, 20 Feb 2021 07:28:40 +0100
Message-Id: <20210220062840.15846-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x/2CRERKOEG/v09yuj3advTG3Mja2X7GDC4i3mqoyafr0mbbItR
 yaCBd4wql/mwtclvIYCWHV0cckwR+5Y+9evN9ZWTK6lLQrQfNLgs6jRlQwOeWftJbwDa24+
 v6xVFR+CTBo3p8ezP+QghR1zf2KnVRl/l7VP3hgT4+0xvcGKA/XCxD2tSOAUlroMw4/ARRf
 kkqRmdyMQrEVgKoTsfVaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tY/mBnRfQvM=:RfZK25b4eLj4XJyDNvjyJF
 rTTLbYepvEYzeqwsXqINjkGthX47IUqpNRHdDgFgV3fM6V1MI2eqeqSRlpDvB0dGV9No1eCaq
 +L+MpXQ/NPnN4QEPTN66p58jiuSDP8Fjxadj2+xEhoFIk5nGeJSZl0X/8H5tzHpj8npV8z+aP
 nkWAWW0HZ+7PrUWFPXQWQIfy729lePTjSofa4rJ6iIRGGrvS11oaM3MPpm916mt3t/H05HXWy
 oTH/FTZdvC+IrKFIWYyiya0Cw752f3MWdRP98hERwchouM7cI2az2Y1QN6qMcsXRkHYmFYcEf
 4DHbtuuplY7cPZVhvvOpKXmWdYQifvXd4Ji4DdjHZRyljjlR5Z8pfWkslLoSu1O+3/PPN27q2
 L+qjAFdTVtRStBoppPv2HYQYMZOeLbjSoQRJuAiN4ccxhiwKNkwarCTRAjGbsPeCFd36tT+zk
 msyHieYIsvZjLZq7VhOAQ05M5q8YWLjPu7QxMKtalOeCjrwesQoXm3LINl4OnOdJCqcU6rWjJ
 JMcgA45wqT6h0DE0R6sBIFZQY1jPvz2Xl7irMJ8+gt/9hpBoeS5g7u3NdqvaW4VoVJC4mof3r
 OCDTNq+e4yhzwIWTwlkKalDdHRC++AKLeuJnIrUoFBDRVhZ0cxWwjNjfFFR+LFCZznMqYDd/U
 eF+Xkfih7NDBPKM4/Lfdnc5feIPXFs6CvitFldvzPg6d+cXYcrwQH2GFWXOZeg4MqLeGtc9NX
 MRDujE/QAGjcPZhUIPvr+DWsQRl17jPwAGB6EIJRRXqHPNFyohJHQMVdPVpBuEHStNmKYfa2R
 aNw5AJCh7Fjx/a8NJPVNRpUjYAg49pxIwfViaNZ85B4mWB2TvpIW0ytmk62pNs3ZthdGXS2U1
 FTfOu7DVrap3GVgtb/qQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next line leads to a false positive
Possible unwrapped commit description
(prefer a maximum 75 chars per line)

element type is =E2=80=98struct reg_info=E2=80=98, not =E2=80=98u32=E2=80=
=98 {aka =E2=80=98unsigned int=E2=80=98}

+++++++++|+++++++++|+++++++++|+++++++++|+++++++++|+++++++++|+++++++++|
        10        20        30        40        50        60        70

Unicode code point 0x2018 (=E2=80=98) is counted as three characters
instead of one.

This code point is used in the GCC 11 warning sizeof-array-div.
Citing the warning verbatim lead to the observation.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 foo.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo.txt

diff --git a/foo.txt b/foo.txt
new file mode 100644
index 000000000000..e69de29bb2d1
=2D-
2.30.0

