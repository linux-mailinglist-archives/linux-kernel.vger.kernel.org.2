Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7815D358BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhDHSBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhDHSBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:01:21 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC8CC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 11:01:10 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id o24so1394654edt.15
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E42XR5KeRAoN2g3+y3om4yOJDcpHthzb/pVdZ1Nq0nk=;
        b=ZP0k/DiFREpyUihVD3ELUkH578x3zA/bRYz+PWu1pA2BVRGnF1JE7GExXaazTvofGY
         Y5NTt1zBOssn5pDsq/KxfyrTm7uYXt+mcEyZwm3ggJ/YqjgjP3eSHBVOkwITrqDatnf7
         Iul2VKN1XZm+j9KOLua2FGd3+WtWlf2Tle9wxirmrSnqxAsT4+NRvBCgvUdC3lO6MHC8
         eeTHW5Ds3xy2dxGM5NhUzXpWPbe2c6iymwVq7LJ6coNVjxdOaI9LvfsZrv5gzZ1fSB04
         pa8lKAxXCxJm8YzfoW+yybynFtVejzLeTtq9mT61bBp4tNnPqG8G62gNUbh3ZJKytuwV
         1ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E42XR5KeRAoN2g3+y3om4yOJDcpHthzb/pVdZ1Nq0nk=;
        b=sVSN7+avOpgqusBNFxB8ug2iS0a7/tZHl9QCXMVGp1l5tQ0DmyOV/tZ7aCdXsLFTNe
         0krp0pMIDw17bXnzhIaPKUFWzxOfUlvnnH1ZejN3BhXI9TXFmHVt8oJsHMVLrKVpZjkj
         zMyrLiHCpxJTmdGDLbJdX43gW4bcMbBZjBgAKah+ZvNAxNnHm7l2IknXVLuBOk49CM2g
         V40kGWht27ZfXoGKkL4R/22GCZENFiujmjIQ12ge7H3HecvhGg4xz5HsFodaHIjnv4ov
         UvvEqF8Dr4U86M+lqiXaspYJcfqkahnswBZh9nvXBLI/5jfSO5r3qK5V1HeTAmYEAvGg
         vJhA==
X-Gm-Message-State: AOAM531037KCzdjHobqt5GG6sepIW4rh6KpFYU27e3BhZSIC5Z65Lxvd
        RpnmTtYujh4i4W5NNle5gMjy7HqrN0j8
X-Google-Smtp-Source: ABdhPJzvw32aCQjkBYW8s07dKEC5VMqe580zpFKp4K3xpVcoW47nSi17gGd6UBEaY4BsM19RLTOXeJiPdsTq
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a17:906:814a:: with SMTP id
 z10mr12131886ejw.476.1617904868688; Thu, 08 Apr 2021 11:01:08 -0700 (PDT)
Date:   Thu,  8 Apr 2021 18:01:05 +0000
Message-Id: <20210408180105.2496212-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH] export: Make CRCs robust to symbol trimming
From:   Quentin Perret <qperret@google.com>
To:     gregkh@linuxfoundation.org, masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, maennich@google.com,
        gprocida@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CRC calculation done by genksyms is triggered when the parser hits
EXPORT_SYMBOL*() macros. At this point, genksyms recursively expands the
types, and uses that as the input for the CRC calculation. In the case
of forward-declared structs, the type expands to 'UNKNOWN'. Next, the
result of the expansion of each type is cached, and is re-used when/if
the same type is seen again for another exported symbol in the file.

Unfortunately, this can cause CRC 'stability' issues when a struct
definition becomes visible in the middle of a C file. For example, let's
assume code with the following pattern:

    struct foo;

    int bar(struct foo *arg)
    {
	/* Do work ... */
    }
    EXPORT_SYMBOL_GPL(bar);

    /* This contains struct foo's definition */
    #include "foo.h"

    int baz(struct foo *arg)
    {
	/* Do more work ... */
    }
    EXPORT_SYMBOL_GPL(baz);

Here, baz's CRC will be computed using the expansion of struct foo that
was cached after bar's CRC calculation ('UNKOWN' here). But if
EXPORT_SYMBOL_GPL(bar) is removed from the file (because of e.g. symbol
trimming using CONFIG_TRIM_UNUSED_KSYMS), struct foo will be expanded
late, during baz's CRC calculation, which now has visibility over the
full struct definition, hence resulting in a different CRC for baz.

This can cause annoying issues for distro kernel (such as the Android
Generic Kernel Image) which use CONFIG_UNUSED_KSYMS_WHITELIST. Indeed,
as per the above, adding a symbol to the whitelist can change the CRC of
symbols that are already kept exported. As such, modules built against a
kernel with a trimmed ABI may not load against the same kernel built
with an extended whitelist, even though they are still strictly binary
compatible. While rebuilding the modules would obviously solve the
issue, I believe this classifies as an odd genksyms corner case, and it
gets in the way of kernel updates in the GKI context.

To work around the issue, make sure to keep issuing the
__GENKSYMS_EXPORT_SYMBOL macros for all trimmed symbols, hence making
the genksyms parsing insensitive to symbol trimming.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 include/linux/export.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/export.h b/include/linux/export.h
index 6271a5d9c988..27d848712b90 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -140,7 +140,12 @@ struct kernel_symbol {
 #define ___cond_export_sym(sym, sec, ns, enabled)			\
 	__cond_export_sym_##enabled(sym, sec, ns)
 #define __cond_export_sym_1(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
+
+#ifdef __GENKSYMS__
+#define __cond_export_sym_0(sym, sec, ns) __GENKSYMS_EXPORT_SYMBOL(sym)
+#else
 #define __cond_export_sym_0(sym, sec, ns) /* nothing */
+#endif
 
 #else
 
-- 
2.31.0.208.g409f899ff0-goog

