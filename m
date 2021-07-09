Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984083C2A23
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 22:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhGIUMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 16:12:16 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:49932 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGIUMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 16:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1625861371; x=1628453371;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=706lys6GUEG45zc6PfPskz8EDclR9t0xa/f81PJP9OU=;
        b=i5CVIOKpr5qpqKVfjhWJDDm5KAOSbErc1f08JauGgldp+A01WVn9IFqn2HpzgAsG
        fBORsS99lnTpdIjPh8n71vQJP7cOMwP83ychiSAr7VgnoKxQWwpHtQWfBHKATDXk
        011874WG+QYrx4zBjuSHlHAWZu7epEg3kSVISy39EIE=;
X-AuditID: c39127d2-1d8f870000001daf-bf-60e8acfb84e2
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9F.04.07599.BFCA8E06; Fri,  9 Jul 2021 22:09:31 +0200 (CEST)
Received: from lws-ybas.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021070922093103-1123547 ;
          Fri, 9 Jul 2021 22:09:31 +0200 
From:   Yunus Bas <y.bas@phytec.de>
To:     sam@ravnborg.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH v2 1/2] dt-bindings: display: simple: Add EDT ETMV570G2DHU
Date:   Fri, 9 Jul 2021 22:09:12 +0200
Message-Id: <20210709200913.2666570-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2021 22:09:31,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2021 22:09:31
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWyRoCBS/f3mhcJBh/+CFn0njvJZPF/20Rm
        i/lHzrFaXN41h82ide8RdosVP7cyWvzcNY/Fgd1j77cFLB47Z91l99i0qpPNY/u3B6weS6Zd
        ZfP4vEkugC2KyyYlNSezLLVI3y6BK+P/vB9MBZ84KqZ2vWZpYJzA3sXIySEhYCKx9/UCti5G
        Lg4hgW2MEqsXrGSBcM4zSszv2ARWxSagKHH+9ltWEFtEIEnixJRlbCA2s4C9xKWlf5hBbGEB
        L4lVTcfBbBYBFYn1l9Yzgdi8AmYSU1f/Y4LYJi9xcu1hqLigxMmZT8CWSQhcYZRYv3UFVJGQ
        xOnFZ5khFmhLLFv4mnkCI98sJD2zkKQWMDKtYhTKzUzOTi3KzNYryKgsSU3WS0ndxAgM0sMT
        1S/tYOyb43GIkYmD8RCjBAezkgiv0YxnCUK8KYmVValF+fFFpTmpxYcYpTlYlMR5N/CWhAkJ
        pCeWpGanphakFsFkmTg4pRoYy3dKTv7Fk+GmerZjuZ9QmMv841k8Fy6t+h2yRKSI69i9mMV7
        D7Hd5rnDsWL50iTnDzktAn+Y+JKLVzIlys2yleLdnBfnWz9Z91LgmpBPSrOq5VYtvra80Ll1
        Sj2H78SFOwz+r5yryJ6dVbdXeruxh5XaD1a75PB/B0zPMa0Xic9WO8qmOWuGEktxRqKhFnNR
        cSIAWolbk0ACAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Emerging Display Technology ETMV570G2DHU is a 5.7" VGA TFT panel.
Add it to the list of compatibles.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
Changes in v2:
- No changes, resent on demand
---
 .../devicetree/bindings/display/panel/panel-simple.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.y=
aml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index b3797ba2698b..7ee3a874249c 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -128,6 +128,9 @@ properties:
         # Emerging Display Technology Corp. WVGA TFT Display with capaciti=
ve touch
       - edt,etm0700g0dh6
       - edt,etm0700g0edh6
+        # Emerging Display Technology Corp. 5.7" VGA TFT LCD panel with
+        # capacitive touch
+      - edt,etmv570g2dhu
         # Evervision Electronics Co. Ltd. VGG804821 5.0" WVGA TFT LCD Panel
       - evervision,vgg804821
         # Foxlink Group 5" WVGA TFT LCD panel
--=20
2.30.0

