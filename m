Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51B400D6F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 01:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhIDXLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 19:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhIDXLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 19:11:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62BAC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 16:10:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mj9-20020a17090b368900b001965618d019so1971393pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/d2b2XvRdPISy2stEvhSTES9bNg5OKL/R1eIpuIylJE=;
        b=VT2IxdjTrgDAs1fsp3hKmhO4OxIIUC6JtTbWKfYK6o3nmK5KGnXNJ0/w7DlTwqMHl6
         CG8uuOq+yFRl1Mhh/ufqxD853Z1yHiJI4G8tsTHQkMF2bIEnR9k21RAkzlbLbXaBMoRe
         A+wmIKpOEJnVBRYXax4Brums6FKH/BZCkFZ/e2IrptII41tDvCm2TDgQt/8B9V6/9czN
         TeXRh8LTvXLtMMopuMYpuAMnjUcxYdUQQT4TVLAkya/k6PKcJq7wz93TvvrM94R6dsYe
         iO7NQPGsX5EKW2PxtkfGhbWTl5G76yLFJm0HTjcUXhAYyauYHvASyvLP7RRQVM0DivDC
         3Rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/d2b2XvRdPISy2stEvhSTES9bNg5OKL/R1eIpuIylJE=;
        b=o5T9oT5ximi+M21fcpK3bB9YpuRzE1OjUiFTv/bjzb4y8/qMzt1xCmQ5aqk5oKLvqE
         H4k/Pfj49pA4sAJT2vl5l/kGQcbCxbsNqHgC0cQGceYH9k+GKV37sZfxrPyaqhdlxsLV
         9GQJnjKSqeOVpSPRiyIgwaaso3xbnnQuyX8TJqzPvG3JPsmilfK0LBqa31cCsT5olfri
         r6AJaGjn6hFLhNnmiAwXVhidWq7ZZ2Usn7SAXMDKo8ydJVUUKBAQ0mdYHM4MgGEr4/Gl
         2L8DHPJlVZO7TreNr3Tfwf3yC7qMN5FC7eriHAf+SNC9AFtJWlR8R40JsOsJXTMicFdF
         Avqw==
X-Gm-Message-State: AOAM531jSc3555wqtH3ePi+03HR4uvvaeKi1bWaa51dBVA0wkONEvmef
        LqgohY3n5kFsNms0EHu73zTz+aRvkx3xAg==
X-Google-Smtp-Source: ABdhPJzek0+ELz+xm3LmBaSgNt/82z1r5sddMg1qhweeO7G40QDb7QDCz0ZSufpK5utnHvBn/qG4uA==
X-Received: by 2002:a17:902:a503:b029:12b:2429:385e with SMTP id s3-20020a170902a503b029012b2429385emr4797973plq.64.1630797027987;
        Sat, 04 Sep 2021 16:10:27 -0700 (PDT)
Received: from localhost ([202.164.25.5])
        by smtp.gmail.com with ESMTPSA id g17sm3198089pfi.168.2021.09.04.16.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 16:10:27 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Down <chris@chrisdown.name>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/2] lib: add sputchar() helper
Date:   Sat,  4 Sep 2021 16:10:18 -0700
Message-Id: <20210904231020.331185-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds sputchar() helper and coccinelle script that I used to
find candidates for cleanup.

Yury Norov (2): 
  lib/vsprintf: add sputchar()
  coccinelle script

 include/linux/kernel.h                 |   8 +
 lib/string_helpers.c                   |  56 ++-----
 lib/vsprintf.c                         | 222 ++++++++-----------------
 scripts/coccinelle/misc/sputchar.cocci | 190 +++++++++++++++++++++
 4 files changed, 280 insertions(+), 196 deletions(-)
 create mode 100644 scripts/coccinelle/misc/sputchar.cocci

-- 
2.30.2

