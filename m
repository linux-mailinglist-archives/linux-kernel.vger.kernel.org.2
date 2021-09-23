Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7607D4166BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbhIWUcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbhIWUcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:32:33 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6850FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 13:31:01 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so10293181otj.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrQFnds+enloHfbnp7JiG8L1TA0qPsvDwBgojFxND+Q=;
        b=nccO5lqvS//QTh5SlYby7k5r8WGPEH2qrdntZZueS9PBJ/kNcUUyyscIQAedeb9Zi7
         rKzaBZ3kv8EeRzkzRiDuutE2hh40P8jTdUKsLo3SIsulLUT1z/v+qxDiJK9rPHqHvF7B
         5Utcd0QU9dK4U2fgZkBECtU4msOizit6SckVwoSMJhWhwCpcncNaLDOewvqVrfvMM3Le
         TDCBhJ6zcNKLHm8TpTefczUDfR1DNc2FIWZUvkZ+y2WI+bc5L5BbWXnCrXAAV/+sLmwz
         /KpFZcwHGK9I5hQQkABgG0EBzE3uEXzT8xfEMSMJgZ6PcWsXT3gvhF+g8hDr38pjT85j
         1OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrQFnds+enloHfbnp7JiG8L1TA0qPsvDwBgojFxND+Q=;
        b=wvBoEVzsjv9Gx9tY2LTMaGbVkViV20BAEIdO29E3cHYu41DFESb59fWlqGhYIoSYjL
         gZd45Iy4FgsUWNcOKIW7GhGjCYJaqNWblwI1KEpCSCV3kqhfXS2DmtWbjnVDUSBd7ppv
         WHfhrKTNTj27F7nC3OvGrQrdlEPtgHdmF1B5/+j+YnERWobRdwi2XpSK/2rBBRn2JzYa
         K/qxokHDSFGL+MRSFzNJy9LQ0M6wR5U4n32nhoLOQFeL+mI8u/Lnkp3m4HR0Ic0zkWFm
         S/G3uz+CrNtH5fAHOiLxeUiV+QM+M6ssZNgrGqIzNk/l4OjvszUM4diDWCiGCMV7GxG8
         vMdw==
X-Gm-Message-State: AOAM532A5blLvdudw/sygVuLfx/ky4+VuxDcbYVgXtjijiPfSCPIA6VG
        YtkAsgTf4WxHT2UVi+zzaR/W6t7Q1Wyerw==
X-Google-Smtp-Source: ABdhPJxUf5eO7r2N/fQhBxg6FPAUzflU7DkCc2cdcpBbZpmn/8zckffn1DG/Ln2HKz/m1nZjs7ePDw==
X-Received: by 2002:a05:6830:805:: with SMTP id r5mr549124ots.209.1632429060685;
        Thu, 23 Sep 2021 13:31:00 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i1sm1583036ooo.15.2021.09.23.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:31:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     sibis@codeaurora.org, swboyd@chromium.org, clew@codeaurora.org,
        Deepak Kumar Singh <deesin@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH V5 1/1] soc: qcom: smp2p: Add wakeup capability to SMP2P IRQ
Date:   Thu, 23 Sep 2021 15:30:58 -0500
Message-Id: <163242893971.825761.9497807239519479301.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1632220467-27410-1-git-send-email-deesin@codeaurora.org>
References: <1632220467-27410-1-git-send-email-deesin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 16:04:27 +0530, Deepak Kumar Singh wrote:
> Remote susbsystems notify fatal crash throught smp2p interrupt.
> When remoteproc crashes it can cause soc to come out of low power
> state and may not allow again to enter in low power state until
> crash is handled.
> 
> Mark smp2p interrupt wakeup capable so that interrupt handler is
> executed and remoteproc crash can be handled in system  resume path.
> This patch marks interrupt wakeup capable but keeps wakeup disabled
> by default. User space can enable it based on its requirement for
> wakeup from suspend.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: smp2p: Add wakeup capability to SMP2P IRQ
      commit: 1a561c521ba901ac86acaf698e79ad6ecedbec2b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
