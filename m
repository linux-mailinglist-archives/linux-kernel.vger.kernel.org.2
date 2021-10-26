Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2B43B68D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhJZQMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbhJZQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:11:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EDBC06122C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:08:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u13so16329289edy.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bAVBWRDZRgubnRSuBYCl4clj0aVWREQm4G5cX+KG1p4=;
        b=IRDZVkn1hy6HTn6NCAY05VCjxdq5sZSzZ/zhkxVxmJgo79/McEOL3/iJ/d1r//8JgI
         35NahJ8ril6M+lshDWp+3AU6poeOYlGjmAXVxV0JB2UQL7Ghwxjz0h0vXbMxSRi3nhiv
         xwxv03QLNDivyn9pXc3PkfJSCC6JURlI+0JbfKbO1J8bMFt2GGA5kOsgNU/HTwVxY80e
         9OfKFDdZSXoFBP4DwuPaGMAnk0jS7qW24jrn7NgJDPscT59nn5Lffb/EvmJKmH2fJObN
         kWg+uYQvl2aryBOblgagD4nMXooTtyuPn5IHQ4xv843vNj1zyR3C10vYR4P6CImPG352
         f1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bAVBWRDZRgubnRSuBYCl4clj0aVWREQm4G5cX+KG1p4=;
        b=TKZfXZSA+INTA6gxX3/fyU7tf3rqfP2AHop1yQlpTD7f5TXCWAUhUJoq5vKu0jI70h
         RnmyH9R4iYo09oVcsU68wJfQ3/juQSOLEZiJGk/tWqNxX5u1BrYgePSDVPyy6s+uaq2y
         mC/P6cZqBwdxRLbHMcDMObCLl7CWxbTBIOeH2lLpojraM+BcIT+wng//2qAaSJbgVhSm
         O0Rty0yJBzM1Wqj2x8vThp/5NZS7oRyqpHpECJV9Fx9HEs7FFFs5g5pzONRotw0lYaMd
         g6eBcFu9k78yEAbXcJ2hECAipe05aS3vghSIYBuOLnfZFVq9bKuMUw93mAldq8fO1ykO
         JRTA==
X-Gm-Message-State: AOAM530/+T110YQMgRGYL59t+Ro4uulY64LbExg3q1lwNJ35xSvNcn2g
        bb9ara7bMT0Zzvp7SLAIR0U=
X-Google-Smtp-Source: ABdhPJxtMgA2kyKQC10zrMOP8KtcHqswMqEj2qKkSjTogokVg/wr2Px2E1gCaIw0gu0zlXxwCQNP+g==
X-Received: by 2002:a17:907:76cc:: with SMTP id kf12mr18527547ejc.228.1635264319752;
        Tue, 26 Oct 2021 09:05:19 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id eu9sm4025195ejc.14.2021.10.26.09.05.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:05:19 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>
Subject: [PATCH V2 0/4] xen: Add support of extended regions (safe ranges) on Arm
Date:   Tue, 26 Oct 2021 19:05:08 +0300
Message-Id: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

You can find the RFC patch series at [1].

The corresponding Xen support (for both Dom0 and DomU) is already committed and
is available in mainline Xen since the following commit:
57f87857dc2de452a796d6bad4f476510efd2aba libxl/arm: Add handling of extended regions for DomU

The extended region (safe range) is a region of guest physical address space
which is unused and could be safely used to create grant/foreign mappings instead
of ballooning out real RAM pages to obtain a physical address space for creating
these mappings (which simply results in wasting domain memory and shattering super
pages in P2M table).

The problem is that we cannot follow Linux advise which memory ranges are unused
on Arm as there might be some identity mappings in P2M table (stage 2) the guest is not
aware of or not all device I/O regions might be known (registered) by the time the guest
starts creating grant/foreign mappings. This is why we need some hints from the hypervisor
which knows all details in advance to be able to choose extended regions (which won't
clash with other resources).

The extended regions are chosen at the domain creation time and advertised to it via
"reg" property under hypervisor node in the guest device-tree [2]. As region 0 is reserved
for grant table space (always present), the indexes for extended regions are 1...N.
No device tree bindings update is needed, guest infers the presence of extended regions
from the number of regions in "reg" property.
    
Please note the following:
- The ACPI case is not covered for now
- patch series was created in a way to retain existing behavior on x86

The patch series is based on v5.15-rc7 and also available at [3], it was fully
tested on Arm64 and only compile tested on x86.

[1] https://lore.kernel.org/all/1627490656-1267-1-git-send-email-olekstysh@gmail.com/
    https://lore.kernel.org/all/1627490656-1267-2-git-send-email-olekstysh@gmail.com/

[2] https://xenbits.xen.org/gitweb/?p=xen.git;a=blob_plain;f=docs/misc/arm/device-tree/guest.txt;hb=refs/heads/master

[3] https://github.com/otyshchenko1/linux/commits/map_opt_ml5

Oleksandr Tyshchenko (4):
  xen/unpopulated-alloc: Drop check for virt_addr_valid() in fill_list()
  arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT
  xen/unpopulated-alloc: Add mechanism to use Xen resource
  arm/xen: Read extended regions from DT and init Xen resource

 arch/arm/xen/enlighten.c        | 144 ++++++++++++++++++++++++++++++++++++++--
 drivers/xen/Kconfig             |   2 +-
 drivers/xen/unpopulated-alloc.c |  90 +++++++++++++++++++++++--
 include/xen/xen.h               |   2 +
 4 files changed, 226 insertions(+), 12 deletions(-)

-- 
2.7.4

