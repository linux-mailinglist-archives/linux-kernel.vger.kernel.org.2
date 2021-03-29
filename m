Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2EA34C2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhC2FQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhC2FPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:15:49 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7722BC061574;
        Sun, 28 Mar 2021 22:15:48 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z10so11358272qkz.13;
        Sun, 28 Mar 2021 22:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0mxrCRYxbdpGTxzocLinHk/RHWK9oHZPF1XXCFK3tI=;
        b=bOu6FBSvoV8FDtkbsGqzZ/hWl5xmE0GXIxxNeo/a2a5SPF0jQBsqF5IdcJdPRo1nqx
         1CZm33WrFNV0A78hZHR2LtGDlB5q5fFMt+RCE8BtmZphF9ezxtZ7dpXQScERNqQGPK2K
         BzIhiFMsARkeFdPCMpVUgDnKmN52FmZgEVVVfGHGXJ5DZwyn5xbHNWtwkS5RqZf+SOIQ
         sdbt/ACkDu1/r3nn0iy6E61mQP0wM5F1bhxOFt0g3CffOBdoy8xfCh//CxsjOhyWFFy0
         2cYSVLJtBnEbWnEySVu+4eHnxR1xJDgZ8jyazSaZJRjl1DxAt3syurdSO3gcAjBX2YwF
         T3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0mxrCRYxbdpGTxzocLinHk/RHWK9oHZPF1XXCFK3tI=;
        b=PJbhGG5/A4WKm7YCWbSEu+2606D8E/P+vQrfWGVSx/5z+L8j344bLN5gjIbw3/Kyd1
         anBhWvWt6uUFZ3zEv6Pax3JSzcqUJ5DBmRttIZInTst+ec8T8QP5IwnLhT7TADmi7f7x
         9eOC/4ipjq/IxlMRXIDcRtPSAjprAx6E7tU7zImBcrHS8yJyL1kl5rzRAI6SJdObQOEm
         rL3apYqfwU9EdlquqrqWtHKPZNskwXNhHeF9Q0O8p1325QbSsbO4eCRGbKRGTlcUE4TP
         DhPWoD6qXbZCzhl9ckJO28E5GD7/OC2FtSVUf6PpHMwlxJ0D7OtSrS08i12US39tK/fq
         1Z2g==
X-Gm-Message-State: AOAM532Wnk26YwGRnp/H68f1uNxbSO/zxKQu3/k4xSnIlTkws33VgfGj
        iw7XqdKyOB4FKAZAnNln8+I=
X-Google-Smtp-Source: ABdhPJw+wKXiVHau97MsCTextd929B5sWjkQLLmpENXhab15CfN4sn/tGd0bHg5yHoZ5wxuiW+DhOg==
X-Received: by 2002:a05:620a:a8b:: with SMTP id v11mr22776476qkg.414.1616994947789;
        Sun, 28 Mar 2021 22:15:47 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:15:47 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/23] vm: hwpoison.rst: A typo fix
Date:   Mon, 29 Mar 2021 10:42:43 +0530
Message-Id: <74382472c305bb6d8e309327ed0ccf823a6dbebe.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/focusses/focuses/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/vm/hwpoison.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index 727f080073dd..7840463a0e9a 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -19,7 +19,7 @@ To quote the overview comment::
 	hardware as being corrupted usually due to a 2bit ECC memory or cache
 	failure.

-	This focusses on pages detected as corrupted in the background.
+	This focuses on pages detected as corrupted in the background.
 	When the current CPU tries to consume corruption the currently
 	running process can just be killed directly instead. This implies
 	that if the error cannot be handled for some reason it's safe to
--
2.26.3

