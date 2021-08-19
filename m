Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AC23F14FE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhHSISp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhHSISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:18:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7666CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u15so3430700plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxrRajkgeOR59o34/2DpG7lBqxnZ5L/RmTpyatgnweU=;
        b=HJnfw11KuXmFKHhBdXkwkUp1xpwlSEcZNaZPFIGi8c2Wrew1jw8jzX6g2cf+c7tZGF
         XVu8gJlKTcj2GrTSeuYBgRhopiiE/FIaADgFRDdy9UGBkYMwj36Lyjp4A9q89yX7qEzf
         ytk+YUbUYm0qRnkxw6K8ulVuL5OdzCyK1HsHvST6+b9kHYcQhywEAEO2LZ7n5z9uK+gr
         bYupwFmjcOkT9bUxaPqGazgzJVVmyurCR/HC/hNStDHShyeg1mB/UNhIZZq90xLvXuP1
         PUO9Jsmt50Cw+n6ev9t1IPz8X+NvFb+WvLmBoTmftmsJdQvsljQWphUAwi5tZfdvJ7aS
         h3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxrRajkgeOR59o34/2DpG7lBqxnZ5L/RmTpyatgnweU=;
        b=riRBD0r9rvK7IkTwUBXhlDPvnY0dJmnV5vElERXHPb5b/zbq5besZ7AhPqN6CSSSXT
         RUpAttnHgJJfPwR0ci0QH/oZa2albROV8xv3cfDHvI0IjNjOsGO+BJ3kmjgcaSNdGe8S
         rdWRRXSx9D5mbVrMySPimw4D5GE+8G8VWhy7EyZ1PxpVAk+FFRNSIeLrzTF0u9w3mJUt
         a1vb7IQcjSuAAN2Va2i2O6ZBCv2qVXow13NveeGOHr4s13tAheqB8J5P08MV7QkYS716
         XJdjQooBM72Oz/VGAdoPd+XE2rzXG8pD5f5XVcMDxBYAuZPlOKIKzYCPDbIzSwlMfmPi
         9arw==
X-Gm-Message-State: AOAM5333hDGt9m9DJr5xw3GhrP+QNRzGbpkuGGWyAjSq3ZSqKc2KfHIc
        Vf+wZSqrTULW6n3WuieBh+rsHKLUlMc7SA==
X-Google-Smtp-Source: ABdhPJxOK832d+KvwH3HXdWOk3E8GBEpoaa8+vNVWMQou45om6Xw/N/xDC1oh6UVVbS1oJ07a5LnnQ==
X-Received: by 2002:a17:903:32c8:b0:12d:b0ff:9403 with SMTP id i8-20020a17090332c800b0012db0ff9403mr11017101plr.54.1629361087285;
        Thu, 19 Aug 2021 01:18:07 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id gb17sm1531129pjb.26.2021.08.19.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:18:06 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] staging: r8188eu: fix sparse warnings
Date:   Thu, 19 Aug 2021 13:47:52 +0530
Message-Id: <cover.1629360917.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series fixes some sparse warnings in rtw_brr_ext.c

Aakash Hemadri (5):
  staging: r8188eu: restricted __be16 degrades to int
  staging: r8188eu: cast to restricted __be32
  staging: r8188eu: incorrect type in csum_ipv6_magic
  staging: r8188eu: restricted __be16 degrades to int
  staging: r8188eu: incorrect type in assignment

 drivers/staging/r8188eu/core/rtw_br_ext.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


base-commit: 093991aaadf0fbb34184fa37a46e7a157da3f386
-- 
2.32.0

