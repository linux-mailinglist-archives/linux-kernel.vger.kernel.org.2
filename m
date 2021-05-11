Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AA737B099
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEKVO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhEKVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:14:52 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C144C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:13:43 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id v4so6936497qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gqxX6Vz+pymSRyXtv27QA0TQ7GwQhPZuzfC0VUoUs5Q=;
        b=emlCbxgPQhBW6tBKZBOZ5Xop6Uu8DAj7/0wu3WbzVPRLh7QVGxetZVVFTfGKTKSO52
         PNcQq/BtN7c5ggwO9pg42Tadw7e9853RiVacQNxfpqn9QZTcyD1+wZYAv2fDycTobf3A
         dj8/8vw7e9vOpGIABvXx+g/WGf5L4qA6klTZAzw6WlbpawznXSK7kPfREcAz4/hgSzlM
         wXu6jGMiUsvpx/w0oOd2Axu+F7HFnnklLM44sroX4OaFSNe4k34sSl+ctAiyY91HCozX
         pLVTG4GDVAeEefdJLiMv+R6AfaUxvdFpl/l8kZyhRvPxGLcws++vS4gQzedfhNPv1aoF
         g36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gqxX6Vz+pymSRyXtv27QA0TQ7GwQhPZuzfC0VUoUs5Q=;
        b=RHkhbn14IML+R02EBQfZR+uoCkhdaj6uc4eAY7tAIqX4uvpuePGy8x1R/BVlhPckUR
         cNaqweJhfxjQj8d3AjOtAcHUpCTIDNSSLNMTV8vWl3Tbi0wZTl25Z1IYedWWZ8KEFtC7
         p7PTOz+x5i0VQS0G4oK8wQwONDGBCXHztOG2/CNP3pH8j7kQFbQiiAdsiQRDipTgnMqE
         8rO4ItxgW5JEfLONU1NGfsUPZr/6wzQcaus6hIiYEKC2px1tr3cquIZaTAMiKE92AvN7
         RkrAWEoV3lr6hbCUtZcsHGuua5e+fbG9L5lKiG6vn5YNcB+2hftxmyFDRXq8y01PJ/98
         aaGg==
X-Gm-Message-State: AOAM531a9GMxGVz31Xb3szcSRiyIOg22HXiT7dXAHFjaqh3eWMA8JVtz
        iJ/nHHFKzKoQI0cuztQkHRk=
X-Google-Smtp-Source: ABdhPJyucclwtqzlHg1LsYabINNWi2wv63iyqGfcntmYPwSs39gtBwGdSfdvi3uoBwg/u8teCvzMyg==
X-Received: by 2002:ac8:5253:: with SMTP id y19mr10835480qtn.380.1620767622402;
        Tue, 11 May 2021 14:13:42 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:f9ba:6614:640b:eee1])
        by smtp.gmail.com with ESMTPSA id g64sm14780392qkf.41.2021.05.11.14.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 14:13:42 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 0/3] regulator: fan53555: tcs4525 fix and cleanup
Date:   Tue, 11 May 2021 17:13:32 -0400
Message-Id: <20210511211335.2935163-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tcs4525 voltage calculation is incorrect, which leads to a deadlock
on the rk3566-quartz64 board when loading cpufreq.
Fix the voltage calculation to correct the deadlock.
While we are at it, add a safety check and clean up the function names
to be more accurate.

Peter Geis (3):
  regulator: fan53555: fix TCS4525 voltage calulation
  regulator: fan53555: only bind tcs4525 to correct chip id
  regulator: fan53555: fix tcs4525 function names

 drivers/regulator/fan53555.c | 44 ++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 17 deletions(-)

-- 
2.25.1

