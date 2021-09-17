Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5C40F15E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 06:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbhIQEkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 00:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbhIQEkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 00:40:04 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D293FC061574;
        Thu, 16 Sep 2021 21:38:42 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 6so12271818oiy.8;
        Thu, 16 Sep 2021 21:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lhOVIgjjrnsjtCfDU8TGEmY7M2yrzSS07/ybU6sxHVI=;
        b=DMCiF4iLY75hf3LxgJlXv6fEbn3GWxWhwkYXMIouAsC+ipv1UkP5ojvHb4VSq7jsxW
         ovReFlihkLPXLSIMssD2Gu/P4Nnx8329OChIvVS8ElDxjJ0//YU3JZNVc3qzO7QcpikJ
         +9/98awoM42LW3xOvAh4BLnwpVrOrkrnMkIR7IKnxKzezwluDzQ2H/9RFSKbRQ34NDXF
         DtN68MH7LPdmRPd+6ZcyNRuIpG80hHPiR/2H43WnqP/qJANETm9lrhNL0L+4dktoUsJy
         KSYYbisidBo0lx92Eog4hNhkuFZFnTkqXlEKiCCYt87ndTLxVen7dTAMvfhPQrBFNVyy
         e28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lhOVIgjjrnsjtCfDU8TGEmY7M2yrzSS07/ybU6sxHVI=;
        b=yxPXGkkZn7sEhfOCS4lscfomJjSDG/mlZYeWpvlP2qtg9YOIrq84tzfNCfMWvsLSve
         YcQPKJdJjUePGfd++HR4lXS76nhQqmojRiQHAoHHsTi9Q34vBXyFmxgRWSM6+8NmMsdU
         nawGqXW1hDFakZSiatsV2rBuEniaXocdjkROZcPq/gVFYra0OOxKFUrFmQEDDrhCOjJT
         VyyGVob+vG4MYbdFoty9YSug22w3eTAwGQuSZw1YHhY2CRoQNvbHxdA39JWa2fFtLOpc
         FUwAlnB7To34q2b3n0Tg+RGQ0B612CmkQe5SP0HGWLKbag8eNi1LGzoJxyoS4YITRa5Z
         vO6Q==
X-Gm-Message-State: AOAM533JtAPARN+dbCKS778AoUyxp7I0YDlQyhpXrm4v8pwbA68gv6JM
        JsPa1Oih/UU/hUlPcVGtvUGb3InYD6A=
X-Google-Smtp-Source: ABdhPJxzw80Fnzr6EyvIrWiTj5GATbkZm9+zouwgnw8Zw40sFmurUzWpWAtHgj/3+tlSqjWy4YhiTA==
X-Received: by 2002:aca:744:: with SMTP id 65mr2985092oih.174.1631853522239;
        Thu, 16 Sep 2021 21:38:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 65sm1168486otc.32.2021.09.16.21.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:38:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/3] csky fixes
Date:   Thu, 16 Sep 2021 21:38:35 -0700
Message-Id: <20210917043838.3514789-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches enables building csky:allmodconfig with
upstream gcc.

----------------------------------------------------------------
Guenter Roeck (3):
      csky: Select ARCH_WANT_FRAME_POINTERS only if compiler supports it
      csky: bitops: Remove duplicate __clear_bit define
      csky: Make HAVE_TCM depend on !COMPILE_TEST

 arch/csky/Kconfig              | 3 ++-
 arch/csky/include/asm/bitops.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)
