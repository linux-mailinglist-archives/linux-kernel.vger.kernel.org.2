Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0B44CEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhKKBPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:15:40 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:56691 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232202AbhKKBPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:15:38 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id D35702B016A9;
        Wed, 10 Nov 2021 20:12:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Nov 2021 20:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=lttO4PhdhNIQwAlpI6RWIhcyJA0IcmTqe22T0/FCtuU=; b=WS+hsxkr
        q/I3fSlY60H8zslNqW/+bzDt7VKjW/36LZlor/yFpQk7bnSnADFOKA00SsmllluN
        IlHryDZC60DdAICuX6UmZOfB8+KdmswYujevM0Vnog0wyisqFdqR0DFfjvdBxKqF
        y+gHsXDXwTJ935FxUH6VvIcdsv+bnIpRdjibw3JQRLZSVfd4NhWQf1L6QSmUiJw+
        TcvosOBz43D1L4Fux/UPRHAiYZlxYaBk9MYhVaLa2n3w8PHb0iupRuemWCA8aSYy
        yvutGGY9kcqYmV7fzNuuswPNyh8dCVV33IL7F84KSCbncGHrqLQWe0XbDjQc+xMp
        p6XhJ7826rfCHg==
X-ME-Sender: <xms:EW6MYXB9Eu7VlJVPyfBrKOifb3aUsSRLv9xYVOUJeG_UJxXR3E_9bw>
    <xme:EW6MYdgkyAW9JqD6lfvnz4e2vPA5QZseIUkVkUjDr45zsH0zuYHTDLS3qBpr6Iwkf
    5HeD-jp2fs_9uTT8yI>
X-ME-Received: <xmr:EW6MYSkY0oXDPJj9mh2CpL3bmP1xceD1r2XavpyHJEmhSH06VbxEFH-E2I0QB_K9kqhFaH0yiNDEiTHenINvflIFkTEeKQCar8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fhohhrsghiugguvghnjfgurhculdehtddtmdenucfjughrpefvkffhufffsedttdertddt
    tdenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmie
    ekkhdrohhrgheqnecuhfhorhgsihguuggvnhfjughrpefvkffhufffsedttdertddttddp
    vffkhffuffestddtredttddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:EW6MYZyL2NRYXGOwgbRt7RDyJb5VbEGKs9Ey14R78J_knIKE91tnEg>
    <xmx:EW6MYcRdtWWQUs7pD9w9ctYJrtJq4RF0R7tLbUEzrTE7vcvN2N1sOw>
    <xmx:EW6MYcagDSoxBvtZyO_mvkEdBv-mS0UodpaKlm1blvHJmvBR_qH-mA>
    <xmx:EW6MYXLughvzejek9L5fwE0m9EMVbtI8AVzhs32GXN04DeT8tTUCvkMS4h8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 20:12:47 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Joshua Thompson" <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <e07d814e65cd38c00bf7b6cb806e81a4d32286ef.1636593047.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] MAINTAINERS: Add macfb driver to Macintosh section
Date:   Thu, 11 Nov 2021 12:10:47 +1100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the MAINTAINERS file, the Framebuffer Layer (and
drivers/video/) is an orphan. However, macfb is still maintained
so update the file to reflect that.

Cc: Joshua Thompson <funaho@jurai.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd441dde..c9f2d49a7dd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11069,6 +11069,7 @@ W:	http://www.mac.linux-m68k.org/
 F:	arch/m68k/mac/
 F:	drivers/macintosh/adb-iop.c
 F:	drivers/macintosh/via-macii.c
+F:	drivers/video/fbdev/macfb.c
 
 M68K ON HP9000/300
 M:	Philip Blundell <philb@gnu.org>
-- 
2.26.3

