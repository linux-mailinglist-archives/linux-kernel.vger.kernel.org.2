Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050993A72E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFOAT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:19:29 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:40453 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhFOATP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:19:15 -0400
Received: by mail-qk1-f182.google.com with SMTP id u30so40287218qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAhWvrf4MKxQa5lHti7TTDcFAj1qiXLJCSE80+4N8ZA=;
        b=PTTiabWgWcrGiWdJmgp9OxmJrzRvrBapVAoWHy/Rs2pXE965cDXAzcHCS+S9fs0NvU
         xGlYHkleDfMwfuwlYFH0N2NW22vvY9y+1NKTkAA+gb1iCpDFOb2w+zTZMHKhExU41UjS
         1bzsJJfFYvSnlp6PYzSon75CE7V8msM7IimjPd9m4DuhPXzn7957UkbmtpgCHAS4/Rwe
         8rQg32Q/o43bFo9kjpqPLX5kDQKdnUluCQwDDqVQ/9husJKhbMkZEsGBSPi0ex4PLU+p
         s29bXrzJ4tVUJa4Ac2aOrIjVFF5d8M1zH/aqlUTLA6Kw3vEmHPOvSqh57RLIIoeIMplO
         sarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAhWvrf4MKxQa5lHti7TTDcFAj1qiXLJCSE80+4N8ZA=;
        b=Eo/XacfYm0X7jEJW1x/XLcIBV4HaMcDHDqyuNHgssQyPNtpDD6N+OKpmAw13dQ9wBR
         TBVRSfaZMS6IJgSd2Z8jmigWX2E1XyBiA5RKCLnlTFEBxBb+wTaL3uNCAqaMFYcGpanF
         dYKDF0elu947IuvQE9Rxgv0ygN5tecGJ4hecjmCgHN8ehZv7kzNTDrQMZkX6qKiQpnv0
         9wB6+RfY7axVjQ0neU8t7y6WNLcyL6G1Ot5Wq08S6TE7c8mSEmn7mxDGdpRXE4rMYIl1
         SA7IiAXShWqvOUn9WBNXQBY5JAwiZwb4eyKrNY+WpZVSrIIqWXhajw4EsyITw6+1E50F
         qL4w==
X-Gm-Message-State: AOAM531uPpWEyRFCN6B5bB79p/CVdO11x+fIutY3n3M5IlcFrWPFoOeS
        j2Bk9YGw7JXHR7t/6rAdTSlR4w==
X-Google-Smtp-Source: ABdhPJyfespBzZJgJdHvPuUKVxuLSsOxM72g8ET5cbHPeAJ3elpkxqK+6Pvv549jNtvs+cN9uG1l6A==
X-Received: by 2002:a05:620a:1443:: with SMTP id i3mr18479386qkl.193.1623716158384;
        Mon, 14 Jun 2021 17:15:58 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:57 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 12/28] staging: rtl8188eu: remove all DBG_88E calls from os_dep/usb_intf.c
Date:   Tue, 15 Jun 2021 01:14:51 +0100
Message-Id: <20210615001507.1171-13-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from os_dep/usb_intf.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 3a970d67aa8c..5ca54dc36fa9 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -351,7 +351,6 @@ static int rtw_usb_if1_init(struct usb_interface *pusb_intf)
 
 	padapter->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
 	if (!padapter->HalData) {
-		DBG_88E("Failed to allocate memory for HAL data\n");
 		err = -ENOMEM;
 		goto free_adapter;
 	}
-- 
2.30.2

