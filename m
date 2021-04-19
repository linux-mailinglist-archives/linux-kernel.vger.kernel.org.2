Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42CA363E77
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhDSJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhDSJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:27:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896FDC06174A;
        Mon, 19 Apr 2021 02:26:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n2so51780805ejy.7;
        Mon, 19 Apr 2021 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tY/k7LsOZFfK3RtnDp9XwkFm0+jK9FFo4MbEp8JdMEw=;
        b=ZXzxvvy3LwGpIBsBfaYmc1JNUzabvrf1FbwSkGygBhvjt4Xtb0B3P9WVgLELJGxZad
         UzY5km4GpYuoN8KHtP2pmOgyTthPE9FqTPLR67dsEN4lUPWK2mzf+HonUpI398iKa3Al
         0lgWFtdqKyv54RXgpi9R5OXo5HRdHCp//CZuYqBi4J1WfFpmAs6V8khSJJpk2qJn1BoR
         l1/QNsRm1cPwR9rPnKM40RW3p5z6OZIQmjugrZV+V/HXKMD/dFn/ouGKN/kVM6mt6GdZ
         BLB5SfG5AdmtxUEaWs1cqP3RJQ+fx6vEWe1KZySI3Jt/vAimxvfMY8ly+FAfp7sp8po+
         RRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tY/k7LsOZFfK3RtnDp9XwkFm0+jK9FFo4MbEp8JdMEw=;
        b=NrpvAzLUdaksJsL4SDOL6pHGubhTKc92veqsDGNs1u/nkgbAKlCVf9tlnnXH/CGNDJ
         gGeXW6JgUaZS999Blsqpf5hkYyf1hdlhLq+BMfrRKMoXRQlghLdsRigTBcGtG92/9RDN
         biUC308U/jwI1Pm7s/XI/IykSd43af6FUd3rqOAETJu1xrCl1N499DE8uLQ1aNOx1lL8
         JFjro03Vijuyk0658GdWf6meoYH4ikVUVmK/jl9Q2VJvc81R0lp0w4MrSCBgvuRsGong
         WC4Qpf0/XDpZBmu6l/bK50trjKpEszB3m8lYrN81Yg80GgOur+dz5wnzhIDJYcA1lMFe
         6CIA==
X-Gm-Message-State: AOAM530EUVr8NXCX9nd5mfwUFM555uoxIea2aOfazA55FJoqCMZBuvuC
        wJVc6CEiSWETMKCb+m71huk=
X-Google-Smtp-Source: ABdhPJynh94GHJwQQV1jYlxE2a7c3BzPkA5iEX5nGCa9dI0cyNp+Wi+59nZGyhZzt8AvNnrqAay8og==
X-Received: by 2002:a17:906:3509:: with SMTP id r9mr21161478eja.490.1618824378181;
        Mon, 19 Apr 2021 02:26:18 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dc6:900:a414:a08d:9e82:6738])
        by smtp.gmail.com with ESMTPSA id bh14sm9943706ejb.104.2021.04.19.02.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 02:26:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND 0/3] Rectify file references for dt-bindings in MAINTAINERS
Date:   Mon, 19 Apr 2021 11:26:06 +0200
Message-Id: <20210419092609.3692-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

here is a patch series that cleans up all file references for dt-bindings
in MAINTAINERS. It applies cleanly on next-20210416.

This is a resend of the still relevant patches from the first submission
of the patch series [see Link] on 2021-03-15.

Could you pick this series for your devicetree bindings tree?

No functional change, just cleaning up MAINTAINERS.

Lukas

Link: https://lore.kernel.org/lkml/20210315160451.7469-1-lukas.bulwahn@gmail.com/

Adjustment from original to resend version:
  - drop subsumed patches

Lukas Bulwahn (3):
  MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
  MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
  MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER

 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.17.1

