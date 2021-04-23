Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1E23692C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbhDWNKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbhDWNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:10:04 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52099C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:09:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y136so17386965qkb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akYRiibsBPZUQXPztVcueh6KuN2q86Ek+U4tZ6zTSgQ=;
        b=K7WC77/1FUXhb40Joklm0c85kgoT7dAR40biO6UsbM5j2apzOnXTrmP6FPl854jw8m
         tQCXvQVcQLqBgopo0wvuhyRQqNrPhOlTFyLCZF9b7WeYk7zD8dpDPauq3GyhzNRvmCSn
         4ElEWliN1rjPZasM35LL5bMVWIRazReNpskNhlSDjb+M0N4056GADHBYRT56vP01FQP7
         7u7US8IOP8t4El6GTli2e79d5+XjCgtH/yaw5/kt02eFIBP2enYavz0mupsUF9/vyjeC
         5AD3/7Kw9r3kPQKse8rMI3+1AxRGi28qZsb5GXzG/MCWDat5ltJmis367j9ytXIQsvSt
         JSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akYRiibsBPZUQXPztVcueh6KuN2q86Ek+U4tZ6zTSgQ=;
        b=n1k5iol8iYSsU65xBtgbCBhteguQqTN0qOLP0KyxICh4ia4wqu50HXpDA3vA34u2k4
         as9HpigZOTGRzvaH7Mdx/tG1WGqhr7U3r4I09IobPlf3q28L/fCs7+/xlpQD8ZuhCq0P
         PGu+0OTJd1644lXQb/oPn5Ne9AdMxArYqkeK539zw8Uj19ZgC21f33qcVSZ/3yeGf22W
         1GWPr1ui0JP5Fb4ywR4p7G1BjqNGIYe7ytO7piNNE7ftA/zB9uogPgkyLl+uESG7IR8U
         x2sZsuUzpKdN1xBJyaot7eyoePiy3iyLdI6oBOGHLr4xBb7SXmPWm0aBt6YPImlGxzlE
         +X4w==
X-Gm-Message-State: AOAM531rdz5Z0hxtLj5brKxBQBpdgY6yPw5RBbixkn1G+kzbNAimsrgG
        d+bfwNH/0vVcvEPcCv2Rv2A=
X-Google-Smtp-Source: ABdhPJzZzIss/PT7AUKo1NXuJncmMwDV0p707BRcmPjG9yBUs/PI3AAxPNEgsAA6bFsTFZYquXyfNg==
X-Received: by 2002:a05:620a:24c4:: with SMTP id m4mr4145592qkn.114.1619183367580;
        Fri, 23 Apr 2021 06:09:27 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.69])
        by smtp.gmail.com with ESMTPSA id a4sm4142613qta.19.2021.04.23.06.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 06:09:27 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, nathan@kernel.org, linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 3/3] Enlisted oprofile version line removed
Date:   Fri, 23 Apr 2021 18:33:01 +0530
Message-Id: <35c4436f0f1b3072d3016148ce1461905b6f782b.1619181632.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
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

