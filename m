Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7F93D76DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhG0Ned (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhG0Neb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:34:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E0BC061757;
        Tue, 27 Jul 2021 06:34:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ca5so5399871pjb.5;
        Tue, 27 Jul 2021 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CORRlFb0KftgV7g3EzAHQ31zcHSimEVwYrbwkTtU9jE=;
        b=V9YwmZho4zxmv4SV6IHOOd6O6yTvV4h6X7/DrxlKjDcN1TV8qjPcl+p2ZAaLP/BPZK
         FLX3/zDJg4xjUKl2rqs3FXSS90FRLvhvxxUtVkNSzn6klxhTrwYd/9NpXYdUUZ3aIywY
         qetup8MwzSPksCgUC+XHQGt+I2jwyBVz0fe3aRPpdajLDCx2bjSsTg9i9xncuZaW6z5d
         3dQrb1JQsKJhdU1uIqFEz6otSo7ApGYhalXhrIamuefHE/GPTnzuq2kA1+odIxq4/A74
         QESNJ2WHjZpd71M9PSSRCFv9ZfyuAWgi76kDhhbzzvsHXVyOV/gEOpuhaTJMt+ZNZkdt
         7Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CORRlFb0KftgV7g3EzAHQ31zcHSimEVwYrbwkTtU9jE=;
        b=ThnAe5NtjVxlnWKUV2nrf987szOwIh+GaRtApXHy178tPSRiy7h2HKCIPwL4tFC1up
         fUAYjspmHsAhhgs+05DFp/pWF08I7cKvjMOR7y/jq8guhy/42/kKN99i579uYW+0gJmr
         tna8i7uMJoaZklUtJUXZq3sn7J9975115oB78WCEIUDQAR6SStqVA/AhA9L3NlyIrDcT
         Z9NpuJ2Bo10fbDvnfMvNz7XOpPjouGvG2JQpe51EXjnyMS64WO8OeWQfTpXvyYU/Qbm/
         SX6jNxED/aVAKotJpwvSn7rfyiQW7Qe3v1BijYF+CnZJAAwmmbsJ0km5LeU2gKJP0j+k
         I2NQ==
X-Gm-Message-State: AOAM530TcWq+6pzLHGIlTikdu/2VNDEL2qOrEJjxzTXQvycW2zSmb4Mz
        c4L5Mb5qrfo8LUYKjRCmKJc=
X-Google-Smtp-Source: ABdhPJyvsSx3iYVjwLa9cpIMgOmW58gopop3hnMqKS19vcMI61SnRdfY0j0WsnunrB8vG99Uyf94WA==
X-Received: by 2002:a17:90b:a4c:: with SMTP id gw12mr2840876pjb.187.1627392871429;
        Tue, 27 Jul 2021 06:34:31 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id e23sm3743921pfd.26.2021.07.27.06.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:34:30 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [PATCH v2 0/5] kprobes: Bugfix and improvements
Date:   Tue, 27 Jul 2021 22:34:21 +0900
Message-Id: <20210727133426.2919710-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second posting of patches previously posted at
[0]. Although the patches were reviewed / acked in the previous cycle
but for some didn't end up getting picked up for this cycle.

This posting rebases the patches to 5.14-rc3 and makes some minor
improvements to the commit log in Patch 1. I've also added the tags as
appropriate from the previous posting.

It would be great if the patches can be picked up this time around.

Thanks,
Punit


[0] https://lore.kernel.org/linux-csky/20210609105019.3626677-1-punitagrawal@gmail.com/

Punit Agrawal (5):
  kprobes: Do not use local variable when creating debugfs file
  kprobes: Use helper to parse boolean input from userspace
  kprobe: Simplify prepare_kprobe() by dropping redundant version
  csky: ftrace: Drop duplicate implementation of
    arch_check_ftrace_location()
  kprobes: Make arch_check_ftrace_location static

 arch/csky/kernel/probes/ftrace.c |  7 ----
 include/linux/kprobes.h          |  7 ++--
 kernel/kprobes.c                 | 58 ++++++++++----------------------
 3 files changed, 23 insertions(+), 49 deletions(-)

-- 
2.30.2

