Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73336347F54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhCXR2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237075AbhCXQwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616604730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XRgY94ha0vrv1w0bON3B8v6mEUZi3/yev0iPH5AU4m0=;
        b=UAVF0M+OMCA+fR1B027LKXavghXEODDsIbe4ZxiIaPzSAPsBFcG4XN5rQibi28StS9HFiZ
        jZUH3ji2uOfS0pssL8IkU/pDcqnAiECCeOOou8AQY7dp3FzNvrIX/S7L7J93A5a1R6WBD+
        fzQztOwNr/yYiIphCaJgweQSypo4Xh4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-4OjbZGDHMWq-gJAKl7Yghw-1; Wed, 24 Mar 2021 12:52:05 -0400
X-MC-Unique: 4OjbZGDHMWq-gJAKl7Yghw-1
Received: by mail-ej1-f72.google.com with SMTP id en21so1229970ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XRgY94ha0vrv1w0bON3B8v6mEUZi3/yev0iPH5AU4m0=;
        b=M3XrjZjoDyKl92O4h8dDWZXzoLWArsUREAJiC3rVn0GRb4GIQEXCIB/wETpQ/OtX44
         Ztp4vS7lTpsRcDtT64y+lyzPWnho89I7x3FGKOk6aNXdj81ZVgf1ivQ6Lru7LO1OouD9
         ZVY+Qh6/7NRWgdDBAg9Ct19mPouoZmVnQqAE1zuL2Dd8xXWd/HhSzJ1HdSVJxuQckeNE
         lpDhd3M7Cd+4vB7/94jHD2Y4bm/N5duVQCdGUnF0J7CCJc4FSQMa0ttxS2tylKJ2WT01
         UKKy0JwhgONC0XUvwlJo5mepq70dm9rHXau9PBTpZBv9TVjfaNpaoKvdNIhF1g3WjHK5
         evhg==
X-Gm-Message-State: AOAM530F9/lttNGu836E5yt5+/nbKOZI1BbbE9q1UyV1vpJ4haB97ub8
        Y5nutBY9Dn/bxR0MDROCpGjvR2GuUN9Vqzm5+LtsBFtAbLzDcClVnc8K8IbuPUapZofJKBJsAjp
        BHS1zem/WqtcGZ4Iu6ARAT+KA
X-Received: by 2002:a17:906:a44a:: with SMTP id cb10mr4612833ejb.424.1616604724416;
        Wed, 24 Mar 2021 09:52:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY1lhKkwKTZjRoMxaASKxOTx9Z2MJ3SePdh04BKuLXFau0XOsfVtKuw+IhbFyDuXkmkDS0bg==
X-Received: by 2002:a17:906:a44a:: with SMTP id cb10mr4612818ejb.424.1616604724230;
        Wed, 24 Mar 2021 09:52:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gq25sm1186328ejb.85.2021.03.24.09.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 09:52:03 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.12-2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Message-ID: <a741efb3-a20e-1ed7-91eb-b2a710a87d72@redhat.com>
Date:   Wed, 24 Mar 2021 17:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a set of bug-fixes and some model specific quirks for platform-drivers-x86 for 5.12.

Regards,

Hans


The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.12-2

for you to fetch changes up to d1635448f1105e549b4041aab930dbc6945fc635:

  platform/x86: intel_pmc_core: Ignore GBE LTR on Tiger Lake platforms (2021-03-23 21:50:14 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.12-2

Summary:
 - dell-wmi-sysman: A set of probe-error-exit-handling fixes to fix some systems
   which advertise the WMI GUIDs, but are not compatible, not booting
 - intel-vbtn/intel-hid: Misc. bugfixes
 - intel_pmc: Bug-fixes + a quirk to lower suspend power-consumption on Tiger Lake
 - thinkpad_acpi: Misc. bugfixes

The following is an automated git shortlog grouped by driver:

dell-wmi-sysman:
 -  Cleanup create_attributes_level_sysfs_files()
 -  Make sysman_init() return -ENODEV of the interfaces are not found
 -  Cleanup sysman_init() error-exit handling
 -  Fix release_attributes_data() getting called twice on init_bios_attributes() failure
 -  Make it safe to call exit_foo_attributes() multiple times
 -  Fix possible NULL pointer deref on exit
 -  Fix crash caused by calling kset_unregister twice

intel-hid:
 -  Support Lenovo ThinkPad X1 Tablet Gen 2

intel-vbtn:
 -  Stop reporting SW_DOCK events

intel_pmc_core:
 -  Ignore GBE LTR on Tiger Lake platforms
 -  Update Kconfig

intel_pmt_class:
 -  Initial resource to 0

intel_pmt_crashlog:
 -  Fix incorrect macros

thinkpad_acpi:
 -  Disable DYTC CQL mode around switching to balanced mode
 -  Allow the FnLock LED to change state
 -  check dytc version for lapmode sysfs

----------------------------------------------------------------
Alban Bedel (1):
      platform/x86: intel-hid: Support Lenovo ThinkPad X1 Tablet Gen 2

David E. Box (4):
      platform/x86: intel_pmt_class: Initial resource to 0
      platform/x86: intel_pmt_crashlog: Fix incorrect macros
      platform/x86: intel_pmc_core: Update Kconfig
      platform/x86: intel_pmc_core: Ignore GBE LTR on Tiger Lake platforms

Esteve Varela Colominas (1):
      platform/x86: thinkpad_acpi: Allow the FnLock LED to change state

Hans de Goede (9):
      platform/x86: thinkpad_acpi: Disable DYTC CQL mode around switching to balanced mode
      platform/x86: dell-wmi-sysman: Fix crash caused by calling kset_unregister twice
      platform/x86: dell-wmi-sysman: Fix possible NULL pointer deref on exit
      platform/x86: dell-wmi-sysman: Make it safe to call exit_foo_attributes() multiple times
      platform/x86: dell-wmi-sysman: Fix release_attributes_data() getting called twice on init_bios_attributes() failure
      platform/x86: dell-wmi-sysman: Cleanup sysman_init() error-exit handling
      platform/x86: dell-wmi-sysman: Make sysman_init() return -ENODEV of the interfaces are not found
      platform/x86: dell-wmi-sysman: Cleanup create_attributes_level_sysfs_files()
      platform/x86: intel-vbtn: Stop reporting SW_DOCK events

Mark Pearson (1):
      platform/x86: thinkpad_acpi: check dytc version for lapmode sysfs

 drivers/platform/x86/Kconfig                       |  11 ++-
 .../x86/dell/dell-wmi-sysman/enum-attributes.c     |   3 +
 .../x86/dell/dell-wmi-sysman/int-attributes.c      |   3 +
 .../x86/dell/dell-wmi-sysman/passobj-attributes.c  |   3 +
 .../x86/dell/dell-wmi-sysman/string-attributes.c   |   3 +
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |  84 ++++++----------
 drivers/platform/x86/intel-hid.c                   |   7 ++
 drivers/platform/x86/intel-vbtn.c                  |  12 ++-
 drivers/platform/x86/intel_pmc_core.c              |  50 +++++++---
 drivers/platform/x86/intel_pmt_class.c             |   2 +-
 drivers/platform/x86/intel_pmt_crashlog.c          |  13 ++-
 drivers/platform/x86/thinkpad_acpi.c               | 108 +++++++++++++++------
 12 files changed, 190 insertions(+), 109 deletions(-)

