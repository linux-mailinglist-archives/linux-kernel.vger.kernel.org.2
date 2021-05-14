Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB075380E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhENQ5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhENQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:57:13 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3040EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:56:01 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q10so25158473qkc.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qkPkKAz2h9nRpZfhfOcMZ0BslBkSdSSeMagvZgD1Yss=;
        b=qG6rtgxeHXnpcKozwIbWX0AI7F6NuFHtr1Y9vS7sV/cqc60MwlRu5AjIr2Ty4+e/Ed
         AdjnmPmIVMcGnUxkeA3RcjsCsjuWdNiEpKduVsLaXR6IEzUGbZyp9lJJTyH1aq2JEG9E
         3DONMqMpEwXxi/+lRhf+0dnuVmRWcX5F0TcNhqpd10nyGZC2slZiw3YnKi9i3+Sfsm/w
         wXlH3IN/1uJXPilHn3CPIdxoxgvh17BBYf1VK1yIzT5h7AyjG5r7ktHco40wIKkeMeG/
         g+g7GrqC7u7m9PUmoQv98Dq5uePFwcplw+VK6uFzDwC5WJQ6+Ecto4ix5y78gAJ71Jm6
         vxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qkPkKAz2h9nRpZfhfOcMZ0BslBkSdSSeMagvZgD1Yss=;
        b=juQlb05qk+ez75Mi9J3rcGTtLqRlWpZD/i3R2S9hSKNX5N+n4C3bTVuNaA7HchvE5n
         Zbe1dxQvNwQfKNuphu79tcJq4PF6VJf1mesoUO6qWo3Z8fZ6BujpHxFNDs3Q+9EM82ry
         0PPS6b/tK2ZcP5YW9510jgAd7Vcm3wDqrohOAx7AW1c7Oh+FI00W0rEGivdWS79fEGim
         b4WMjZft3p5o1cF19fbM9J2UFH4vclY6Q2RYmGQskBhmL/nZduX4iZjnWzKvSsDXs2EL
         pemeGScuBNYhcpaF6MvoYJcPvGN397zaiWaMfkrzo/ZDl+VJbHpW+SGbYAjir4AJHudQ
         +cJQ==
X-Gm-Message-State: AOAM5315RzbOZduhAvRFp+voNJ2tSxl1D6XO0qNS3XOn5nftWhCuCEMr
        mlsrm0mTgX2vLWO7qZeJ5M0=
X-Google-Smtp-Source: ABdhPJzYq6/ohjuA9Z6TYJwziX+TnjbfR2q5JCx6HsfpRHezE9oez8ww8g5rcjhSfdg/zOWxyhEXMQ==
X-Received: by 2002:a37:b945:: with SMTP id j66mr43895508qkf.270.1621011360337;
        Fri, 14 May 2021 09:56:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 97sm4939503qte.20.2021.05.14.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 09:55:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] staging: rtl8188eu: Drop unnecessary NULL check after container_of
Date:   Fri, 14 May 2021 09:55:57 -0700
Message-Id: <20210514165557.1384106-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result of container_of() operations is never NULL unless the extracted
element is the first element of the embedded structure. This is not the
case here. The NULL check is therefore unnecessary and misleading.
Remove it.

This change was made automatically with the following Coccinelle script.

@@
type t;
identifier v;
statement s;
@@

<+...
(
  t v = container_of(...);
|
  v = container_of(...);
)
  ...
  when != v
- if (\( !v \| v == NULL \) ) s
...+>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index fc991c8c16d2..b4d81d3a856c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -4038,9 +4038,6 @@ void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
 {
 	struct adapter *padapter = container_of(pmlmeext, struct adapter, mlmeextpriv);
 
-	if (!padapter)
-		return;
-
 	if (padapter->bDriverStopped) {
 		del_timer_sync(&pmlmeext->survey_timer);
 		del_timer_sync(&pmlmeext->link_timer);
-- 
2.25.1

