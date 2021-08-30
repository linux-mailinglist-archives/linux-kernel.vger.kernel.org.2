Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249993FB991
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhH3QAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbhH3QAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:00:22 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4E4C061575;
        Mon, 30 Aug 2021 08:59:28 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Gyw4F4ZJzzQk2q;
        Mon, 30 Aug 2021 17:59:25 +0200 (CEST)
Received: from hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
        by smtp202.mailbox.org (Postfix) with ESMTP id 510FC267;
        Mon, 30 Aug 2021 17:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1630339163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oveQHB7IdXcHl8AM8auAoNrl5xf6elidMDarRIPD7LM=;
        b=mbIBYfAKmq80Tj5gKBTh65NDmq0ftaS60M9LbITsks9ppu/KvV+MjrV8aCxlOphFgwp/eM
        WJblWMseT5Mt26siMj7PZz+FIDRfjnPLSQ6hHrra1gfBXTUuZl+/KqGHrErZwt4S+0Ihld
        ZKtpHkj5LewiiF6qXwYGm91VNTjXg7KQ6n40+9jNYDJ1ZfmV3Tfq4EbSFvYaJAU3Z1j1Xy
        fx+lMI8QSO2wfZDyIcITnymmaNRezx3FWLYdDOW6QHRvTUTGjB1du1zoIDWy13Mz2JeA/9
        KACFsTKhb3e9JFl2REYhmZCUYmnDCUYUf6/Q+WbQTfOssOuOWh/CXGom6TFkxw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp202.mailbox.org ([80.241.60.245])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id fWZT7BTQpqPS; Mon, 30 Aug 2021 17:59:22 +0200 (CEST)
Received: from ms-v3.lan (unknown [211.58.59.88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp202.mailbox.org (Postfix) with ESMTPSA id 4116A26B;
        Mon, 30 Aug 2021 17:59:17 +0200 (CEST)
From:   Sungbo Eo <mans0n@gorani.run>
To:     linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH v4 0/2] Add MUSB for MT7623
Date:   Tue, 31 Aug 2021 00:59:01 +0900
Message-Id: <20210830155903.13907-1-mans0n@gorani.run>
In-Reply-To: <20210822041333.5264-1-mans0n@gorani.run>
References: <20210822041333.5264-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 510FC267
X-Rspamd-UID: 27d2ab
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for the MUSB controller on Mediatek MT7623.
Tested on Mercury RUSH-318AC Wi-Fi router.

v4:
* DTS
  * add tested by Frank
* musb
  * add userspace control flag patch

v3:
* dt-bindings
  * remove the queued patch
* DTS
  * remove unnecessary status=okay from u2port2

v2:
* dt-bindings
  * add reviewed by Matthias
* DTS
  * rename usb3 label to usb0
  * move usb0 & u2phy1 nodes to the right sorted place
  * disable u2phy1 by default
  * correct u2port2 node name to match its reg address

Sungbo Eo (2):
  arm: dts: mt7623: add musb device nodes
  usb: musb: mediatek: Expose role-switch control to userspace

 arch/arm/boot/dts/mt7623.dtsi  | 33 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623a.dtsi |  4 ++++
 drivers/usb/musb/mediatek.c    |  1 +
 3 files changed, 38 insertions(+)

-- 
2.33.0

