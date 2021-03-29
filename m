Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B8D34D768
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhC2Shl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhC2ShK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:37:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B812C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:37:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so8581706pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vX47kNAbuQ6iB1dL8WXUv9iCpp8Rvoq9MaFH5UQI38=;
        b=pCAl0bSL/I5WQtZov9ySDbJXFGEJH8fmLrqtdxAvKbwMitCZ26kUfZ/iiDtktj5fJJ
         G9u8iihtEvHzjpgsQsB1skcXCj7ckkpINKKLrZC50ESwZRbAfe5upG1TO620D/ia0l70
         +y65rDOOMlpjygsHtnzmfOZuiw8Q5FOcnTXvjlfzh58aIKQzifsBiE918rijmVwcFKjq
         qyveWaNE6k/FMI++0MMnDPHsq3bWWUIO6HhMnjIFeF+A/AAG47PqjjHPnxcLPXWECrCV
         fj3rPSTkhELMWV7e7H7xI0cCDkToNlOLSniYWz+7BM/sFm++gvxDcPR7e1BgWU+isk16
         Fm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vX47kNAbuQ6iB1dL8WXUv9iCpp8Rvoq9MaFH5UQI38=;
        b=gwolIL/BMB0ZsReDEhyjHfGgAGJMoxboO0aavBGk2ijBQJ7wuM7vhHyDWPyHHJhUTD
         ILpX+mq72XjHaTT2W4n7LgdGDqw2x4n+6pnaF+WR/6XyNw9QHbWW+NBW8v2GVNFMDj6f
         MJvvKeSEm8Vt7outOfx67HhE21HJqNZFF2WqO4KgV8ZApeMMd66FZarGa7u4WpXKRqB9
         +kaNDuMFOzAi6wAgiiBJG7RmLUO30FZc3M+1YI3tsof2rLIm/3UkZQ/D5lbIv4jNpB9r
         W8YHZg6kGPUVSGMEPl8akdvK9N/33oxYxdpqt7RB2puZMJVdrRSTJylmRjrESFdN7GKd
         6kNw==
X-Gm-Message-State: AOAM530HA6bXc4914xC/hgGCjdGX1vjktthQXlOH9G60ZGKOvbItBImV
        wbq1uAN0FWVfwv/lrrvRgSTRt1foiLo=
X-Google-Smtp-Source: ABdhPJzOcjK8lse5dwGxec+1eCDIQXd22D1u4X0NONkPKF2eV/Cystg/J5MADzJZ6P69Jy7JK7CjWA==
X-Received: by 2002:a17:902:c48d:b029:e6:f7d:a76d with SMTP id n13-20020a170902c48db02900e60f7da76dmr29563498plx.66.1617043029628;
        Mon, 29 Mar 2021 11:37:09 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:9e10:2d94:bd34:41ff:d945])
        by smtp.gmail.com with ESMTPSA id f2sm18348117pfq.129.2021.03.29.11.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:37:09 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/2] xtensa fixes for 5.12
Date:   Mon, 29 Mar 2021 11:36:48 -0700
Message-Id: <20210329183648.2277-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fixes for the xtensa architecture for v5.12.

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20210329

for you to fetch changes up to 7b9acbb6aad4f54623dcd4bd4b1a60fe0c727b09:

  xtensa: fix uaccess-related livelock in do_page_fault (2021-03-29 11:25:11 -0700)

----------------------------------------------------------------
Xtensa fixes for v5.12:

- fix build with separate exception vectors when they are placed too far
  from the rest of the kernel;
- fix uaccess-related livelock in do_page_fault.

----------------------------------------------------------------
Max Filippov (2):
      xtensa: move coprocessor_flush to the .text section
      xtensa: fix uaccess-related livelock in do_page_fault

 arch/xtensa/kernel/coprocessor.S | 64 +++++++++++++++++++++-------------------
 arch/xtensa/mm/fault.c           |  5 +++-
 2 files changed, 37 insertions(+), 32 deletions(-)

-- 
Thanks.
-- Max
