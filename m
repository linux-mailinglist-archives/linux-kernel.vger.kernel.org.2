Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0136C717
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbhD0NgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbhD0NgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:36:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EB1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:35:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h8so29846472edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OE54W7NCs1R5KPrbcjBvep6Zw9jQTp9radllgP0GkYE=;
        b=QGmIOw9etZKn784PahzhcsTnfTJp26aQMKE/Q5DyH6Ewro+MDxP/1dckk5Er9ippca
         Sfs9RI2LXyWCnWxVuJX8a/9Jns1kDbFc/gVFlNxSbLDgq8FNyj9Jn+TKOEcy1Jd6DwOv
         KA/3tzwscIHkWngeB14CArCPIHf/LlyARALgOGkWG4/yOWttgs+/NsRAIhcFvfSB+Bmi
         fKkmOJlcU6qFsCfl65cj7hcWvuosQQIkrSdcz6FKxP1z5CUYIRM5I91DjPpcfiM4ihDT
         9mqJIkJx8sdf5F0CCxPxiVF5HdunDb8RTp7ztvYbBDvuFi6HxXx1YLUuSoD1q10RC3oB
         g7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OE54W7NCs1R5KPrbcjBvep6Zw9jQTp9radllgP0GkYE=;
        b=H6bCEmwL+hGyhCjF9G6eotrlFVsdSyzNumDW9G9mrTqbnPTm1weEDxVp96vXn9RkWe
         Tyw6bv/5O85uDtzU5ZD15jmn1xxSTHdOjEmaFC45eqiFg+grae+QTkk3c7usLp576efO
         /r/kk1Nwiw83G3zt1gInMwAV3u1sp/oolyqFhYkWzelmQ6YWN6AVI+kcuwl42XPd1reR
         IA/ewu8mTQGfADNhBhCHj+qrf45yvM20SNBSj6YPyfI0PRsAXCUngmmSQm/EFIUwvQS8
         gCi25NEQjxedzHs0wZKQHTZiTmUaD+1cFpo0t0a3Xo3bNkS2YsuZ1wl7tGI3wKvetP6F
         rqSA==
X-Gm-Message-State: AOAM531UNQdaWZyd27h6ytHSF/gVuOosaekBf0E3YE9xHxHWjk1pPdIS
        4QbYEIykSjGyqBDOxW5wfT2Paw==
X-Google-Smtp-Source: ABdhPJxUaMdDzlni1Pv6xtabG3se+PjWYztObZzJcI6TF+/SGx4krymiMbzMW+NWQ1XaYGCfM/6OxQ==
X-Received: by 2002:aa7:d14a:: with SMTP id r10mr4400455edo.385.1619530531202;
        Tue, 27 Apr 2021 06:35:31 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s8sm2590842edj.25.2021.04.27.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 06:35:30 -0700 (PDT)
Date:   Tue, 27 Apr 2021 14:35:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] kgdb changes for v5.13
Message-ID: <20210427133528.so6puv5wxj25dqwi@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.13-rc1

for you to fetch changes up to 83fa2d13d628be901a21cdfb3553963cd8858052:

  kdb: Refactor env variables get/set code (2021-04-14 13:47:09 +0100)

----------------------------------------------------------------
kgdb patches for 5.13

Exclusively tidy ups this cycle. Most of them are thanks to Sumit Garg
and, as it happens, the clean ups do result in a slight increase in
the line count. This is due to registering kdb commands using data
structures rather than function calls which, in turn, simplifies the
memory management during command registration.

In addition to changes to command registration we also have some dead
code removal, a clearer implementation of environment variable handling
and a typo fix.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      kernel: debug: Ordinary typo fixes in the file gdbstub.c

Sumit Garg (3):
      kdb: Remove redundant function definitions/prototypes
      kdb: Simplify kdb commands registration
      kdb: Refactor env variables get/set code

 kernel/debug/gdbstub.c         |   4 +-
 kernel/debug/kdb/kdb_bp.c      |  75 ++++--
 kernel/debug/kdb/kdb_main.c    | 588 +++++++++++++++++++++++------------------
 kernel/debug/kdb/kdb_private.h |   5 +-
 kernel/debug/kdb/kdb_support.c |  18 --
 5 files changed, 381 insertions(+), 309 deletions(-)
