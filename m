Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F192C44675A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhKEQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhKEQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:56:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6C8C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:53:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gt5so3450311pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4nGHuCf41SngR745SwIkimU/Vz5GHGbBbJavoYdXknU=;
        b=cvlBAU4nu5Zfg7BqZjgLR7OzjV6Q/yQ1MI3p5KYU+MbWfFYAN5EaU1pY3SlYw6k/CN
         4NRKMukOUbn/W+Tubf9Z9KdM4Qr7/8VN9mt3WxjLprN+g7hXLrGRZzFZ3amYuTc+71/T
         6+5Y9u7BfNClL00+y41u+I5AoM5QsUrLPHAalCPG0mLdkKqHMlmsa4vzW6KUaB35Yz1e
         X6xFOmHrHNUKOTzNBLnSj0r5fcnISWHcr2sWUNxGDupgd3kGm34ZwkWFy7P8C7x3uqRO
         moozdY1w/STHnTkqLheHWFHwhuTZJNXU6HMQn7hJ5tzLhP9qHPd1GXlkFyUotADabZ9X
         3Ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nGHuCf41SngR745SwIkimU/Vz5GHGbBbJavoYdXknU=;
        b=dnqmHUlRDpE0gTp4rLZGi7bnlPIsPmJjbfOaY2eIXc7M66It71ncSoPp/ELE1tEKUb
         nQY3cJrH3oMIeNEjhR4JQWgnsInXAYCX85m1NVXV1QLyW86oN0DTE088/IuRiTr+pofb
         sYc/QNP6kw5x+NFjMO0Fqnl2ya8P0c7T9YGcfwTMA51b2S9XcVnNSDJxbctPjQ/flU39
         xPsqyvNc1wAnA2tenNlG+02G23oQSi35Yz0XVl4EzlsnjkneQSzVDnqrYKjAMc8TOhxH
         dcRRiVYSJdVHt9HjR+AgP+ajIJNNCCRWolllcooJr5cuyyfEzSQWqg/Vl2PVy8I6zTTC
         SQ5A==
X-Gm-Message-State: AOAM533Lc7ZQ8GPN/kndxQYoYGGoCyhDqQnP6KtqR947aN/ax0OFkpqd
        QODY//AIAQTXdT8MvA/2hF8=
X-Google-Smtp-Source: ABdhPJwUiTStHlUz0AoR2/KXSCbvRLr5WBjWiWLRorWKks+4plI1K4xZeMemnQ3lFWKVsD9JQJzPnA==
X-Received: by 2002:a17:90a:fe87:: with SMTP id co7mr31139202pjb.21.1636131222166;
        Fri, 05 Nov 2021 09:53:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:4490:4409:3406:a18f:7c45:2f81:cea2])
        by smtp.gmail.com with ESMTPSA id s30sm8524425pfg.17.2021.11.05.09.53.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Nov 2021 09:53:41 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        saurav.girepunje@gmail.com, dan.carpenter@oracle.com,
        shreyaskumar1035@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Remove unused local variable in rtw_efuse.c
Date:   Fri,  5 Nov 2021 22:23:28 +0530
Message-Id: <20211105165330.78524-1-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <saurav.girepunje@gmail.com>
References: <saurav.girepunje@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series to remove the unused local variable in rtw_efuse.c

Remove the unused variable padapter from Efuse_Read1ByteFromFakeContent.
Remove the unused variable padapter from Efuse_Write1ByteToFakeContent.

Saurav Girepunje (2):
  staging: rtl8723bs: core: remove unused variable pAdapter
  staging: rtl8723bs: core: remove unused local variable padapter

 drivers/staging/rtl8723bs/core/rtw_efuse.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--
2.33.0

