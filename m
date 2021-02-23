Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508913224A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 04:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhBWD23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 22:28:29 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:40628 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhBWD21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 22:28:27 -0500
Received: by mail-io1-f45.google.com with SMTP id i8so15639874iog.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 19:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HI1IeUcajrSGQGzEM7tIoTC6RGw0rv93ilEN7asvsjo=;
        b=pOfv5ahQ3dgdNM4kFSM9ka0t4ji3FCyF5eiHcSzC4IxXjtnF/gZTd2cqbJAB90yozs
         D6Z//+U7jqtrmaqP8wq7zUCKYGf/0mk9A9fYP2cO/oupkzoKCugBA6DO1DoKbUtFVe1t
         BKetgr6Yfj6jVFgbkDh43PCXmul91qJAa13nNcparF18yYImv1hiA6TwVIvQpz8ueXvi
         YCRJCV0l7+8SI2NJ0CLbdN2+AfvxYFIP7k9KPgtIWqQhO9HyIYplpRZunGlhOE3aG5iO
         r5YHSuVoT4u4xsFaUiNID1pJmSqS4IfBhWItSoKlk8wcKZRmjiEF0xg88n366qFUv9YI
         b16A==
X-Gm-Message-State: AOAM5331+Ti3OBJ0W2XAFqHnU72Fq0Xrz+H2OFv/rd79oEMI/mV7kGie
        2ffMGeWfWXnoj2Rrm5Ax2pFtaaqaYi8=
X-Google-Smtp-Source: ABdhPJzhb9u66SIfGCCsHf+vx/HoQGMVHLdzObOa2U+QErsRxFWXu7KWTWtU6YYWJZmiOqqQSN/BuQ==
X-Received: by 2002:a6b:3b14:: with SMTP id i20mr18764997ioa.28.1614050866467;
        Mon, 22 Feb 2021 19:27:46 -0800 (PST)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id c16sm5536698ils.2.2021.02.22.19.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 19:27:44 -0800 (PST)
Date:   Tue, 23 Feb 2021 03:27:41 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.12-rc1
Message-ID: <YDR2LTclQGy7OHKc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Percpu had a cleanup come in that makes use of the cpu bitmask helpers
instead of the current iterative approach. This clean up has an adverse
interaction when clang's inlining sensitivity is changed such that
not all sites are inlined resulting in modpost being upset with section
mismatch due to percpu setup being marked __init. It is fixed by
introducing __flatten to compiler_attributes.h. This has been supported
since clang 3.5 and gcc 4.4 [1].

[1] https://lore.kernel.org/lkml/CAKwvOdnxnooqtyeSem63V_P5980jc0Z2PDG=0iM8ixeYTSaTCg@mail.gmail.com/

Thanks,
Dennis

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.12

for you to fetch changes up to 258e0815e2b1706e87c0d874211097aa8a7aa52f:

  percpu: fix clang modpost section mismatch (2021-02-14 18:15:15 +0000)

----------------------------------------------------------------
Dennis Zhou (1):
      percpu: fix clang modpost section mismatch

Wonhyuk Yang (1):
      percpu: reduce the number of cpu distance comparisons

 include/linux/compiler_attributes.h |  6 ++++++
 mm/percpu.c                         | 36 +++++++++++++++++++++---------------
 2 files changed, 27 insertions(+), 15 deletions(-)
