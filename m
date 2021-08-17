Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470B93EEA15
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbhHQJkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:40:46 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:36708
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235871AbhHQJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:40:40 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 16C6F40CD5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 09:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629193202;
        bh=O8grwwL2ifdZnTVT+NKzhfJJRenRFaKSvMvVvpUkqxw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LY2VJqIbeVoh/lKViIxAuXUvye+Y7VhOvM1HeGB1J6LQSryix5syb14IM5EvNp814
         Bit+YERVKfZP4aRu087WY+Q9EYMhes4c8M2Z48Nbru1mmExa11tWCPKZA4Ggs+w7Gm
         cB9v641QxQbcJPw9AXzY3Y6I+2hrzHUqJejTs828rfH3jbx7EWG0OJWF5vTE7D8LZd
         mJT4R7i6qOukTd9DPvXAuS8Vtj8chDp8YpR/9/5ZpK8Uf2KCifgPZJb4c9aXdeZ0yJ
         140JyDsPQWZ/toMdEa8oOgVbDJSQRrpo5WK9i2UhpJoaB+ropzCjkZOtfeydxyC8US
         0DLPbONcg9Rxw==
Received: by mail-ej1-f71.google.com with SMTP id s11-20020a170906060b00b005be824f15daso1215033ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 02:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8grwwL2ifdZnTVT+NKzhfJJRenRFaKSvMvVvpUkqxw=;
        b=PTY3kjjzJRBmC0tXP4uMNRqkgu0NQN495okymLFByIc5YZ+0Dmwpsl1341z34L2Z9G
         32NwxydJN5h9ci43P4zDALlNcKQge65ev8WWLH5CRIdKxH8mRAo+BurjlOkEGcSEdWmJ
         U3nSBlDdzNtjMdNNeoZfmOid9zimmk6s6kwg51tdFyFHLIVVy4r5+QYmKXPW+3H1Ajs6
         uPUiXzy4YnNwQfZiIDBNz6I82GiCEIUF0bkFbnW9luOIy7EwjcB00YlNBhaLbdGKvBry
         OPXy8IYkhr8Sj/j37E1SSVKr7sdsDPxxc1iPQRUfLoDHNB42giwnPfEGObOg1bwz9xIl
         marQ==
X-Gm-Message-State: AOAM532Y+mswO9V8XtllLFDA3RkppqjJMjyv1uFqX36VdAgIZyCKAb+T
        CuWNbqe9TnJXMZlxkgADQua2Q/G+se1pfsEVfWZoagWzbyRxSGGQf5ek3wsmzY6jO5SIZFw+A4F
        y+VQXMMBzQ8NapTpUgVcsPk0fZ7IlSVbDxE8L6eMp+A==
X-Received: by 2002:aa7:cace:: with SMTP id l14mr3209275edt.14.1629193201826;
        Tue, 17 Aug 2021 02:40:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPaN9/+Xh9sugyxx4rCADXIJl5PW2HMz+txn6kA9UaH5J9NRz2BaR5d40ICG4bM9PnLwqk4A==
X-Received: by 2002:aa7:cace:: with SMTP id l14mr3209265edt.14.1629193201687;
        Tue, 17 Aug 2021 02:40:01 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id sa21sm515667ejb.108.2021.08.17.02.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 02:40:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jan Luebbe <jlu@pengutronix.de>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: EDAC/armada_xp: include dt-bindings
Date:   Tue, 17 Aug 2021 11:38:07 +0200
Message-Id: <20210817093807.59531-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
References: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include dt-bindings for Marvell Armada XP SDRAM and L2 cache ECC in the
EDAC-ARMADA entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index be8e4af8ed64..ec75414db0ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6574,6 +6574,7 @@ EDAC-ARMADA
 M:	Jan Luebbe <jlu@pengutronix.de>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
 F:	drivers/edac/armada_xp_*
 
 EDAC-AST2500
-- 
2.30.2

