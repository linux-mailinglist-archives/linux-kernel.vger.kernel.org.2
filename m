Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA47B40736F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 00:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhIJWiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 18:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhIJWiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 18:38:15 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D1FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:37:03 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y18so4315853ioc.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IFaDdxqmF/T13hXPY+icTVWA4xnaWqbUGckikX+9UCU=;
        b=KApiJDO81GVjSe/Z5tZbiWT7xBq6x+evwNXRfNs5RxZEPC2ify4IT0CqzG77T4ST0Q
         X6scXMZl6SsRESo/jZKRhAjsAtrYu3UdNdWj6DxiySx8DrSs2E+wmVvV0gMTCVP4gbDd
         AQGB/Mp3fziOhTu8BRTusYT07k4kOvvMt0+JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IFaDdxqmF/T13hXPY+icTVWA4xnaWqbUGckikX+9UCU=;
        b=8D1TPWLiKznHwXoA9Hd6iIYCheaLnO+2zocfniSjGT/u286gH7sgmSk40I+oZj1v0A
         pLgQnsweMrAqjnHWl5plIJ/FjqZ1zOAeMyqC+z7o5Rf7qBhBwxlMcTqA0YHIFDya55lR
         1GGythnsl2FFUNUaPCrEH+kF7XqURYJWlG4trEIuqrXhQ2i3GofGTtsmgfSl4gEhFwbI
         zehPgtEGaV8yl+q8Ep2366kPPo1+YuZfXfCTTWF3U+Qs3CiFHFpb5X3dtQVibsjfSSN4
         K/4dZFtZ54eaTkg6ZoDU7Amqsnu2LP3EYCLBDOurlkYeSzLIcRTpWU8pMzkRFKVaB19H
         bT2Q==
X-Gm-Message-State: AOAM530BmDygBQbUhKL8gI31njaehnR7LTkPjNIpaKdtJwwghVznhL5d
        bCiQLsOWFSaJFhcUusf3JaVZxmEslZhSGQ==
X-Google-Smtp-Source: ABdhPJyo1Zzq8WZa3h6TAc80j+2p7KisrmCeonOgHtXV/Hhm9GdGRLW7KTmjd6/XBPFJGcOPMU6sWg==
X-Received: by 2002:a05:6638:d1:: with SMTP id w17mr46388jao.33.1631313422678;
        Fri, 10 Sep 2021 15:37:02 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c23sm21623ioi.31.2021.09.10.15.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 15:37:02 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org, paskripkin@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: fix control reaches end of non-void function error
Date:   Fri, 10 Sep 2021 16:37:00 -0600
Message-Id: <20210910223700.32494-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build error with -Werror=return-type enabled. Fix
input_system_configure_channel_sensor() to return status when control
reaches the end.

drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.o
drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c: In function ‘input_system_configure_channel_sensor’:
drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c:1649:1: error: control reaches end of non-void function [-Werror=return-type]
 1649 | }

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../media/atomisp/pci/hive_isp_css_common/host/input_system.c    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
index 8e085dda0c18..5d088d6fb01f 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
@@ -1646,6 +1646,7 @@ static input_system_err_t input_system_configure_channel_sensor(
 	default:
 		return INPUT_SYSTEM_ERR_PARAMETER_NOT_SUPPORTED;
 	}
+	return status;
 }
 
 // Test flags and set structure.
-- 
2.30.2

