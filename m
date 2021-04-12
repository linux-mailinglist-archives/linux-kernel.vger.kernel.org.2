Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7058535D352
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbhDLWns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbhDLWnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:43:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6404C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:43:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t22so6830802ply.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LC3H1cpiJHCBM+DlZ2l4WxoB82Db8dlZgy3XW4iJx9k=;
        b=MruJg+xuFzaCytSuuv12vMblzQ7q5GzuCNFQGcXm+Nt1n0/BwllA6IzRBNEJfkPUFp
         AV6TMTGTvKWCJj+yl+J4zzuhWSgZ9GyY2jNqkKR6gRxOhlJFnTkl8g8axTdSR4j+edTX
         oE9mdIlsknxxUQT0/Z908lxQ05Dv0f/JULOMHTPTBvQQCQFE0TbcPNjDzooOgtEs4tl4
         Ko0JzSNHOJCz50R47sGq+nEiYnuCliROrrWM5su1fPVKFtl1sHxaiR9kxxAs0uUbvcr1
         xRQliwJO05PcRTOWdZXgMrGuK3Ejx2TEBUGySdj7T3FZ8mW+7fsfClLGtQVN1HakKk1k
         DiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LC3H1cpiJHCBM+DlZ2l4WxoB82Db8dlZgy3XW4iJx9k=;
        b=kIcq6nY6f+u2Sn7y0InjyvpWAYlOgeb6KlycqUSoZQvoPZrVRG2tkw1QAtdq/ScIIA
         WGyk18cWgDimK1GWl4p+guG2NyE3khZHiIgo0cZp5Y/lWZSlCvRntM88s9zNFlIvdWqc
         HY9tTtuqsoUOgwMGHZVWQKMO1pAKVei+ZgYuubNLVAqKt3EzcXAHKXb8XdWqeZFX5M24
         yprxwy1KT4UHkh3Mi0jeE59Uu70EF6rRsvH2274FMnPrjwlEp10MX68PGAWy5jUnETgq
         XqOi7arojF6hvpjaaM/U1qjDJtuhQXkKn8nK7KMI++YRDBGsOZSIBLF1xxmgathgaerB
         L8Mw==
X-Gm-Message-State: AOAM531s++a9Fs4yd+G3dpbvjZwdZO3d0SvJkIkGnqTVE4mLddFx2aCR
        gjCxH9z4h/J1DRe6hj8V14hI+DBsX7fkRTs=
X-Google-Smtp-Source: ABdhPJwN10UL2cdw3PwNpnbgdfVEgC35BRL0gAtn7CD1Gdwxrf1MoEjZe0CkpRgEUYHu3ff4Ofz0vw==
X-Received: by 2002:a17:90b:1e50:: with SMTP id pi16mr1514048pjb.24.1618267407516;
        Mon, 12 Apr 2021 15:43:27 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id l25sm13365373pgu.72.2021.04.12.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 15:43:27 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] mm,hwpoison: fix sending SIGBUS for Action Required MCE
Date:   Tue, 13 Apr 2021 07:43:17 +0900
Message-Id: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote this patchset to materialize what I think is the current
allowable solution mentioned by the previous discussion [1].
I simply borrowed Tony's mutex patch and Aili's return code patch,
then I queued another one to find error virtual address in the best
effort manner.  I know that this is not a perfect solution, but
should work for some typical case.

My simple testing showed this patchset seems to work as intended,
but if you have the related testcases, could you please test and
let me have some feedback?

Thanks,
Naoya Horiguchi

[1]: https://lore.kernel.org/linux-mm/20210331192540.2141052f@alex-virtual-machine/
---
Summary:

Aili Yao (1):
      mm,hwpoison: return -EHWPOISON when page already

Naoya Horiguchi (1):
      mm,hwpoison: add kill_accessing_process() to find error virtual address

Tony Luck (1):
      mm/memory-failure: Use a mutex to avoid memory_failure() races

 arch/x86/kernel/cpu/mce/core.c |  13 +++-
 include/linux/swapops.h        |   5 ++
 mm/memory-failure.c            | 166 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 178 insertions(+), 6 deletions(-)
