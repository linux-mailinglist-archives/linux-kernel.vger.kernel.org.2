Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8025B3DF150
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhHCPX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbhHCPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:23:54 -0400
X-Greylist: delayed 555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Aug 2021 08:23:43 PDT
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C71C06175F;
        Tue,  3 Aug 2021 08:23:43 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4GfJLp1tKwzQkBN;
        Tue,  3 Aug 2021 17:14:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1628003664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EcJWRJoQvwrbMls4jqlRToUwyMp6kVwy1tVus5ShU+U=;
        b=W974kskAaTUrwqg8DTvvQAjY1eiUE32JIJ3zXIQFbqpxHK0iTTlSoV0Qody/krv2y0DssW
        lHK/IX0DPg62HpKTULp1bN2VO3c1YNqwg56Cfqr/Fntghi0/mX35Co+d1VkvNt9OUUxf20
        r0ze7rL7j7XxKdKT0D0uaVCcxX/mHyt8Kkr+yz9HKJxqYNaUEiaQFo8kPp4On2Omm2arp+
        ufYKs/lBFyPgo7/GSZ7VlC03SGso4+wCNefvYH5NOzOW64Soe5lVnvgCHdNL15yT25ICOX
        Wl9cBspLwRmOv7XWVkWj1psAmPXg6z+RS6V7jWpeVHAUHqDasMWdnbLjL8Z8ig==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id k8tO6CO0vNjD; Tue,  3 Aug 2021 17:14:23 +0200 (CEST)
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
Subject: [PATCH 1/2] dt-bindings: usb: mtk-musb: add MT7623 compatible
Date:   Wed,  4 Aug 2021 00:13:19 +0900
Message-Id: <20210803151320.71531-2-mans0n@gorani.run>
In-Reply-To: <20210803151320.71531-1-mans0n@gorani.run>
References: <20210803151320.71531-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1256C1899
X-Rspamd-UID: 880e3d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document MT7623 compatible for mtk-musb.

Signed-off-by: Sungbo Eo <mans0n@gorani.run>
---
 Documentation/devicetree/bindings/usb/mediatek,musb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.yaml b/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
index 84ddacfdbe9b..03d62d60ce5f 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - mediatek,mt8516-musb
           - mediatek,mt2701-musb
+          - mediatek,mt7623-musb
       - const: mediatek,mtk-musb
 
   reg:
-- 
2.32.0

