Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2056136BB93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbhDZWSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbhDZWSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:18:49 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FADC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:18:07 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id z5so4725669qts.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akYRiibsBPZUQXPztVcueh6KuN2q86Ek+U4tZ6zTSgQ=;
        b=eMuIfx/OuzlQock963Ne7pvsqDBMlHu4Bul4KdatGwo4eW5lpM3qm+GXJRqH36UAUC
         ED9hfoCsQTABo+oZcDRLXNf1hKCIAyR8IlwDzGgmCklO1LoU82KRZgSDPIFo1ogddSIE
         phjbfVkPkJSFdwv/UYwkQxgm594x76Itp27AOi5ilrN1UmC9dzhMDMkOPyvYjCBTOe9z
         DndH/DumU8Bupo34HBIn6jp9GuQreGVKVGjXzkWrTlXC7dfPzBPIaiC/e1dvTBrVVJYE
         bkKJFU8qCe3s91zPATaQg/da+SAXkwoNvxaeCqK9y2pkBtz1MRswVyw6S0MHhGg3pPhB
         9o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akYRiibsBPZUQXPztVcueh6KuN2q86Ek+U4tZ6zTSgQ=;
        b=cOf9W510Yiz58Rd0WZEIwl9H7WZrCVCcMo1eK4GUDQdvjCDUlVNZzkgib+KxVMqZR7
         70MjgN/a1ZbEK9mUGKnXK59wTsGRRL9b3vAWEwpzNN8lGAi+SPDGSCsfucsuPymZwy3g
         5YoaGBo1ZIZu17yiYwGEpVGr8uuvWoae745X5mu76C77Bc80ea+DZvydayiFrw1+vwJ3
         qnDECa1db+TuXLRCC+CxO+B8JNoIR1CZEiuNnsZEL7zYo7tcwDFIHdOdjpJGtdKRLRMs
         T3P/fHH+toT9ftNAxzJXCj2yTUhX8ZHfb8UFGhgRkdHiNLoWWVNNi8jl3r+bSPsGiYox
         Gdfw==
X-Gm-Message-State: AOAM532AjJQSDHvSuu3OdgXJ0lmNAWrYbIcSd9/AeXn2G415MR5tlzya
        vflPn6fOGYRUx5dyExdr6bJZp+xpVkIuUQ==
X-Google-Smtp-Source: ABdhPJz5XQQ8dJqNBGZdU29rGTsf1sX4ajQMV6ehuxFRGx0Phrr7VXtO9HtEJdl7yTwzFxQGbk0DxQ==
X-Received: by 2002:ac8:44d9:: with SMTP id b25mr3736979qto.257.1619475487144;
        Mon, 26 Apr 2021 15:18:07 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.247])
        by smtp.gmail.com with ESMTPSA id x20sm1374111qkf.42.2021.04.26.15.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 15:18:06 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, nathan@kernel.org, linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 3/3] Enlisted oprofile version line removed
Date:   Tue, 27 Apr 2021 03:38:47 +0530
Message-Id: <35c4436f0f1b3072d3016148ce1461905b6f782b.1619181632.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619181632.git.unixbhaskar@gmail.com>
References: <cover.1619181632.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enlisted oprofile version line removed.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/translations/it_IT/process/changes.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index cc883f8d96c4..87d081889bfc 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -51,7 +51,6 @@ quota-tools            3.09               quota -V
 PPP                    2.4.0              pppd --version
 nfs-utils              1.0.5              showmount --version
 procps                 3.2.0              ps --version
-oprofile               0.9                oprofiled --version
 udev                   081                udevd --version
 grub                   0.93               grub --version || grub-install --version
 mcelog                 0.6                mcelog --version
--
2.26.3

