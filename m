Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746A640E628
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346612AbhIPRSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:18:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54406
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345103AbhIPRK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:10:28 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 374653F2FC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631812147;
        bh=xPpOqBWr7It3vesqmSTKYQnMNxzHvZ+jahU7C4r+dU0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=KQF7p14GfNwrr7j5pcz4SWE1B8JaunbHzKKn8eHUJhWfwV7OFYxzpcYsjAWpPqcHb
         iVoA+YB9m8e+quukUsvb3CSss+wDVebnkFSj89SC82tQO+ClQfMgFP+EejpS0LamoG
         VGQx94MxDfzZi+Ezpt5fj2xXqeA9b5IemBTpuip+BbtZ6zXvD3Ipva5QgcsAxhlS1h
         HkVulwqurO4Rb3U73mJ2GFpaBOsN2SVkMjJO4vMtiKzKp9L6WQwRMslIRPZFAo6auP
         ghIxNLB1M9yNhThBzql36fIV6OhAkNKv5QbmA3lRgTDz1h44p492uVojwWHPRR7xXB
         gudluOAH/Slhw==
Received: by mail-wm1-f72.google.com with SMTP id 17-20020a05600c029100b00305eac9f29aso1392036wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPpOqBWr7It3vesqmSTKYQnMNxzHvZ+jahU7C4r+dU0=;
        b=SsUn1TSnzmWhRULv+nyoR+ik61C38cUv2KI1qpnvsUL6tpj8snrEZxsx3aljXaZdip
         AHbDwKwLvk8Fd2D9kn2rj2LIZgnAy/xerxkHkNHNOughDgss0DeuLzFTUFx8wp2yibXD
         SP9KYFFSYxn//tSNSeIxL/ZcYdpUQKE9ZWKybnXpNe5olHmkSPyNHpRdTcyKY25t4nf6
         gT5cesLppzI9CspLfoMSy5bs7iiMaLC/FxvwlUFUcE63TLQBCPlOT2wUTpOr69OlIYBs
         7fGsD6C+X17IR7ReViB1ViVKDylGmKhhVSk0I8O+mi8xnkX/ATSqZtHhhqPT9WhcuuIB
         GXJQ==
X-Gm-Message-State: AOAM531NMrigNCMqao+Q0Nhku1F7A0jJNPGPCcuJH52bJxZrHvqvQF+i
        tN7B19Eta/3rq988JTuhC9FrCkSW20M1GJ8DxEk8vnomKgfARVY7lYLAvR+FpiUfbulAl4begvv
        ags+rEnJh09XymIgonClSnIiV0f9KOgP4aQqw3g8JsA==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr6116425wme.71.1631812146008;
        Thu, 16 Sep 2021 10:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPp03RDoAih9s3NW/qGubj3h1EcnVLf9/Ph3lRs8Ac+5xs5w5VZJCzJ/TDFN0K5bf63k0ndA==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr6116411wme.71.1631812145892;
        Thu, 16 Sep 2021 10:09:05 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id f20sm7893839wmb.32.2021.09.16.10.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:09:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] serial: 8250: remove duplicated BRI0A49 and BDP3336 entries
Date:   Thu, 16 Sep 2021 19:08:59 +0200
Message-Id: <20210916170859.138813-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BRI0A49 and BDP3336 are already on the list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 98e5ee4d0d08..1974bbadc975 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -56,10 +56,6 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	{	"BRI1400",		0	},
 	/* Boca 33.6 Kbps Internal FD34FSVD */
 	{	"BRI3400",		0	},
-	/* Boca 33.6 Kbps Internal FD34FSVD */
-	{	"BRI0A49",		0	},
-	/* Best Data Products Inc. Smart One 336F PnP Modem */
-	{	"BDP3336",		0	},
 	/* Computer Peripherals Inc */
 	/* EuroViVa CommCenter-33.6 SP PnP */
 	{	"CPI4050",		0	},
-- 
2.30.2

