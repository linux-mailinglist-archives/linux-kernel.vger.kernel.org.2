Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48F3FB90F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbhH3Pgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbhH3Pge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:36:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDADC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:35:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so183467pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ycmCKNPJgpcB3YMEss9Ra0DZx7JMWRVdCgZx9z/DNn0=;
        b=CYcFHCuVeNg1qUbDtLgxHOvwlLpT8nf/FXWHUZRQEpAOZApYO5oYzGFw5ttfZlPey1
         bmnJ3v0sX6/55bPQM5gxjOPkc+Hya/WOfzDq8VV0R7hDXVAZLAf9CM5a4iltNUR3io0B
         aHefaHB7+lD6uD94osrn3n63ZdVAvgpjCBoDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ycmCKNPJgpcB3YMEss9Ra0DZx7JMWRVdCgZx9z/DNn0=;
        b=qQXMTD/7TfOdlpQC0IY74CVFaUBWzzbUi2fyrhtYtBQEgSWqPvxiXv9DLjJevnLFoa
         HQXPQdkSfKV3OUthi2Nkl7VvQoIFHKWK7SQP78q4mWaWDcBktlm4GxfjdsRE5fuQy7QJ
         YY65ilC+3Be66nio9n7lwT+syTfatEnPYOff5WJz0moy73uYBXt/AwXwhKLKCQX3uryf
         NVYwET1VvIkTQvcS/esLpZBchh/SF2bLB1zBfAjqySqgVlYj30o/6/8Ff0nF16Cf4cX6
         uWafsVLywtbstq9EotQ6PlZkn4qKdzumdIL2C1mDLCl5k8XJpNQ7FmXJVYLM4+F6twh5
         CDOA==
X-Gm-Message-State: AOAM531gFFNDBt9A+zwhS9btnpXdX2npLnUpltClIAA9KiPGC81D8yVb
        aCt0www+Dk/jmU33+Dkl72eKgQ==
X-Google-Smtp-Source: ABdhPJwi32UTr9IwxTycPbcvQxxUNoOHq7+rN9Cnb44EOMY7EGG464Xxpt7qBKn+uz2xtnJUWiaY0A==
X-Received: by 2002:a17:90a:29a6:: with SMTP id h35mr27349351pjd.188.1630337740577;
        Mon, 30 Aug 2021 08:35:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:b658:7113:70a2:ea])
        by smtp.gmail.com with ESMTPSA id i1sm21115438pjs.31.2021.08.30.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:35:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: core: Add stubs for nvmem_cell_read_variable_le_u32/64 if !CONFIG_NVMEM
Date:   Mon, 30 Aug 2021 08:35:10 -0700
Message-Id: <20210830083449.1.I38e95343209fe1f808c3b4860795a00a2b539701@changeid>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I added nvmem_cell_read_variable_le_u32() and
nvmem_cell_read_variable_le_u64() I forgot to add the "static inline"
stub functions for when CONFIG_NVMEM wasn't defined. Add them
now. This was causing problems with randconfig builds that compiled
`drivers/soc/qcom/cpr.c`.

Fixes: 6feba6a62c57 ("PM: AVS: qcom-cpr: Use nvmem_cell_read_variable_le_u32()")
Fixes: a28e824fb827 ("nvmem: core: Add functions to make number reading easy")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
It might be handy if this commit could somehow end up in the SoC tree
soon-ish to fix the build warning. I expect that the "qcom-cpr" patch
will be part of the pull requests send in the next merge window and
it'd be nice if we didn't end up with the build warning in -rc1.

 include/linux/nvmem-consumer.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 923dada24eb4..c0c0cefc3b92 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -150,6 +150,20 @@ static inline int nvmem_cell_read_u64(struct device *dev,
 	return -EOPNOTSUPP;
 }
 
+static inline int nvmem_cell_read_variable_le_u32(struct device *dev,
+						 const char *cell_id,
+						 u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int nvmem_cell_read_variable_le_u64(struct device *dev,
+						  const char *cell_id,
+						  u64 *val)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct nvmem_device *nvmem_device_get(struct device *dev,
 						    const char *name)
 {
-- 
2.33.0.259.gc128427fd7-goog

