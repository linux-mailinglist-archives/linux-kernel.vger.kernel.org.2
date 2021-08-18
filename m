Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943593F0EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhHRXtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbhHRXtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:49:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F603C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:48:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k29so6061053wrd.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgG1PsY3tE2f6I79M1HWHc/yv1eGrqJsECS6IsBtKJc=;
        b=oDKq8IhSo9XceFS8d9SssZnfdPKcmb6+DnDgUYV1LFyKzMKsksaG+VDk7vn0X4a3as
         EoifHhPg6Xq5XigBSlukV6yvk2wc/scebnU9kwEDhcU09BbltZcvdK7/1l+l2QuCHx98
         HuIQCRP0m8z2iQB+ogWR6C9nGmXdslPaxJ3CsuhlH3cuqnasZplQgZydQF8Pnf4TCv7N
         DqwbaZ06cj9+95QZXwBAZWpI2eh72aS+rDu9eky1qNkhTFkF+EW7cww21Srp5zTN40lY
         xpeaSCwCNIwgnWvaMYLu29WJn72nRSIX1VtssHqE+nJQvVgfdFafcWQZsDkHGg27Yi80
         SP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgG1PsY3tE2f6I79M1HWHc/yv1eGrqJsECS6IsBtKJc=;
        b=hqThLSvBbRmK24T4afCNpc8o/7hdAPU3dqf713LUtEUXZ4iCbYvh1zstoHM0Ra4MiI
         B/+GsRQdpN0jtcIDx6ayjXzIDICqLWOGUo+DquDDdo0olOZbfkoeyxZ/RvJp6OkhCMnQ
         eKj4N7Zdb7KxwDbcaT0GzJsL10HdShQqyGonaZpdEX1IL9FZw2pmIWhlRhtM9TUJMh/1
         p7CWjLYCfAMgDZtd+S0Tt34uJh7+a5Xq9JoidXrFPJ5nHxv5ecRge83r+TAFLNLfrj8p
         4irTcC5x1hJBs8cvuSgDkyDbN+yvaQRoeQrLJ2RETF+LVXd1a3YNzs+ipFxghCwGe8u6
         YYMw==
X-Gm-Message-State: AOAM532Fl7FA4eE+xfYS+zbCR4LYDiSRs0rBhxLZR5i/kIWMRFHzdLJq
        2YVbocOly+Q2gk+gNv6/PafMSw==
X-Google-Smtp-Source: ABdhPJx8oJZlUs6qetU3AOfFAT3Bdf4wrPVN8O8dXYUIs5V1eXRqp7dpNPmNrUtuFzKvD9YT/Ti3ow==
X-Received: by 2002:a5d:4846:: with SMTP id n6mr73176wrs.91.1629330535943;
        Wed, 18 Aug 2021 16:48:55 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1205916wrt.77.2021.08.18.16.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:48:55 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 1/7] staging: r8188eu: convert only rtw_vmalloc call to vmalloc
Date:   Thu, 19 Aug 2021 00:48:47 +0100
Message-Id: <20210818234853.208448-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234853.208448-1-phil@philpotter.co.uk>
References: <20210818234853.208448-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the only call to rtw_vmalloc in os_dep/ioctl_linux.c to the
kernel's existing vmalloc function, as rtw_malloc is just a preprocessor
definition for _rtw_vmalloc. The _rtw_vmalloc function is defined inline
and returns a u8, wrapping standard vmalloc. This behaviour is not necessary.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index c0e66c194952..ab4a9200f079 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4481,7 +4481,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
 		return -EFAULT;
 
 	len = dwrq->length;
-	ext = rtw_vmalloc(len);
+	ext = vmalloc(len);
 	if (!ext)
 		return -ENOMEM;
 
-- 
2.31.1

