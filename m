Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25BA41350F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhIUOMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233459AbhIUOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632233459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cE900L65kVIfjK8VvpSvwnI3zOb0vmCndw5L/cT4PJY=;
        b=BNBn9joqL0GmbZE+lerdT4LOMyN6eYqTj2+P0GOK8ugxFxWopfQB8RAYN1QwhXXtTtObSa
        aXy7wTygppVMxFzwR6csoQQpkJDpIWzCaFloN15SNERIoKATIJF05MRV1UqiNQF0hdOyct
        loUqvcAJ36Y7x5tUSSQ4hqvxhG64aNc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-27CWZdxEMXG47KRX38NnwQ-1; Tue, 21 Sep 2021 10:10:58 -0400
X-MC-Unique: 27CWZdxEMXG47KRX38NnwQ-1
Received: by mail-ed1-f71.google.com with SMTP id w24-20020a056402071800b003cfc05329f8so19224712edx.19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cE900L65kVIfjK8VvpSvwnI3zOb0vmCndw5L/cT4PJY=;
        b=LJHcG9LhNDdFOGv2vFlA7p3XzZXPA3Sm0W8sL7Zv2zHt5sXeIAetNpSro5hCehnnLF
         GBRbokVOsidvS6oRpSMR38E6neNioV7I1bOpV0HKDiwKK9VsisXlQFXufDSkwNXOAAYH
         4iXdmadwJ3qrE6E5Y4YFUaXZtMqrWbyVtPWyh2by9u0mWdg1WT7TE6JO4qSbWqmi5aoY
         fcKduuoKsgtdTT115aVqX0lFw+wFgJataM17t313511G9rnZDmnE2ENi7yLfBf3ImKa9
         +aBrZXP8tb0ptSoNlmlp+kPIYY//Q9BypWIL0y5Dw7nTWm8wlSktDQ0mqSAzcTUlYGUi
         k9UQ==
X-Gm-Message-State: AOAM533DvYlP+ho19Nhsk7mTn09/Wpna55nLEYj+8+KYYjaopUCNuRE/
        vOJZ+LGdxGwSBWerlQ3Xr4Mw4pIYG82ojrDy/Vbc6YnQdU/rYKlnLBNIdAYV7eGufi9w9l+Jv63
        gb7dh5xOw5l1WAhx0/Ooaaw4a
X-Received: by 2002:a17:906:6dc1:: with SMTP id j1mr35454455ejt.324.1632233456591;
        Tue, 21 Sep 2021 07:10:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAoM5e3buXw+N0LcG9p+wHQBfnYocJMtDe5bhVO8jD0Iq9JvegX69/gL9z94fLU813+DHQ5g==
X-Received: by 2002:a17:906:6dc1:: with SMTP id j1mr35454437ejt.324.1632233456410;
        Tue, 21 Sep 2021 07:10:56 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id be9sm8031877edb.13.2021.09.21.07.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 07:10:56 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.15-2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Message-ID: <d7f081b7-275a-4f1c-ed27-9016ed5b2b46@redhat.com>
Date:   Tue, 21 Sep 2021 16:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the first round of bug-fixes for platform-drivers-x86
for 5.15, highlights:
 -  amd-pmc fix for some suspend/resume issues
 -  intel-hid fix to avoid false-positive SW_TABLET_MODE=1 reporting
 -  some build error/warning fixes
 -  various DMI quirk additions

Regards,

Hans


The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.15-2

for you to fetch changes up to 6f6aab1caf6c7fef46852aaab03f4e8250779e52:

  platform/x86: gigabyte-wmi: add support for B550I Aorus Pro AX (2021-09-21 15:49:23 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.15-2

Highlights:
 -  amd-pmc fix for some suspend/resume issues
 -  intel-hid fix to avoid false-positive SW_TABLET_MODE=1 reporting
 -  some build error/warning fixes
 -  various DMI quirk additions

The following is an automated git shortlog grouped by driver:

amd-pmc:
 -  Increase the response register timeout

dell:
 -  fix DELL_WMI_PRIVACY dependencies & build error

gigabyte-wmi:
 -  add support for B550I Aorus Pro AX

lg-laptop:
 -  Correctly handle dmi_get_system_info() returning NULL

platform/x86/intel:
 -  hid: Add DMI switches allow list
 -  punit_ipc: Drop wrong use of ACPI_PTR()

touchscreen_dmi:
 -  Update info for the Chuwi Hi10 Plus (CWI527) tablet
 -  Add info for the Chuwi HiBook (CWI514) tablet

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/x86/intel: punit_ipc: Drop wrong use of ACPI_PTR()

Hans de Goede (2):
      platform/x86: touchscreen_dmi: Add info for the Chuwi HiBook (CWI514) tablet
      platform/x86: touchscreen_dmi: Update info for the Chuwi Hi10 Plus (CWI527) tablet

José Expósito (1):
      platform/x86/intel: hid: Add DMI switches allow list

Mario Limonciello (1):
      platform/x86: amd-pmc: Increase the response register timeout

Matan Ziv-Av (1):
      lg-laptop: Correctly handle dmi_get_system_info() returning NULL

Randy Dunlap (1):
      platform/x86: dell: fix DELL_WMI_PRIVACY dependencies & build error

Tobias Jakobi (1):
      platform/x86: gigabyte-wmi: add support for B550I Aorus Pro AX

 drivers/platform/x86/amd-pmc.c         |  2 +-
 drivers/platform/x86/dell/Kconfig      |  3 +-
 drivers/platform/x86/gigabyte-wmi.c    |  1 +
 drivers/platform/x86/intel/hid.c       | 27 +++++++++++++----
 drivers/platform/x86/intel/punit_ipc.c |  3 +-
 drivers/platform/x86/lg-laptop.c       |  2 +-
 drivers/platform/x86/touchscreen_dmi.c | 54 +++++++++++++++++++++++++++++++---
 7 files changed, 77 insertions(+), 15 deletions(-)

