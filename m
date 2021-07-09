Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABFD3C2A26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhGIUMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 16:12:18 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:49932 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhGIUMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 16:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1625861371; x=1628453371;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GYoGy2G1a0uYVX5zuuv6GmMJBYgqtDpCCJ5Q2QV+qW0=;
        b=U+cG/p3v0Be1UJ9UFmkal59mw/NlhqaFmcOO7i233OiAmlIK2EsvHWJ5OtMbq8Xq
        VyjvZKvB4x6kXd+ntkLUM4ilPDfhRfiLb53aBpFWlY/t+heQ92XvpD5OYdv88Wg3
        dvB4LGhnmM9se0nK3NAZ6iP95fUuNsy7KyAJHF85pOA=;
X-AuditID: c39127d2-1e4f970000001daf-c0-60e8acfbacf0
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 10.14.07599.BFCA8E06; Fri,  9 Jul 2021 22:09:31 +0200 (CEST)
Received: from lws-ybas.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021070922093127-1123548 ;
          Fri, 9 Jul 2021 22:09:31 +0200 
From:   Yunus Bas <y.bas@phytec.de>
To:     sam@ravnborg.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH v2 2/2] dt-bindings: display: simple: Add EDT ETM0350G0DH6
Date:   Fri, 9 Jul 2021 22:09:13 +0200
Message-Id: <20210709200913.2666570-2-y.bas@phytec.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210709200913.2666570-1-y.bas@phytec.de>
References: <20210709200913.2666570-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2021 22:09:31,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2021 22:09:31
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWyRoCBS/f3mhcJBjMfqFj0njvJZPF/20Rm
        i/lHzrFaXN41h82ide8RdosVP7cyWvzcNY/Fgd1j77cFLB47Z91l99i0qpPNY/u3B6weS6Zd
        ZfP4vEkugC2KyyYlNSezLLVI3y6BK+NQ40zWgtmcFddWr2NuYNzO3sXIySEhYCIxb/pVti5G
        Lg4hgW2MEqem7WGEcM4zSlzrvsYIUsUmoChx/vZbVhBbRCBJ4sSUZWwgNrOAvcSlpX+YQWxh
        AS+JJx82g01lEVCROLiwCSzOK2Am0bCwjw1im7zEybWHmUBsTgFziQWHL4PFhYBqep9+YYGo
        F5Q4OfMJC8gREgJXGCXWb13BBNEsJHF68VlmiMXaEssWvmaewCgwC0nPLCSpBYxMqxiFcjOT
        s1OLMrP1CjIqS1KT9VJSNzECg/rwRPVLOxj75ngcYmTiYDzEKMHBrCTCazTjWYIQb0piZVVq
        UX58UWlOavEhRmkOFiVx3g28JWFCAumJJanZqakFqUUwWSYOTqkGRlm/GSH8sYeSjsmyT1OX
        PvFpY1XNJ9WG34EHWnYkPGGyuVvgvySmd+6mtdoP4yfWfxD8fLl/5l8vUZkrop3LwzlDzI8y
        P4++EtZr09m8Mit8cVIBT3en3WRJlmWfPBpr7LTetjOEtJ5aG3nq6FZHnulJVuZt89e0yIrX
        Pl/oOMuzb81hAeUmJZbijERDLeai4kQAXqRGiVgCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Emerging Display Technology ETM0350G0DH6 is a 3.5" WVGA TFT panel
with capacitive multitouch. Add it to the list of compatibles.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
Changes in v2:
- No changes, resent on demand
---
 .../devicetree/bindings/display/panel/panel-simple.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.y=
aml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 7ee3a874249c..88ce049a0100 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -110,6 +110,9 @@ properties:
         # Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
       - edt,et057090dhu
       - edt,et070080dh6
+        # Emerging Display Technology Corp. 3.5" WVGA TFT LCD panel with
+        # capacitive multitouch
+      - edt,etm0350g0dh6
         # Emerging Display Technology Corp. 480x272 TFT Display with capac=
itive touch
       - edt,etm043080dh6gp
         # Emerging Display Technology Corp. 480x272 TFT Display
--=20
2.30.0

