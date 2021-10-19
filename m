Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D7C433570
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhJSMJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhJSMJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:09:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864ECC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:07:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so1838775pjq.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVIQT82jcRb7GPMNtR+z9+ttpCLcsjQyVlSrcNJwXOo=;
        b=EX+vS61JMITPqLH96+nqUjYjcawuaPHoSesPYtZl1n7rBxiwMf2CPx/+7ad2X7WcuS
         kW8kp5lC6ebvYfNylNrL0KzX3tR0lDDDStyiQC9S9qO7CvZAiy/XJN0LaaebFnT+n3Ns
         E1+rykixHr7OAAQVvKS7e6ZQi53IZ5JY05XqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVIQT82jcRb7GPMNtR+z9+ttpCLcsjQyVlSrcNJwXOo=;
        b=jF/PnKifI7IeM6+HPWEQ5dt/GIsv3Qd1aAMbgaTGYS/r0wMoqXfXz3jN/1wDhs+o4O
         dGK0L522/3C/1z5CM7JRQajRD7rKCOlUbqpdRyl/uH/Bedyj1aAGGe/8K9o+rSKXC9xm
         HJys+4sV0PdIzIMrrOxfMvnXr0fumTVJUxq2SnReQUUJ/0ntq63k/T779NK/ILFjN0+l
         s0hLLd+lCLFzITXZoTOcs+IkK/SSb7LcnSm7aDIQ7mRmqySAe4apUdkJ0+0Sx854fodE
         Ch8+SWrRO0TO2AsnNYJUGC3ACyQusoOfJHghOsTuW11Vpldz25M8eGaiTNp7+W2jNy2W
         Lcpg==
X-Gm-Message-State: AOAM531buadOgjUs1OtLYPcYkitLKNPqE+ak/Eozvkq0t2NqLCdIqplv
        wRvgSX0ZxxRff+l0t3e1ghZQMF3seN+Atw==
X-Google-Smtp-Source: ABdhPJzjbEBfYj1NJaCL6KZizsoAX8NL57PBxlOdEyuR5fwk5opRhttrYLoodMKKcptVYabTjzO6Tw==
X-Received: by 2002:a17:90b:4f90:: with SMTP id qe16mr6333304pjb.137.1634645249158;
        Tue, 19 Oct 2021 05:07:29 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:1d7c:b745:dee:c8a4])
        by smtp.gmail.com with ESMTPSA id k16sm5236160pgt.57.2021.10.19.05.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:07:28 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Mark-YW Chen <mark-yw.chen@mediatek.corp-partner.google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 3/3] Bluetooth: btusb: enable Mediatek to support AOSP extension
Date:   Tue, 19 Oct 2021 20:07:15 +0800
Message-Id: <20211019200701.v5.3.I257ac5cfaf955d15670479efc311bbab702397f4@changeid>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211019200701.v5.1.I139e71adfd3f00b88fe9edb63d013f9cd3e24506@changeid>
References: <20211019200701.v5.1.I139e71adfd3f00b88fe9edb63d013f9cd3e24506@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables Mediatek to support the AOSP extension.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Mark-YW Chen <mark-yw.chen@mediatek.corp-partner.google.com>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>

---

Changes in v5:
- Let the vendor command in aosp_do_open() to determine what
  capabilities are supported.

Changes in v4:
- Call hci_set_aosp_capable in the driver.
- This patch is added in this Series-changes 4.

 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 87b71740fad8..30c63031592d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3876,6 +3876,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btusb_set_bdaddr_mtk;
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		data->recv_acl = btusb_recv_acl_mtk;
+		hci_set_aosp_capable(hdev);
 	}
 
 	if (id->driver_info & BTUSB_SWAVE) {
-- 
2.33.0.1079.g6e70778dc9-goog

