Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04DF351E64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbhDASko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239634AbhDASQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 600EA611BF;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=W9qTW8sb3Bpmt5sO2o4/hJoRLEr7kwrt5MiJiGbMGTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulY2uGEfmc8/ma2UGM1nVSltK/8kPn/wbS7eQvq9UC6d8vtdKRAWDhjDchVCc9vvP
         lnkzg1erEIBxaPC+hU/jnXqZBNhNtdJ7WdeaAfw+6I+0RPW5KJ+42AZVnKF7Iyj8mu
         W+gnlHwKqAUBuooAkgk2OlTbMcAt78HzQDcqUrjM2fMzcoBBZ6ftsJ7xlDwZx9NzCn
         eVgC9JNnP47AKnx1nsK3Rfdc7EDV22qjxZS3Yj/d7YxoREnqIPH7zoD3udgqAeq4rP
         aMcNbGUSyBr0l3ayIBam/+0CRSw5R5v8l5nWPrQlwXYIFYyoya5sxnegWbp48Nxk84
         046625NLcPQfg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c3Q-D4; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/32] MAINTAINERS: update imi,rdacm2x-gmsl.yaml reference
Date:   Thu,  1 Apr 2021 14:17:44 +0200
Message-Id: <b03a41b5051b6cb115b2aa9c3d610e75d84dcfea.1617279356.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file name: Documentation/devicetree/bindings/media/i2c/rdacm2x-gmsl.yaml
should be, instead: Documentation/devicetree/bindings/media/i2c/imi,rdacm2x-gmsl.yaml.

Update its cross-reference accordingly.

Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")
Fixes: e9f817689789 ("media: dt-bindings: media: i2c: Add bindings for IMI RDACM2x")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1644b6e9697c..b405ee71f730 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15258,7 +15258,7 @@ M:	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
 M:	Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/i2c/rdacm2x-gmsl.yaml
+F:	Documentation/devicetree/bindings/media/i2c/imi,rdacm2x-gmsl.yaml
 F:	drivers/media/i2c/max9271.c
 F:	drivers/media/i2c/max9271.h
 F:	drivers/media/i2c/rdacm21.c
-- 
2.30.2

