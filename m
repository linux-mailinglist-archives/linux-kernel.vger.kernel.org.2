Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640E0351FCE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhDAT2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbhDAT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:28:46 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52062C041B36
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 12:17:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id o27so3735928pgb.14
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nlEty8FbrPXfEuiwzU9OVAHqfrb/3joIbwaJdu5fO44=;
        b=QSntTpECX8es2vOgpgsVQixFbafEesFafN4Bzaq4712xl6Lp68jJHZTkl1YI177619
         QEKerfpHXNaHIDUo4BJsh5aj285zB/9VcoH1lBKIIiJneIq2vX5upBnfgQa2X+IZK9bQ
         ut9PpEQaCNQgfDmNUQ3EygQyX0QErvgOBAFzNoPBbRSTXozlbZ0sWDOP9h7TMEPZP+MG
         3jehI4bc4N7gPWyM5smNvhfx0L6UfgJMoPMZY6Bo0dsmMTINhiqu/x3MTUinFMBJOqFH
         LfsNqz1HkMyLVX6nLomMGzSoWbqeTscnmuH0A6FqFsxK17PjTMojKJMZ4zdHseqE1krr
         6L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nlEty8FbrPXfEuiwzU9OVAHqfrb/3joIbwaJdu5fO44=;
        b=VpeCX3/rTxzVq3sFWKTBvT/FjSDyEtsArfnvIGZlPzZaiUZx/gSx7dhsmEA2ZF6+Si
         yuumjjl+PwmoNBkvdJW3ayggooYUKQQB1F3iMpmsLDU3W94GesAR8jlG3WQyYHfJlK70
         Cm2WaiXSwxOSB5kYubSRYEjRGf4sYelWrZOgvDsKhz6nbSS6ecvV6WpUWp3adMPt0GY3
         EjMjm0itsMjplpaIOqxj6efMBcAlJgdRHY1S5wY1WQqA7qQ06cMOVYO0sC+Cxnly9atk
         x4n/UHryTAT5p8VIvBR3qg00X1HFH/cl2lFYo3JA8sEctQ4u6Vo2G800f/Q56pM2jvXg
         /FkA==
X-Gm-Message-State: AOAM533cvc+dCQsrQc1tzYibB6nqICz1wCNSc/3qcjf5KkCF1Trb4Lan
        bfYnO8jgYWBv4n4NhJgJPsajqZI9ZTM8
X-Google-Smtp-Source: ABdhPJz+iVbbW+Al8L02mPKFb3osxiJwm1KiVsG7416KcEaTmWJ3FCuEaDnnEeHvkJrncERy0gmFN5EuygRJ
X-Received: from royyang.svl.corp.google.com ([2620:15c:2cd:202:a838:37b3:5242:e2c3])
 (user=royyang job=sendgmr) by 2002:a62:7c17:0:b029:1f1:9ef7:163a with SMTP id
 x23-20020a627c170000b02901f19ef7163amr8859557pfc.51.1617304669075; Thu, 01
 Apr 2021 12:17:49 -0700 (PDT)
Date:   Thu,  1 Apr 2021 12:17:44 -0700
In-Reply-To: <20210330205750.428816-1-keescook@chromium.org>
Message-Id: <20210401191744.1685896-1-royyang@google.com>
Mime-Version: 1.0
References: <20210330205750.428816-1-keescook@chromium.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH] Where we are for this patch?
From:   Roy Yang <royyang@google.com>
To:     keescook@chromium.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com, corbet@lwn.net,
        david@redhat.com, elena.reshetova@intel.com, glider@google.com,
        jannh@google.com, kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, rdunlap@infradead.org, rppt@linux.ibm.com,
        tglx@linutronix.de, vbabka@suse.cz, will@kernel.org,
        x86@kernel.org, Roy Yang <royyang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both Android and Chrome OS really want this feature; For Container-Optimized OS, we have customers
interested in the defense too.

Thank you very much.

Change-Id: I1eb1b726007aa8f9c374b934cc1c690fb4924aa3
-- 
2.31.0.208.g409f899ff0-goog

