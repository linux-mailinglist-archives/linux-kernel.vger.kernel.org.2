Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D664408D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbhIMN02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:26:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34142
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240356AbhIMNX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:23:28 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7BE9B40270
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539248;
        bh=hZ5N4zB6ne7AqKTWsazgl2eww5+7SrfSBiF0jiwRIRU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=V1WQ8oEoicl90mvQNd5qeVdtYBcGUzTnTBdbkiexfaoQVW3anJPjherjStF0XGr0n
         XcnthW4fF+R5Z1Qfwov06Dg0CC/Vz4UCYpzlijha2Edn0zHU/JPvG/QU1Zb/q9pqnX
         qRz0PfdjRJxcAgp4R4w7Nz+BH/AUiO7T7h3N7R4xEPccqgozuJG0thaGJ2fX1jg4Hz
         p28zpnUJldrV+m4q4FvWan2YvAyvEEHkInelVt8xYyLC3z2Dix1bdrd/JfSlEhe7Qv
         bpX/m0i7vaAyZMSnf7u3f3GBwEx/lZsANcfWoxbhLgGlDLM/wcasF0zYN+87b67gpp
         oJGhQlKs9CDZQ==
Received: by mail-wm1-f70.google.com with SMTP id y23-20020a05600c365700b003015b277f98so1302279wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ5N4zB6ne7AqKTWsazgl2eww5+7SrfSBiF0jiwRIRU=;
        b=oVr4mNbW7LR7duaekTe1BJ4D+1lPNuBozO/b9+W0j0huu+iLXD/b6NW539Dy8/mM8G
         70CcwKUx46jLYz/xKY4LTZDsjkef/Np/pdCk9u6cZOx3L48cZI2Ov5mrTI/Ra7xw+NQK
         pnt0P2/afWnh9ivLul9EYholqHPxBhPQaiD6ki2c1jk62q70pKpyjWiVP8/SivcXq+bR
         GroFusyEnYcmFeDEhxdH+Kh1vo1ATrKnulD1KS6FXcgku2iata8a5vUKmGhKwD4kMbAq
         HkqVXhdulUqAG+5l4FL8sxS44ajkiYi7MB29vpFUVSCESLvbW//7LoYF8bLCFMMvZWi2
         IWzw==
X-Gm-Message-State: AOAM533Az3Mx1GmZd2hxTbBDnp5ieh2Xu0Jn/fZkXbOuzHzZixoQ/V4L
        8iteZMFY5/yX3T8ojAbI7jIqkcFOMySN0AmxiaV7gqaKYMaKW8sR3n3oXZ3kTDrtK99l5IHmo+R
        VHtyBWCM5aTzx5wn8rkED2H+FDsteaKB5lOhUX8Xt7Q==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr11406240wmi.136.1631539248168;
        Mon, 13 Sep 2021 06:20:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGW1ojaPyD1M/BS656w+4FJLzZXRQcOiJW5oHFj8BydpZT1RYPdlEY9jeHIFid1HBy2UQTIw==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr11406199wmi.136.1631539247756;
        Mon, 13 Sep 2021 06:20:47 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 04/15] nfc: fdp: drop unneeded debug prints
Date:   Mon, 13 Sep 2021 15:20:24 +0200
Message-Id: <20210913132035.242870-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index 051c43a2a52f..f78670bf41e0 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -335,7 +335,6 @@ static int fdp_nci_i2c_probe(struct i2c_client *client)
 		return r;
 	}
 
-	dev_dbg(dev, "I2C driver loaded\n");
 	return 0;
 }
 
-- 
2.30.2

