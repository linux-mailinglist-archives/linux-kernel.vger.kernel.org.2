Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1B3D955E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhG1Shd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhG1Shc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:37:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9082EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:37:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b6so6490231pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QUj8foCCXf2Hk0Q8YOnlzfaB+AWEIlA45uSJGKNgJo=;
        b=rinhSxLDgPmyxUtR9SfQ4nRnJZ6mz38pdo5BKLzaRUlE9EWwogV+o5/i0NW/rLAaoU
         1nj7KzLjz90Q4VMNi3FTIHivOrfane/rw2OY0h9YG5/279qq/79XpPaad0RZun458eZy
         yDylY498WiHYUJ+HH6A5Z2yNNB6Sqmh0Q7XdPus2GEI6uczteTghzTLGzQagKavtI7js
         AfxsPhIzoYHGarTLfORkjTbq2XGDk/i56tl16bJKA6bwYMCU6yDNCvQc7adodCKhq4gF
         /qf8GempK5KXpOcaGt93CgqibucSqrC+tXhL7tKv51hxcpWBGWvxcLvfA7KMa2XcydEa
         ZV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QUj8foCCXf2Hk0Q8YOnlzfaB+AWEIlA45uSJGKNgJo=;
        b=tSW33VxNhyay3TrZ0TDhCl0QPf/gXHseojL4LGEntcbcVZ3GlRA7fk6gaIJJ0u3mwQ
         2tvQjFdGWz5G4T64/SYDorDXBcZgU/iVA+ZbF9TjpTzFQkFHrc4Swk0utEi8zC9MIjoW
         ptryoVFRJajRnTP4bCzcAEzMLw2BtWBfrpQOsZ+ytRqlbY6VMQnvUVDNEpkOpiAnzfE9
         R3h0w5ix/KmSWNwIcYEZP5nZaInuGkw9lqXRd5dLWVRYs8g5NXAQ0Vpi03+Sq/wilCTk
         VYWn6UWnCfR0gT7/8qjJ4QcY6DYKSDXxPIufRlYNh7wNtB4YBuDllRg8Dd2XbwErPu2B
         Epug==
X-Gm-Message-State: AOAM533UIMPOVPwQL7vsdUJrjvIN7E2A87JwpNrC5YKZlNZL1xbIORyW
        +umqKv3Z+AIOv+zoIiPqQNo=
X-Google-Smtp-Source: ABdhPJyF8DWigz/tOuixgsjSJSYs5FpNxAHWClZ/fyQYv9v3wJIjXjeUyb+OGhQae8wsEDk3NPrrRA==
X-Received: by 2002:a17:90b:1981:: with SMTP id mv1mr10980318pjb.227.1627497450120;
        Wed, 28 Jul 2021 11:37:30 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.5])
        by smtp.googlemail.com with ESMTPSA id t71sm559021pgd.7.2021.07.28.11.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:37:29 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com
Cc:     dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: vchiq: Minor fixups to CONFIG_VCHIQ_CDEV
Date:   Thu, 29 Jul 2021 00:07:15 +0530
Message-Id: <cover.1627495116.git.ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

The patchset performs some minor fixups to the CONFIG_VCHIQ_CDEV config
option defined in /staging/vc04_services/Kconfig. (Introduced in [1])

Summary:

Patch 1: Enable the config by default to be more consistent with how
         cdev creation worked before this config was introduced
Patch 2: Add some more details to the config's help text

Please let me know if any changes are required.

Thank you!
Ojaswin

[1] https://lore.kernel.org/r/846c424dd4aae14d1cc28c8f30877a06e2b7dd10.1626882325.git.ojaswin98@gmail.com

Ojaswin Mujoo (2):
  staging: vchiq: Set $CONFIG_VCHIQ_CDEV to be enabled by default
  staging: vchiq: Add details to $CONFIG_VCHIQ_CDEV help text

 drivers/staging/vc04_services/Kconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.25.1

