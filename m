Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5C3905BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhEYPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:43:04 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43329 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234294AbhEYPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:43:02 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 61D7F1311;
        Tue, 25 May 2021 11:41:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 25 May 2021 11:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tju.me; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=3dOqmWnre8Qli2mInIo3ZkkdNa
        BOEO5L4G3nLgoVQDM=; b=nPpQn95Jvv5OpxSFlX52gjl8gbM7z4GDxvxUQkRu7u
        BApLthnY+6468+HYVbcJfIIrrKgWWjrrHPQuWg6Nm8pP1wb7Wx9zsTcGhymsaCj4
        Dxg9UxSvpsNKL7LrygrTMZKRF38GtYCZOfwHI5/3oJNgGpPcIRCwjv0zs7x4dli7
        CwTZjBi8GOfqiieR45Lxz783PqVSJIQyOSLOq4kK9xDvSpyfHH29iiIhCMHUl4R2
        YalUK3hz1VcZ7f0XTAUUH/iZyzddxZ6YuSEaDx24NSNcrCZDkmT4AreZWRcauvpu
        buU7YWZ9tlHsqGg2FJVBb2BOpFhXBfa1wyNpEoiDZQaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3dOqmWnre8Qli2mIn
        Io3ZkkdNaBOEO5L4G3nLgoVQDM=; b=TS7AF0FFCubRJ8JFc7t9ge5fmzE6RRbWJ
        mv3+MFPaez7u3IeYTfLEAqgE/9I3yUZ8HEk+myW1AngqgMFAX930CK7vArrSW+R9
        nCeXSy61Y4bIP6R7YF1Pn/RGWfkTeRC7hDUBtTlT/e0mzzKMTyTEh916Qg2F2EXV
        n2wsis64I3BfDAduj+nO2N2JYJdW8+1/RqiyJRVhUWCEqBh6+qgfPUHdriZ6ShuO
        wgREp+5ai5TQ7jc7+iSuFUQhlhOduQ2P9A0uDQT+cXYHosvtYgKdbwGGVewBl1ww
        s4hBReEv4uzW3CHHMKuxDwYVgSxY41Ug6/EMMMhuNcHjNgFbWzE2Q==
X-ME-Sender: <xms:qRqtYCWt2xrqEw8ayfIIN7HOKpxYx2wruTOTk9ilK8PkAZnhfXOTNg>
    <xme:qRqtYOkSKsmCT_5oH9d7sFAA1nUF8dSo90BXndfHg2aw5oocv1GO9h6FmSv3aNa8C
    en4tQs7WQnZGg0eBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvihhlucflrghs
    phgvrhcufghllhhrihgthhcuoehtjhhusehtjhhurdhmvgeqnecuggftrfgrthhtvghrnh
    epjedugefhkeeuueekueejueefgeevjeeuvdefudfggeeuieehueelteejvdehtdfhnecu
    kfhppeelgedrudefgedrledtrddvtdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepthhjuhesthhjuhdrmhgv
X-ME-Proxy: <xmx:qRqtYGa7E-jZ01Tn8OnLccHCCTB9s-524Vrxi9b4vJO_LOSr6vJdDg>
    <xmx:qRqtYJXarwVlrRMZV0IcT8Iw44w8j-HKH9i9x7QWu_TwuEcSCP6CfQ>
    <xmx:qRqtYMmz4V3mk_iNdHQgZ_LaLgQcLuIAWfo7dCvryZRwC-ciyeJ3tA>
    <xmx:qhqtYNAtXJq9Up5MzyBnE6QJ9hsLQywEyyhOLZ8SQ64x_8BapsL_ug>
Received: from alpha.fritz.box (unknown [94.134.90.204])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 25 May 2021 11:41:27 -0400 (EDT)
From:   Til Jasper Ullrich <tju@tju.me>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: thinkpad_acpi: add X1 Carbon Gen 9 second fan support
Date:   Tue, 25 May 2021 17:09:52 +0200
Message-Id: <20210525150950.14805-1-tju@tju.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X1 Carbon Gen 9 uses two fans instead of one like the previous
generation. This adds support for the second fan. It has been tested
on my X1 Carbon Gen 9 (20XXS00100) and works fine.

Signed-off-by: Til Jasper Ullrich <tju@tju.me>
---
 drivers/platform/x86/thinkpad_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index dd60c9397d35..edd71e744d27 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8853,6 +8853,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (2nd gen) */
 	TPACPI_Q_LNV3('N', '2', 'V', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (3nd gen) */
 	TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),	/* P15 (1st gen) / P15v (1st gen) */
+	TPACPI_Q_LNV3('N', '3', '2', TPACPI_FAN_2CTL),	/* X1 Carbon (9th gen) */
 };

 static int __init fan_init(struct ibm_init_struct *iibm)
--
2.31.1

