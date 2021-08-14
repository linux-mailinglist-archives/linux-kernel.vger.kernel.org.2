Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375A03EBFC1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 04:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhHNCcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 22:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbhHNCcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 22:32:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC56AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 19:31:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b4-20020a252e440000b0290593da85d104so10998562ybn.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 19:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lHPa9dZiexJU0+NOxYBxT/1rFTgtrFkEMcMwrwajn2A=;
        b=uYB/2nOgOCsf8449dDt1lFr3eHG/CEwEiDffrr4WD6KbfpAOWpAbVS0RVrqBcNHA5M
         sqMv9cscfS4i8eJK/E93Q/vk6EsUCxeEiZAppyMHe4I803jFiWN6cprf53b2seOHT3fs
         Vaw+G26a1P4t+w3IOTLXBhFOOE3X6/d9msIrulz6BW2szKMEB1CyrN3exXd0H8EjsMor
         +Vz42GHMLU7/W6idWpVtQJuE2UUwIN59ECYK1heWrihSg+uaW2YVg1RFkILFSaazfEJ+
         d9MlBf8EDthGUY7Ms7wALv/0zjShetKKKPW1ZwiemYNhamtSy7EZeLLWE4JiNgLsUSH/
         I0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lHPa9dZiexJU0+NOxYBxT/1rFTgtrFkEMcMwrwajn2A=;
        b=uIyRVIwW6v0ECKh0QRbaUZZ/NYQngktgXcP6BdZ7Y4lCIVLZha6MW5lnTegBePhreI
         1K6pxFMHxikT3OvG38MtslqyzVFL4VF+AZLSadPKXZBpisnpVaqdhP5UwutBI0DY5T4f
         sTis91vE6RlopOTXAGZzqFsOKz3c9SacyFubA2Qvfex2So3BSjDn/RIngcxgLyJbMNWY
         bt8plIwWXJAaKqrC78HmwC/wh9W6AD7tNBPG+iWLcqadEONTFpnO04xdkPdWkt9PnH2f
         utM8E3frN+sXPD+DRYRWI+4aQ4liWr1bZ4hVzF6BFVqOYc3c44GRjm2Fgg8V+Zz34rxl
         51GA==
X-Gm-Message-State: AOAM531QF9RjgBdpCj3p7DnWFFWKe8iEQQFLsO0zl4yIuprCqv2cTnkp
        nvKXqJGD1Wc4/l/HRWGSZ8+5CSXlGzyY6dA=
X-Google-Smtp-Source: ABdhPJyhJIjk0Uf7wAZcoSKUtIrElyRpf3rTcpyVfpCoxjffZLzN04D0UeXyhghBHuZU7EYz9syKrIsJ+yA+9u8=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:55f9:6fdc:d435:ad28])
 (user=saravanak job=sendgmr) by 2002:a25:b21f:: with SMTP id
 i31mr6557931ybj.403.1628908296136; Fri, 13 Aug 2021 19:31:36 -0700 (PDT)
Date:   Fri, 13 Aug 2021 19:31:29 -0700
Message-Id: <20210814023132.2729731-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v1 0/2] of: property: Support for few more properties
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series only to avoid merge conflicts. No real dependency
between the patches.

Saravana Kannan (2):
  of: property: fw_devlink: Add support for "leds" and "backlight"
  of: property: fw_devlink: Add support for "phy-handle" property

 drivers/of/property.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

