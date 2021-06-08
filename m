Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352AB3A00C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhFHSrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbhFHSmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:42:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE6C0611BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 11:39:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l184so1709336pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggAVsZg/cXVvUqOkLCWYOUQSB2LS7JfS85VC4f/i35Q=;
        b=A+zfVz8+HcNRW0Fu44E5Rx1laJBsnN/evN5OVcSQxI6o5VY7aMp/wkbk7YZEddRyqf
         j6V+36FDLYuzRKK0DZJdGdBLB1Y5CRMIUggAtmTOBJhRrwD5l/9iHbx4GyRMeC21ZXxf
         5f54CDraX2aeQzPczl3kziJJa3SLjW7q/K6iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggAVsZg/cXVvUqOkLCWYOUQSB2LS7JfS85VC4f/i35Q=;
        b=EuHuYqAvqSVDNHqeq8in256gC5g6trZ2/P7Vm7t0zq/f99fuKfJqG8WrFb1JyyAJeN
         lZGy7yI7NENYQuA0kIn5HgDgJ7BG8S15XAKjVosozEHErZJIWuNiH9Ieri8HHAxT0p/3
         CrR2yWDOi5sGoK43aAfl8Q96wF7meCGrcBxuo5Uc63ieqnSgoBJ+N3/vFWjVQO1I/zUm
         WDTckdC9bhlucI6gsRubCzX+MI/hKNmpA+WSd2mH/O14d7CGLGxwkmoWPq2Dp0J/aFwU
         uwJaEl5fvblIS3tiBvxYfSOs6K0fmoYmUR+K65g+gjFd2NXWAAUB9s7hjvwtyOJclyVt
         dVRQ==
X-Gm-Message-State: AOAM533ii6EiwkrhtPjm7U68KqLb1MJqb7UjYfOeI4q98QqlhSdIfdmd
        XpxjvcLZgBJNxXA2gIfDsgCdxA==
X-Google-Smtp-Source: ABdhPJxQcETaq1CxSn2r98DdBqfCgzxobh8dnkqILoMHMZd+vnkG8uyC7KrRE3gaJyWFsbkQFdmt4g==
X-Received: by 2002:a63:ee11:: with SMTP id e17mr15958908pgi.323.1623177598571;
        Tue, 08 Jun 2021 11:39:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm11613587pfb.28.2021.06.08.11.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:39:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Christoph Lameter <cl@linux.com>,
        "Lin, Zhenpeng" <zplin@psu.edu>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 0/3] Actually fix freelist pointer vs redzoning
Date:   Tue,  8 Jun 2021 11:39:52 -0700
Message-Id: <20210608183955.280836-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- remove redundant size check
v3: https://lore.kernel.org/lkml/20201015033712.1491731-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20201009195411.4018141-1-keescook@chromium.org
v1: https://lore.kernel.org/lkml/20201008233443.3335464-1-keescook@chromium.org

This fixes redzoning vs the freelist pointer (both for middle-position
and very small caches). Both are "theoretical" fixes, in that I see no
evidence of such small-sized caches actually be used in the kernel, but
that's no reason to let the bugs continue to exist, especially since
people doing local development keep tripping over it. :)

Thanks!

-Kees


Kees Cook (3):
  mm/slub: Clarify verification reporting
  mm/slub: Fix redzoning for small allocations
  mm/slub: Actually fix freelist pointer vs redzoning

 Documentation/vm/slub.rst | 10 +++++-----
 mm/slab_common.c          |  3 +--
 mm/slub.c                 | 36 +++++++++++++++---------------------
 3 files changed, 21 insertions(+), 28 deletions(-)

-- 
2.25.1

