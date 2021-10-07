Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAA74259B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242538AbhJGRq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:46:58 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36784
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233719AbhJGRq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:46:57 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F09563F499
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633628702;
        bh=Coe08tkAG3DLADP+J9knykBNBTwMfZOYcNMbzRGgajM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=VOsCr1ulRNevDdC9fABrnL2tyu4H3VuaSV6i3i5J7BZKxWXkQ8GwahM/yxPK+RalM
         9iFaQMkv+xbNQrsWpOtubbUeqvz4QmhoN0+DurVm2Upjf98PqOf1wy22EhW/DLIiQG
         LynpqKXf4kvXIv927ukfAYmW2oAheGLA+G9nuK/x0me8vO2xtkSimgHOShaByts/RN
         RlYm6YQTrXQeVdA5bMFDYY5ahcUHpcXMrtYv/+oBJVi4DGp47Ci4He1YL0yRLUlQzW
         C+PtOJ7zn3NydVqdbc2wI2FXjH/j4KV7y2y7Srs2+1zF50Y00bqU79hy6BHQqbRO3A
         V5Hdupg19LDpA==
Received: by mail-ed1-f72.google.com with SMTP id p20-20020a50cd94000000b003db23619472so6615648edi.19
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 10:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Coe08tkAG3DLADP+J9knykBNBTwMfZOYcNMbzRGgajM=;
        b=AErdMxhOJakYt8ub0h6oeUQ4C+pWLZYhzOl7PP9LSGigl+AZGqjY+ZLd5t30jfrnvt
         Buz0lstcgglSUeJirqHfYRI2zwNpTKZe68o/It1I2vTslOTOP4E5pQGFBJEkz7AFNKHy
         45fRDcXqzhmv7b8xbRaAJmH6atYkJIZRTECjJ6hLiixdQDJzaQGQ0oQFF6oKQLH4Ho6D
         zB5pM6pvrFKu7xTnLvWwCcVT2l6zBLuS4eNrqBtftNKm747cOGTHypcIcPv3Dm8uVcW1
         jaLeMv49yBnSNi9d8gvONrkw1KNCKnouDvltFqSjyHnkle8ucXqfPULWtsXrjiUjErcO
         bPYA==
X-Gm-Message-State: AOAM530HbeBLmsj/kc+LS6jsjbIjRAYl4r7CX/GTcwDjGQrxBFlirwsx
        G67MyZctB/cT8+1OMP5BzgevBKpcSvA8VRLCFbX6w5j70EA34DHKWGYYUxuGKk+OqPsgTw9lktq
        b3CRypjelEwchfxYW6KPX4xE3kGzu6hhSdpW7ay9zIw==
X-Received: by 2002:a05:6402:40f:: with SMTP id q15mr7790412edv.333.1633628702713;
        Thu, 07 Oct 2021 10:45:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/cRrFbBE0AEAY1wTn0RkOd29OzBi3ThqVg6eaCa0cLj3RymI+vrrOi/pDfxhLH7N7JZpaZg==
X-Received: by 2002:a05:6402:40f:: with SMTP id q15mr7790386edv.333.1633628702498;
        Thu, 07 Oct 2021 10:45:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id u23sm24243ejx.99.2021.10.07.10.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:45:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Lin Ma <linma@zju.edu.cn>,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg KH <greg@kroah.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] nfc: nci: fix the UAF of rf_conn_info object
Date:   Thu,  7 Oct 2021 19:44:30 +0200
Message-Id: <20211007174430.62558-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

The nci_core_conn_close_rsp_packet() function will release the conn_info
with given conn_id. However, it needs to set the rf_conn_info to NULL to
prevent other routines like nci_rf_intf_activated_ntf_packet() to trigger
the UAF.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/nci/rsp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index a2e72c003805..b911ab78bed9 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -334,6 +334,8 @@ static void nci_core_conn_close_rsp_packet(struct nci_dev *ndev,
 							 ndev->cur_conn_id);
 		if (conn_info) {
 			list_del(&conn_info->list);
+			if (conn_info == ndev->rf_conn_info)
+				ndev->rf_conn_info = NULL;
 			devm_kfree(&ndev->nfc_dev->dev, conn_info);
 		}
 	}
-- 
2.30.2

