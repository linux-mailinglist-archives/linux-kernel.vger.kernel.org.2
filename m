Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CEB40124E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbhIFBCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbhIFBCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8EFC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso3635555wmr.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kL68p0tfdTAUziYOxEZ4ok/eKSJ9jhhvpxDDusc0v0c=;
        b=bGBWWfDfAc7uqJCyLTgiFYOBpcQiZw94mfDRtYodAoqo+92nkjH1brkaMy2HR7/Rwk
         B0vI1kOLgufQb9F9QRxgKwznS7PI1Axaoi85ep4U90lnJ6YamWbOHvsyMcgNvsKV+9+G
         v05C7sQm827Ro8V6PGdOwq09PbSaVFoACf91gaT60+qTTQUBHHAZwxEOFaGBdLkfGm/V
         IODcUdpvooDbz7SraXKuQnhmCrxMO0CI2SsGxhVJVvUnrouly6OQYHBbTE1hsv6od+iJ
         c24zwDw8iD69nWRSqoff6BK/3A7XxTdMI91wUjFhjRhxsyfYU3imGVwOqUNQicD6r1g2
         pPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kL68p0tfdTAUziYOxEZ4ok/eKSJ9jhhvpxDDusc0v0c=;
        b=GjkGFjZXfgYL6lqOAl2KLw/vj1vki/Ebwp54W52zJ78L9BaG+Hc8RvKKTJ4JDv3iCx
         MF/dkOGLqwCDDxHC5sn3Vt6pSmbcBcT9QVBC+4/H8+/jBmXL/uedo0PfpSSAX1zDYSvc
         4xA/1QCGbub1imOppWC6tZnDboBWG7HZXHe6PLB7maY2sbb1HtDFVWbC58dVeD/EwYbJ
         AMUAtY19+9z1XwhVR8Cr3Ic9kbndNaf6zdzB0LlZc8wEu0nsxPw98wsyviISMgwLs9u1
         oqiyMlm7grz/lkiZ/GZU5Aeuo7+r9H6zKwv39uPC+Z4ndfOWePrlCWq+oykPNK8/5B5u
         B0gA==
X-Gm-Message-State: AOAM531Ix+wMGRi4WFQ6ThXl9UffY9CQU1oKrTe8zf6iX+ivFiVzosO9
        Hdw4z3lCu+qbPXuB2IfOpj5rZA==
X-Google-Smtp-Source: ABdhPJzv7wWobcF1i9iLzFdqxmQYH/m5q2dR3ENF2yeyrvxIu9jYfvBZULwyeQVYUe/Fh1E+QVaHZA==
X-Received: by 2002:a1c:4d10:: with SMTP id o16mr8905088wmh.60.1630890072714;
        Sun, 05 Sep 2021 18:01:12 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:12 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 04/14] staging: r8188eu: remove enable_interrupt from struct hal_ops
Date:   Mon,  6 Sep 2021 02:00:56 +0100
Message-Id: <20210906010106.898-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove enable_interrupt function pointer from struct hal_ops, as it
is unused.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index e59a482cc139..f4cb3727030b 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -156,7 +156,6 @@ struct hal_ops {
 
 	void	(*read_adapter_info)(struct adapter *padapter);
 
-	void	(*enable_interrupt)(struct adapter *padapter);
 	void	(*disable_interrupt)(struct adapter *padapter);
 	s32	(*interrupt_handler)(struct adapter *padapter);
 
-- 
2.31.1

