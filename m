Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3777342F88
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 21:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCTUfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 16:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTUfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 16:35:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2146C061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:35:21 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g20so6650626qkk.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2I6x03kMkjNl83YH2pVzq69+m5IQls71xhfE0AcrKw=;
        b=KeHzGqu8/PsfWoeJLkaD3GtodgJrtjUJ8XQVly8ZM67Czca+0DGhguknEVsdnfNTHY
         jeoA1MGoZnEakvwSgD000vnQaRrqp9DV93zNdTl58qH0Aw0LpPR2Vimk8wSC9XoNYUhz
         RF4AeIDWElitAWW52O9sijjKVRwMeu+QR40Ro1+tM7faslS282KVisAzIc2o6ScQMb3j
         vQpxB+v3816PpdVVmcHAr0fF5alBdC4+P4I2+1/FV8JLf3Rmj2NI2UWFqhOkj9uui6TX
         Oqp1ubXaL7rRMNCTD3uuUVNDq+Ob/9qKCGxSCdEaw8nHiICcMUL/bhp9pwcGPaejlV1D
         AEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2I6x03kMkjNl83YH2pVzq69+m5IQls71xhfE0AcrKw=;
        b=eXnuPH8DbyKO/Gc37ZMPIwalmcKBskHkpz6adY47st7+7eDkL0gsjSf9e8/4yFcsUj
         JMeGAAiZ8Cl5I256NfD5Qb7NmZh9DK6Z+WTZyPszuToZDYWujDrTEbfbAdEeaTcE7Ply
         gnR71ik6FXR2vvUG2mF7OclR+TonNXsghae9B/pqJbyls//ynvaHp7YbEBp8JkSNlxPw
         S55Gldeaz6jywldijvYmy7gctcgHOwxmKbIfRHBNtlXy1YXCGkLFwUsAFjrJKaRA5dqa
         jKHj45uxSVCUEufR1kcTAOxT/xTMdKA7rCZjibUNpLQvBiGYhYtmx3ph/8wPwB6XLzsi
         zFsg==
X-Gm-Message-State: AOAM53036QkpOeCBHPRynhmrGa4L7zgBK7721lQjjkKdAdY5OI4ybGiC
        KM7i3dNllvNN5i9IZZUjFUQ=
X-Google-Smtp-Source: ABdhPJyeeaRivoONc8OlG409EoWt/iHNzEQclWyasxayI8KLLuwiDEMw5Fda9Y4CTwjei+kmS9uEDA==
X-Received: by 2002:a37:6889:: with SMTP id d131mr4269172qkc.264.1616272521223;
        Sat, 20 Mar 2021 13:35:21 -0700 (PDT)
Received: from localhost.localdomain ([138.199.13.205])
        by smtp.gmail.com with ESMTPSA id i6sm7404702qkk.31.2021.03.20.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 13:35:20 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     james.smart@broadcom.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] nvme-fc: Few trivial spelling fixes
Date:   Sun, 21 Mar 2021 02:00:03 +0530
Message-Id: <20210320203002.13902-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/boundarys/boundaries/ ..... two different places
s/assocated/associated/
s/compeletion/completion/
s/tranferred/transferred/
s/subsytem/subsystem/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/nvme-fc-driver.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 2a38f2b477a5..8624b0c6aace 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -441,7 +441,7 @@ struct nvme_fc_remote_port {
  * @dma_boundary:  indicates the dma address boundary where dma mappings
  *       will be split across.
  *       Value is Mandatory. Typical value is 0xFFFFFFFF to split across
- *       4Gig address boundarys
+ *       4Gig address boundaries
  *
  * @local_priv_sz: The LLDD sets this field to the amount of additional
  *       memory that it would like fc nvme layer to allocate on the LLDD's
@@ -608,7 +608,7 @@ enum {
  *
  * Structure used between LLDD and nvmet-fc layer to represent the exchange
  * context for a FC-NVME FCP I/O operation (e.g. a nvme sqe, the sqe-related
- * memory transfers, and its assocated cqe transfer).
+ * memory transfers, and its associated cqe transfer).
  *
  * The structure is allocated by the LLDD whenever a FCP CMD IU is received
  * from the FC link. The address of the structure is passed to the nvmet-fc
@@ -631,7 +631,7 @@ enum {
  *   When the structure is used for an FCP target operation, the nvmet-fc
  *     layer will fully set the fields in order to specify the scattergather
  *     list, the transfer length, as well as the done routine to be called
- *     upon compeletion of the operation.  The nvmet-fc layer will also set a
+ *     upon completion of the operation.  The nvmet-fc layer will also set a
  *     private pointer for its own use in the done routine.
  *
  * Values set by the NVMET-FC layer prior to calling the LLDD fcp_op
@@ -640,7 +640,7 @@ enum {
  * @hwqid:    Specifies the hw queue index (0..N-1, where N is the
  *            max_hw_queues value from the LLD's nvmet_fc_target_template)
  *            that the operation is to use.
- * @offset:   Indicates the DATA_OUT/DATA_IN payload offset to be tranferred.
+ * @offset:   Indicates the DATA_OUT/DATA_IN payload offset to be transferred.
  *            Field is only valid on WRITEDATA, READDATA, or READDATA_RSP ops.
  * @timeout:  amount of time, in seconds, to wait for a response from the NVME
  *            host. A value of 0 is an infinite wait.
@@ -718,7 +718,7 @@ enum {
  *
  * Fields with static values for the port. Initialized by the
  * port_info struct supplied to the registration call.
- * @port_num:  NVME-FC transport subsytem port number
+ * @port_num:  NVME-FC transport subsystem port number
  * @node_name: FC WWNN for the port
  * @port_name: FC WWPN for the port
  * @private:   pointer to memory allocated alongside the local port
@@ -919,7 +919,7 @@ struct nvmet_fc_target_port {
  * @dma_boundary:  indicates the dma address boundary where dma mappings
  *       will be split across.
  *       Value is Mandatory. Typical value is 0xFFFFFFFF to split across
- *       4Gig address boundarys
+ *       4Gig address boundaries
  *
  * @target_features: The LLDD sets bits in this field to correspond to
  *       optional features that are supported by the LLDD.
--
2.26.2

