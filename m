Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26924326AC8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 01:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhB0A1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 19:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhB0A1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 19:27:45 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D45C06178C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 16:26:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g20so6168877plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 16:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vT9C4uK5m9m8aSd4JIqeVek2WQmiJglw5BM22hi2qE=;
        b=ExBnl+1zHVaGtFVHNR7bFHyLqGMR9rgJu/ts+PqWr/fJVyC2AZvd3SEpb36Qm8GHB7
         Ta1pg7NnrSVBong/uGVc6ETZ6bNXqj5goRvlhvBhAX9PR6/hlgcaAdtkcLUyO8HRxt9w
         k2xwR2Z7r47DF5mqFNITKvWD0WWUOJbG0K81Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vT9C4uK5m9m8aSd4JIqeVek2WQmiJglw5BM22hi2qE=;
        b=DY0Hh6S+4lW5rzULGpBzpGARQYAEcz/GHAq5hGkY6339PR5AwGsuYM6qQE5E6sphf8
         /62mvoXO0C1WHKRbuT3kBYDyanZvBOyeBtOoym/Uab7DEaW2qoFA+EsoTAY8yx4WJUgw
         ZieBUK7+aXaG5Js+sneM8eOOfH9/c4+JqFBfO07ynNlhsjQYf6QeCzz84yPcZitvxX0H
         FbrPWSKl20m3neyZVgOiIgo3IGAv2qA6fw8kbVFRQWEN0kUtfS6tjgXdNZe+XYhpQEdL
         WPuNVt8gpXxsXWPyXbD4IRmYtHLFaPe4W4wYv6vS+ZIpE4l6V6NS4uT4OIVPKS8JWyNl
         2Mug==
X-Gm-Message-State: AOAM5312OpBgfvqY4gt7A9WCmSi4tfnhUL3NBPpeeDqeWazR74+s9Ek1
        GE9XRntE+hDqat0xYAaG67Wssw==
X-Google-Smtp-Source: ABdhPJxRz+kMv//a9n7/44AZQdUJvK6HEviDg4TqN0DeHJRGDDYbx5409puKNu0VN0yQLeCTKTJ87g==
X-Received: by 2002:a17:90a:b782:: with SMTP id m2mr5833394pjr.220.1614385589412;
        Fri, 26 Feb 2021 16:26:29 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:7525:b50:4b48:1a6d])
        by smtp.gmail.com with ESMTPSA id t6sm9793744pgp.57.2021.02.26.16.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:26:29 -0800 (PST)
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nvmem: core: nvmem_cell_read() should return the true size
Date:   Fri, 26 Feb 2021 16:26:03 -0800
Message-Id: <20210226162521.3.I4bf6b274645a06943a421a90c14a97e8c03e6830@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210227002603.3260599-1-dianders@chromium.org>
References: <20210227002603.3260599-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we look at the gpu speed bin currently in sc7180.dtsi:
  gpu_speed_bin: gpu_speed_bin@1d2 {
    reg = <0x1d2 0x2>;
    bits = <5 8>;
  };

We can see that this is an 8-bit value.  However we had to specify the
"reg" as 16 bits because the value was spread out over two bytes.

It doesn't make sense to expose the fact that the value was spread out
over two bytes to the client.  Let's use the number of bits to return
the length to the client.

NOTE: this change has the potential to break clients!  Hopefully this
breakage will be lessened (or eliminated) with the previous patch
("nvmem: core: Allow nvmem_cell_read_u16/32/64 to read smaller
cells"), but it is possible for anyone directly calling
nvmem_cell_read().  From a quick audit of mainline I don't _see_ any
problems.  Most cases won't change at all (number of bits matched the
length) and the big case that will change is the Qualcomm "CPR" driver
which seems to handle the length properly (it could probably be
simplified now, actually).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/nvmem/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 8602390bb124..00454d841a7f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1379,6 +1379,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		      void *buf, size_t *len)
 {
 	int rc;
+	size_t bytes;
 
 	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->bytes);
 
@@ -1386,11 +1387,15 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		return rc;
 
 	/* shift bits in-place */
-	if (cell->bit_offset || cell->nbits)
+	if (cell->bit_offset || cell->nbits) {
 		nvmem_shift_read_buffer_in_place(cell, buf);
+		bytes = DIV_ROUND_UP(cell->nbits, 8);
+	} else {
+		bytes = cell->bytes;
+	}
 
 	if (len)
-		*len = cell->bytes;
+		*len = bytes;
 
 	return 0;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

