Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23D830E8F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhBDAw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbhBDAvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:51:54 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932C3C0613ED;
        Wed,  3 Feb 2021 16:51:14 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id n15so1786268qkh.8;
        Wed, 03 Feb 2021 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kiJxUQ1LfmJpMH3ArGz1asuR6L/tew69OdmGsRfnmUQ=;
        b=cls3mXtIZJp+eeXVS7csbRR3IYArotJ3rlJaGxYTcMHf4jJ5yGrmx/U+iP4+0LMsHt
         gwOMvAGIJLh5e9Y1TIpgqG6WK03QhGYImq0nTDQc87UaaSx2wanfBQQw7LWJWM6akw7S
         wMhagk+7CAOIb6lbPRw7eJnBnhzvHG20JHsITVmV7BLrcwNN6scWWUePWrUJnzR4uvx6
         3FaqZ8BnkM6qlXIrw694deK5qJJPMnxYi1u7BpetAHkLQy1aGYeIRmioxfkmX5UaOz0S
         yI9Iw7fMRX2tJveH/jEtcK1O+j8VIrl8H8CG46lBI0J5PF/LbvvcTYSgvn6a7azw7raS
         gedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kiJxUQ1LfmJpMH3ArGz1asuR6L/tew69OdmGsRfnmUQ=;
        b=bkhDChHtH0z/ikSKFuawGaOQpAQ9Kj6ZL72i2QHUSaJPOVKbK3LDkwpe/BRvGp+WjF
         hvuFVBzdDMnAXbVEC6rbrTP6CSq/5aQqiP2+tDE96YGwSskKO6gv4ZkIk+4JubkWrGb2
         2H/0nL1BIhIqoy0WtjTY3/MlmaE/mQsx7c7ZjodhfFUICxxT+qwHi4i82Qz923emtdJU
         QZVm83adeTxgxPIXKDPhbDK69Cb5wfzLFyDmjdho1wz1JZgZf66ECq9kMNVZcOjtNZTd
         trFtiQwiaR0+/B9naWY4pEoEenUmrsQYfLJTr28Vw+WnZxHwuzifxf3q+jB0L6Teqyyj
         fS1Q==
X-Gm-Message-State: AOAM533HWekDmeLKI2YeJLIotQih9yj8SrGIea/uzJnwzxq05xWfcZIx
        3nITeEJb1aAnyYKNXbsKWLeNli4QYsJQ6uHk
X-Google-Smtp-Source: ABdhPJzOQc4dr5HRI+lZ399XNF2V60k2Q3rgxe2JsLxCt2U+efyhUjEDQoIkjP+A78aLwk143SiM5w==
X-Received: by 2002:a05:620a:41:: with SMTP id t1mr5453748qkt.322.1612399873839;
        Wed, 03 Feb 2021 16:51:13 -0800 (PST)
Received: from localhost.localdomain ([138.199.13.179])
        by smtp.gmail.com with ESMTPSA id m10sm3042668qtp.72.2021.02.03.16.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 16:51:13 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] arch: sh: kernel:  Fix a spelling archtecture to architecture in the file relocate_kernel.S
Date:   Thu,  4 Feb 2021 06:20:46 +0530
Message-Id: <20210204005046.21462-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/archtecture/architecture/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1 :
  Missed the changelog text,now included

 arch/sh/kernel/relocate_kernel.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/relocate_kernel.S b/arch/sh/kernel/relocate_kernel.S
index d9bf2b727b42..deda2f60a8f2 100644
--- a/arch/sh/kernel/relocate_kernel.S
+++ b/arch/sh/kernel/relocate_kernel.S
@@ -3,7 +3,7 @@
  * relocate_kernel.S - put the kernel image in place to boot
  * 2005.9.17 kogiidena@eggplant.ddo.jp
  *
- * LANDISK/sh4 is supported. Maybe, SH archtecture works well.
+ * LANDISK/sh4 is supported. Maybe, SH architecture works well.
  *
  * 2009-03-18 Magnus Damm - Added Kexec Jump support
  */
--
2.26.2

