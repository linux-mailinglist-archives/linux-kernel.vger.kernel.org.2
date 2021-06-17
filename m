Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AF33AAC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFQGmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhFQGmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:42:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8871BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:40:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso3243022pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5tXXD3iVvEIVZ0tTMhEKfG6zykuiGGLtMWYWjRDWYs=;
        b=ZvI05WcGmnfe5oUfXHNoGdM/4PM/h3nxOJp96Y+tFn5U15FBFxeWkFmjh3oZf1EL8A
         ADkJUTvU+y/ObXXNwK0vGCrvjU1eU92ZHL7pmy1vKZFrzb+YG+Yqm32icH5OIHbXYy2p
         a2oGBtVpOoRVNRRYQe6ovJIHlhAuYmObTEb5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5tXXD3iVvEIVZ0tTMhEKfG6zykuiGGLtMWYWjRDWYs=;
        b=R7fhIxGJSV1mf8pU3XtDa/jAi00kvLYs6E8jI3cAe7/EXn3X0PGlBttHPnUOa73mK5
         YR/RK+d/WqpBhAWQZMiUIYG5PJc0jqfO1JpoUADSuE9Ndz1hGLGkYQbmSeXBjOTWUGAG
         pQ8M3LiACoJf7PiSmQFWXhQVAwvpcgccma04SnZMXvD4iyC49CBBTx9A5YMBCH7zcRKk
         hHHRZflZhwEDQUFbaH20szA3A4y1DZiFFC1lfDpYFODNEf0RmYXsq69TgjTfOZXM26rQ
         +RaEBruytN0LE/4idhJCqg3gxPoWJbnST31MBtY9WwMQIuJFpLFheepo7Onzp7BkBfuT
         XlRA==
X-Gm-Message-State: AOAM530XJe34zhYBTblvhIRc+Oj7x29jHLJRRvVvaWBK8QuKICUTIYwX
        2LEMYDTwv9UGZLhdi0uifcab+xhBCppa3w==
X-Google-Smtp-Source: ABdhPJzXBEGC2svL4/w6uQzTlhwr8EKMXDJngko+LKuujG1Wr3mcyI7qAM8QXo2oeD3ihoXSYQO+3A==
X-Received: by 2002:a17:90a:f193:: with SMTP id bv19mr15312947pjb.86.1623912003744;
        Wed, 16 Jun 2021 23:40:03 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id b1sm4112148pgb.91.2021.06.16.23.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 23:40:03 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v14 0/4] KASAN core changes for ppc64 radix KASAN
Date:   Thu, 17 Jun 2021 16:39:52 +1000
Message-Id: <20210617063956.94061-1-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU. I've been
trying this for a while, but we keep having collisions between the
kasan code in the mm tree and the code I want to put in to the ppc
tree.

This series just contains the kasan core changes that we need. These
can go in via the mm tree. I will then propose the powerpc changes for
a later cycle. (The most recent RFC for the powerpc changes is in the
v12 series at
https://lore.kernel.org/linux-mm/20210615014705.2234866-1-dja@axtens.net/
)

v14 applies to next-20210611. There should be no noticeable changes to
other platforms.

Changes since v13: move the MAX_PTR_PER_* definitions out of kasan and
into pgtable.h. Add a build time error to hopefully prevent any
confusion about when the new hook is applicable. Thanks Marco and
Christophe.

Changes since v12: respond to Marco's review comments - clean up the
help for ARCH_DISABLE_KASAN_INLINE, and add an arch readiness check to
the new granule poisioning function. Thanks Marco.

Daniel Axtens (4):
  kasan: allow an architecture to disable inline instrumentation
  kasan: allow architectures to provide an outline readiness check
  mm: define default MAX_PTRS_PER_* in include/pgtable.h
  kasan: use MAX_PTRS_PER_* for early shadow tables
