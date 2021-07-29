Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9D3DA15C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhG2KlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:41:24 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47788
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236246AbhG2Kko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:44 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 675F63F239
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555240;
        bh=So1uUDkE721+BEqMeRM8NOIaRYftuFanUkfPQdOA99A=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LcJpcVqO1Q45p0JH/FCarrOA08lTJgjKg292V28U+vo0Q2qtcKOp7vlPkir0Q1i+9
         nA7p+otPGN/Oj0ezZu4FX4f5ng0XL6965w8zeWbBgBTy0FoXzVcRxDIzbuItauD6Hq
         +rOtqB/ubTS3m+I/qN4eOFl9Gsu9ZmtztEB0CBfbpRX2AdSjfnRSCbPviI5yIU+OIh
         5qZpxLTr2Q7PWLf7gR5CeUzqyuAVBSp9WNs2p72F6T8+yiQ+qDlz+7VDJFPa00llQJ
         Ud90JWJ+RH2KgXIv6zTOEX0DYaZgtjG4Ai+FWG83pEmfTm9UTXmU3odH3c1xlvIMzT
         KFK7OpfiI3P/w==
Received: by mail-ed1-f72.google.com with SMTP id b88-20020a509f610000b02903ab1f22e1dcso2733091edf.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=So1uUDkE721+BEqMeRM8NOIaRYftuFanUkfPQdOA99A=;
        b=Oz0fekbSt5kDj6mOItqjaG3eQeQeI7TwRcgyTUBwknZQR0TBC1gaCJhQgrueiaXB3g
         i8zij/nXqP72GMTfqr/CE1H/6nxCs2axT9H3ueQfIZ9QqFFi0cd2xWHDgFSxi/HOwMVe
         YBrlEhcESC7snk8cBq0cT84VdPEiqWgwgu0IM8+5j44I8fiVFxXiO67ZugkIfQ6ABgrL
         0cBZWtVp/kEhVGab/xqEb4CdoWHLQFyAmYMBQvQLi5ZPiAIOybg+7CQRdig0rijuv9bm
         titedkF/Kr2MXVf236I+xIz91Xaq75etD/YX4NvDBkwgkHVGrli6tYAhIzTh655CDJ5N
         RUAA==
X-Gm-Message-State: AOAM533/ZcX/iLWzFlyjUkjqD49BEaZnudYkOvZe/3EzR/PUDRJESeWY
        9UsdnQj4rcwQDwdqcB9mDG3OjZE5gPcKIl3jjPh9fLIY7PDKF7PywLVp0ymYBjRFnCpgq6eq2er
        geZT64bcfwysBdfOQz7N1/TzN2zrCQ9WA86XVZwyjEQ==
X-Received: by 2002:a05:6402:cb9:: with SMTP id cn25mr4576420edb.271.1627555240172;
        Thu, 29 Jul 2021 03:40:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwg8gQFeBPTWOxeoK6KYjuQRUdToXFwmH6p9ZgcYdRRS/mw4BXtIUndBzQfGalBkLacI2jz9A==
X-Received: by 2002:a05:6402:cb9:: with SMTP id cn25mr4576407edb.271.1627555240070;
        Thu, 29 Jul 2021 03:40:40 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 05/12] nfc: virtual_ncidev: constify pointer to nfc_dev
Date:   Thu, 29 Jul 2021 12:40:15 +0200
Message-Id: <20210729104022.47761-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtual_ncidev_ioctl() does not modify struct nfc_dev, so local variable
can be a pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/virtual_ncidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index b914ab2c2109..2ee0ec4bb739 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -170,7 +170,7 @@ static int virtual_ncidev_close(struct inode *inode, struct file *file)
 static long virtual_ncidev_ioctl(struct file *flip, unsigned int cmd,
 				 unsigned long arg)
 {
-	struct nfc_dev *nfc_dev = ndev->nfc_dev;
+	const struct nfc_dev *nfc_dev = ndev->nfc_dev;
 	void __user *p = (void __user *)arg;
 
 	if (cmd != IOCTL_GET_NCIDEV_IDX)
-- 
2.27.0

