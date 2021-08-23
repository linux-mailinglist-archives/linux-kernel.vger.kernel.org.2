Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058CD3F4EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhHWRB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHWRBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:01:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39174C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id x11so38508158ejv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrNCzcVvX7cvPSUZXmD40dpydUh09OSJcRtDIAA99/A=;
        b=apI8fQsF6DsHGrbZFrpOjapUk3FN3pbrrYdxsq7o4Xti+gSDnHb+rSAyl6NH4lrvxu
         D9hwmWCjr06e9cL9Z1ZZYWR/0xiGygpUoozRCjCsVcylBPjRa9/0oTlTAwZTkg05Fp97
         f9OeiqMnzU85LAJH/8NgyQVnoVnfJckG/Di/sIoaDCIBaVqsiXvSKySJdYggKnyGuahg
         Z9vY1iBM+7u2dNOrjZNK08A4qLL1VkQ+BXIZckv9BxkJwA+jIAHRej6gVe8ZG39dX4yk
         J5kaUblQRVssYZHPfjjnpSOzIfdoFWjdrsYZXDCymrpRbKg76SVxkm9YPGBjcwA6mE4a
         VJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrNCzcVvX7cvPSUZXmD40dpydUh09OSJcRtDIAA99/A=;
        b=q0o1RMyrKWG0IzVu+CVS0vRhbfKqtK32MZnS5hUpZOW33Pc6P+G261DJu+KE3fLb68
         o+WisTYC0XvP0DJlOq4DsTe420FlV2yI3p2rF8V0NmmJjc+PYCOADfEaeuWGR2LZZENl
         8s3Kz1m5DdddT7hsaVD6CPC3HVRqEPIbQj1Sn3eBiH9Ik1pM0k9OTAdcS9vPiHCliiKt
         HvCXGKlQF21ea+v5IQDjGSaluMkAqS8IbT5vGiQhSnAgkIRGZzkmNVkZNk6+182DnGol
         Cv8yUuwr+qx9LuAhEOj1aU/bK5OiHE+vmGFaiYjV8K/4fcBy9E5tk0jhU8pI+E+6eQOV
         iDRw==
X-Gm-Message-State: AOAM532tTQWH+PLb/hibbaeGri0zBI1f/WrrPCNrSOai+uXvizbD2FAL
        3E9zN3VggOw0TqmVsK732Xw=
X-Google-Smtp-Source: ABdhPJxXSES81ybuHB4XMNvH4P6hH6kzpwbzIIeSRfcCE3o7rYth8bDR15rHycbYBgnTbdTMnlJPiQ==
X-Received: by 2002:a17:906:b787:: with SMTP id dt7mr37662614ejb.111.1629738039778;
        Mon, 23 Aug 2021 10:00:39 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id b18sm1633188ejl.90.2021.08.23.10.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:00:39 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] staging: r8188eu: fix sparse warnings
Date:   Mon, 23 Aug 2021 22:30:25 +0530
Message-Id: <cover.1629563318.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	This patch series fixes some sparse warnings in rtw_br_ext.c

Changes in v3 -> v4
- Added this changelog, as requested by Greg's patch bot

Changes in v2 -> v3
- Fixed incorrect usage/removal of endian swaps and checks

Changes in v1 -> v2
- Split patch

Aakash Hemadri (5):
  staging: r8188eu: restricted __be16 degrades to int
  staging: r8188eu: cast to restricted __be32
  staging: r8188eu: incorrect type in csum_ipv6_magic
  staging: r8188eu: restricted __be16 degrades to int
  staging: r8188eu: incorrect type in assignment

 drivers/staging/r8188eu/core/rtw_br_ext.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)


base-commit: 093991aaadf0fbb34184fa37a46e7a157da3f386
-- 
2.32.0

