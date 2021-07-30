Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0438A3DB411
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbhG3G5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:57:10 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:39438
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237768AbhG3G5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:57:04 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id F34213F237
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627628219;
        bh=VTZKLd4Cikiu9JLg7PgN5ojxKk/zgZVaneS8eoEANNg=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=blv0rcEmGWek80qxxIg+997a1WkFwDwK7d2eVUedS18yUdyUkDpTcSCImUanqfGic
         VB3ny/z1bleHHFMgZMiZtAzsH6juzBjVwOYmnD8TeyXWzUp86Zu3+oSUZ1V6nJhty0
         BOsxvQD4zKGHrYur7YDHvWcJHEgqLfwoymdyGMcUWwRv9tFBjyo8m316mAjd34RhJB
         a/sB7nPRA3yPDgGO5jBtLuHqWmjz++7lxclAEAmnErv/OPR8ogIp6vhyi6YPNTtrLC
         9pbzQwidCYgq+Yp1M5uLbIYampqdsdTSRvgjtsox1rNvRYjrfREe1CZBnuN8cabNbF
         488CCD7OA0oHw==
Received: by mail-ed1-f72.google.com with SMTP id s8-20020a0564020148b02903948b71f25cso4143087edu.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTZKLd4Cikiu9JLg7PgN5ojxKk/zgZVaneS8eoEANNg=;
        b=YdoXlW01hnJVuEQEK5nrd9Q3fkY7EK8NGZi4HUVIXfQzrD4h2K82DzmHaodjPBftuK
         qn7YyA1SON+pk3ngfXO09wzvZR8IdAEHTNst88/BpEqDes8cwmZ+FDyIPEzjQfnbkqYz
         Jqgul7Zfg2OV2+I1O0Tm0a/a1qwYk5yTSA7DIzrXdI+zhSKEqbAPKuZUVElbom0nKhKh
         xyl6pjA24gaAPeLs8oZ8CG76WeQehp1/1dCcrDVhl7dQaX/E1BlqG9pFnBrfonWnf0tS
         O4L2cMLRKQvr4vivEoiQKqmAMQNK1OsUblNJiZ35XJyb0k3rPFoydWcHQS4r3EjDoLV6
         hosA==
X-Gm-Message-State: AOAM531QSUC7q6amwbe+vPzqbRJpJK8OB8RQORh5ifTnTBV0RSabCpjc
        U1oWnPb4z2iwynpT1/CVYLqem5fW1cOJCPyYQrkLObnxnBZOIS9F99RK9VdMTQl0dQTA3CRUJKF
        KDGIR3VbCOU+uS5GJP/zg76g+ANgbkrKR+bChgzmzBA==
X-Received: by 2002:a17:906:b0c5:: with SMTP id bk5mr1155701ejb.428.1627628219715;
        Thu, 29 Jul 2021 23:56:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylZ3S3p6DxsgjZ/9cTB22EdT6oJK/+hQyLCw8aJEthyQhQ6wGtvZ2CpjES4B9CXlBatvmOMg==
X-Received: by 2002:a17:906:b0c5:: with SMTP id bk5mr1155697ejb.428.1627628219574;
        Thu, 29 Jul 2021 23:56:59 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id m9sm238518ejn.91.2021.07.29.23.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 23:56:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] nfc: hci: annotate nfc_llc_init() as __init
Date:   Fri, 30 Jul 2021 08:56:20 +0200
Message-Id: <20210730065625.34010-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210730065625.34010-1-krzysztof.kozlowski@canonical.com>
References: <20210730065625.34010-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nfc_llc_init() is used only in other __init annotated context.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/hci/llc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/hci/llc.c b/net/nfc/hci/llc.c
index fc6b63de3462..2140f6724644 100644
--- a/net/nfc/hci/llc.c
+++ b/net/nfc/hci/llc.c
@@ -11,7 +11,7 @@
 
 static LIST_HEAD(llc_engines);
 
-int nfc_llc_init(void)
+int __init nfc_llc_init(void)
 {
 	int r;
 
-- 
2.27.0

