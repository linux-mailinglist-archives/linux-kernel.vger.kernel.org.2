Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1F43B80F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhJZRUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:20:37 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34315 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbhJZRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:20:30 -0400
Received: by mail-ot1-f53.google.com with SMTP id z5-20020a9d4685000000b005537cbe6e5aso14068853ote.1;
        Tue, 26 Oct 2021 10:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hWW0ySj1nWGdlJxyeRRqOVJEjSmeEjqAFoipUfzw0Q=;
        b=pdSwhQTs3i+Qv2oVLkXDt4RpBfFVJQgyO7xjJVLtn9Tp7EsQJNfW1BMaBJ79JMo7kM
         vXioPfZvwfkZa/vhPR/gtbAWjAyYqjDWpsAnMLOiN3yatH/qkoudWCGqX475irrg3qLo
         wwk/BevNmEEBGztU367m9Amx65l78F5EY/iNu4PrkLDGxU8axwRzT0eqb0lnS6WyGUqy
         I9Val1Sigi9iF8oRRUtzbDSTVoW3XqYRjUXltewdFfOY1KC9XLcgn2wGl6HOUPIJFyAq
         HuwEC0hJf/nyxShUnt1iXaFWSkY4ZWu8d5q9xXoRoxkKQKo7ivLIyspn3RAB4yUO591i
         uRcQ==
X-Gm-Message-State: AOAM532BUT2Ylf/uSl5KXADVo/WOZnvGumrB2WPWaLsKZj2wp6tM5ZHA
        qt/HBYiJWjHX9idt+9Wf2SETWG3KdA==
X-Google-Smtp-Source: ABdhPJw26TimrRWayhm6ou3Jq7zIrieSAAYTnmRa+m4JN1MlGQd3W/KvLTcBP4vfe9sQFoqP1K/8Dg==
X-Received: by 2002:a05:6830:1c64:: with SMTP id s4mr19877414otg.174.1635268686126;
        Tue, 26 Oct 2021 10:18:06 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id c37sm4894553otu.36.2021.10.26.10.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 10:18:05 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] dt-bindings: Add a help message when dtschema tools are missing
Date:   Tue, 26 Oct 2021 12:18:04 -0500
Message-Id: <20211026171804.2867369-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtschema version check works, but is not that clear when dtschema is
neither installed nor in the PATH. Add a separate check and message if
dt-doc-validate is not found.

Cc: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 8d6d912c6a6a..001b4f62b741 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -9,6 +9,10 @@ DT_SCHEMA_MIN_VERSION = 2021.2.1
 
 PHONY += check_dtschema_version
 check_dtschema_version:
+	@which $(DT_DOC_CHECKER) >/dev/null || \
+		{ echo "Error: '$(DT_DOC_CHECKER)' not found!" \
+		"\nEnsure dtschema python package is installed and in your PATH." \
+		"\nCurrent PATH is:\n$$PATH\n" >&2; false; }
 	@{ echo $(DT_SCHEMA_MIN_VERSION); \
 	$(DT_DOC_CHECKER) --version 2>/dev/null || echo 0; } | sort -Vc >/dev/null || \
 	{ echo "ERROR: dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION)" >&2; false; }
-- 
2.32.0

