Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE884364DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhDSWva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:51:30 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:33509 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhDSWv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:51:29 -0400
Received: by mail-io1-f46.google.com with SMTP id a11so34450268ioo.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tdto6eIFZj79NTB2sahhhHxHCQcjLnGHA5qMcw/UR6I=;
        b=f4ofy7FEe6jUFEhFYRrppzBenoNPNEXHITJdB0REjMvLob4PYF05G5vXhR2lwpJXnv
         kXIbvh5IhO3R2xvk+hI9fevTWnyB7NdWthusLZI5vJyqpvEwHb+NzquyI7BfK13Dlmcx
         23nXRAIfvWu+qfd1do8+BPeLkKZ9pBAarPBOqfUChFAfEzasf3FOU/PK8xJirDtsJEQz
         gc44nJBkm6lGSRmnyTM24ndMXhe8+1QEzCsb5nwwf15j+kmrCLGf69tuLOztJP011K+T
         LwZu9clE+FmPP6i/iV5if9HB3xmHEp+iht1/kjrAS6puOOxqa/3Y8EnQH4VD219Mlw+y
         UnwQ==
X-Gm-Message-State: AOAM5321E4e0Z7fvSSl5GIvAQA4yMe96VkkXJkHVrgRw92VSQmOyxFGf
        Kn+I7XxORoiIKk5pmYLrYLI=
X-Google-Smtp-Source: ABdhPJwREyAaz7MwQNfl5RAG7pqM97qm228tj7EoAQXgKgVZ67pjazRLnes6lIUpKxBM41PT6ckAOg==
X-Received: by 2002:a02:a10d:: with SMTP id f13mr18649051jag.72.1618872658496;
        Mon, 19 Apr 2021 15:50:58 -0700 (PDT)
Received: from abasin.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id d7sm7566967ion.39.2021.04.19.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:50:57 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH v4 0/4] percpu: partial chunk depopulation
Date:   Mon, 19 Apr 2021 22:50:43 +0000
Message-Id: <20210419225047.3415425-1-dennis@kernel.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is a continuation of Roman's series in [1]. It aims to solve
chunks holding onto free pages by adding a reclaim process to the percpu
balance work item.

The main difference is that the nr_empty_pop_pages is now managed at
time of isolation instead of intermixed. This helps with deciding which
chunks to free instead of having to interleave returning chunks to
active duty.

The allocation priority is as follows:
  1) appropriate chunk slot increasing until fit
  2) sidelined chunks
  3) full free chunks

The last slot for to_depopulate is never used for allocations.

A big thanks to Roman for initiating the work and being available for
iterating on these ideas.

This patchset contains the following 4 patches:
  0001-percpu-factor-out-pcpu_check_block_hint.patch
  0002-percpu-use-pcpu_free_slot-instead-of-pcpu_nr_slots-1.patch
  0003-percpu-implement-partial-chunk-depopulation.patch
  0004-percpu-use-reclaim-threshold-instead-of-running-for-.patch

0001 and 0002 are clean ups. 0003 implement partial chunk depopulation
initially from Roman. 0004 adds a reclaim threshold so we do not need to
schedule for every page freed.

This series is on top of percpu$for-5.14 67c2669d69fb.

diffstats below:

Dennis Zhou (2):
  percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1
  percpu: use reclaim threshold instead of running for every page

Roman Gushchin (2):
  percpu: factor out pcpu_check_block_hint()
  percpu: implement partial chunk depopulation

 mm/percpu-internal.h |   5 +
 mm/percpu-km.c       |   5 +
 mm/percpu-stats.c    |  20 ++--
 mm/percpu-vm.c       |  30 ++++++
 mm/percpu.c          | 252 ++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 278 insertions(+), 34 deletions(-)

Thanks,
Dennis
