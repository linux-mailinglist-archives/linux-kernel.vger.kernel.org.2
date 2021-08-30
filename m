Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38AA3FB3A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhH3KLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbhH3KLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:11:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE21C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:10:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ia27so29939901ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=En2oiBi9kPrtUy0uJinZTaYdUdnckwgx9tp/T2mXg2o=;
        b=c+Z4yomMG8koOEkgkljTr7ZOuIr2oZZ8xfvvduHH4+FcG8pkloKBoP15w7xDJRI5Ux
         GBW0kUXf3TNbce7wrdw91Al7+y7cBcQuW6bg4fpSKEHdRev/n9AzI1mzRUu1nsNtmYSj
         AB5uW1A8vnxn2g34DRY0YCp4JgnXySXr5eGb16IAduslb9/HaKs24yIANoTrBlRFSYCk
         NDUhSCCYOP2CRuLjWkV1DEjhA6qg4+0rAK2KMrSmfh/XXJHqPL5iQJUh1uLK2h3HsGyL
         jXH1Vz2Mb18L62PWrhoY4trpK1ii0C/cwSnjPP7bHSwT9EaNUwg/DECmieyfBhVaTpJM
         9dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=En2oiBi9kPrtUy0uJinZTaYdUdnckwgx9tp/T2mXg2o=;
        b=AFYW41VmXH5L6hBrxYaux6OtzUE2K0Sc4O8STz9cgvz1K7+q7iOGVCDxWanFXpDPtJ
         eoKe7xRuIMqge6ezgiKklUnaQz+y1AD+v3PKU2OeiLOXYmWwOxkGSMDp3QaQI12oIVvF
         aO/46Yh04Q/4wbwc0cK8cgKWOy2o2BCJrWiQsyXPjhHvb1m99zXUJkP69v75o/46X9NT
         q9J58bJgjmA278964Kk9SUve4WiMV9TNjP50uda+2Qp7oFDpMEvcxUOEAj6Z2DSIncV9
         Ti7FO2FeXvdFftyZ5sf+rqlYsoYO2tqzbGKkTSCUGf0u9IsbAK7TUnDkfG7Q62Lls/OY
         aD7w==
X-Gm-Message-State: AOAM530iljBJHrrHyVb+39kgzgZKXTwWlgHw4KWbkFuNdLVf60gw9HQL
        eu1eZH0zIzGrEnjvCRfZzLQ=
X-Google-Smtp-Source: ABdhPJy4ki5+hJhNzffkS25xsIFR8gOMzkgGf1pt6mf26X1fHBzSYXeWeFnPdmWjnwa4saXwVjo23Q==
X-Received: by 2002:a17:907:aa4:: with SMTP id bz4mr24420879ejc.97.1630318213855;
        Mon, 30 Aug 2021 03:10:13 -0700 (PDT)
Received: from gmail.com (0526ECFD.dsl.pool.telekom.hu. [5.38.236.253])
        by smtp.gmail.com with ESMTPSA id j14sm7575446edk.7.2021.08.30.03.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:10:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 30 Aug 2021 12:10:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI changes for v5.15
Message-ID: <YSyug0TnmiHyhHEZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2021-08-30

   # HEAD: 1be72c8e0786727df375f11c8178ce7e65eea20e efi: cper: check section header more appropriately

A handful of EFI changes for this cycle:

 - EFI CPER parsing improvements,
 - Don't take the address of efi_guid_t internal fields

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Andy Shevchenko (1):
      efi: Don't use knowledge about efi_guid_t internals

Rasmus Villemoes (1):
      efi: cper: fix scnprintf() use in cper_mem_err_location()

Shuai Xue (1):
      efi: cper: check section header more appropriately


 drivers/firmware/efi/cper.c                    | 13 ++++++-------
 security/integrity/platform_certs/efi_parser.c |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)
