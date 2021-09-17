Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6E340F163
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 06:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbhIQEkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 00:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbhIQEkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 00:40:08 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8708C061574;
        Thu, 16 Sep 2021 21:38:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o66so9598572oib.11;
        Thu, 16 Sep 2021 21:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDd/hCzBlERY9F7r0rwYEDf9VwfVw8rUcJGfsqBY7OQ=;
        b=Bx/nhfg9TuPw7VpkWW0gE+INPyv9Zbhdx/pDlQAJMprDBf1gWuJWZWrQwAxhhZGpHh
         oN5In7X03JH0eMjpoCD5OD9MC2FJl36BAKhEOd+9D1jYkcOwKaK8RUlWtBeJalicvDWg
         atwbrau+lrM5hHzL3w4V9MlC4DDVWl7F5g3zSan306msUwNYdjZl/OtDQ437+ANQtSvu
         v/eLP/JDisaw5FJhbnu+5YNtxm4sXWZNq0qNSn+0XE6KdcHZgaesKC/fWDes7MhVlKVE
         7RPxEUVbozlOPLpseWpvw5fW03MTCFu5xEDgqKFMnXypq/TdXEb1I3ZLWHne5rTE9lTW
         KRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xDd/hCzBlERY9F7r0rwYEDf9VwfVw8rUcJGfsqBY7OQ=;
        b=PYJgoW8W0OdJHlaITOJwkwt7pVLzdStDUC2TD9zYmSVcqMmmdfYs483bnVYhQWOsJ3
         iqRe4q/BoIZHpKXcWMXJ3ls12XfCSA7Ltr8TDVojiStGuNIWSfYclPB0DqjRyXXkJOze
         WTmAw5owp45S3bRzu/HBiw/fE0tDkn5ztQrBw+XbJVnV5kOGA/RPwiWsL+qGPKbz4yNy
         4fH8G4SKaSm6YncuTrUBLDG6TbuvySq5dw2iYN6uLA2i/n9C/JzoT1mfkRF189ImIUM9
         7rbHm6ukkMukcr/G1cihXUD08h6eDwwfOLOMnnXEjFsgij2FG7lrIK4Wg4nG/mmZCpyo
         IvTQ==
X-Gm-Message-State: AOAM5303Z9D3xYBaiBwW0RzIpkd7kpPhdlhSQ1YXgF8QviqcsHUViRZH
        c2baxw2HUsKEzPst7EtuUuk=
X-Google-Smtp-Source: ABdhPJz4pDFwXdfmScu1NF3MvoCan9K/PgoUeWr/BLP+iwxIPfs5YUQKCQGB2EarR/FXhH+uQAkuRQ==
X-Received: by 2002:a05:6808:3a8:: with SMTP id n8mr11811934oie.10.1631853526350;
        Thu, 16 Sep 2021 21:38:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z26sm1181615oih.3.2021.09.16.21.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:38:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/3] csky: bitops: Remove duplicate __clear_bit define
Date:   Thu, 16 Sep 2021 21:38:37 -0700
Message-Id: <20210917043838.3514789-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917043838.3514789-1-linux@roeck-us.net>
References: <20210917043838.3514789-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building csky:allmodconfig results in the following build error.

In file included from ./include/linux/bitops.h:33,
                 from ./include/linux/log2.h:12,
                 from kernel/bounds.c:13:
./arch/csky/include/asm/bitops.h:77: error: "__clear_bit" redefined

Since commit 9248e52fec95 ("locking/atomic: simplify non-atomic wrappers"),
__clear_bit is defined in include/asm-generic/bitops/non-atomic.h,
and the define in the csky include file is no longer necessary or useful.
Remove it.

Fixes: 9248e52fec95 ("locking/atomic: simplify non-atomic wrappers")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/csky/include/asm/bitops.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
index 91818787d860..02b72a000767 100644
--- a/arch/csky/include/asm/bitops.h
+++ b/arch/csky/include/asm/bitops.h
@@ -74,7 +74,6 @@ static __always_inline unsigned long __fls(unsigned long x)
  * bug fix, why only could use atomic!!!!
  */
 #include <asm-generic/bitops/non-atomic.h>
-#define __clear_bit(nr, vaddr) clear_bit(nr, vaddr)
 
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
-- 
2.33.0

