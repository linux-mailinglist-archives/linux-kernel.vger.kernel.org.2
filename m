Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600EB456E55
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhKSLkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhKSLkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 137so4670111wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXhac0vmd2nPRIQAbZGGksGdc5x+URB0Z3FRwhT4Sdk=;
        b=qVtLNbXjRUq6xsug9pQIrD+QZNFkvo5G+60a3HFyLn8jKHQYNQVUSJjr7waPN3BGc/
         x+W9hVtfNXkS+0Bxp+uDYu1GKfgtfNhv9tis40jpEhrCe+dObRiWi8bqMpcJfWA23rpR
         qWPxhv37kYT4RepiVRTrV10KshTSmOnx3RxTUUW7sCXsVwqyhT65WPnc2GltmR2PLzcZ
         z1+kY9GLwH/vlbXWCuz6UepE+i7tQkSlKd/pCX47SacP7QRO5eWrHDXkeAYhvfVNfHZU
         UKz+ATOdmj9WSCW7n5+Y3+q8FnylF15GgRrOMeDu9S6plDR5NEu8X+qx1NX7nXFqc+AP
         fJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXhac0vmd2nPRIQAbZGGksGdc5x+URB0Z3FRwhT4Sdk=;
        b=BX0Zr0L8NqXqL73+mbaZUHjWVbgQ2JWfuvxj0DMWRUIHz0WGYXZ1/ZeopaQCslQKCm
         QFHBALCTfjlQC9AmiuPvdThMsl/+py8iGBqavoBzr2b1NoJptXlBb6YUA+r+zCbmyWe0
         82SFs7ASOs8lSrDKSuUJIJekblX3HCaPpC7dEwFim+ZlU38VOaQUnHJ/EfCjJDt/oFvy
         s4iq3o5oimWsd8z1XRzpiIZiRoSE9x64fjtahGJlIKwaZQJpGH0VMqTLSur4tKlWarBs
         b5fdfk0fu2FYuhV8HQjK5KvX98D4tX0kjJXu44+vq5Jv+hTfZV2dI8fgkNYvY6GfN0kU
         Zjvw==
X-Gm-Message-State: AOAM533pLbMMhjwR+H8yU0GBdSe8hCt7FqP7sC1UfppRDXwA9l61Cl5Z
        GEpehVhbTVGr+DUxKb5w6E6JXJ0G7S6/3Q==
X-Google-Smtp-Source: ABdhPJy6hYeRvf5yNgekZLiaE/x5KpzPUAPbpNlqbByxyYF/Gd/vkx2p7FbLFr1G9hzAX2FWBcnOZg==
X-Received: by 2002:a1c:a711:: with SMTP id q17mr5892695wme.158.1637321828955;
        Fri, 19 Nov 2021 03:37:08 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:08 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Corey Minyard <cminyard@mvista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 01/17] linux/container_of.h: Add memberof(T, m)
Date:   Fri, 19 Nov 2021 12:36:29 +0100
Message-Id: <20211119113644.1600-2-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many xxxof_member() macros make use of the same construction
to refer to a member of a struct
without needing a variable of the struct type.

memberof(T, m)
simplifies all of those,
avoids possible mistakes in repetition,
adds a meaningful name to the construction,
and improves readability by avoiding too many parentheses together.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Corey Minyard <cminyard@mvista.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
---
 include/linux/container_of.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 2f4944b791b8..199c78a3bf29 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -5,6 +5,9 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 
+
+#define memberof(T, m)   (((T *) NULL)->m)
+
 #define typeof_member(T, m)	typeof(((T*)0)->m)
 
 /**
-- 
2.33.1

