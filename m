Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B43326AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 01:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhB0A1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 19:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhB0A1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 19:27:05 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE0C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 16:26:24 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id a24so6140692plm.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 16:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPMHMPCXzSuxLIFTtD345UsCc5XGfr7wNzeChZhcfKY=;
        b=TWAjXFo23zzD0FdqXg37IGKQSx/NBwMUeTqxWkF5wKx1nhJxg1Yc3Yr3djNYtNXHMB
         rv6zxLRP681F6KAjl6dZiqQAqsFhgcxoOyed6YqhE1Yc0S419y2h+0YU90GdDpryLVqW
         Qe8xrKW7HpvwGCM4oA153EPld0kv7keo4NOVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPMHMPCXzSuxLIFTtD345UsCc5XGfr7wNzeChZhcfKY=;
        b=bci5PMdKWl5NAy+gFGbmbHHnaURpS51rff9JCCZX+HCI9RnuOz731lqNAFbYdC7nMy
         j4lnCGsnltS5F333npOFt5izYHSRRhOGBq3rkPeJTNmvtuTHH1CRxN3YK4XbW8RWNzmf
         2Z0MYSynryiHXhTyd+gY07SB9Dx97xUTsAXm49ZUwoEqkf5ixpNxTMCOxR4YVrV4bAIh
         YAT3VdxwnKr4HFTMUsyU0cQUCg8Pv7yXAz3lw2H99HjbPJSfsOsqrsbenA8XarZP1WW/
         8aWp60O5+784LFp9YdRWnop3sP3foXJat1rFZlbwklferj7tM+IiwKHbrHC5xP7HbwQl
         VcHw==
X-Gm-Message-State: AOAM530FxKj6dDh3QZVa5jn+h840sIIeVTZgwbJ7ZHmswWFkceWGWgIk
        TbaCxtdAvGScjOzfw8GUWdyG6g==
X-Google-Smtp-Source: ABdhPJx7A9Qm+a3u9y2rVrEMPrI01HocE65ALEkSTBLCuLvDAyquykOSg94ZkF0WArrG5JilcgWQoA==
X-Received: by 2002:a17:902:e8d2:b029:e3:c3e5:98ae with SMTP id v18-20020a170902e8d2b02900e3c3e598aemr5586251plg.78.1614385584353;
        Fri, 26 Feb 2021 16:26:24 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:7525:b50:4b48:1a6d])
        by smtp.gmail.com with ESMTPSA id t6sm9793744pgp.57.2021.02.26.16.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:26:23 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] nvmem: Bring a tiny bit of sanity to reading 16/32/64 bits from nvmem
Date:   Fri, 26 Feb 2021 16:26:00 -0800
Message-Id: <20210227002603.3260599-1-dianders@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series was inspried by a KASAN warning that I got at bootup caused
by the GPU driver on my system interfacing with the nvmem API incorrectly.

I have posted a fix for the GPU driver but looking at this nvmem entry
made me question how the nvmem API was supposed to work. I've proposed
some improvements and these seem better (to me) than any of:
- Open coding logic like that in "cpr.c" in the GPU driver.
- Ignoring the problem and just forcing everyone in the future to
  always specify a length of "2" for the GPU speed bin cells.
- Ignoring the problem and specifying a length of "4" for the GPU
  speed bin cells.

About applying the patches.
- GPU patch can land on its own.  No need for the nvmem patches.
- nvmem patches can land on their own too.
- If the second nvmem patch lands without the first, however, it will
  break the GPU patch.


Douglas Anderson (3):
  drm/msm: Fix speed-bin support not to access outside valid memory
  nvmem: core: Allow nvmem_cell_read_u16/32/64 to read smaller cells
  nvmem: core: nvmem_cell_read() should return the true size

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 31 +++++++--------------------
 drivers/nvmem/core.c                  | 30 ++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 27 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

