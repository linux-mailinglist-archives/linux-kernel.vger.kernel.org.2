Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461CB3DDEB3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhHBRmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHBRmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:42:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB01C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 10:42:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so3712066pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zypShOHHJ2S2Sr8vYY3+01JamPdXVQkfX8nYGZTs/v8=;
        b=UX3jnTK98osl/Axo20/sp012WKEY7J6mC6yrEFYUhrhOUphUJ4DIlviKg6uh3VSAOd
         +8jJTZtowWD9U3d+n92q3KZWt7hgObMzi+/sG3ag5z1WqaiP9LXLT8dH2IadNEQtNUKt
         EDVb/slMJ4IdCrpscFTsgfpwiJI7HTbphOx1OCUgW7imE3IbDDT5gjYaZYX5qq5vj+Xa
         XwWkGs/ju3m0t7p1ERJVkZmU1PkuaKuF34VHaFzNNbUs/V9uSnjQbHehJIsw/Bd0hE8w
         f/kQf1yw7J5Rq1Udw5Q1ZzB3OIZQODyX7USjc60yQpWG7mSGrnHuPSdn2XlIJaPU9ptj
         JGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zypShOHHJ2S2Sr8vYY3+01JamPdXVQkfX8nYGZTs/v8=;
        b=eRB1tgwAjDybQxo+vKkhrElVvuos9MyDtmw+4PD1lrCEbILvZqC3jdFL2Kl/VBqIkk
         t+OIqnYxG/8so3XeT7GHzUS0k+e7mb3tE9tGG1ZpN1G1zbQ4NeNGHASRRLOa4AJVMWmm
         muLAnA0qBhI3nfnb7nqyV/pPsntdNzOJQa5Cee1MnjMt4erthCDwSG3J+Q9cTOw4DfvN
         KHrv9bj4TBg28W/865F1omIeU4kAnrJPOHnEQK5pPBtcoH8VnismZb7yjhbiymeVwL88
         IaXKCunaidJ4DT8XSJ6Ty/EdZpXb9kloArmY61GyHqX16Ba5BzYey/qI/e/WbyD5fZSg
         ERKQ==
X-Gm-Message-State: AOAM532WiGpBojI35vQ/8qb2ohbmGcK2+jwJ31gjmyIGeL4TfHZHiQtz
        o/kbVQNu8dX/0AedNdT09gM=
X-Google-Smtp-Source: ABdhPJzx0DKlCLxHPHDUBxDKLhxHxqqYAwRsRUtoR6//mPFMX4uq9eoiTtyOWFbt1sqAQuGunldUNA==
X-Received: by 2002:a17:90b:17c3:: with SMTP id me3mr18083pjb.203.1627926143371;
        Mon, 02 Aug 2021 10:42:23 -0700 (PDT)
Received: from localhost.localdomain ([122.161.50.148])
        by smtp.googlemail.com with ESMTPSA id t30sm14449236pgl.47.2021.08.02.10.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 10:42:23 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com
Cc:     dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: vchiq: Fixups to Kconfig
Date:   Mon,  2 Aug 2021 23:12:09 +0530
Message-Id: <cover.1627925241.git.ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This patchset performs some minor fixups to the config options defined in
/staging/vc04_services/Kconfig. 

Summary of the patches:

Patch 1: Makes BCM2835_VCHIQ imply VCHIQ_CDEV to make the behavior more
         compatible to how it was before VCHIQ_CDEV was introduced (in
         [1]).
Patch 2: Add some more details to the configs' help texts


Changes since v1 [2]:

*  As pre discussion with Greg and Stefan, used "imply" in BCM2835_VCHIQ
   instead of "default y" in VCHIQ_CDEV.
*  Added some more info in help texts of both the config options.

In patch 2, although the resources on VideoCore and vchiq are really
scattered around the internet, I've tried to keep the help text as
accurate as possible, as per my knowledge.
Please do let me know if anything is off in it and I'll fix it.

Thank you!
Ojaswin

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/patch/?id=2b5930fb3dc06d86149071f9dc8b6992cac1c3aa

[2] https://lore.kernel.org/patchwork/cover/1469192/

Ojaswin Mujoo (2):
  staging: vchiq: Set $CONFIG_BCM2835_VCHIQ to imply $CONFIG_VCHIQ_CDEV
  staging: vchiq: Add details to Kconfig help texts

 drivers/staging/vc04_services/Kconfig | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
2.25.1

