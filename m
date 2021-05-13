Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADC837F5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhEMKty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 06:49:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59807 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhEMKtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 06:49:52 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <dimitri.ledkov@canonical.com>)
        id 1lh8tV-0002Lz-PL
        for linux-kernel@vger.kernel.org; Thu, 13 May 2021 10:48:41 +0000
Received: by mail-wm1-f72.google.com with SMTP id r10-20020a05600c2c4ab029014b601975e1so603576wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 03:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kuZkXiug9hdhkwtw393tPFCcAjWKu2EOVq4JY2WC3ag=;
        b=DJRCFgQ9zxZ4bKN20cG9dnZfkcOgve8bSGQcufFtf85s0RmA1e0nU7LDBg2MS1SXUd
         F7rhfmr0/fXU4tarnilyn50fwNGqYZHThw3T0vj0xkwbXv6YB2fqagd1J5bZHsoZgRNr
         wqge1fzx18W53fS3hHHovFLlzvwEVd2/Mo7mAz07ZAIierqocUN1g5XeVDiHvMFqwOpG
         4h1+NQoqLAjRqEBvIhHRQx8WLWem9API4+zTz4I7TyKUoZzRyhvqx2c5Sk64gThD4+YZ
         KMh3qPTUkAfC/QgHG5KFYMkytGPA+a1ShJIklBukU4AmXfNhrHB9JBTOAfFRibRRVgPf
         4nHw==
X-Gm-Message-State: AOAM532rXkwF4vv1Iz91VsXWMZ+TmiE15r8oWnaNuGGIyOY4kQO4FOFS
        3VqKnDj/iVj4v5cYfp9kjEP1N6kyMa5HL2eWI0avQvJ0VKD3cMBo9pezCsIPhQfMgG6Yae0Kbcy
        iRkJ28APNYiBr08q9yh+lSeRQREb78gTZT7DjF46mvQ==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr3205622wmj.170.1620902921222;
        Thu, 13 May 2021 03:48:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiZg1PttR88N5AhNZ3Q7s9Cf+giyBB7Z6cn60s55E/x5qXakwQmFLxiAbOo25RtsizWbLRfA==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr3205589wmj.170.1620902920975;
        Thu, 13 May 2021 03:48:40 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:8449:869d:10a:b1b9])
        by smtp.gmail.com with ESMTPSA id k7sm2522973wro.8.2021.05.13.03.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 03:48:40 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kyungsik Lee <kyungsik.lee@lge.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Bongkyu Kim <bongkyu.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>
Subject: [RESEND PATCH v1] lib/decompress_unlz4.c: correctly handle zero-padding around initrds.
Date:   Thu, 13 May 2021 11:48:31 +0100
Message-Id: <20210513104831.432975-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lz4 compatible decompressor is simple. The format is underspecified and
relies on EOF notification to determine when to stop. Initramfs buffer
format[1] explicitly states that it can have arbitrary number of zero
padding. Thus when operating without a fill function, be extra careful to
ensure that sizes less than 4, or apperantly empty chunksizes are treated
as EOF.

To test this I have created two cpio initrds, first a normal one,
main.cpio. And second one with just a single /test-file with content
"second" second.cpio. Then i compressed both of them with gzip, and with
lz4 -l. Then I created a padding of 4 bytes (dd if=/dev/zero of=pad4 bs=1
count=4). To create four testcase initrds:

 1) main.cpio.gzip + extra.cpio.gzip = pad0.gzip
 2) main.cpio.lz4  + extra.cpio.lz4 = pad0.lz4
 3) main.cpio.gzip + pad4 + extra.cpio.gzip = pad4.gzip
 4) main.cpio.lz4  + pad4 + extra.cpio.lz4 = pad4.lz4

The pad4 test-cases replicate the initrd load by grub, as it pads and
aligns every initrd it loads.

All of the above boot, however /test-file was not accessible in the initrd
for the testcase #4, as decoding in lz4 decompressor failed. Also an error
message printed which usually is harmless.

Whith a patched kernel, all of the above testcases now pass, and /test-file
is accessible.

This fixes lz4 initrd decompress warning on every boot with grub. And
more importantly this fixes inability to load multiple lz4 compressed
initrds with grub. This patch has been shipping in Ubuntu kernels
since January 2021.

[1] ./Documentation/driver-api/early-userspace/buffer-format.rst

BugLink: https://bugs.launchpad.net/bugs/1835660
Link: https://lore.kernel.org/lkml/20210114200256.196589-1-xnox@ubuntu.com/ # v0
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kyungsik Lee <kyungsik.lee@lge.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Bongkyu Kim <bongkyu.kim@lge.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sven Schmidt <4sschmid@informatik.uni-hamburg.de>
---
 lib/decompress_unlz4.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/decompress_unlz4.c b/lib/decompress_unlz4.c
index c0cfcfd486be..e6327391b6b6 100644
--- a/lib/decompress_unlz4.c
+++ b/lib/decompress_unlz4.c
@@ -112,6 +112,9 @@ STATIC inline int INIT unlz4(u8 *input, long in_len,
 				error("data corrupted");
 				goto exit_2;
 			}
+		} else if (size < 4) {
+			/* empty or end-of-file */
+			goto exit_3;
 		}
 
 		chunksize = get_unaligned_le32(inp);
@@ -125,6 +128,10 @@ STATIC inline int INIT unlz4(u8 *input, long in_len,
 			continue;
 		}
 
+		if (!fill && chunksize == 0) {
+			/* empty or end-of-file */
+			goto exit_3;
+		}
 
 		if (posp)
 			*posp += 4;
@@ -184,6 +191,7 @@ STATIC inline int INIT unlz4(u8 *input, long in_len,
 		}
 	}
 
+exit_3:
 	ret = 0;
 exit_2:
 	if (!input)
-- 
2.27.0

