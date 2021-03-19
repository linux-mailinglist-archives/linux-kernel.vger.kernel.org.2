Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DC43417DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCSI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhCSI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:58:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC54C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:58:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ce10so8416557ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xTE0saRdg1HsN1EnA4Jq0r+/ZgbH4gbf0pvKWFq0G4=;
        b=sHbqQmRLJsfWvwKSFK5pLm8ZJhyl1QxhYB8e/ZHzRxnb3mZpcYevIa58/8MORE93dY
         rXaHXBdBiVU2C71qHQF+88WbETtLV0aQGM613W6a5yMp/sZKBI1NNhPxNGWYcJ7WJSzk
         wMj2KZZ0K/ObFf1pLHOYUEUNt9HFtF1OmysHS5nWCGbuoSE197J0q1tMWGgF17/E3FfR
         FzjY4ZrhiQDFF10amYSyd9tqyj6/UXyEkTbCpMOudmCc3+Qc5y0UOWy/01LodzY5Fr2R
         R5kRdiafUe5mYxSRjUOjf1fk9eXxA150FywvxEx2JxL/sy8TrHPYX+euMfoSHYZvyrq3
         k3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xTE0saRdg1HsN1EnA4Jq0r+/ZgbH4gbf0pvKWFq0G4=;
        b=WIe3USbjZyc0E7RyRbNSqViWGv/d7bB/k5x2oPZ5x1IdT0jIpCJcRj+DuJ/2N7lXDI
         70jnUEqwyjNnPzUTgLXMJG1ob7TwoZQY7MEBoVgPO99jOoedz8M/a7fzWOo7vajL/WYj
         LwDsroeA3eWaPMWjaNCGuKm5JU4o0s0ewDmQFEM3VtTch3TIT8dULNVlng8fy8bQXQDe
         aLNnF6q2Gvdg8nuIiNvhQNy6c4ImVJdqSWRp84BwMxld2YP76Xred14oAEaQYZsImgGU
         AU1ECdfaEqcAPVTn/wNxMtecU3aOfby/7rDP7MjvD+o4YvLzkxORhnplYOBTXnZB1kJI
         Rm+w==
X-Gm-Message-State: AOAM533+Qd5jFK64h0fXgMjayxy5b1GjTwizbC+IhcIV9zGOk6xX5vnu
        oGzkfWZou0Pj9fLfW+kG/zk=
X-Google-Smtp-Source: ABdhPJxe1oYFepFttZO8myg+sBvUn/11IPGgad2p6AEhHUgbVCAQHvnIyZbRl6Cc9dQRZt6A1v5JnA==
X-Received: by 2002:a17:907:e88:: with SMTP id ho8mr3167568ejc.199.1616144324555;
        Fri, 19 Mar 2021 01:58:44 -0700 (PDT)
Received: from ubuntudesktop.lan (205.158.32.217.dyn.plus.net. [217.32.158.205])
        by smtp.gmail.com with ESMTPSA id b22sm3447818edv.96.2021.03.19.01.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:58:43 -0700 (PDT)
From:   Lee Gibson <leegib@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Gibson <leegib@gmail.com>
Subject: [PATCH] staging: rtl8712: Fix a possible NULL pointer dereference in function r8712_joinbss_event_callback
Date:   Fri, 19 Mar 2021 08:58:36 +0000
Message-Id: <20210319085836.8259-1-leegib@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 10 analyzer reports a warning: dereference of NULL
The function r8712_find_network can return NULL and is usually checked but
no check is present is this case.
Fix by adding the check.

Signed-off-by: Lee Gibson <leegib@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 6074383ec0b5..f5886b39b3b5 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -728,7 +728,8 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 					     r8712_find_network(&pmlmepriv->
 					     scanned_queue,
 					     cur_network->network.MacAddress);
-					pcur_wlan->fixed = false;
+					if (pcur_wlan)
+						pcur_wlan->fixed = false;
 
 					pcur_sta = r8712_get_stainfo(pstapriv,
 					     cur_network->network.MacAddress);
-- 
2.25.1

