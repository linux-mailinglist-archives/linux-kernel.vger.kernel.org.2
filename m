Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3F3EFF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbhHRIf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbhHRIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:35:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576ADC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:35:18 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s11so1508717pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vDsYBBnC0wYyXBYZaBH77gFXX3d5byNqFtp7f+jn/bI=;
        b=Ht7pREXnxtRddZoj6umydIJ7UUFPEFat/a2wsgzrelb2JeWWEU5zVuqxJ28rSfxYiF
         8oSfZUxzAKw2KxDMNL6KIEekHxVtLRp0KOuGwQOqXUH9DH3PZtdSSGzab1BH0TuY1Wmu
         YsNAPs+tkl+pHRSco+H3Tb25LJbx5V0y6YsHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vDsYBBnC0wYyXBYZaBH77gFXX3d5byNqFtp7f+jn/bI=;
        b=VZ+neYeygfe/9EyEYz0FcMQb0RlYwJk1m3wT38iA1aBed766+nVsyB8wc/4Xo1aW8k
         kc34NcxDSB7vNqbqQmzswWwMWObBUQdwRE8kF5xtAzsFC76d2PzpHuy7BhUVvVaRWPP2
         1Hm34Z5jJqDK35VlJPBReRJUwzmSQxumqqJ5ni+rAIcX0jnAxxyLxqfRhWmpwQ3cHLF/
         5yMX4mgVE7Z5nQpn9pG5CDfHF9mVkiL2zaxi8PyQRuGPd1VrM4cn1YRN1rWj9C4EnKMi
         NRq2Ts0SanN+H0JlF8WjEXBKOVmGfyxkx2BVmyE8RYgRSqsoW0lCH38auruJC+fXB/ta
         yFCQ==
X-Gm-Message-State: AOAM532X6LwI4sfV1qMUZavLUfjhuQ4CUZH4DqSQxuQ6cgJf0kMgjsxD
        cjK1KLoGQgIcmn8WiB+8ofHiUA==
X-Google-Smtp-Source: ABdhPJzcHpKnXkGdFwkw25re2UgTYj7ujcLwpjKBCQspQtF9H+FIY4nlOHWSZgjoYXvv6rs9hE9gPQ==
X-Received: by 2002:a62:aa0e:0:b0:3e1:5575:1bdf with SMTP id e14-20020a62aa0e000000b003e155751bdfmr8216483pff.2.1629275717956;
        Wed, 18 Aug 2021 01:35:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mg11sm4370835pjb.28.2021.08.18.01.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 01:35:17 -0700 (PDT)
Date:   Wed, 18 Aug 2021 01:35:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [GIT PULL] Clang CFI fix for v5.14-rc7
Message-ID: <202108180134.4FDC95B434@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this Clang CFI fix for v5.14-rc7.

Thanks!

-Kees

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/cfi-v5.14-rc7

for you to fetch changes up to 14c4c8e41511aa8fba7fb239b20b6539b5bce201:

  cfi: Use rcu_read_{un}lock_sched_notrace (2021-08-11 13:11:12 -0700)

----------------------------------------------------------------
cfi fix for v5.14-rc7

- Use rcu_read_{un}lock_sched_notrace to avoid recursion (Elliot Berman)

----------------------------------------------------------------
Elliot Berman (1):
      cfi: Use rcu_read_{un}lock_sched_notrace

 kernel/cfi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
Kees Cook
