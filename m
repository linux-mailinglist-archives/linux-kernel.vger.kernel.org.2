Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC47D3E2707
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244395AbhHFJRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbhHFJRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:17:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884BDC061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 02:16:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id x17so5132231wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rm9dmvf7NyAu0BtSIxArzSGCpnF+/iNzeSptP2c8L9g=;
        b=MPk6/ImcBnaCeQu8Gx+ZCKPMKHUeJZKe57B2GEfa+77gy6YBCsui/vKYHPyiQsiKrA
         kVLFNRN5f+wycBz81UF9xOdVd/Izb6YjnxQGOyVbBSv0NkKysKtIUs93rgA4jRMjI2h1
         Jy7ZlBeQ4oa2EAXfD5FPFnrTRTNsI9srntUx3QesDLggkkGOAfVQzhk/weZ809nqGuk8
         9IP8xX2y0hMcbs7D+nlStn2puRRW0emh5a0QENHqZg9FTla6ptGrcBwaXUI/bsDukeuN
         HfZm+bpvn+4CGYW2Lj0dmwfLmx272UM/m6ONsZkIAvT+X+vGMeYHP8/KVVM7NpTUSHCC
         WWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rm9dmvf7NyAu0BtSIxArzSGCpnF+/iNzeSptP2c8L9g=;
        b=RT3cz4iBb21dBHsSEP+tJ/z+bxWQL1zDEP2YZmuMvQmD3va2L+FBrup7k3P4w6hydQ
         VAvhJtCR228+Ncq4YguAKbEHLfjqNXbW6OZr0IIz+7Dit9npDzsK+Lu7R2gyaIAyrBZR
         Fw3r/M+1A75xtxHmgiddYRsiR7xXLGWQUwrevNpAPESf2+9uCyguUWipqMoa6fv3PBvd
         xyrlr89x4oqLcwZQ+LB5vugg3/AlWLU0+LwAhPm/9aM68UmanmekElD390wvl7chvgOZ
         +ishROupDyTL7TzwGiaAYjegMYNrMhUVRNwtBBZBDZVTavWPOdABgvaXT6d5Puj0ZlZ1
         hkwg==
X-Gm-Message-State: AOAM530PbxWpjUhMaCcrBvFBuBG5kW1z8/I6FC7ReCE60dN/t4O/ljjh
        gcatgQ/vNqseFWOZNBayFfM7Yg==
X-Google-Smtp-Source: ABdhPJwpewNme8tsMKytK4GImiJ+VQaL+Uc/0MQn6cIuxWU3fxsXaZpBqw5KdIYFbvtgTaDqlHTwTg==
X-Received: by 2002:a05:600c:4308:: with SMTP id p8mr19862807wme.45.1628241405235;
        Fri, 06 Aug 2021 02:16:45 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id w3sm7811760wmi.44.2021.08.06.02.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 02:16:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] slimbus: patches (set 1) for 5.15
Date:   Fri,  6 Aug 2021 10:16:35 +0100
Message-Id: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Recently runtime pm testing on slimbus reveled that its
totally broken on SlimBus ngd drivers.

Below are the fixes to get it back working.

- One of the reason begin incorrect device pointer used for
runtime pm and in some places

- Second one was to do with unable to validate transaction id
 which resulted in negative runtime pm count.

- Other fix was to do with resetting dma addresses once ngd
controller is power-cycled.

With all these fixed runtime pm is now fully functional on NGD
controllers.

Currently I marked them all with Cc: <stable@vger.kernel.org>
as these all patches are required to fix runtime pm on SlimBus
NGD controller.

Can you please queue them up for 5.15.

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

