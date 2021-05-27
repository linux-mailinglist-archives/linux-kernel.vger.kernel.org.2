Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93D392A87
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhE0JTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbhE0JSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE41C06138A;
        Thu, 27 May 2021 02:17:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t193so3240537pgb.4;
        Thu, 27 May 2021 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7E3U/5AhryLclxpfw0wD5x8qTR7kxMBtSVWXSh7TOT4=;
        b=ftfsc0DbCQuzNSpY4OdYMxvIrlOOwGbbOqV4R0PWMIvEUoezU7vcXZN383vMqW6ZAS
         CMZPAHSWotA0/EWvKCBCXT6h3HlxqYgiqRYQP7sTwSsL3FchfZyA28p86+vgSZf0xTBL
         7aR5kpYAFhjVdyzApH0QjU5A4pZHtzyNWPkTfzETvknH/HBcAQ0U4Fr4Tg3NdgSpHyAP
         DELVkzoMWX1W36P29Tfx37G/qnqpa5PRtpFwJwVfBi41SA5uwgIUSZFy27v6fq/ha6tr
         A6Mn/7yJmXYnIAvUqumlEpH+PCpJqAtauxhyNLPo9REdtgIG3MsZUgc712LCvwPhCgHI
         Z+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7E3U/5AhryLclxpfw0wD5x8qTR7kxMBtSVWXSh7TOT4=;
        b=Co2UvDjCR0CGpMMP0BDJHpqMvSn1OldrQRzxld9u7YlwFUKVbNxnHKUH5pQcp4yYNA
         9P7ozoGZCh1EwJLHdlD5j//qaVacN3G0RUdeN5O7ThYcOSwb42mChCUqUax3FbT/TmOr
         yixuUHfOe8c2BHSQIFNlwbJmClXXtv3NJ0ZTk6gmtSn5l6KhVYjmnk2bbmeABggtphTH
         lB0330m/NjuMiUBVQnnOUh5gzwvk+RhJ2j3akKErYiS5M06ei/mYnJV9i49gJum3TTpB
         HUKPSIHrUNAZCl8CpTSn0QZbQ6dmj2v934HjGRtfAxlLfo5pLCI/NWKvF4dQouYTT6ZN
         iyQg==
X-Gm-Message-State: AOAM530+1GIDpgQDRWMmym4td6s+umE8muNTrxTsZcD0wAsFJcj3Uv0B
        PNc9/6KeQvNIP4PSxxVsh00=
X-Google-Smtp-Source: ABdhPJwgtiWDUwUtL/l2g5AWUOdRNSDFZrGUk3wl6R4ZJrPqzvTvF4qkwtORY590B2E1+93+THKLLg==
X-Received: by 2002:a62:585:0:b029:2a2:3976:60a9 with SMTP id 127-20020a6205850000b02902a2397660a9mr2794343pff.47.1622107021447;
        Thu, 27 May 2021 02:17:01 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:17:00 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 06/13] docs: path-lookup: Add macro name to symlink limit description
Date:   Thu, 27 May 2021 17:16:11 +0800
Message-Id: <20210527091618.287093-7-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro name MAXSYMLINKS to the symlink limit description, so
that it is consistent with path name length description above.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 3cbaf30b0f83..40b9afec4d60 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -992,8 +992,8 @@ is 4096.  There are a number of reasons for this limit; not letting the
 kernel spend too much time on just one path is one of them.  With
 symbolic links you can effectively generate much longer paths so some
 sort of limit is needed for the same reason.  Linux imposes a limit of
-at most 40 symlinks in any one path lookup.  It previously imposed a
-further limit of eight on the maximum depth of recursion, but that was
+at most 40 (MAXSYMLINKS) symlinks in any one path lookup.  It previously imposed
+a further limit of eight on the maximum depth of recursion, but that was
 raised to 40 when a separate stack was implemented, so there is now
 just the one limit.
 
-- 
2.31.1

