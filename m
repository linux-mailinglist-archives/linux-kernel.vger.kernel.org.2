Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EB544A48E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhKIC2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbhKIC2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:28:53 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9283C061766
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 18:26:08 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f5so16989292pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 18:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Q2XXtoLJL00suV9nfAUEcGT4qZnNfnnIEyDWr+YV8w4=;
        b=xfChmhnwRfWXYIb8SdijH7DpY1iPLgrmKu4oTqF8k/lmajZxwzxHZ34rHA/+ASiWE1
         LhNzzQIcAMViGlhKi8O+tw9zVPSolI4VyuXB9ZoJQ7yO3s8ayOlIZEpoLCUqApa9930S
         lnYcxkZcNZWV8ah/Qx9sxYo65ytsIaKqK6Jegk26pNkGsQslPdTvmuUbverWtKTYvnmy
         S5NqrxsnOOqGIs2Hrl3ikBt2kQsxDQesNn0Swa0y69LBW+0r9/tvQRa4ZkrxgqEpHx/G
         odxRMKLl04bQQwOiHI8xAi9845Ul+GLQdpK2d9Erkqg+Mkk6V98BMo8Rik8iEMzy6vSK
         3Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q2XXtoLJL00suV9nfAUEcGT4qZnNfnnIEyDWr+YV8w4=;
        b=cWn7jNbgAyIyA1ZA3/dbaTBXsMvsjW+WGHigaFoKBFZ3Gr1T9zDyJsbBipdVZuKVQK
         mLDZjriPKpujMSOcZOnFQ6JYTmR10lLfUbeBSxtVU0BAEylwtFyXsLBfDmEFKdJO0sCF
         +N3itFTJ2u4txVtUIOOj00wvp2zvXICCSWdhN3PJmi9OSiHXFJgf38MW71c2P7uTsu5N
         ESn7ADzMvw4d+jWUE8DUoSscz8BorKicC1PGmRjCr5+O6mWGScrJMinY80QY/JidOVaw
         0CSluO0K2rwlrujDD3DSPp2RKIIY5R4OgDGXqF5ubpKUaxLkfixv1jh0WSm7wDW0giLp
         aFJQ==
X-Gm-Message-State: AOAM530pZq20vQ/o1TCyEvI6DN8RQ8Ms2vOkJtzvoLtyEDNF3SvbpI+7
        QeQacTbwxo9ftTdFbzPeJfBpRw==
X-Google-Smtp-Source: ABdhPJxNrOgRZxk1kFYUbbDWZbNMjuMIgU76QUqpRw+t2ghhx3bkHXXLY7hb/02cr3EXaXM2ASmIVA==
X-Received: by 2002:aa7:8019:0:b0:44d:d761:6f79 with SMTP id j25-20020aa78019000000b0044dd7616f79mr4395020pfi.3.1636424768218;
        Mon, 08 Nov 2021 18:26:08 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id om8sm589619pjb.12.2021.11.08.18.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:26:07 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/3] clk: qcom: smd-rpm: Report enable state to framework
Date:   Tue,  9 Nov 2021 10:25:55 +0800
Message-Id: <20211109022558.14529-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the enable state of smd-rpm clocks are not properly reported
back to framework due to missing .is_enabled and .is_prepared hooks.
This causes a couple of issues.

- All those unused clocks are not voted for off, because framework has
  no knowledge that they are unused.  It becomes a problem for vlow
  power mode support, as we do not have every single RPM clock claimed
  and voted for off by client devices, and rely on clock framework to
  disable those unused RPM clocks.

- The clk_summary in debugfs doesn't show a correct enable state for
  RPM clocks.


Shawn Guo (3):
  clk: qcom: smd-rpm: Mark clock enabled in clk_smd_rpm_handoff()
  clk: qcom: smd-rpm: Add .is_enabled hook
  clk: qcom: smd-rpm: Add .is_prepared hook

 drivers/clk/qcom/clk-smd-rpm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.17.1

