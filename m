Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC678408DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbhIMN2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:28:12 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34168
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241176AbhIMNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:25:39 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5C9814028F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539270;
        bh=IGi454bY1uM8p5QRZSKGDo9YXvHCL/LufQFtzz+SznM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=TVKJmnVJLRM5Hrah7bOUMODh5Vj2a4tf0Uy/kSSXkYAij64cluvAPFXi9l5UMOY/O
         OzZT4Wm0ftonrNR7Jor0StEYPT1X2eBJUxa4T/ErI7IlACiUqY1tNNsbcT/DDiRzG3
         ygtg3Z3K94aM2EKy6GSEbL9mbC/qvY765Slj0Y2JFuAyfJNLJ3dA1YGtJ+HiulRJ6Q
         eGct19qat+WAYVzla/3csbW3Axocc7aKnQ0mSsHA3Fka/yfLHXGnKFNT1eA7OReb59
         D1ez94Rqp+yp2GA7NVKe11Fcr+qXKANEg8ExV+puCigQCoHYA0VNqv14iJiWq66q9I
         WiFe9/ooT2jFg==
Received: by mail-wr1-f70.google.com with SMTP id r9-20020a5d4989000000b0015d0fbb8823so2464625wrq.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGi454bY1uM8p5QRZSKGDo9YXvHCL/LufQFtzz+SznM=;
        b=YELopcRgShi/sKkyTP/iL3+Vi0aoid+C63/4WfKzcVkW1ryo+TQU6D8zK2EX0r6dgZ
         cp+Y+B1idM1gGnsz0p6MshbYwV9dt3D7dNzkhsXPcBhViufnx6b8FGW0VGA+bKsQqOSR
         mj6Ou8sjLwYjhveleVYnpvmoCs+C3tjhElEyz2qGLRP4+F1Hn8m6xpRQLfXdu7MOqLoU
         S4iX7cLTggVLBKN6n/pET4sWj65qu+SifqO21M+dyGBK/RgNq08sLZ1I3lnt/wbbrTIY
         xSQvrkw0exSSmLKu7Ln7xxlyxgX2AOyWOimI+QvCEL4vRqEA6KkgKdnynJI7D3Ecbz8F
         98EA==
X-Gm-Message-State: AOAM531MV1ATUlgSxKo36Qjrge9AbN5Ijz3x3tA9iXLiy92i2pxpRkzX
        0fGVCeL5ibzq6Lky+1t57iziGVHaWOioFO1IxnkErGLYuDifFFkaiSxwUJXYXARWdwXyAj2dqJz
        wtso3wuppXjOo2TVnCsA04KCHUDZOOFESBNzOkhMipA==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr10982105wma.75.1631539270108;
        Mon, 13 Sep 2021 06:21:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzcTw8iBQqSZqojTcM4kP7OKiemOCKYYc0KcyxRfeOMDAJB3GM+IUl88UZvA8hAphcWLUGHQ==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr10982078wma.75.1631539269943;
        Mon, 13 Sep 2021 06:21:09 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:21:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 15/15] nfc: mrvl: drop unneeded memory allocation fail messages
Date:   Mon, 13 Sep 2021 15:20:35 +0200
Message-Id: <20210913132035.242870-16-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nci_skb_alloc() already prints an error message on memory allocation
failure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcmrvl/fw_dnld.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index edac56b01fd1..e83f65596a88 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -76,10 +76,8 @@ static struct sk_buff *alloc_lc_skb(struct nfcmrvl_private *priv, uint8_t plen)
 	struct nci_data_hdr *hdr;
 
 	skb = nci_skb_alloc(priv->ndev, (NCI_DATA_HDR_SIZE + plen), GFP_KERNEL);
-	if (!skb) {
-		pr_err("no memory for data\n");
+	if (!skb)
 		return NULL;
-	}
 
 	hdr = skb_put(skb, NCI_DATA_HDR_SIZE);
 	hdr->conn_id = NCI_CORE_LC_CONNID_PROP_FW_DL;
-- 
2.30.2

