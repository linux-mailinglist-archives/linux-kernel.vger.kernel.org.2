Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8195745CE71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244091AbhKXU5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243951AbhKXU5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:57:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A0C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:53:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id n12so10614904lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBAopcuMZHjciIHB7DxD67GWh0M8Q3KOr2lZGv2eaVQ=;
        b=EOVNOSIKB097eJDLI78+TDQKEJMxEAhF1DjiOYB9US8P5Va356lafZguv3Uj2gDwR4
         Ctqcqmf+EkIuST9RZXpJNWUWuM0WLuR4We3+2VVX2B427CziLBQwhCPTe4sOW7IRYuiC
         aClHOn6gzPx4TxcdaotH3Mb+V+iLHfmsb4Mrw3XSVMV+ASZz4ooCS+JHbWRG/qeGNKZZ
         xmDf1Xf8QaKbD1D5kVTyzLNQM98Pv7HX/2NPj3KFIAMgfmVocJXKKdJpkwdRxkk1RjSY
         duz585QyMLv+6U/BdYsBk1KWN0oe+TJrOkDvnyGQMq78HyPglrUGXtLW4ohb1+5f6XIG
         efhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBAopcuMZHjciIHB7DxD67GWh0M8Q3KOr2lZGv2eaVQ=;
        b=hYKIDlJxCIyoAMgbb7yp0hnWfoQV4COP+O+UOoqO1TWZz+FVIJk51cPz/nFsSWN22Y
         fyDn78i7C5eUGNX2aYwzaHMvrGA8iwKTuBCX9idCfJ8s9wEs5LKwqjadMaB/OgP8LBlD
         3MwiUQrr7DQ4oY+7wQZnduMVO1PGNHI6uqFzIddFIxm1QAphvo9APeLVQsMAy0pjTWFF
         iETMjQIQsHEwCP0Vm+/abazbw78D3jB38F77q0Xv7sKwNUSC1D5hmlUh+EHRNYMiOqKm
         /6yCK8CaXtr5myaXDJL5YuO6E/BfRsRDc2fxfHtUiKxLvohUbPE55Pd7rkV8G+QOXgBl
         bTPg==
X-Gm-Message-State: AOAM532gD76CrcnU4pHMKifdetNSmOvb/W75j+S8bMXfMeoF+j/86qpx
        wWlup8aXT+dwQYjK6R1Dy3oQUv95zHDL5w==
X-Google-Smtp-Source: ABdhPJyichwpAJNMAkydxI87GKxoZRWxO8uoBVnYkUCHsGmrt0hZCYLPXfYtuT9M9aREjB1c6odbSA==
X-Received: by 2002:ac2:5310:: with SMTP id c16mr18736716lfh.580.1637787233851;
        Wed, 24 Nov 2021 12:53:53 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id j11sm97608ljc.9.2021.11.24.12.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 12:53:53 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V3 0/6] xen: Add support of extended regions (safe ranges) on Arm
Date:   Wed, 24 Nov 2021 22:53:37 +0200
Message-Id: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Hello all.

You can find the RFC-V2 patch series at [1],[2].

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
"reg" property under hypervisor node in the guest device-tree [3]. As region 0 is reserved
for grant table space (always present), the indexes for extended regions are 1...N.
No device tree bindings update is needed, guest infers the presence of extended regions
from the number of regions in "reg" property.

Please note the following:
- The ACPI case is not covered for now
- patch series was created in a way to retain existing behavior on x86

The patch series is based on v5.16-rc2 and also available at [4], it was fully
tested on Arm64.

[1] https://lore.kernel.org/all/1627490656-1267-1-git-send-email-olekstysh@gmail.com/
    https://lore.kernel.org/all/1627490656-1267-2-git-send-email-olekstysh@gmail.com/
    
[2] https://lore.kernel.org/all/1635264312-3796-1-git-send-email-olekstysh@gmail.com/

[3] https://xenbits.xen.org/gitweb/?p=xen.git;a=blob_plain;f=docs/misc/arm/device-tree/guest.txt;hb=refs/heads/master

[4] https://github.com/otyshchenko1/linux/commits/map_opt_ml6

Oleksandr Tyshchenko (6):
  xen/unpopulated-alloc: Drop check for virt_addr_valid() in fill_list()
  arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT
  xen/balloon: Bring alloc(free)_xenballooned_pages helpers back
  xen/unpopulated-alloc: Add mechanism to use Xen resource
  arm/xen: Read extended regions from DT and init Xen resource
  dt-bindings: xen: Clarify "reg" purpose

 Documentation/devicetree/bindings/arm/xen.txt |  12 ++-
 arch/arm/xen/enlighten.c                      | 132 ++++++++++++++++++++++++--
 drivers/xen/Kconfig                           |   2 +-
 drivers/xen/balloon.c                         |  20 ++--
 drivers/xen/unpopulated-alloc.c               |  84 ++++++++++++++--
 include/xen/balloon.h                         |   3 +
 include/xen/xen.h                             |  16 ++++
 7 files changed, 239 insertions(+), 30 deletions(-)

-- 
2.7.4

