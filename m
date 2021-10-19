Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7B434175
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 00:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhJSWjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 18:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJSWjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 18:39:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAFFC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:36:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p8-20020a056902114800b005bad2571fbeso27070610ybu.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HQ19xvqiA4G2WyV84la3hZZlIas5Up6lbNaE2iEUudw=;
        b=B/CSM0YSuktD6EYoqfLCaVy8RYSOxFuP0LUVkyQMmgw68PXHXLo3DxrzbQ5mRLL2nr
         /qdzIlkxXN2FIcONlsTLfjkmD7PkbzalFbdWvwacSv6jJZIKPhjf05L+wJlFjE7gjQ7t
         T49ezs0mvDidFxLIyN3kNkMGRATB2/m+oBZ0+TRTxNM7gelmXXIxUIR9KZF0czlSX15K
         Mym4TtsKy0wJ1Wtb3WhE+vnxt3SnbL4MMGJhvW35gfslpq06AmhY5wgsJH0EnU08IoJx
         EVob8kREfk7WHcP2BX2giwKq65TeYWhDrdKlmBivU0WwCOGBijbRdLPjTKVi8XCIHcqB
         YNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HQ19xvqiA4G2WyV84la3hZZlIas5Up6lbNaE2iEUudw=;
        b=dPFmZdnLWsz0C2aVhC5L6BdsweyF9d+FGx/o9eC5nFVmqYO/SBPoTZkns4vyCbHQT8
         kENng/HFYgQG5xdcBXVwcIO0vGXXDlmdAm09cFpOJfIJQXcCSb7mcV4PDAIH61xjtdD+
         sLpBtTqrxNv+bxTpPSKJxmrbx1u7zx7tBVS/XNZDcfVzed5K0w2I4cS9/OuJrdpfL7JR
         dOs/hNtk8l2vFIpYHg56xHQRswQKFOzX6/u8SWHXE1QSxK9qtB/VllD8BgraazlBtFU3
         cuw8F+9EztePJZKJfCtSt2fdOeEDPUoV0KcJYJBx215afdwSd8ZW0dLmjUm7CqUKpaI3
         bCGQ==
X-Gm-Message-State: AOAM532cZsa+rn6+C+3IXSqz2AVwm5IuT18ZtOfNOsoFmIhcM0zC8Fgh
        HR/Jj55tq2o2mGCwdtdeJBj4Mzx9jYM5AOydNpk=
X-Google-Smtp-Source: ABdhPJw8gj8UnUkHmA+a6grhu4fCJl80HHw5UUgNvqwL2I3SJpua2zrBe5qXBZBDsTvh4Vd4slK1H5z4bs8Rth4+iS0=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:de0:247b:5157:7c15])
 (user=ndesaulniers job=sendgmr) by 2002:a25:5ed6:: with SMTP id
 s205mr41737765ybb.31.1634683011550; Tue, 19 Oct 2021 15:36:51 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:36:42 -0700
Message-Id: <20211019223646.1146945-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634683006; l=1185;
 s=20211004; h=from:subject; bh=pCnBLq31wEGMpWFMLpVJEj7B9XvdubS5B2YjxrY7RcY=;
 b=NK/adL7rbrI5E749ksLXBr/RwWrOfasC07zBEQzqpMQxkI6l7xk++wgsUS+UenoWWhiacuq+cUtr
 dmVh9lhYDFQkO6VwtrRX3kCcdumJNdCVVW6tWdWz6z9XRqkkZUzo
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 0/4] compat vdso cleanups
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Four fixes for compat vdso, the first three are related, the fourth is
standalone.

The first three fix a warning observed for `mrproper` targets when
$(CROSS_COMPILE_COMPAT)gcc is not in the $PATH.

The fourth makes is so that CROSS_COMPILE_COMPAT is not necessary to
select COMPAT_VDSO when using clang+lld.

Based on arm64/linux.git/for-next/misc.

Changes v1 -> v2:
* Fix binutils version numbers in 1/4 as per Christian.
* Add new patch 2/4 as per Arnd.
* Rewrite 3/4 to use redirection of stderr to /dev/null, as per
  Masahiro.
* Add parens and update commit message of 4/4 as per Nathan.

Nick Desaulniers (4):
  arm64: vdso32: drop the test for dmb ishld
  arm64: vdso32: drop test for -march=armv8-a
  arm64: vdso32: suppress error message for 'make mrproper'
  arm64: vdso32: require CROSS_COMPILE_COMPAT for gcc+bfd

 arch/arm64/Kconfig                           |  3 +-
 arch/arm64/include/asm/vdso/compat_barrier.h |  7 ----
 arch/arm64/kernel/vdso32/Makefile            | 36 +++++---------------
 3 files changed, 10 insertions(+), 36 deletions(-)


base-commit: de56379f21c70196ff18c48790e8e43865893869
-- 
2.33.0.1079.g6e70778dc9-goog

