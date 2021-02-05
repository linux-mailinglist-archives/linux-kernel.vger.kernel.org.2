Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722EB3108C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhBEKND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBEKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:09:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945BC06178A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:09:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a1so7015040wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fzuLP5q7Y22hqk74qWKi13wdAskCgNT+M/at9DAaCkE=;
        b=BEmrVD1In3nVLxXUkMz0EIQjZDJHJJghT2E+tIr5YJbppShCB1e5cwg84JKjFf7JMV
         v+HQgPfoal0s+B2r8L2ONAImTPZAeK6sGjPmXc4Yig7m6T7dsZyRWzFCkqvJwEQOHgb9
         bNe9P6E/Yl7sJbyQCsmQ1/HZuKMfPK/WB42msS5rup0OFI2kDa0kx2E6lThaTovjV7wi
         /wCjQDV6sQYsnhM3i7a4LLxn7BlkCK3X0mc8E+yD5D5V7SZt2igawr/DD4OpazHlN/c3
         ImQGoqBvVSWCkUgcm24mH39SE6WDmaQ52lidRIU2or0At/kelbEn45TuRNAXNaGU4RPA
         R3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fzuLP5q7Y22hqk74qWKi13wdAskCgNT+M/at9DAaCkE=;
        b=ooqCW+kLF8oAA+8nFAmVF0Ewj1P1NtE2e5RyjvLwLQdcV76jRJUdulDkrqupqKf3af
         dc3iGNBFoUX9h5YgOztxt4mvlXo1cmHExL9whMwxg892PpG5QGK0fXHjQefTzK9hMx85
         4xBrwjp0sI0c6D/HSLQPGxKmRmgtTRqY5Uqbxjl2YHBquXnV//H03+J9TIEk0dmnr3Hp
         Llqui7gFF+jV4wBtVh5u9FRQBN/EiXC/8d3o5JuHwOMDn1iRDEWuuKunsETrIc6lrZ0x
         3gWJY+cjwgHfHHiTs+RwqlguXAVuHvxsz54kzDnxTD5TGsWdfEx1U/kvOAfh1jp3nfuD
         EBlw==
X-Gm-Message-State: AOAM532tpmVvTDtUohnMTbrDmxEXv9TyGc4qRIrrj+TaLbfg8zMm8znX
        Yp/iRFSUbdKYQJTVkqLHqUpcfbEUkvtZRw==
X-Google-Smtp-Source: ABdhPJyEkRChhLPMlqP7bnsV2B5qtwgp044ldrCaFivcyhOXqDXfCcvrTtwZLuD65RbRlIO+m/5GwA==
X-Received: by 2002:adf:e4c3:: with SMTP id v3mr1860432wrm.210.1612519744690;
        Fri, 05 Feb 2021 02:09:04 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g16sm8067738wmi.30.2021.02.05.02.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 02:09:03 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] nvmem: patches (set 2) for 5.12
Date:   Fri,  5 Feb 2021 10:08:51 +0000
Message-Id: <20210205100853.32372-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some last nvmem patches (set 2) for 5.12 which includes
- fixing a typo in Kconfig
- a fix of uninitialized pointer

If its not too late, Can you please queue them up for 5.12.

thanks for you help,
srini


Nicolas Saenz Julienne (1):
  nvmem: Kconfig: Correct typo in NVMEM_RMEM

Subbaraman Narayanamurthy (1):
  nvmem: qcom-spmi-sdam: Fix uninitialized pdev pointer

 drivers/nvmem/Kconfig          | 2 +-
 drivers/nvmem/qcom-spmi-sdam.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.21.0

