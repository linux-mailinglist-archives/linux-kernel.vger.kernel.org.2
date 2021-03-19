Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0350A3420E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhCSPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhCSPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:24:27 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BEBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:24:26 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z3so6495665ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeyO8ujnhLSKg2G2vTkf8OieiuVk1+Co5vEHfYuss8E=;
        b=CHDNOifZ8tkzQRyRNcZaseJlM/TyTZxtWvBGDNk8/Mt5sSdDQpnAbvkv6cwqD4P1Vu
         tPuzqX7dFTLWdF6sEAGKTj6fpclXpzWdYpn3Ik8OvD/pGe1wClp1UqyuvhOsJeLbwAgO
         +r0O7vkkicWi8OzfJzQRP/bkGYen+jvCwcfiC3ZdxAA4Kh+L9yEnE0c+SZErOCeCBfTA
         zl/YTWWgDkh6uxMHSGiledmerDZxAbsOlbGQ/Ak6zp8agv6my66gkEAb/5bvtck7raHQ
         qPttxTLaTghjwmYtRmDXiScyTTHTT/daE3DUmVS2mdtZI6WUEEotU16i0ERqecHDewTm
         PWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeyO8ujnhLSKg2G2vTkf8OieiuVk1+Co5vEHfYuss8E=;
        b=JbBSO5XUcBInX8W6pSW0MiJlsKOWl1yl4T1EeY/72DG62SrMA77P5JhYpEHpyhAKLZ
         z7iLpvMSV36GjqJTpaJ259Ml1KoAeoJTEy1tsohQFUBIZjdP6Ve0RmjBWPwMzIMIbyT3
         i8yU8dvcJKFy/IfsweRsKbqwEqrxY2/wAMqay0kwr8HZczAW0PoZac3b2jB5r8rPW2w8
         IShqjYnEV86Oo+aPRDFJfjxj1p7FXGQPqtFI0Tn4jRKl91thiv5AtQceSDrP1P3gBm6N
         lvpjgUACp2SUIk1gfVt1MuySrO7JglfNQJ49PIcI8LxCoy+seZXo0eoyYNaHjHCSepe0
         S7ag==
X-Gm-Message-State: AOAM530nBxBsDZplS8mzSyPskZTrxh+gSvUVSE611u80xh+HdUXm6b7O
        3lPhvBfUIwKYMFYlH1xt9XD87Q==
X-Google-Smtp-Source: ABdhPJyVn9TYqxOHgnUHtx1xCuE7iRrmYMdgwMUd05PYidhO6ofoPFqBCyiBiF56rn860iD8QyUoeQ==
X-Received: by 2002:a02:661c:: with SMTP id k28mr1862704jac.78.1616167465540;
        Fri, 19 Mar 2021 08:24:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id b5sm2686887ioq.7.2021.03.19.08.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:24:25 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: ipa: update configuration data
Date:   Fri, 19 Mar 2021 10:24:17 -0500
Message-Id: <20210319152422.1803714-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each IPA version has a "data" file defining how various things are
configured.  This series gathers a few updates to this information:
  - The first patch makes all configuration data constant
  - The second fixes an incorrect (but seemingly harmless) value
  - The third simplifies things a bit by using implicit zero
    initialization for memory regions that are empty
  - The fourth adds definitions for memory regions that exist but
    are not yet used
  - The fifth use configuration data rather than conditional code to
    set some bus parameters

					-Alex

Alex Elder (5):
  net: ipa: make all configuration data constant
  net: ipa: fix canary count for SC7180 UC_INFO region
  net: ipa: don't define empty memory regions
  net: ipa: define some new memory regions
  net: ipa: define QSB limits in configuration data

 drivers/net/ipa/ipa_data-sc7180.c | 30 +++++++++++++++---------------
 drivers/net/ipa/ipa_data-sdm845.c | 25 +++++++++++++++++--------
 drivers/net/ipa/ipa_data.h        | 24 ++++++++++++++++++++++--
 drivers/net/ipa/ipa_mem.h         | 10 +++++++++-
 drivers/net/ipa/ipa_qmi.c         |  2 +-
 5 files changed, 64 insertions(+), 27 deletions(-)

-- 
2.27.0

