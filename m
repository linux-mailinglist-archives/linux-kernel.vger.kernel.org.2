Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C533F0A82
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhHRRtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhHRRtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:49:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180C9C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:48:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j1so3099077pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dThvG95AKYmfSVzdJA3a/UDQFTluWlf22praOUB+Zbs=;
        b=GeAO1B69Z4+Uupb9HeH1oibnV20CQgb3KyeBWoRXciRWMBhVqVxED2Omhwl1Ikbqk5
         ogkokoXt330CYDu6kfp0mNUhKoTO7gRPKHr54vU8qIRGMs6HfbdD4VrnZbCVckevrJ61
         M39NrYJSbwCT2JKeZzREvu5joH4pdBpfDDdT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dThvG95AKYmfSVzdJA3a/UDQFTluWlf22praOUB+Zbs=;
        b=MknFGtZ0EYGMh3NKBf3brrNwHCFnKtuxDxngr4Q8oK8OiXdSJxZ8Ekhd1zoj9WFN8S
         JCiahbL+r7fkE2Jk0avgI/YkC31AwtvkRyifsvtGFmyYpSr5ROpoSTqQkfHDitJQc1WM
         tFiJnzqzhqs+Ykqg/HUfVj3HQ3oX06p0iAjiN8bsOQStYqDV0f5nTa1W8yuYEEuDw0lq
         XYUc+oo3kOGA5fR3t6ciZak6pzs/YpFFfAtPWEg+qTDM3/3O7NNQh2hvWL7o1SQoXzFu
         QExebX81n/AlXidO18tT19MqsytI+GSegxPwcnrrvrKE4NJ/aZNQzYJxxRraWzZrw6sq
         IXCA==
X-Gm-Message-State: AOAM530qlLt06X9vmrYEqJYq6EYZDIjGAXakSt7D9KTQ4mPxuPCYLw17
        Tip13aC4+j6hgJbalKnJVXkkhA==
X-Google-Smtp-Source: ABdhPJyFmosvGWap4JktyDPy6Mr+eSFnZ2PVT9WyhAMwyE445kte5IuHCw/qUBZBBS05bBCREpDc9w==
X-Received: by 2002:a17:902:e889:b0:12d:a686:394a with SMTP id w9-20020a170902e88900b0012da686394amr8201851plg.57.1629308938627;
        Wed, 18 Aug 2021 10:48:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b10sm400241pfi.122.2021.08.18.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:48:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/4] LKDTM: Various CI improvements
Date:   Wed, 18 Aug 2021 10:48:51 -0700
Message-Id: <20210818174855.2307828-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; h=from:subject; bh=lfjpPjSL9u6+AD94ZIbB3QoMIRRZ/G7Ezz9D5Ay+kGI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHUgFCPW16E1lQcohGZyFYf0zfIHGTn0zdlBOG4Ge +kf5dIuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR1IBQAKCRCJcvTf3G3AJlh+D/ 94pNcZKwGyNKZDKJOKFk/rJ2BSys9Mg2gwox+65o48wNqzpbqsVzEfsRE1sh/8y8jPPgcUXyjEUmGT KBwnqQRXV+/166xl7aoDpHdjaoz2UWwTyJp0XjNO+uuAKwNI9EYSCRzKRe2wtkMNJkd8yoMDw2hD+A QNQm3egBv0PrDkdJ33VAjpjG73r5BSGrCZB78bc8ZLzjmrkBCutQZUqBNdZ+wmD+hKzslTmuKQ8HKF aZWrNCLWjgDVE9cp/rBtpJI4zQSscGth/hm6C03bEpNLZR9qynYx/opFDkEc373tJUxLXWSSoLC0J5 eoQOsfRk+E58Afh88dsCz+mDmYKxZ7mbKESTRMinTfGwfW2i0diSM857HcfIr78fuh+64X4RAlHEe/ k9sRxX/o/YMrzBw4K0BvelY9bm/nedA7N0hB013/41qciunLBEVTc+Gs0MD9eq20ckDwjhT9CBRqVm A+iF1Az57MiVMeoVXmaVBhlgS9pRcK9grjeAQ+WNlHSJ59jfgfiCTaX7ZzP11sSjrBMPqWHl7LEbYh zFN7Lp3Q02aMkX6Mev3iaWaJDXlCgTi/luNKwvIGSzfj/WFL5beUjeGHgiam4VUzGJmkqWauA01QyK oEK7F0MvMgtkHLPsS6kiZ8WUzwNh5dGRa9Ztz1Yenc3GlRQqBKi+K0dOsPIw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Can you please pull these LKDTM changes for drivers/misc? I forgot
to flush this queue of enhancements earlier. :) Here's what I've got
built up, mostly tweaks for kernelCI, configs, consolidation. This also
includes the __alloc_size hint adjustment I'd sent earlier, now fixed
with a better comment.

Thanks!

-Kees

Kees Cook (4):
  lkdtm/bugs: Add ARRAY_BOUNDS to selftests
  lkdtm/fortify: Consolidate FORTIFY_SOURCE tests
  lkdtm: Add kernel version to failure hints
  lkdtm/heap: Avoid __alloc_size hint warning for
    VMALLOC_LINEAR_OVERFLOW

 drivers/misc/lkdtm/bugs.c               | 51 +-----------------------
 drivers/misc/lkdtm/core.c               |  4 +-
 drivers/misc/lkdtm/fortify.c            | 53 +++++++++++++++++++++++++
 drivers/misc/lkdtm/heap.c               |  9 ++++-
 drivers/misc/lkdtm/lkdtm.h              | 24 ++++++-----
 tools/testing/selftests/lkdtm/config    |  2 +
 tools/testing/selftests/lkdtm/tests.txt |  3 ++
 7 files changed, 83 insertions(+), 63 deletions(-)

-- 
2.30.2

