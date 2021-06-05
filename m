Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FFA39CAF8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 22:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFEUkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 16:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEUkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 16:40:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEF7C061766;
        Sat,  5 Jun 2021 13:38:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 131so16322083ljj.3;
        Sat, 05 Jun 2021 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTC/pIu30sSoKz1vPLWu2EsUml5Qb96YwKlSwWGIyQo=;
        b=AabnPA0tUb3CI/kOoBBOIH2ls6fExJTuy3v9OUkH1ZGY48DS0aCcW2y9BFoX4YrNXz
         ZQGEQpx1yF7ERy6K2O+vHCSfeTuEuGIJxuTECstjR5OCORZ4AglPsJgH+Ce/CC/2giVd
         0nLlmYAYvMoBUpdIinahGzQ5+VrPDjkQJWY5plPJXja70qBCR8HZQIrd1pfVTbGNt42u
         +G6FE3Ko8zPLyA2IS3wNowZYRvsPeNcZxL0sBQZTLJ1UBLNK/Dl2vSldJKTYEnRJeY3X
         dphpkdZElAzWKRKU3KBl7LNw+fc+ulvIfHeKgKqpIrg+EH2CX5kfJ6yVfiIL+WaD2jzb
         9Llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTC/pIu30sSoKz1vPLWu2EsUml5Qb96YwKlSwWGIyQo=;
        b=SHB0R8OxykIJFrUvUPJp6p9px6nkjBM+JGljzuxr9HhKf/GExdpj4vvdKKMpzGtlDM
         57WwqaNTPchusG3FBADboU7qBT3jpMoZ8+7n/M//ag3o1G5xjGyMdj6o/2eU8KYUkfNO
         XW+tzwf90EbcB7LMj23ztcFG3D3i0WNyd23EV5QsAjsd/WEylXD8Z7Dym9Mx3C8WK/hY
         W9RbD2UyxKI4hkD9nMmpLJ10hNuePrOp/o8PACr0xjWGmS58HEau7Hs4oupcpcX9mv2D
         x2YwjZaQf25gETDgJPYL1HePb33NUrzmFiNYYfM3FMZXQUQzPTpmAq8WkKnouHhOY74S
         LkFg==
X-Gm-Message-State: AOAM533yLLgZsl04kDmhLjVnP0hjm1vKEM7Qmz/BzG6BT5ObJrRpFvV9
        BOW4KhV0IaanTXhHXJv3oY4=
X-Google-Smtp-Source: ABdhPJz2+NH3rL8XtYXVlgiLbWx44gUJ8bGqzbI4fnFzb3Pjk/gVxbQ9Hk2fyWjgQC8Lmc4Vk2QC8Q==
X-Received: by 2002:a2e:700f:: with SMTP id l15mr8547086ljc.52.1622925500740;
        Sat, 05 Jun 2021 13:38:20 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id k24sm1170063ljg.43.2021.06.05.13.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 13:38:20 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Frank Seidel <frank@f-seidel.de>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Justin Ernst <justin.ernst@hpe.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/4] platform/x86: tc1100-wmi: Constify static attribute_group struct
Date:   Sat,  5 Jun 2021 22:38:06 +0200
Message-Id: <20210605203807.60547-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
References: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only use of tc1100_attribute_group is to pass its address to
sysfs_create_group() and sysfs_remove_group(), both which takes pointer
to const attribute_group structs. Make it const to allow the compiler to
put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/platform/x86/tc1100-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/tc1100-wmi.c b/drivers/platform/x86/tc1100-wmi.c
index 803920b6f01d..9072eb302618 100644
--- a/drivers/platform/x86/tc1100-wmi.c
+++ b/drivers/platform/x86/tc1100-wmi.c
@@ -156,7 +156,7 @@ static struct attribute *tc1100_attributes[] = {
 	NULL
 };
 
-static struct attribute_group tc1100_attribute_group = {
+static const struct attribute_group tc1100_attribute_group = {
 	.attrs	= tc1100_attributes,
 };
 
-- 
2.31.1

