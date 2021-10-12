Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E9442B08B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhJLXs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbhJLXs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:48:26 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDCEC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:46:24 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w10-20020ac87e8a000000b002a68361412bso783584qtj.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=U1CBuwTvctaYUlQJhZIppI9ILyM5IxB5cbt7UE9WsqY=;
        b=OSXAr37CFli6hdER8dhZKrAe0g0va7VrU/6C3pfS6bZYyesWzvxQw545v2Yz9Pgc+r
         6HQkzMenAvbRIbO+IIrHmDOeN1b8XIJaeKHiulsk6zDy1u8SQTp23lqzy9Ezbx/l0zdZ
         x1a5dT+3iCs2WIsnXsqEMSBXRI56rjZ9YiH+H0t2eD0anXIicY4dn7DsXbKTdL5atUYp
         99VHdz3+OH/drwGUdFuQppxPIrtk0FbLHR+sjBMRQy3fQchBRiL/E+qSIpa+Q+Gzj0fm
         63c2whJ59wPRHe2ModiqsDZYyFzE/rovMwrsBF6E/NOLAxAmOz2AoNgHsHGMH2sj0nAE
         hrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=U1CBuwTvctaYUlQJhZIppI9ILyM5IxB5cbt7UE9WsqY=;
        b=ufIe9UisQJMBGQX50gpSfScOgldSqf5D1a+sXFHLNIEoxKBRYhDg8aPnZf5XbK+vam
         +978lahLotaLWi32ZjvI8MK9AtmLvK9qlP6tJon/VhovNw9FPJLkDtlbDPHAjVd+T1SU
         ScbwP0JBZWkGoWVVJa0FdZ7p0T9WmhhdP7b2dYfOGomOPtiJPJMVdhcyZcczEmB8Ca/9
         xeYFfb/3Z0U4ZoizA5iFgYAK9ZhIMUr/tYWCgku4FauLR/v6apq1hy/RVPg+wn2NqqUz
         TV7xnPmLl+BFHtWgrGHAPIZ8F9f2kkpI0s0keN2DIRYD5PBZIH3B68lzPjKrrUmWZ/d4
         1SYQ==
X-Gm-Message-State: AOAM531AX0ddT7T06wUjB3YPigulUTT3WovbZyA6pAIg5ZYoEOZC19/B
        0T4cdhmir0K7D1jznid30Alsv0FMSJu1C2a3nGg=
X-Google-Smtp-Source: ABdhPJwFJFZTxamtNTe57wwrUCI8q0lOwHN9rjl8tqB//Wb8EHJ7CsLVhYYvxb32TE+NYnY5KAdX5Ts4ad+rdVgDB2E=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:9b44:962:5897:17c0])
 (user=ndesaulniers job=sendgmr) by 2002:ac8:7c96:: with SMTP id
 y22mr25820433qtv.338.1634082383291; Tue, 12 Oct 2021 16:46:23 -0700 (PDT)
Date:   Tue, 12 Oct 2021 16:46:03 -0700
Message-Id: <20211012234606.91717-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634082365; l=859; s=20211004;
 h=from:subject; bh=g3CBsvmGQbuOYnCD8e3MLFwlDDGe9HbIj3f8iC/Hh/s=;
 b=PgfEWmno8ql8mPhYJpHZoIzk7yY9SH3UKBR5mlpy2uh4OOOeVfmJR0VHB4XCATUsta9Us6DdJRUy
 UD+2nr3mBYXbBuAEIc0tINg6Wq6or+VSndHCgZ4nSboOdFC3wfVu
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 0/3] compat vdso cleanups
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three fixes for compat vdso, the first two are related, the third is
standalone.

The first two fix a warning observed for `mrproper` targets when
$(CROSS_COMPILE_COMPAT)gcc is not in the $PATH.

The third makes is so that CROSS_COMPILE_COMPAT is not necessary to
select COMPAT_VDSO when using clang+lld.

Based on arm64/linux.git/for-next/misc.

Nick Desaulniers (3):
  arm64: vdso32: drop the test for dmb ishld
  arm64: vdso32: lazily invoke COMPAT_CC
  arm64: vdso32: require CROSS_COMPILE_COMPAT for gcc+bfd

 arch/arm64/Kconfig                           |  3 +-
 arch/arm64/include/asm/vdso/compat_barrier.h |  2 +-
 arch/arm64/kernel/vdso32/Makefile            | 33 ++++++--------------
 3 files changed, 12 insertions(+), 26 deletions(-)


base-commit: de56379f21c70196ff18c48790e8e43865893869
-- 
2.33.0.882.g93a45727a2-goog

