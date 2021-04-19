Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ECC363F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbhDSKP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 06:15:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53780 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbhDSKPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:15:24 -0400
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lYQve-00075z-AF
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 10:14:54 +0000
Received: by mail-oi1-f198.google.com with SMTP id o8-20020a05680803c8b0290186eca96c5eso998667oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AFGQXRTkm+Wz/d9byiqmpLrhi68ol481g+XnsvV8E3Y=;
        b=McJJDqTvldCnY1w0brSsG0D3H7+ZOZB9N5nNarRSa5AOX2dgykYygqd4FEOjnosdEr
         pPFdm0tGdpfQ7O9Mfbxa5SavmgJ43YhlTl3vUjtmr8UYt7AKW2Bp0KjBEq6sSKBPKr+k
         9/v06fwKeGCUnrFEu2CXRzMSJ8cMO04p6zPew3bRNuzb4ARiYSyzV0+1cfDlcCTJrLWQ
         26WZyK1pg2A9E97eIY+7fJRy1upPT/9tlRFJZ9flzu2kanNs0hMWymifjI9OA2Hvon0d
         /IG8oR93lZvmE3UOszHyS3hgecbnsN7YQcyUFiv/j80UZmirXc+3km8UyBME2gTO5Zf7
         5mXA==
X-Gm-Message-State: AOAM533b2q2/hflxrHvV0uYM2BJv9Wota9gDZM4XuAxmfSaK+lvi0UfL
        2XiEM/TRLp5oPndDl4IQUjwIZd6UBn0rRmTJWRiuDDGPeFOahfqlJZ2qZvwiAXxG1xOfWcuL9Mp
        K8jPum4XjyyYfZwL63oYiGmzcLyJdNLx2wnA64MvEUIR80x3EdpM4mLi3NA==
X-Received: by 2002:aca:3d86:: with SMTP id k128mr15405653oia.86.1618827293199;
        Mon, 19 Apr 2021 03:14:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ3H/MPVrkZPdrf0JMRaUd5nUx31rAGnUgSwEHkFfbZTUMhJhlgUCnD3bx/Kq6qun+RMwDKY8j0d0G21mIxk4=
X-Received: by 2002:aca:3d86:: with SMTP id k128mr15405642oia.86.1618827293014;
 Mon, 19 Apr 2021 03:14:53 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Mon, 19 Apr 2021 18:14:42 +0800
Message-ID: <CABTNMG0C7_1xYvgethtdPNTBLAfQEy5xu7q-MG=BbpqF2TwY5A@mail.gmail.com>
Subject: Broadcom 9460 raid card takes too long at system resuming
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        megaraidlinux.pdl@broadcom.com
Cc:     linux-scsi@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    We found that the Broadcom 9460 RAID card will take ~40 seconds in
 megasas_resume. It is mainly waiting for the FW to come to ready
state, please refer to the following kernel log. The FW version is
"megasas: 07.714.04.00-rc1". It seems that the
megasas_transition_to_ready() loop costs ~40 seconds in
megasas_resume. However, the same megasas_transition_to_ready()
function only takes a few milliseconds to complete in
megasas_init_fw(). The .read_fw_status_reg maps to
megasas_read_fw_status_reg_fusion. I tried to add
pci_enable_device_mem() and pci_set_master before
megasas_transition_to_ready() in megasas_resume() but it makes no
difference.

I don't really know what makes the difference between driver probe and
resume. The lspci information of the raid controller is here
https://gist.github.com/mschiu77/e74ec084cc925643add845fa4dc31ab6. Any
suggestions about what I can do to find out the cause? Thanks.

[   62.357688] megaraid_sas 0000:45:00.0: megasas_resume is called
[   62.357719] megaraid_sas 0000:45:00.0: Waiting for FW to come to ready state
[  104.382571] megaraid_sas 0000:45:00.0: FW now in Ready state
[  104.382576] megaraid_sas 0000:45:00.0: 63 bit DMA mask and 63 bit
consistent mask
[  104.383350] megaraid_sas 0000:45:00.0: requested/available msix 33/33
[  104.383669] megaraid_sas 0000:45:00.0: Performance mode :Latency
[  104.383671] megaraid_sas 0000:45:00.0: FW supports sync cache        : Yes
[  104.383677] megaraid_sas 0000:45:00.0: megasas_disable_intr_fusion
is called outbound_intr_mask:0x40000009
[  104.550570] megaraid_sas 0000:45:00.0: FW provided
supportMaxExtLDs: 1       max_lds: 64
[  104.550574] megaraid_sas 0000:45:00.0: controller type       : MR(4096MB)
[  104.550575] megaraid_sas 0000:45:00.0: Online Controller Reset(OCR)
 : Enabled
[  104.550577] megaraid_sas 0000:45:00.0: Secure JBOD support   : Yes
[  104.550579] megaraid_sas 0000:45:00.0: NVMe passthru support : Yes
[  104.550581] megaraid_sas 0000:45:00.0: FW provided TM
TaskAbort/Reset timeout        : 6 secs/60 secs
[  104.550583] megaraid_sas 0000:45:00.0: JBOD sequence map support     : Yes
[  104.550585] megaraid_sas 0000:45:00.0: PCI Lane Margining support    : No
[  104.550999] megaraid_sas 0000:45:00.0: megasas_enable_intr_fusion
is called outbound_intr_mask:0x40000000

Chris
