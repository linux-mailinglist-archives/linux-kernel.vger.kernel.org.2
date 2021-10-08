Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E61426F63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhJHRND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhJHRNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:13:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A0C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 10:11:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g2so8767791pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3AthuTf7PN9ZAZEaHWQZ0ldOOC/wqL7Dn/PDy+rjpJ0=;
        b=B1UAJ/sJ+GHhTuMIbEtlsAyOveE2v9sAfuhXY9RM+gKd/D6anhABKALwFRGD63J540
         gFi0+1AXqJCTD4clNJ8OmAzWjBJlOMutIrMEsmdC7qRczERxaq7QgZwtQAfat+EeVaIi
         2Kjl6UY744oGRy0D+L7P9nHhAiYFanVH43Psra6SC9AnzjCBF1XjlsdeHIL60E1wlddE
         UNuQqamFXJgcTVNwB2XVraz+Huic9g73f9yHbk6xV1vllhN5CYxXjijiYkmW0+3pdxQk
         Bf30Thm3PhtERma2H6LSWoEVZ+sGZRYEs9QmN19Uztiu/J0f1m9HYzA3eG236gYnnZhs
         XRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3AthuTf7PN9ZAZEaHWQZ0ldOOC/wqL7Dn/PDy+rjpJ0=;
        b=oOSsmfbuK/X16XJAZYnfazmtJ9ORKNJev6eqxq3plh/gcQc/66cnZmRtLAh1E6hYXD
         RMwRWdkTskVSa42EwvqPjB4uZokGTV1VpujAHLmeVz2GqdbnARHgkE6obMhvUItDUs52
         rTXQJsj7nM5EXqQtrnWMUoi0F/MmK7myt4HxSOU7/JRbjCvH1t9QLZHrHTgvdh8FNXVA
         EuivWFWQ/ygHv1byqQ95+QFomh/8PbadjP69DYPCD7Qg0VzhpAuOYX/mj7RYjdN6vXz5
         CYloy/35njmgjQHVzMWjb8EPkJbT8hHowQRLwk4cKOqXnfpIit1fYwePr2l2WaG0B/0c
         iO4A==
X-Gm-Message-State: AOAM531oZkMpK2KJAdedIZgSYH5i67HXk/SruSphpCfGYt8IogJJc4l3
        ODRybWHuuYYQUpWInRRmEIc=
X-Google-Smtp-Source: ABdhPJyucpD1MS7WL5rE2JLQW+Sm33RfXEDRkHsGL5lhdCd6W2CKGm2wZZGY9+QJw9FeorWxwqV2Pg==
X-Received: by 2002:a63:b04c:: with SMTP id z12mr5520411pgo.371.1633713065475;
        Fri, 08 Oct 2021 10:11:05 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:ecea:c8ec:ff7b:52])
        by smtp.gmail.com with ESMTPSA id e14sm3231848pga.23.2021.10.08.10.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 10:11:04 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/4] xtensa fixes for v5.15
Date:   Fri,  8 Oct 2021 10:10:51 -0700
Message-Id: <20211008171051.16554-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fixes for the xtensa architecture for v5.15.

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20211008

for you to fetch changes up to 012e974501a270d8dfd4ee2039e1fdf7579c907e:

  xtensa: xtfpga: Try software restart before simulating CPU reset (2021-10-05 12:19:05 -0700)

----------------------------------------------------------------
Xtensa fixes for v5.15:

- fix build/boot issues caused by CONFIG_OF vs CONFIC_USE_OF usage
- fix reset handler for xtfpga boards

----------------------------------------------------------------
Guenter Roeck (1):
      xtensa: xtfpga: Try software restart before simulating CPU reset

Max Filippov (2):
      xtensa: call irqchip_init only when CONFIG_USE_OF is selected
      xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF

Randy Dunlap (1):
      xtensa: use CONFIG_USE_OF instead of CONFIG_OF

 arch/xtensa/include/asm/kmem_layout.h |  2 +-
 arch/xtensa/kernel/irq.c              |  2 +-
 arch/xtensa/kernel/setup.c            | 12 ++++++------
 arch/xtensa/mm/mmu.c                  |  2 +-
 arch/xtensa/platforms/xtfpga/setup.c  | 12 ++++++++----
 5 files changed, 17 insertions(+), 13 deletions(-)

-- 
Thanks.
-- Max
