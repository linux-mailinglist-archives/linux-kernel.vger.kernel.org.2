Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D916E457E99
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhKTNEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbhKTNE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4417C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u18so23185041wrg.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SH+Q6LojGu7UgEpjLXhweTjmFMPk/2HTazX3kWWC7Bg=;
        b=ccfoHwAGmUL48MJqxtgO3zUsE79pMzPk9aCKl/vJ3NyNLkgF2CAi8vqtiaaMKn9YQl
         Vzq7KV3Ah3jXTIEASXH/16011ye4uQ4UucoDFrBKTrGKhiwrginEndBaAIduh3T6EiR0
         ASd1AfhDJAx4dMGtdxYFKcoc21mW7CYgvoGGL4GnW/zbkrdgpyvvW2RMMI8RWwFk2ITD
         NLBmaMGuXpXc/EStlclmqfdm3uVNAIHHHGT4CRQ/9M0vFli1IdQdmb+xqJ/8pTjAD6VT
         tBdL52UsAdgH34YX+iaUQnrkpDLRWWT0+zzZm+JBlIJ6kVLyPcOsr90RvWxIbnlru0ra
         D4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SH+Q6LojGu7UgEpjLXhweTjmFMPk/2HTazX3kWWC7Bg=;
        b=DxNoaQFeWb31Z9VVqbBQg3WgkeNMn54/hTqbIzQM7Va0nfnCmNqf7sbOOglTdwB5BT
         IiYkG2pycOqL7T68uZjvKGGtxHsCQkIytbl1jPxUimP1LSjvUOFXIhlCro9KeZ3jzYz2
         6t33gS8xKHON4oJKfEtq9D7alPv5JwH0CyWtNnW6GChyxZhyUSsRzlfaNFdF+wEZlHcV
         4jalC2g02F6QNDQdfZ0/S3YZhYhn9YK80e/8tlNBArNY+wYzJr2s/5zFmyLXdlj1+/ZZ
         HrW0EPSOYoulOKnQdJHigjRPO8hXkSVnFC3uS4nMZsZLW1rYRfaCADsFET2nGzNf00+Q
         dHEA==
X-Gm-Message-State: AOAM533g+IyvclS1IEJY4qAqBo1JyOeQf+bZ7eWDsvDlOtuAuKf2PTcx
        yYD79zxeqtfGayirQdOZb2oVVtryy1G/Eg==
X-Google-Smtp-Source: ABdhPJw7TN9aaX1jB5CVXRFjPif7V9PDbcEZs01yfU8uXp9hAxmlIhN2z/DTbB74e3F9NN6XbP33nQ==
X-Received: by 2002:adf:eece:: with SMTP id a14mr17992223wrp.333.1637413284473;
        Sat, 20 Nov 2021 05:01:24 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:24 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 07/20] linux/memberof.h: Add memberof(T, m) macro
Date:   Sat, 20 Nov 2021 14:00:50 +0100
Message-Id: <20211120130104.185699-8-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(((T *)0)->m) if a typical construct used by some wrappers,
and also directly in many places.
Write a macro to encapsulate that construct,
and avoid repetition (and possible mistakes).

It also helps readability by reducing the complexity
of mentally parsing so many symbols together,
with a readable name.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/memberof.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 include/linux/memberof.h

diff --git a/include/linux/memberof.h b/include/linux/memberof.h
new file mode 100644
index 000000000000..6d8cb3dabbf9
--- /dev/null
+++ b/include/linux/memberof.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MEMBEROF_H
+#define _LINUX_MEMBEROF_H
+
+
+#include <linux/NULL.h>
+
+
+#define memberof(T, m)  (((T *)NULL)->m)
+
+
+#endif  /* _LINUX_MEMBEROF_H */
-- 
2.33.1

