Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BDE3EFEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbhHRIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbhHRIMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:12:02 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF3C0612A6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:11:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r2so1453247pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjKNkNmbs11EnubKPixQYCj5845xTew9b5PqY/X9Rb0=;
        b=B4jbY3AwUOwVorBvYSTDSgEAo+OLI3PLc8YMAL2NygYivECzZ8TZjampBH0j9WxFT0
         UzBb/82CWddgRp7sM5RThEXv7C8LPJtsJjzGdp/oZ9QuU9eECpNWrDzQdo8XxhbXLT2v
         /z9eJZyocDI4MuDRcPm5yDUVERGo6qZRTYs7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjKNkNmbs11EnubKPixQYCj5845xTew9b5PqY/X9Rb0=;
        b=AMVI+YHF2ie1BuvgIGnQte0K8Rj5ocAtUJ6QEYykLoos0xiqYAkV4aG0IqDkkOUKf5
         1IL6lQTWcTLwwWfbPorK/VoLY5Z3GL82J/bWlYossApQ/xGzm5nA1GTeDi/CUugjyBn6
         LZ1Ok2V96eGhhVJ2ZcEYf50QOysx9Q9lYeUEScfm77Qm/guv01qE/Mw3QbzGXdGbN1Vu
         mlh9HXYSSCIzM1ULu8hfFDk4P8rNtvYnxWaqrkpjdbqAPwsDPQyttM2vLGUFWgfhUPIR
         8dQEb/sytpZhb6REgmU73SVjZQIll61NDsPtdD5mxxd9+aeEwlR2w3QrsZoeVyfugZAt
         Gu7A==
X-Gm-Message-State: AOAM532y6p8SOyoP08BoLGGoChP8D5foIw0ndwoaa+7p1y0xjdVybbtI
        xSEk9nslwi/OhwTb2er1wj1yqQ==
X-Google-Smtp-Source: ABdhPJxFJvXxnOdY4pIto8lwXdwu3BpvMyMn1I7zljYSudTFKME99EzAgwcKKuhyxUVpkreCjOYSZQ==
X-Received: by 2002:a62:7a0d:0:b029:3ce:18bd:76d7 with SMTP id v13-20020a627a0d0000b02903ce18bd76d7mr8097084pfc.18.1629274283559;
        Wed, 18 Aug 2021 01:11:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm6125686pgk.57.2021.08.18.01.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 01:11:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH 1/5] stddef: Add flexible array union helper
Date:   Wed, 18 Aug 2021 01:11:14 -0700
Message-Id: <20210818081118.1667663-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818081118.1667663-1-keescook@chromium.org>
References: <20210818081118.1667663-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4032; h=from:subject; bh=wNcfypC6/+KHDbIj8cU4psVET+vLK2EdMOO+mtjv1ZE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHMCk11+uQJTuNDaPLU8sBgA1/s3vLk+mMKbETDi4 LijsR+SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRzApAAKCRCJcvTf3G3AJoQ9D/ 9FHP7a71jZFs28VBcZ0A0ecihVEG+t2c8snmQ8JKHmPLsyLI3bBjT3qnzkSuBKIBbSIQ6W9p2LGCjD WFLvPmq5QVpfZ0+AvuiW4lIC/PJHv+ks2e5zwolcBspTDBMregbJJnYsAAGHTdL91p90v8eQm6daak tri6Xs6LSejimghQb6JId6n559TY3UEdk4FlMYVyIT5sxE0OpiXvWdfbIa3d1zHNQjXaK5iJKB1OZd 5Tg1NxbZAXKMhq1XyzVrUj9YS0msshMNRbogaR2dzucNkhpFbmMcnpI+WqhcvVmDA33FcDDMTat7Cr 4DismPx2Oy0hWtyOPOMY9JVFZjGrRtq3BlnmVa+MUQY/YN5iPjSWKbO4X0BazOPmfIJJAnUdaiqoxG 1QjBUWgwshF8p2vyxPtFedp2ukOlxxq9Zoez8YbbS2nuRQWMpezkXUCVayiST8NCvhaI5pkUq6CEQU 9GTNr5FsUMuloaBtrt0UnWZ06yT2Z4Y5qQUId0fkJMJpB2oGjDdDc7zRUQhbL5kGho/oJy6Z+Bu7c+ zsFpCv0j37Wh6Xm7MRwNsx8wByH9s4uvlSz+Af+RWjAGal7BEVbJa6XXGXDl3y4p/hVY3JyCqd6I/i dhVpX4ArWlHu1EiSX3QEECAseqznz7M4Kf9FsC+Cn57XM/dNTF413uKAj8lw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many places in the kernel want to use a flexible array in a union. This
is especially common when wanting several different typed trailing
flexible arrays. Since GCC and Clang don't (on the surface) allow this,
such structs have traditionally used combinations of zero-element arrays
instead. This is usually seen in this form, implying a union of "foo"
and "bar":

struct thing {
	...
	struct type1 foo[0];
	struct type2 bar[];
};

This causes problems with size checks against such zero-element arrays
(for example with -Warray-bounds and -Wzero-length-bounds), so they must
all be converted to "real" flexible arrays, avoiding warnings like this:

fs/hpfs/anode.c: In function 'hpfs_add_sector_to_btree':
fs/hpfs/anode.c:209:27: warning: array subscript 0 is outside the bounds of an interior zero-length array 'struct bplus_internal_node[0]' [-Wzero-length-bounds]
  209 |    anode->btree.u.internal[0].down = cpu_to_le32(a);
      |    ~~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from fs/hpfs/hpfs_fn.h:26,
                 from fs/hpfs/anode.c:10:
fs/hpfs/hpfs.h:412:32: note: while referencing 'internal'
  412 |     struct bplus_internal_node internal[0]; /* (internal) 2-word entries giving
      |                                ^~~~~~~~

drivers/net/can/usb/etas_es58x/es58x_fd.c: In function 'es58x_fd_tx_can_msg':
drivers/net/can/usb/etas_es58x/es58x_fd.c:360:35: warning: array subscript 65535 is outside the bounds of an interior zero-length array 'u8[0]' {aka 'unsigned char[]'} [-Wzero-length-bounds]
  360 |  tx_can_msg = (typeof(tx_can_msg))&es58x_fd_urb_cmd->raw_msg[msg_len];
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/net/can/usb/etas_es58x/es58x_core.h:22,
                 from drivers/net/can/usb/etas_es58x/es58x_fd.c:17:
drivers/net/can/usb/etas_es58x/es58x_fd.h:231:6: note: while referencing 'raw_msg'
  231 |   u8 raw_msg[0];
      |      ^~~~~~~

Introduce flex_array() in support of flexible arrays in unions. It is
entirely possible to have a flexible array in a union: it just has to
be in a struct. And since it cannot be alone in a struct, such a struct
must have at least 1 other named member (here provided by __UNIQUE_ID),
but that member can be zero sized.

As with struct_group(), this is needed in UAPI headers as well, so a
minimal implementation (without the __UNIQUE_ID magic) is available for
UAPI.

https://github.com/KSPP/linux/issues/137

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/stddef.h      | 10 ++++++++++
 include/uapi/linux/stddef.h | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index f2aefdb22d1d..c7c5d25ac184 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -83,4 +83,14 @@ enum {
 #define struct_group_tagged(TAG, NAME, MEMBERS...) \
 	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
 
+/**
+ * flex_array(DECL)
+ *
+ * In order to have a flexible array member in a union, it needs to be
+ * wrapped in an anonymous struct with at least 1 named member, but that
+ * member can be empty.
+ */
+#define flex_array(DECL)	\
+	__flex_array(__UNIQUE_ID(__flex_array), DECL)
+
 #endif
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 0fbdf2f711aa..6320bbc90721 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -25,3 +25,16 @@
 		struct { MEMBERS } ATTRS; \
 		struct TAG { MEMBERS } ATTRS NAME; \
 	}
+
+/**
+ * __flex_array(UNIQUE_MEMBER_NAME, DECL)
+ *
+ * In order to have a flexible array member in a union, it needs to be
+ * wrapped in an anonymous struct with at least 1 named member, but that
+ * member can be empty.
+ */
+#define __flex_array(UNIQUE_MEMBER_NAME, DECL)	\
+	struct { \
+		struct { } UNIQUE_MEMBER_NAME; \
+		DECL; \
+	}
-- 
2.30.2

