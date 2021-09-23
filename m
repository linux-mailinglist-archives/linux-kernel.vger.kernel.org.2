Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18D416508
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242978AbhIWSPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:15:37 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53187 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242890AbhIWSPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:15:10 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id F3D37580C18;
        Thu, 23 Sep 2021 14:13:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 Sep 2021 14:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=T/djh9uTPfyNI
        9aNLpOkvqZ/OxJWQe31irHlWe3Pr60=; b=F2Trk8/eE5xiVUveJdVHO10QdvJYo
        +YYeP/pUXdieOgI2AfVG0UYqyzEqfn2qs/pSa+YtvJetnU9RFmeaKuXWSvctMT6l
        pL8K311/p0uggL7zsnFIdu+aZBP7yF99JnHoMMX61t3ufLdnIBq+kw62M+CiMdLZ
        bUoZaLmdXideq5Jf2PifXEygwUmcVFdYZvP3tRx6IaanuxbgOm4EqN27pD7DOAHe
        r2fdB7ZwOOCqXrXDZew1MmMzjeXln2u2FydnPZMgBHalZ+3Ri5O4psPATf5NG8AH
        8NbGDTMwZZ5YpjOscHR9tWKPS7/mozy6HrdaZ2UG+doXY2FyGEylqMeJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=T/djh9uTPfyNI9aNLpOkvqZ/OxJWQe31irHlWe3Pr60=; b=R7c70pdR
        ZyXEwjgibEniFUqyp76FksD4i2qPyvvbGuF8P3syxogvjkqaQupbzz6YR0eyt0Av
        c5hDUC9BVQ1hCXxuXJed8ReVJ3e12jlRCNxFvbkOFqr2jxHe1v7TpdFZzAEFaB2X
        tOY+N+54kAfn+bcwVIlgV6Q7sCMQ0ROPD1NgPBBLYIMb6iJaAECMOa3E6suQzUIX
        KGtnv5f+FSg5RyrXJAyg8TYVK7QiF08EayvCO6wdnEgZwjF56fvP5IowgUGOK5kA
        PFm6yZZyPQQlPAljCt9+MGvOAncxkDmUe9+ze4T30GdcRuF5QK/Vd1XhNRx+Z/5z
        xT1bcOwIZUjDOw==
X-ME-Sender: <xms:0cNMYROn5h5G3tbMpM51ZCwa2SSLNapqPrRcb0Suz_6zS9O5kkCIBw>
    <xme:0cNMYT9RyikWIriyEGkdnI9K2ViricLiE483mQCspAamP11mB3MtkmiBpdSQ15sol
    9tV0kNLGemViHP4YXY>
X-ME-Received: <xmr:0cNMYQSKlw9Otc0OUgWNVdyWGQ0tlynnbeUThvNDGFMKXDwnEgHjihj27tGhf51o6fNsCmrhQtyQsWLqQVVuQgRolOkTSZfKh5GJgHH5mhteLhY43-2RfDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeiledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
    jeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:0cNMYdvHGMLaDnV5Cf2ko4V5gMJDrarYMLh3I37D042wlOe2nw9BXA>
    <xmx:0cNMYZeeQ0z36OElaiKihRLqcdRNSBRd8cUbJGuZPWfK3DXWHE-3Yw>
    <xmx:0cNMYZ3MYN_PgIehXM4i_AvYr6E-bTFCVlbUlxKjix7UkYxXZvyQcw>
    <xmx:0cNMYZ1A50447rwp9kx0ONNSq9ZCv5QZCjfWMP9x9d_J40n-DcKhxg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Sep 2021 14:13:36 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH v2 3/6] usb: typec: tipd: Add short-circuit for no irqs
Date:   Thu, 23 Sep 2021 20:13:18 +0200
Message-Id: <20210923181321.3044-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210923181321.3044-1-sven@svenpeter.dev>
References: <20210923181321.3044-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no interrupts are set in IntEventX directly skip to the end of the
interrupt handler and return IRQ_NONE instead of IRQ_HANDLED.
This possibly allows to detect spurious interrupts if the i2c bus is fast
enough.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
changes since v1:
  - added Heikki's r-b
  - s/event/(event1 | event2)/

 drivers/usb/typec/tipd/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 162d405baa92..cd1e37eb8a0c 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -476,6 +476,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	}
 	trace_tps6598x_irq(event1, event2);
 
+	if (!(event1 | event2))
+		goto err_unlock;
+
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
@@ -498,7 +501,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	return IRQ_HANDLED;
+	if (event1 | event2)
+		return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int tps6598x_check_mode(struct tps6598x *tps)
-- 
2.25.1

