Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A9D447E72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbhKHLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbhKHLIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:08:19 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7793C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 03:05:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso14749781wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 03:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8N0EVvSK7cmgp6FySmGDS9JBMa2kFHQv45CEzvjOUHw=;
        b=bLOQrK8ZIDqtFnSGWZYIA0RlhIdqTgOSBo70mwisHpE89e9n5OIG1KxsZhU3u8cdv1
         U4LlwtxgNqeWSK6cTdTLip46Vja6E6ueuydYJcR7RRtkJk5yjnwznIOUx2+/9tt23LLp
         DBM2BqNKliyfsBX6/YoGD/nqtUV210UsgGEtjkiCcMFJwLmLirlvcxAhSd3yd4QDk1L8
         u41bGsaeR3gq4BNR+aqbJ9hzpEd0bJn1S6pO6vaOzz/FSEHN2FD3ry5bXwJRbYakDcIa
         yDrPpLUoS/SZx9SCPJx8xnRZcxLg62XIThp4/3a/ry6NyMVj8a1QJLi42Qkcl/xmNq15
         Susg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8N0EVvSK7cmgp6FySmGDS9JBMa2kFHQv45CEzvjOUHw=;
        b=F93jH5JZtxCDkK+eeP63yten0x10/uHrC3dy+65Z9/5weFvdImKverXZix6FezBYrx
         gCESK+NshGoi1GfP9Uq+STebuLk67zpPJPhevW3Oe46OaBydPSbBFUOVEJqzLPeGZB/+
         1NLAtJJQEvyRR6LjLh+iBYCzmjKXFVUaPN/oL6emlMYGxvjx/dBwKT8GBFnQ19H7bQgG
         Snr9dS26o611+3XcmatL4uujUB93vhTR+Le33KoH016xG1LmLv0wMY1rNxTBWk+YPvnu
         9tyacRaVIjwkH1tV03qgk/MqSUzxPJfZ19blVasKjpz1Uqw/IowGzzogKIaCwpYilt+j
         IqBA==
X-Gm-Message-State: AOAM532kZ9CQqL7yzrZCn+vh+3LPQJhewfsGZ3ee+CqpZrCXcKVSJiAZ
        4f+/JglhbSnQMQYreu5K9Z6pgyaB4iOh0Uc8
X-Google-Smtp-Source: ABdhPJyFW00fs7JeWVvHs079TdXUCXEqYaF91jOr4IkIFps6rWM7SUpqmbgSA3mNKRnPRUpz+tS8/w==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr53997110wmk.51.1636369532216;
        Mon, 08 Nov 2021 03:05:32 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t127sm20059156wma.9.2021.11.08.03.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 03:05:31 -0800 (PST)
Date:   Mon, 8 Nov 2021 11:05:30 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [GIT PULL] kgdb changes for v5.16
Message-ID: <20211108110530.x7ztji4kavmqfecj@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.16-rc1

for you to fetch changes up to b77dbc86d60459b42ab375e4e23172e7245f2854:

  kdb: Adopt scheduler's task classification (2021-11-03 17:21:37 +0000)

----------------------------------------------------------------
kgdb patches for 5.16

A single patch this cycle. We replace some open-coded routines to
classify task states with the scheduler's own function to do this.
Alongside the obvious benefits of removing funky code and aligning
more exactly with the scheduler's task classification, this also
fixes a long standing compiler warning by removing the open-coded
routines that generated the warning.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Daniel Thompson (1):
      kdb: Adopt scheduler's task classification

 kernel/debug/kdb/kdb_bt.c      |  16 +++---
 kernel/debug/kdb/kdb_main.c    |  37 ++++++-------
 kernel/debug/kdb/kdb_private.h |   4 +-
 kernel/debug/kdb/kdb_support.c | 118 +++++++++--------------------------------
 4 files changed, 53 insertions(+), 122 deletions(-)
