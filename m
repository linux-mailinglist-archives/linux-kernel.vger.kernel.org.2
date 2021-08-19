Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FA93F1500
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbhHSISv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbhHSISs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:18:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B604C061757
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nt11so4437540pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTzxzxgtANnnZ4yDUItRXfvQkRDYdVRI72br3L7vJiU=;
        b=ulsr12LQIKBPZl89g0R0dzxz+ZIfEHuok8a8gAt2/ohMBcbIyNg5dT/lvjd1kpws/A
         8O/qCbIuPcGUp55U1nBxxEwsSw9vMS9qzHbSloRIVdCZr1a7ONJt6Y3nmtJZ5rIVTlTp
         yq/jQS+wYRWj+iNBoucGCb2aqueI7itfsM0xQmqbNbnRGiV0ZAMxmeHjATjZkS2Yc0eT
         RpxrPXU3QXNnE6egXdrASuxVuNkfmLPvtBOkmkI7JjzIHAGB/1Ja3zstVJZjNxsYM69k
         Yh9pNm7ePWvfLwh1rECCwoMGJqhsvWWeuS1RPSONhfHPxK6zA/CObSzjScnie4nnAikR
         xr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTzxzxgtANnnZ4yDUItRXfvQkRDYdVRI72br3L7vJiU=;
        b=Hx5In92eW2KncVXMJdxouQ9vBevWsK1agmcZdMIYaKm6dRdsbGZOjPg89KtjnFUWWk
         Lch368iFk70So6uUXnkiR9ihj3lFNlC+UtC2+Vfecj/iED8AtjYec9mlQGpZSUyA7Yj7
         NOZYkJ9vD3Pl/F3MN/8BB2TWErP+QmXMSNwJgI+5pinIIAtxUW4EF6iwAm10JXVib9Hz
         NsJm+CX2QLgDYst/kYj4/uc0e9+SiJqXJKl//o5GU2kHY2bu6jM7UJD9rAiJ7egw5Q5i
         GwKP3b9hy9Eesd1OtmFhmOrSmUvmOJsfudVCSQjUeedcLcSw0XKCoymnM0wQQXeKmvm5
         k68g==
X-Gm-Message-State: AOAM532FuCz+oudt4hvDFVPbllgU/0+YzMSrWoYxU43yo59FbGCROFvZ
        MQDWNPFau3hUALhZlN8vl+0=
X-Google-Smtp-Source: ABdhPJxkwlNSeTHHSstt+OwNXHu3Nq6pZnOaP+v7cXxc7Z8ij4lwWCQAdHCsKkPMpippPU8HlHeruw==
X-Received: by 2002:a17:90a:d587:: with SMTP id v7mr13918406pju.110.1629361091668;
        Thu, 19 Aug 2021 01:18:11 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id gb17sm1531129pjb.26.2021.08.19.01.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:18:11 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] staging: r8188eu: cast to restricted __be32
Date:   Thu, 19 Aug 2021 13:47:54 +0530
Message-Id: <602aefc30b0d979dc6e402d52da2f096ea5c67cf.1629360917.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629360917.git.aakashhemadri123@gmail.com>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:836:54: warning: cast to restricted __be32

Unnecessary double cast, remove them.

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 404fa8904e47..6a0462ce6230 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -671,7 +671,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
 					struct dhcpMessage *dhcph =
 						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
-					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
+					u32 cookie = dhcph->cookie;
 
 					if (cookie == DHCP_MAGIC) { /*  match magic word */
 						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
-- 
2.32.0

