Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9613FA554
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhH1LLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhH1LLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:11:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D944FC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:10:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d17so5715807plr.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNZVmSi+YWtBuE88PyktsWjMFwWCYEKdMAbg/wYXEfE=;
        b=IRunIA7B/5B3xfhD3JS7Fkuv3bvMTk9oGvsIgFbrUh4JVQ5wViWrhvv3Kdw2YX6Jt4
         Poa4uuDlGp906YUU6E4VbfRJU0AIPPA6PtlX3LLD6DW/yoEbL7SU/aZ2g7kWKprT7VDu
         skFxuBow71CwcMuOVICIfZKo+dyXJV5tzkTdwF4eolrmgIvxzDvmRatADs3o31pa6Z71
         nbCSCgslId63nUtAU1dO5Hks9z13QTHia6KuUK6dk2AguhlmR8WX8dfHD1swHgXJuIoK
         GNQ3PDyyh/jG67JoZiBYsulRy4QrakALjlNGmGvTm4zdoMYft15+C/A/TNBUC1DZfkcd
         gI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNZVmSi+YWtBuE88PyktsWjMFwWCYEKdMAbg/wYXEfE=;
        b=Vvot8OUOiPOVIkFycFMyhq1N7vcjkZAHnRGsJlE9BMw3FpqBK748cqbdNeBV3c+oBl
         yk93wKtiS0VsI+l3QB7ssioXgAK9qqfJY2aI59MrtH5SFCcZ6UkEqm6ET3TITMpKII8I
         SiRxTBuvNBHMQPJw79xvt0kfjVVZ70GtZT6cmlLG7gbCl6ufK0+lBKSeou12dSuAI1BR
         mpsLTM5DMr/TISqIOu/Ds4PVeDmzohlxOdNkTfSAPSwg8DtloLsWtDoPNVTZjaTuDHMd
         j7kCYri4OCBx85HPmlEK3UemDMmeTCTCEelFc9vPs2s0Jbb3+zJVp4Cd6nrS5D0qD8lG
         xEwg==
X-Gm-Message-State: AOAM533kevoYzULZy8tx7qDuNInr7uExIl0SSqk7D8HFw5ajPzTr6mPC
        Wb99RxsGZmJD5AfZY9ZOPmY=
X-Google-Smtp-Source: ABdhPJzA/sBMojeYKMMn2KVby78V4f0kr3rQiPKJXWDWxqGrxD4YDMKFrRs5lgxo+tWXoop5fURxpw==
X-Received: by 2002:a17:902:b58e:b0:136:7ca1:1334 with SMTP id a14-20020a170902b58e00b001367ca11334mr12904546pls.23.1630149051362;
        Sat, 28 Aug 2021 04:10:51 -0700 (PDT)
Received: from xps.yggdrasil ([49.206.124.188])
        by smtp.gmail.com with ESMTPSA id y64sm10205379pgy.32.2021.08.28.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:10:51 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] staging: r8188eu: fix sparse warnings
Date:   Sat, 28 Aug 2021 16:40:43 +0530
Message-Id: <cover.1630148641.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	This patch series fixes some sparse warnings in rtw_br_ext.c

Changes in v4 -> v5
- Dropped two patches as they have already been fixed by Larry's changes
to endian sensitive variables in `struct dhcpMessage`

Changes in v3 -> v4
- Added this changelog, as requested by Greg's patch bot

Changes in v2 -> v3
- Fixed incorrect usage/removal of endian swaps and checks

Changes in v1 -> v2
- Split patch

Aakash Hemadri (3):
  staging: r8188eu: restricted __be16 degrades to int
  staging: r8188eu: incorrect type in csum_ipv6_magic
  staging: r8188eu: incorrect type in assignment

 drivers/staging/r8188eu/core/rtw_br_ext.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


base-commit: 4adb389e08c95fdf91995271932c59250ff0d561
-- 
2.32.0

