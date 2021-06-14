Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420753A6DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhFNSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:01:52 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:36688 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhFNSBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:01:47 -0400
Received: by mail-pj1-f42.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so32433pjn.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/mqJ66EtHUK4IIeoN0FRfV100MhEBbh41UIGDSjmrc=;
        b=DCOUY00RgUasECRr1FdUnz1y8UsZ04/frPpEqNRLVeJE2EOqBAV5G/jjL0cN0Ljj7T
         th1r8nYGtamAOIieyYcB6Z/FdOTCqbLfMgbwaaqNA7WImkU7jReGZJjPf/S07j2m+eSv
         dTQgGPzMYyk3qWukbOOaFA5/YRN5SWkWdY6q2p8C/KJNKZ4jHKM3wz6E7pfhLKR3pmot
         xjZeEqUPKBrFzA0y5070o5rN98ku390q9a36jRw35WGT9QhROLNlR2mSN/igZ1/4h1Ry
         WnSduTzJqpnSZNSEuypWp3GnUVZSYXMdD2fO5t/n5gjkZOA8sooAKvUD6aGIiDQXiTsk
         pmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/mqJ66EtHUK4IIeoN0FRfV100MhEBbh41UIGDSjmrc=;
        b=kj1rC7/Kzvyh24WCvRq9HAfn9aJqC5UxLQ8ogcDHwJbnZ/F5fXO7tVJCalY/OZsS+I
         UVagQXzg+D+n8jiU02VGGps3zLcasKxG5TO5s11vu+0Lp0vjscbV/YYGD79E3PdoxYVi
         YSFpnuESAivDsp4CMf/VuAvoT6UEDGgplyPVdwIEwoOXL4h1SEnK3BYc1Zd/38kGTM3n
         c1LXWBFdT4MXZKRuCCPyaSL359h/v+8bvlgLNCS2XNEHie+/6/7IpEMrQPydmlZL98uI
         E0qUssMX+fkmXktqgXhj6sohFaYsKZKH/cxpvExsT7IKJd503mxwWdPPLbpNTEbWbW1v
         HRgw==
X-Gm-Message-State: AOAM531DSUC45xeKOnhZPwOtAnYamcMcBrRZLFLlFyZoNerxwtTHVND8
        5JIJYgaNaEY0cVno0fakBmCBapzVpgN5uA==
X-Google-Smtp-Source: ABdhPJy54AaIv/GBKBbCJXK/RvaeF2Tgxpc4qaHjM+oYELVe058w21gxCLPhyHyqxZl6ajgnyEk+HA==
X-Received: by 2002:a17:902:8484:b029:101:7016:fb7b with SMTP id c4-20020a1709028484b02901017016fb7bmr411849plo.23.1623693524931;
        Mon, 14 Jun 2021 10:58:44 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j4sm135335pjv.7.2021.06.14.10.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:58:43 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] coresight: Patches for v5.14
Date:   Mon, 14 Jun 2021 11:58:37 -0600
Message-Id: <20210614175843.532624-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Greg,

A small tally this time around - there might be a part 2 but that is not
clear at the moment.  Applies cleanly on today's char-misc-next
(db4e54aefdfe).

Regards,
Mathieu


Andy Shevchenko (1):
  coresight: core: Switch to krealloc_array()

Jeremy Linton (1):
  coresight: Propagate symlink failure

Junhao He (3):
  coresight: core: Fix use of uninitialized pointer
  coresight: core: Remove unnecessary assignment
  coresight: etm4x: core: Remove redundant check of attr

Sai Prakash Ranjan (1):
  coresight: tmc-etf: Fix global-out-of-bounds in
    tmc_update_etf_buffer()

 drivers/hwtracing/coresight/coresight-core.c       | 11 +++++------
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  5 -----
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.25.1

