Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3543A1BAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 19:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhFIRZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 13:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231514AbhFIRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 13:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623259391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=peNQguMIZxsiTtT/t38MJAly3Hcz6eiRy0HbljXWio4=;
        b=hWld1Zx/A40yVZREsF9oiSF7CIrU/8FjVVk1NuIgxEXsXO7QmVRUSkRUHjb9R/cclpCb81
        W4WubLAnNLuWn5GLbS4g6nB+/NwnoaEGmp0LyiLNHbkxh+6oDlKpIL3tAdxoYHbnVQa8qj
        hQFp82Ng+hbDtCFlQG0EdoT7bkPeBYk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-lVGc8SivM1ad25tmQcqwGA-1; Wed, 09 Jun 2021 13:23:10 -0400
X-MC-Unique: lVGc8SivM1ad25tmQcqwGA-1
Received: by mail-ed1-f72.google.com with SMTP id c21-20020a0564021015b029038c3f08ce5aso12768875edu.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 10:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=peNQguMIZxsiTtT/t38MJAly3Hcz6eiRy0HbljXWio4=;
        b=HR+LcyQAYteJPYI1e5dD6xPcCZ4q/ydo43n0qHQUOK6ewwVfaCG1wgYoKiOXiyzVfg
         KqZjGCI82ak5IS8j5a3ekdY/FyNa+4tFDj4uFHDR49bVTIlw+4dPzUrQ6OHK68fN23eV
         yPvSAvMHxm5aChfrSJYWty81NYO/JtPictE93AJ+5U/Bb2v36LnKmJQ2m2Ol5xuVBvCN
         mJ94zcAeqzcF+tqPSA2tRPVtAdYvR3UdZ0V74SycUFeQLplR88omQ7RtB6c00nTIEDts
         71NjzpUMI4XASnfeesHRdBV1XsWdUhFYPE3fNRVVHy3VOuNXkYCL1aO5BXSk8zOReM7C
         T77g==
X-Gm-Message-State: AOAM5329T+iJdJrBJq4Zy3y87B9F9707v+248Y7hpshsObIe11SjX53o
        2/ggZdInYkU42gqQE+xv+NrM7T5gimqAZF6I50fkH7u5dEhccCMi8SiQIQwctChyIAZSx3gZX9S
        ONXs961dj5m35CYn+QgtkRQht
X-Received: by 2002:a05:6402:5a:: with SMTP id f26mr515572edu.306.1623259389288;
        Wed, 09 Jun 2021 10:23:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyknKH2uiTBUeCGPhqnlCmEMhOzuj4jQmm2WzSOkynDnzdAldpkRtK2yvTxGj4868DxwKg3Hg==
X-Received: by 2002:a05:6402:5a:: with SMTP id f26mr515557edu.306.1623259389156;
        Wed, 09 Jun 2021 10:23:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i25sm122999ejg.103.2021.06.09.10.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 10:23:08 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.13-3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Message-ID: <f389f824-2a3f-e0fb-2120-7bfa0baf7bb1@redhat.com>
Date:   Wed, 9 Jun 2021 19:23:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a second set of bug-fixes and some hardware-id additions for platform-drivers-x86 for 5.13.

Note the mlxreg-hotplug revert is a regression-fix.

Regards,

Hans


The following changes since commit e68671e9e1275dfdda333c3e83b6d28963af16b6:

  platform/x86: touchscreen_dmi: Add info for the Chuwi Hi10 Pro (CWI529) tablet (2021-05-20 14:11:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.13-3

for you to fetch changes up to 701b54bcb7d0d72ee3f032afc900608708409be0:

  platform/mellanox: mlxreg-hotplug: Revert "move to use request_irq by IRQF_NO_AUTOEN flag" (2021-06-04 22:03:13 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.13-3

Assorted pdx86 bug-fixes and some hardware-id additions for 5.13.

The following is an automated git shortlog grouped by driver:

platform/mellanox:
 -  mlxreg-hotplug: Revert "move to use request_irq by IRQF_NO_AUTOEN flag"

platform/surface:
 -  dtx: Add missing mutex_destroy() call in failure path
 -  aggregator: Fix event disable function
 -  aggregator_registry: Add support for 13" Intel Surface Laptop 4
 -  aggregator_registry: Update comments for 15" AMD Surface Laptop 4

thinkpad_acpi:
 -  Add X1 Carbon Gen 9 second fan support

----------------------------------------------------------------
Maximilian Luz (4):
      platform/surface: aggregator_registry: Update comments for 15" AMD Surface Laptop 4
      platform/surface: aggregator_registry: Add support for 13" Intel Surface Laptop 4
      platform/surface: aggregator: Fix event disable function
      platform/surface: dtx: Add missing mutex_destroy() call in failure path

Mykola Kostenok (1):
      platform/mellanox: mlxreg-hotplug: Revert "move to use request_irq by IRQF_NO_AUTOEN flag"

Til Jasper Ullrich (1):
      platform/x86: thinkpad_acpi: Add X1 Carbon Gen 9 second fan support

 drivers/platform/mellanox/mlxreg-hotplug.c             | 4 ++--
 drivers/platform/surface/aggregator/controller.c       | 2 +-
 drivers/platform/surface/surface_aggregator_registry.c | 7 +++++--
 drivers/platform/surface/surface_dtx.c                 | 1 +
 drivers/platform/x86/thinkpad_acpi.c                   | 1 +
 5 files changed, 10 insertions(+), 5 deletions(-)

