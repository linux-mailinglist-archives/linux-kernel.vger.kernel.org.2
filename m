Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5103D815C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhG0VR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhG0VRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:17:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4371C06179B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:17:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so6755524pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9wMesWb3kMvGhORYmMr8FR6o9+jwEvZSo1EsZxY8W0=;
        b=BN7P01Ur0nT1MgFEaFehSRb7jJppIMvpuqQP+s+oBiWS7VXbf/RvYexr0Hx4+J+tRF
         ub6d2NuQ/h6uhZ5C5OC3+rwkID8I367GLLdmYSUSQoeXhXVWNYV2m0sd3TTyLfRvYZRi
         tIFkyuHmHnqC70kWh05pztablIQYnYXX+GWGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9wMesWb3kMvGhORYmMr8FR6o9+jwEvZSo1EsZxY8W0=;
        b=F+Q14swbr4LU2jXeANC2DV7bv2lXjHGeKn4gyLV7ZPDJGykOvIf5vK3ddSHONyFjtS
         Zh0wrAFcEkbu5HObDq8zOqdz+0P9TcBj8vONrwohXXWPm/lAfWGjGpu457fPLcYBetZe
         dmOEEPE5G8+VvppxYj2Itwyeu5KI2TUdb1WpUkie2XY7XEEJlxlWOmJ36WUJoAZo31LR
         UmQzoHfTNBbL4h5XanoNK/+uvc2wFF9xH7QQ5na7UNWV5smaTOCXuSnlkO63WZpafrLS
         GmIBw08MGSbHOn3WW509zssGCPPXvv/Xxm11RQaSM1q2ff0UU5nSGqwTNjrBtUxdseki
         c/OQ==
X-Gm-Message-State: AOAM530s8XXuYb01mKpjfLUczQmsipBa80pp0bK0Mfbga46X+WYnkI1H
        fdpu/9OGX6pfr0NLJoI1qsft0A==
X-Google-Smtp-Source: ABdhPJwBzhqNz9CV9N0TSyJ7ZTBhPPhkncXxe8pHuZBIHnuiml3joPIijrND7KmjOEKulsBBdR6JNQ==
X-Received: by 2002:a62:584:0:b029:32e:3b57:a1c6 with SMTP id 126-20020a6205840000b029032e3b57a1c6mr24589168pff.13.1627420620372;
        Tue, 27 Jul 2021 14:17:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lk5sm3712997pjb.53.2021.07.27.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:16:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 58/64] powerpc: Split memset() to avoid multi-field overflow
Date:   Tue, 27 Jul 2021 13:58:49 -0700
Message-Id: <20210727205855.411487-59-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; h=from:subject; bh=EqAYyR61If64Fj2IYKFg3jD8wd3YsI3R0DZAgupjjpE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHON8m2NPAIDr9Q/N7SXLMGlDKKJPMFM5SUAuhto 7+vlDg+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzjQAKCRCJcvTf3G3AJq+CEA Ca4qR9dFfukeDpwBivSWmdN4IXrLxxds4i79tyF2RZ1NetlF3zQFjf0dOJJ6NfqCZjinnNwHjnPaFi 9x4UwneOOuPj/4rf8k7cSpmM2UreUaAAA8VP/jFKg8vdwSBqelmbZjm8ng/qha6pxe9jqRvhE2RWKP qnrUYIUXlqe7N3FgL/8eOB67y/Un3Rfqu05z/doNPDcGWYTfIhpaZu3n+amLx44YduL03EwcMECH/l NDarqGZ78zXiW9XBAw38H8M3+unTerG5RPPulpFMa3XJ+hy0ln0RAD/CKthoOCrGmjVHEls689FYmk 47Xi02bCJdYfIgjqNVNZcc95yunNV29nLCcUCjqRA9qZpvkMrJWQANAATLtxAcI+/txMZUwS94jUFC otBX6K+dP0tshHI5p9QXMMjeOFJUZsvIm5n+eNLtqZADzbxH5992mbjlaJZzSynXuRU7LnKYFwp99u ACzU3xk+GoPHSQbfn0SU7L/H8QNlNuzxIiWmgfUKY2AXa7GfFeO+JPWTK/H/PczC9Or0vmzcwp+j06 gmLqgbtlJS5EyLTqxwdJDfRPF9CCi/hV2nu4l+oo6Pue1qSXQEmcxzqGPzn+HR7xkb5suJeevW+l7Z gDF++XCKaI8rWqYNDAdfLYj6eQLBZMJ8AM/75DxdC9t3gUyhjbCYaLueTqow==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Instead of writing across a field boundary with memset(), move the call
to just the array, and an explicit zeroing of the prior field.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/macintosh/smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 94fb63a7b357..59ce431da7ef 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -848,7 +848,8 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
 	cmd->read = cmd->info.devaddr & 0x01;
 	switch(cmd->info.type) {
 	case SMU_I2C_TRANSFER_SIMPLE:
-		memset(&cmd->info.sublen, 0, 4);
+		cmd->info.sublen = 0;
+		memset(&cmd->info.subaddr, 0, 3);
 		break;
 	case SMU_I2C_TRANSFER_COMBINED:
 		cmd->info.devaddr &= 0xfe;
-- 
2.30.2

