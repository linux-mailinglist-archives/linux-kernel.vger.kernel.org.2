Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F114210DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhJDN7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbhJDN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:58:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C60C06136A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:53:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x4so11146220pln.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QehrCbnowDf1RKEEztwsvEnHuiWWf1+by9ueLaqBt5I=;
        b=HD1FAaEtufc7ayGdPFagvKFo4lY+o6I6/nQOa+nVkJHZWF4gn1Zd86f56QDiJmRERT
         cJ7/qKo40ISZ9l6pLFbm7BG+GvlqxekUCZucWtRLoGIZL0sAmMTGgGxEbo+89QGomMqk
         F06R/fZFslZqdzjDhsuFd6DM9UJxmwRmegojJHXlFwjzshrhgKufUcrnmWtk8oQOyKyV
         48P036+d1eYmnHMqEMXCm084uNEGSg9txbxUXWiU69JjBsacmUsrPGih+ky85b/2QB3r
         lLSD1qhYF77rBR/NWuUVA4marCG9VaWVfBOoI9Rnw4dd1xAyB9uJHKQU04cUUSzm0j6p
         Zhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QehrCbnowDf1RKEEztwsvEnHuiWWf1+by9ueLaqBt5I=;
        b=QEHON0D16NOtj7ensvhXDzaDAgXu65RHuXm2ylfQ/LFCHDSkmt7lxkYv9tTiWOfDfK
         /Ae2mcbazucq3xEt7wldDJ33qKtlQ27zw/U52borL0pHdFqiXYRn3xqiQ727/GOr9G61
         MlS/YuabSZQU9b8TUY+gx4RG9DuoMFodH6q5aO55bUVjmY++qNAzUokofdTrZI5QP3vC
         jwTkblwBbYEf9IPHnSCgFGrT6V5IzHKIjiNx3ud1B6KQgMATc3BbWGQicybDFHU/fnmn
         JDHsHFbRuVDsA/RiGj7jWJi07RmIsG3iVZnrebBezaMxH9aHt9xWw+HqUQc5VAA7tS8a
         ATCQ==
X-Gm-Message-State: AOAM530mrBZ0m+nWhn0RjQPGiFyq6pe3SH0SD8JMu9JJDsA7ODDjbiG7
        19HuBZXh47URFIlOZSa+ZKI=
X-Google-Smtp-Source: ABdhPJyN7WK8TDIV07lY6Vw3BSCzWsRh8SxCdZyrqPzER9GZiXV7WlUHrJTVeRbnHqxrI3lD1Qshqw==
X-Received: by 2002:a17:90a:1984:: with SMTP id 4mr31119195pji.241.1633355597382;
        Mon, 04 Oct 2021 06:53:17 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id k17sm12209548pfu.82.2021.10.04.06.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:53:16 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8] Fix long standing AER Error Handling Issues 
Date:   Mon,  4 Oct 2021 19:22:35 +0530
Message-Id: <cover.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims at fixing some of the AER error handling issues
we have.

Currently we have the following issues:
 - Confusing message in aer_print_error()
 - aer_err_info not being initialized completely in DPC path before 
   we print the AER logs
 - A bug [1] in clearing of AER registers in the native AER path

[1] https://lore.kernel.org/linux-pci/20151229155822.GA17321@localhost/

The primary aim of this patch series is to converge the APEI path and the
native AER error handling paths. In our current code, we find that we
have two different behaviours (especially when it comes to clearing of
the AER registers) for the same functionality.

This patch series, tries to bring the same semantics and hence more 
commonanlity between the APEI part of code and the native OS 
handling of AER errors.

PATCH 1: 
  - Fixes the first issue

PATCH 2 - 4:
  - Fixes the second issue
  - "Patch 3/8" is dependent on "Patch 2/3" in the series

PATCH 5 - 7
  - Deals with converging the various paths and to bring more
    commonality between them
  - "Patch 6/8" depends on "Patch 1/8"

PATCH 8:
  -  Adds extra information in AER error logs.

Thanks,
Naveen Naidu

Naveen Naidu (8):
 [PATCH 1/8] PCI/AER: Remove ID from aer_agent_string[]
 [PATCH 2/8] PCI: Cleanup struct aer_err_info
 [PATCH 3/8] PCI/DPC: Initialize info->id in dpc_process_error()
 [PATCH 4/8] PCI/DPC: Use pci_aer_clear_status() in dpc_process_error()
 [PATCH 5/8] PCI/DPC: Converge EDR and DPC Path of clearing AER registers
 [PATCH 6/8] PCI/AER: Clear error device AER registers in aer_irq()
 [PATCH 7/8] PCI/ERR: Remove redundant clearing of AER register in pcie_do_recovery()
 [PATCH 8/8] PCI/AER: Include DEVCTL in aer_print_error()

 drivers/pci/pci.h      |  23 +++-
 drivers/pci/pcie/aer.c | 265 ++++++++++++++++++++++++++++-------------
 drivers/pci/pcie/dpc.c |   9 +-
 drivers/pci/pcie/err.c |   9 +-
 4 files changed, 207 insertions(+), 99 deletions(-)

-- 
2.25.1

