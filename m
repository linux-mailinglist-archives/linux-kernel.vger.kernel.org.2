Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885D4311C40
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 09:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBFInH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 03:43:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:46445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBFInE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 03:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612600885;
        bh=jKjTxUhx0ZNYdb/aeP0CN8+I4HtK+hmzEwsPv81gWyQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ObzIE3K1u68uklIZPh/tDCUooGV6jFe85bM67qgjMsT7caOe+fSRP4RkDS5to7+VO
         Ignpd2vHw3cdsX6dYOKR8+4fDDg2o8qsqdWto3SuYX06RuS9/rCUU7Y6bOwvW2NLOy
         8qd3HPpeDLNs0unB3Nr+8t7zVfUixV1uA4R7ej5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([62.143.246.89]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hVB-1l4AQ0320X-004jyh; Sat, 06
 Feb 2021 09:41:25 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] docs: arm: /chosen node parameters
Date:   Sat,  6 Feb 2021 09:41:20 +0100
Message-Id: <20210206084120.43305-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZF+CMxuQR6Z5hw6+G8WobfOwH0qpnXY5qwfc8e3AYz1GMiItJ2w
 euzvJ04R/WPrHxfxOkeHdddqmkTAh+X5AxHvuvkMWfxv+Mt8AUgutASTIBr9eUBPSpGoaez
 36FWxp2O3m/UHe9Wg3WpdDFU6uukJR1VDmAsK8XfVHezzAWQI7GWDCQPEPhMAY5gYnGd6ea
 4uDM70yN/fNZjZmwsguHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Coo//GXXLlI=:T5yue8KHto5xWxSQ/PctAp
 /qnkx8OUuI4LFNYeLf35zo9i0ko3U8H2Rcmz1+LeiBT8nteVguZB/N9OadU57LgC+izRZUUU5
 BGcXzeohep+QYEelrM7onXQIwojgLwRfTYRZb/LydPhrw5/tsXosjxvdMb5tQW5FB13KzlUfb
 0sY1eO54/jcY0qN3gKW/rM12WgW0MvCXVHq2TunhMiSANQmmFCXg+WK/1VpzjELUPq2kNs2O2
 KmQ/OlYY/Z277xN4afxJbhjaPsdNWmaMdzJK0nkSicYei1Vy+P8KAzq4ftOeDMqLkldGArFbg
 WuN8ow+4x6xSAsfem52E1gVwn35qnE6GSvxasNp5DpZv6AREpVSqpiUlhl8minxTt8TaqzJAs
 uFILHgqNhRZ1+CjKHYh+1puu+WgrOQZLDgY2wWpyyLWUpm8kgovRFR/muaJvXDr3EUliUwXq/
 BKV7IKhVC0KrkhS1G95UNTQuOcvPZvENk03aDYLnpTROUAKn/JpaUBXO4Y4Wnyfl5GIimbO3x
 LX3yt4Qde4ygg0cwQeVbdbnnTJG5yX6n/1ZDVAGwPs7I6AQ8wXeak5il0JWxIs1y2i/OxiaOX
 9wndN794586mMtKYWUvN/glvAW+JJqAgDqyEtXjwHS74FdROxUKwTAoGZnEjV3lEoBRo/fRGT
 P4ym5ixGMFShjxUO3ixY/Racqn5f27gQpsatqTHfDjpPIk6ZMWXpmuUlUnpzJm5qb1zJWYThx
 zg7zDnFqayPEQDYk82C7d4G3fXEN2KVmjjR5ch7LX0BFZizPTDfzmjjq2+nJ4m0vRaNKc5ZUO
 64I4E4zf2DxlhAT+v+K0D2GOJopmEqE916DIExItKgSmMsE4I8l7UfKk2fkPVR4QyNoO2ZmJZ
 Y3hSGM4Ysjv+C7j6bWXg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing items to table of parameters set in the /chosen node by the EF=
I
stub.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 Documentation/arm/uefi.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/arm/uefi.rst b/Documentation/arm/uefi.rst
index f732f957421f..9b0b5e458a1e 100644
=2D-- a/Documentation/arm/uefi.rst
+++ b/Documentation/arm/uefi.rst
@@ -64,4 +64,11 @@ linux,uefi-mmap-desc-size   32-bit   Size in bytes of e=
ach entry in the UEFI
                                      memory map.

 linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor forma=
t.
+
+linux,initrd-start          64-bit   Physical start address of an initrd
+
+linux,initrd-end            64-bit   Physical end address of an initrd
+
+kaslr-seed                  64-bit   Entropy used to randomize the kernel=
 image
+                                     base address location.
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
=2D-
2.30.0

