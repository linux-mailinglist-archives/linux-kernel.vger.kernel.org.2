Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17DF3E3A3B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhHHMj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 08:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhHHMj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 08:39:57 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C34C061760;
        Sun,  8 Aug 2021 05:39:38 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4GjJgq43NfzQk22;
        Sun,  8 Aug 2021 14:39:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1628426373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BNkho6kEYucAS56T6bDbZFEUffzkZUASAaEQ6TytiPI=;
        b=D9GRjbSNhqCNkMwYnMjsSl+PYAv9LKmRhGCUk/3/8ZhrS+bRg3Il4ESA3IcXnPxbCf5Q8X
        ru782uxEBeXWbPP2cAkjS6h4jWkIYuQ73/daemWpWOkeqCKW0XbgwaYZM79cRx32HNp42a
        2zXISb81Ffrwj8qdsoQcen1c6bq4ld9exBOVYDxZVMCj0spfn8dnQbHaE2zKZ88Y21nav+
        KT1PtD2cMhv6AseQYWO9jnwqh3u5XTklT8ZfyPrn8B1E0aMf5QHYqFdV+6yBy4+iIXYD6v
        dzBOKo0NXYc/wTgQbhe/xqM4MbPcS37tsFEtiaMXvyqadxF/1PULYyW647DQPQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id IvuHFhvsFGqQ; Sun,  8 Aug 2021 14:39:31 +0200 (CEST)
From:   Sungbo Eo <mans0n@gorani.run>
To:     linux-mediatek@lists.infradead.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH v2 0/2] Add MUSB for MT7623
Date:   Sun,  8 Aug 2021 21:38:38 +0900
Message-Id: <20210808123840.176738-1-mans0n@gorani.run>
In-Reply-To: <20210803151320.71531-1-mans0n@gorani.run>
References: <20210803151320.71531-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9AAA31898
X-Rspamd-UID: d9b34f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for the MUSB controller on Mediatek MT7623.
Tested on Mercury RUSH-318AC Wi-Fi router.

v2:
* dt-bindings
  * add reviewed by Matthias
* DTS
  * rename usb3 label to usb0
  * move usb0 & u2phy1 nodes to the right sorted place
  * disable u2phy1 by default
  * correct u2port2 node name to match its reg address

Sungbo Eo (2):
  dt-bindings: usb: mtk-musb: add MT7623 compatible
  arm: dts: mt7623: add musb device nodes

 .../bindings/usb/mediatek,musb.yaml           |  1 +
 arch/arm/boot/dts/mt7623.dtsi                 | 34 +++++++++++++++++++
 arch/arm/boot/dts/mt7623a.dtsi                |  4 +++
 3 files changed, 39 insertions(+)

-- 
2.32.0

