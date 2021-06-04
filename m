Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0E939C1F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFDVLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhFDVLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:11:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F52C061767;
        Fri,  4 Jun 2021 14:09:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r13so6121198wmq.1;
        Fri, 04 Jun 2021 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYFV0srmfGQRc7dn8dE+4bhDucZZhZ154l7f+7GwPAg=;
        b=saapGm5k0S+8TyIp2cDmjRAhUK981fh2laRJVdALTK1hGBWzOZ5HEhgTl/YmiFWHcA
         jbWWq61jbN99vj01OHINbHFMGM+4lLsgLxcWHlFoek2uI+dlkj0tWKk8iVgKZcQb3JPN
         6OuGbr325nw9H5jbFx2BT6fg+i2uHzxR5tb759i0sqehLqplGgwuYkkXm0Hj3Q9tN2ek
         /5LR+dsygODJ8mjmbOsplg4/4KuPO2zu6Rj72GENn2CNYH8tFzZuzG+L42M5qOGx/olF
         EWBcrCJiu1h3afuKOKJEETUXevNEhHtuzUZ34zl3db96+9m+A2b+WxZWH/KDV7Ryd6PM
         041Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYFV0srmfGQRc7dn8dE+4bhDucZZhZ154l7f+7GwPAg=;
        b=hzC8wzN//oSeuzbKpRkBm/4X7QbfE3XsGVcdFdBzCyburfp44OrIJ3lICYLcvaE6b2
         MT0F37MxXDkR2xiwyogbiIfRzwmmM3OYKMEOIZLJq7bOtX34n+1kBTxodwhBxaJFJi6l
         VAYkiT20XAiPy0SAVessy7xH2knHuvFVzTknmhfnXUxi49OLUioPOxxKP1+NCGA5nVO0
         RWnJvDGLmOxfCRQTKBcqi+5fZozLMOxE0skrwFK6eWOOS5ZMuV8zn35tuM2IicKhicGA
         TRx21xNdfER/JKIhuwiip/X0lkQx/upIyCr3Zv4HPNWA0xsSrb0rlobbf4Y82ekUTez1
         iczw==
X-Gm-Message-State: AOAM531BxD/QuS5OfP9YB+mX8ckAlPB1bp+AqiNs8Yt4bd3cO2r87kjY
        xNLFgNXZazhGrKKMw7/W9imxD9IFxbo=
X-Google-Smtp-Source: ABdhPJzO5GlbLLXgfwhsCaXSQUzL8+hzf65UAog/9EDdbFuIVl8kHGRUlTCTUh08eZo58NKZLVB+CQ==
X-Received: by 2002:a05:600c:441a:: with SMTP id u26mr5404277wmn.166.1622840965909;
        Fri, 04 Jun 2021 14:09:25 -0700 (PDT)
Received: from xws.localdomain (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id l5sm9478853wmi.46.2021.06.04.14.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:09:25 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/2] platform/surface: aggregator: Fixes for user-space interface extension series
Date:   Fri,  4 Jun 2021 23:09:05 +0200
Message-Id: <20210604210907.25738-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small fixes for "platform/surface: aggregator: Extend user-space
interface for events".

Specifically, prevent use of an uniniitalized variable and drop an
unnecessary initialization.

Maximilian Luz (2):
  platform/surface: aggregator: Do not return uninitialized value
  platform/surface: aggregator: Drop unnecessary variable initialization

 drivers/platform/surface/aggregator/controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.31.1

