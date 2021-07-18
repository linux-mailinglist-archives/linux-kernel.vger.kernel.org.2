Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D553CC730
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 03:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhGRByO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 21:54:14 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:40948 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhGRByM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 21:54:12 -0400
Received: by mail-pl1-f181.google.com with SMTP id j3so7631474plx.7;
        Sat, 17 Jul 2021 18:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9wrU3f/qBXvoHCsQwbSv3zTFBdueaFrjtvOaMQGrNw=;
        b=tnJ/W6ic5QciLtvJ3Xa3OngC49o8t/bdpDhRrSzASiJcm19EGhYISRcOE0t2hGoZ0B
         f3OZkbi47PR/nm2m8vLGTbj8i64LtrH04uicSKrY+53lJJB5u8YZuhYwhKSjfEhEB1Ip
         NxEior/bMO5VzCtTr8uDx4tZkWG+D6AlXBPfGmSpXdb/Jq9GT4ekobtj0+U0BYQW6/TK
         Lq5VI2l3sv2NHJ4OzZKarvnNaTURBBB6zTd8wJXFod/NbbRn/7QdhtXgPGvfzs2aU3iX
         xUJpz/mTXlkLThKtaawGuCW0qdBRPykfi9qKN7cFtCVmFIbmuVl/dlEmDCmzwx1qay98
         LuRw==
X-Gm-Message-State: AOAM530r+FVPR2zcO5n8IoYSFbLVKDuvjiw3GFy3eLDtJf79NrrrvtII
        k1wDgjIxF67b2fNMpymJBvyMPPHjnLg=
X-Google-Smtp-Source: ABdhPJwDu2cGy70Ta7wzaMghpHd9vdE92YoB3AlDOl/UQgbtxhII/VputRCQrizmwrh2AZjdi54LcQ==
X-Received: by 2002:a17:90a:d994:: with SMTP id d20mr17537218pjv.207.1626573073842;
        Sat, 17 Jul 2021 18:51:13 -0700 (PDT)
Received: from localhost ([24.4.24.239])
        by smtp.gmail.com with ESMTPSA id d2sm14964410pfa.84.2021.07.17.18.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 18:51:13 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, moritzf@google.com,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/2] usb: renesas-xhci: Cleanups
Date:   Sat, 17 Jul 2021 18:51:09 -0700
Message-Id: <20210718015111.389719-1-mdf@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking through the driver code I ran into two minor things.

The first one is a simple if (err == 0) -> if (!err) change.

The second one removes an empty(?) function that seems to have been
around since the beginning (and always has been empty).

Moritz Fischer (2):
  usb: xhci-renesas: Minor coding style cleanup
  usb: renesas-xhci: Remove renesas_xhci_pci_exit()

 drivers/usb/host/xhci-pci-renesas.c | 7 +------
 drivers/usb/host/xhci-pci.c         | 2 --
 drivers/usb/host/xhci-pci.h         | 3 ---
 3 files changed, 1 insertion(+), 11 deletions(-)

-- 
2.32.0

