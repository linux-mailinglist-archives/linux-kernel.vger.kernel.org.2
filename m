Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F293E4183
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhHIIZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbhHIIZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:25:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B41C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 01:24:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l18so20277559wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDd4lKUJqG8OPU5ddGHsmolwmnjPEUNJaQsD+ZTeFpA=;
        b=tYSF36ydrOwJpte+q7ZqXy2Xxq+VyPGVm5WGO+TOLVKVbVzuSopDOynsBljuzNLSFR
         LI1HFMCJXwx3SNAjNawBEUpb6aca53cHNYtCKPzX6gq6214e2jzD4EmKYsoLUOpCcb8g
         Noog9Dg0ok/C1Cq1eMKA0dStwT0LA8vPIqCOxRI4OsQ960avvKzaI4bytSLSP9M8Ab5r
         4dlDyWKR61d6yq5HZBAK6GRUAbb9BYB0deg1ONuCK9cnWqR15ztyKK425Kn/9wJf2ZMK
         dVkSrT4hl3iu/lkMiP3mbGTkeehc2VPAFqGeBhdSOnjL3W3Md4f1ateH8kb8ySKGITan
         +ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDd4lKUJqG8OPU5ddGHsmolwmnjPEUNJaQsD+ZTeFpA=;
        b=gWFaJuSM9fGZcuWuk/dKhjEHmRtfL+Adfwm1a4SAuwZOtScnwSDf3vUwUnYItp/216
         LrZ+7mEWo7jYUyATLGh08THS/+NVXSDFoDD0Ql9/wJV26EtIL9GleuEf+lPcHnF7qTGU
         dDdI9o17uEcdNgR7uyTrykdoQyZA74nTBY8X0+2reseyEtLH2DD3in5oItMvu9HPr6Xw
         rH1/QqOhJoOlut6FtYgaYV5dBLzYdy1k2ixb0c2eUEskzCaulK6bHu/HCJPbAT74l00k
         lMpN2idcw88J5x3Gh5tIBVGbOA4WDgrNUdST6u2hgExYbHT8TsrVRa8CvBpcahDWMl3W
         qvGQ==
X-Gm-Message-State: AOAM533biILxI92WT6YKVkSKpLnYiT040aX3TuGwIaMu650rHxKlduqI
        00IxzuewzCljkV/TMReBPRTQ+w==
X-Google-Smtp-Source: ABdhPJyo7tKrnyu+n89J73SOlziPdTpwewQPpB7KUPQx2nNSI5Cd6uYgNlOP2fVJVP8neecOkKqf6g==
X-Received: by 2002:adf:df12:: with SMTP id y18mr24088121wrl.189.1628497479893;
        Mon, 09 Aug 2021 01:24:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t15sm18036371wrw.48.2021.08.09.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 01:24:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 0/4] slimbus: fixes for next 5.14 rc
Date:   Mon,  9 Aug 2021 09:24:24 +0100
Message-Id: <20210809082428.11236-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Am resending this series with proper cover letter and subject-line.

Recently runtime pm testing on slimbus reveled that its
totally broken on SlimBus ngd drivers.

Below are the fixes to get it back working.

- One of the reason begin incorrect device pointer used for
runtime pm and in some places

- Second one (2 patches) was to do with unable to validate
transaction id which resulted in negative runtime pm count.

- Other fix was to do with resetting dma addresses once ngd
controller is power-cycled.

With all these fixed runtime pm is now fully functional on NGD
controllers.

Currently I marked them all with Cc: <stable@vger.kernel.org>
as these all patches are required to fix runtime pm on SlimBus
NGD controller.

Can you please queue them up for next possible 5.14 rc.

thanks for you help,
srini


Srinivas Kandagatla (4):
  slimbus: messaging: start transaction ids from 1 instead of zero
  slimbus: messaging: check for valid transaction id
  slimbus: ngd: set correct device for pm
  slimbus: ngd: reset dma setup during runtime pm

 drivers/slimbus/messaging.c     |  7 ++++---
 drivers/slimbus/qcom-ngd-ctrl.c | 22 +++++++++++++---------
 2 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.21.0

