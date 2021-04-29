Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC83036F16E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhD2UwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbhD2UwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:52:05 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B3C061344
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:51:18 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h22-20020a05620a13f6b02902e3e9aad4bdso24607502qkl.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Or34t9xNkasHEVB+RIcYh+c2ArZJTq9tqpVTRgs5Qhc=;
        b=qQTUPXh8PbZjsiPRcb25RIzV3VKbCt4CTsOEKgachSgD7r6bFSGas6y60WoGPbLKbL
         GhHwlbbMwxTNkHS4AFI7zA+XYFJIqPGfkbE2QCkrNFYgc4mVTtmLMpDeysTmM8roi6q8
         5BP1qHcnhMwrwiSBIlmgOk9tjUczYtwgwKtqZnu94O9/+tj6APx5wHcK6/DpHzOlDB8o
         KJcbvkHaygGTptIdKQ3L/OL4gMNrjEZUhEXylGcvFhJWCYuUxPE9Qx2gfjGkSjlc+OvK
         Sc9HQ9JYmwYF8Dis3MYvndvoT2IOPmG90lkb7LHpSWuqUToRZ/wvjQivnz9/5GYN1vG6
         Hu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Or34t9xNkasHEVB+RIcYh+c2ArZJTq9tqpVTRgs5Qhc=;
        b=EsklOIxqYMA4/yQC7CZM3h4qBKgEOpe+xNfESzvDPGY0PDw5mnkOvkUWyyknGOAtLb
         zfUIJV1Cr5AKaEdbjZ9oU+Vo6jZoCNIAj/JRYBFamJYnCoGT2B7M5EKwn/xn5cyQy2oN
         /xZR0VSprsnEqzQQrBWso1ae0AwUVflJV5D4Z+DcoL3jfega4qCI1vTHBLjkiI8FrfcP
         HzPR7sxyx+YfzX+N0Luh0iARKSikBUyTswHR91fJP+em79ynq8ivD3VOus+ha+y1H1rH
         +lRE7LonfTGyc3r+ljJ92EVqJ+U4+tTMSpPqGADWRinymDbJCCQQLNKlWRNHZEyynoJF
         N35g==
X-Gm-Message-State: AOAM531aj2Xi4z7IMsxLa1dLn8erp00rrBi0wLPi8NVmTeIaiuhs/mhy
        jClM6B3prVX3EQVTcb3HGTUzXST+vyAqUjeHBrLnTQ==
X-Google-Smtp-Source: ABdhPJy2sPuUiFl8tQXq8A/BMXxBiMDGpE45ttlPeIxNjf9PihOuGqdKO+RMt5zzhNlcyWEQnRGSpt+QpQAWQgy6LMfpuw==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:bab5:c64e:5a6c:36bd])
 (user=brendanhiggins job=sendgmr) by 2002:ad4:5588:: with SMTP id
 e8mr1698913qvx.10.1619729477203; Thu, 29 Apr 2021 13:51:17 -0700 (PDT)
Date:   Thu, 29 Apr 2021 13:51:07 -0700
In-Reply-To: <20210429205109.2847831-1-brendanhiggins@google.com>
Message-Id: <20210429205109.2847831-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210429205109.2847831-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [RFC v2 2/4] Documentation: Add kunit_shutdown to kernel-parameters.txt
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, sboyd@kernel.org, keescook@chromium.org,
        frowand.list@gmail.com, dlatypov@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187f..fb2aacb29a4be 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2233,6 +2233,14 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown=[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running built-in tests. Tests configured as modules will
+			not be run.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests
+			halt:		halt the kernel after running tests
+			reboot:		reboot the kernel after running tests
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.31.1.498.g6c1eba8ee3d-goog

