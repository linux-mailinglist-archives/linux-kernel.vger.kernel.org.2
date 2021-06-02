Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AA43991E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhFBRrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhFBRq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:46:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD17C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 10:45:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l1so5089867ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=V+ujQUElFdPvyySutDIS2BMJiANhFPiYP2AfmTZQYCQ=;
        b=MoxBwVunlvc5WExf5U8dAGyX5mGVBbaXvRq7g6sVJYtSZ89Ly9FKNQX8eVoJrEiDHx
         yu66/L60MpSbu7J7dTAnd5OI/J1TqbpjBjzMVhLjfpMHt0Jxz9YpFQXVuJSUhdS8hrWE
         44tjcxv/LYwksH5QUCs0J1kU9hV0+6bAaA9iY2DAhxiudEVha18h098t1gQJoGyK7ROr
         0K49RUYGi9OVM3a1Wsj8TYM8Sk09ue6WvGdT5jaZPSpkydDHVc5Hi8Kcake4JHppFqmB
         ie6RVmPQf3iG06n3pHi9UH9t+8cF0c1Kg1P7uD6mMBnP6KyGK9q+RHJ7X8X+O1gWVnS9
         Uo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=V+ujQUElFdPvyySutDIS2BMJiANhFPiYP2AfmTZQYCQ=;
        b=F+faOg+MkrCouPhw1tXIqt+CGd9I1gaq6DeMlUsNgQZd6awLCG8rfw1SCK5A8sL7ku
         z1t8bLSEQU2IngmTp3E/qwW+pMPmT3aS/zSB9PJ/WHTJgvozEBqAd2z/v/9lp4JJa+R/
         YS0bl3LDfO8WdwjX1fhTxSsplEt9BsX3ZaroVi+PmCEdztfiR+iF82hnWe8lp4Z+/aA7
         +AB9ZSFfYVVLhO5O/zdDBHjoV2RADgi+WLLuW5yEEFUvgm9nauwO8TQHq7sRUwLXUT33
         ceRIcSFKv0CEVX3VkWXYx5hDcjWBRee3mpm+qWUCy2WB8tM9tD/cyvrdIxRps73C/bq5
         bu+Q==
X-Gm-Message-State: AOAM530wDwOuzUQBdPQtMT/BcU0tv5UVTW5MfEFr+jKhK7VYcAii/CQP
        L652/WWuFqZXS6lE20Datbc=
X-Google-Smtp-Source: ABdhPJxi+7Cy/pwbPaqalxY+ZPbeFwdQJPHqs8BUSDrs0dl7Sm3Ac4yzGCwapULMRbWGdDsQpSNDkQ==
X-Received: by 2002:a17:906:c1c5:: with SMTP id bw5mr35268384ejb.552.1622655899492;
        Wed, 02 Jun 2021 10:44:59 -0700 (PDT)
Received: from gmail.com (563BAF3B.dsl.pool.telekom.hu. [86.59.175.59])
        by smtp.gmail.com with ESMTPSA id bh3sm348149ejb.19.2021.06.02.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:44:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 2 Jun 2021 19:44:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI fixes
Message-ID: <YLfDmYv1VSoaaVpq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2021-06-02

   # HEAD: e169fba4f464760dd9734c9e39e1c2e88e374f32 Merge tag 'efi-urgent-for-v5.13-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/urgent

A handful of EFI fixes:

 - Fix/robustify a diagnostic printk
 - Fix a (normally not triggered) parser bug in the libstub code
 - Allow !EFI_MEMORY_XP && !EFI_MEMORY_RO entries in the memory map
 - Stop Risc-V from crashing on boot if there's no FDT table

 Thanks,

	Ingo

------------------>
Changbin Du (1):
      efi/fdt: fix panic when no valid fdt found

Dan Carpenter (1):
      efi/libstub: prevent read overflow in find_file_option()

Heiner Kallweit (1):
      efi: Allow EFI_MEMORY_XP and EFI_MEMORY_RO both to be cleared

Rasmus Villemoes (1):
      efi: cper: fix snprintf() use in cper_dimm_err_location()


 drivers/firmware/efi/cper.c         | 4 +---
 drivers/firmware/efi/fdtparams.c    | 3 +++
 drivers/firmware/efi/libstub/file.c | 2 +-
 drivers/firmware/efi/memattr.c      | 5 -----
 4 files changed, 5 insertions(+), 9 deletions(-)
