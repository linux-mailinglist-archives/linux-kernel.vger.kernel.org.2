Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BCB412F88
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhIUHfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhIUHfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:35:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5190DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q68so19903992pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fj7HOMTAEjrvCtbYb+Vzu40lpj7JG3HNn+Dw24QDhE=;
        b=XiHW8y8HiRKWE4MjzdMcGMKrnLNUm/2DxA23Rwjpv/Y2uyPKsGHVF9SKjyTZVOVt3u
         tgiuas0utFrWqv82kSL92lTElSNbMUhfilYsigMBE4gg4Z+0qqWEcJaE36vLVbqHK8EU
         S1mlWNz3aV+xpcH30RxiKwXEaOaqo3/wPwL3KA/pY83VxwI+4t5uXrCmDwDDf2kue1m9
         S3Bj+0XGOPmuNxVCcr+oCUFw3V+P9n4DG2NPHtEPKcMJuRfjiqK/j+vzSlmyX3xhnvbM
         HCpYgs68zPF3esI/eCuWrEfgdERS/P/6D0XZNFlIzjRMzIHHSTB4MVAM0KLay/cFcNOQ
         RdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fj7HOMTAEjrvCtbYb+Vzu40lpj7JG3HNn+Dw24QDhE=;
        b=rYebg4mBXXCD4PnTUXeaLRrm8qw73rjbRdmef4QcoaYFPVPwqMqNCfAqQVW7lRpQmv
         8hYv7sAFfKi9noD0r40bUEO8NK/rNZpp42WHAazv2JrYTsdeeLLmwqs7gEam9EOSThrw
         2b8Xy2g+IKUpHwMgFmtWwgb6HpeoejB9AvxLcansZK5uConWKUvxwix0RcMeEN+o0qd4
         rRDg+7OEnDphSfxqVlUGRPZJd87ufdPvp3qQprAZurMCXjp/y+ETYOAEPBC0B9RYuE7j
         8Y04j5Afv3KcpLLryxtRxA6cqQ4J77VhXCfPGd3YzomTpxKheTiiGBIfZ1G51f+vXkUq
         WELQ==
X-Gm-Message-State: AOAM533fAxjDKWZtSwfsFvUmY5hWKZ+OOEeB4QNCkE4YquJMQQIBrdzp
        BmJch89zZ0e0fMTh+rg++rvYR7H6hWc=
X-Google-Smtp-Source: ABdhPJxAImd3GsLSf8jEOhahqfGtQvb40nnbL+RNafys5hkuywableCwRRUk/AB6esCS4cPJbBL2aA==
X-Received: by 2002:aa7:9e0a:0:b0:447:a7f7:40e with SMTP id y10-20020aa79e0a000000b00447a7f7040emr11513094pfq.37.1632209664732;
        Tue, 21 Sep 2021 00:34:24 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id x8sm16565957pfq.131.2021.09.21.00.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:34:24 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Philip <benjamin.philip495@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: rts5208: remove unnecessary parentheses in all files
Date:   Tue, 21 Sep 2021 13:03:41 +0530
Message-Id: <cover.1632209460.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes all unnecessary parentheses in the rts5208 driver.

Benjamin Philip (8):
  staging: rts5208: remove unnecessary parentheses in rtsx_card.c
  staging: rts5208: remove unnecessary parentheses in rtsx.c
  staging: rts5208: remove unnecessary parentheses in rtsx_chip.c
  staging: rts5208: remove unnecessary parentheses in rtsx_transport.c
  staging: rts5208: remove unnecessary parentheses in sd.c
  staging: rts5208: remove unnecessary parentheses in xd.c
  staging: rts5208: remove unnecessary parentheses in rtsx_scsi.c
  staging: rts5208: remove parentheses pair in sd.c

 drivers/staging/rts5208/rtsx.c           |   2 +-
 drivers/staging/rts5208/rtsx_card.c      |   8 +-
 drivers/staging/rts5208/rtsx_chip.c      |  16 ++--
 drivers/staging/rts5208/rtsx_scsi.c      | 106 +++++++++++------------
 drivers/staging/rts5208/rtsx_transport.c |   6 +-
 drivers/staging/rts5208/sd.c             |  68 +++++++--------
 drivers/staging/rts5208/xd.c             |  48 +++++-----
 7 files changed, 127 insertions(+), 127 deletions(-)

-- 
2.31.1

