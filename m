Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F383D8BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhG1Kei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235972AbhG1Ked (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627468472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WqbYlFVczMjefGq/E8hjUCD6IN/H9aL+LJX308Bbaeg=;
        b=R+0KIYVs6f6dz93RygEojWRGvZHS1GU1G6Lc4xjcsxVkgjZih89DXzdk1ipDxe+oCBH/vS
        ihuhSLcmFXKVe4h6I6zpbM6uiNTOsNJIwdqqRqPmVX2LLlhPeGCZL4304Ls0CjhILWpdCa
        UKtV+G+JG69yf8FqEe8tB1WCspQ2/nE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-8ugoLre9Nxi_Y_BhTnDyQQ-1; Wed, 28 Jul 2021 06:34:30 -0400
X-MC-Unique: 8ugoLre9Nxi_Y_BhTnDyQQ-1
Received: by mail-ed1-f72.google.com with SMTP id k14-20020a05640212ceb02903bc50d32c17so1038160edx.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WqbYlFVczMjefGq/E8hjUCD6IN/H9aL+LJX308Bbaeg=;
        b=L+NwCqhE93i3kKkhl6afreJOB64Yu68RNrU3MImbZc40b8KTJwGh8STLVHwzOh6GQQ
         MN77NHlIeyfAVexBOOEV5FvZxyIWhQ+KWl/gpoeEs0x9qLQgvQi3ociIW4NGiQIBzGyB
         J3Hk/fsz7Y2tKNJZaZ50aYzhxjaNiLCGSCZ02GUSL4TWHn+Gb0Z9Yok+dqjXeWaJfnE8
         8ScnCn9UhK8bgat+MI/1hF6kYT2HW9nZQkWg0swC5bPFdsNGllA33iuXfgBlPNSzz8Eo
         xK1PnA1amlbW7DFINQjqwjYqkZj7mRqPE3IUw42YsOvHEK+1tcxwafVZgpBcBUkhJbN4
         7ZzQ==
X-Gm-Message-State: AOAM533z4R58pskyTAnmjpHaKpyu90l1a/A2WpIT05COY5jAoL+icr3t
        hDHo/3DUo00AgfcIuEph+IdsnBEibMd7bbvy3bbWXPFTUhGFDCgPkkNFYP1mGcENKi9CP8ZkH7r
        udbysU6nExj9TmHiTjf2JM8Nc
X-Received: by 2002:a17:906:3006:: with SMTP id 6mr27197628ejz.73.1627468469758;
        Wed, 28 Jul 2021 03:34:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7JwMzC99Ym6dFiISGnF85kJMEhce47Kwas0P1ncLLr2Or9f+7pd5G3HAGd/vW91ItZkzukg==
X-Received: by 2002:a17:906:3006:: with SMTP id 6mr27197610ejz.73.1627468469567;
        Wed, 28 Jul 2021 03:34:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f12sm1883953ejz.99.2021.07.28.03.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:34:29 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.14-2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Message-ID: <093f84b2-d058-40f1-e888-1cafe1846b12@redhat.com>
Date:   Wed, 28 Jul 2021 12:34:28 +0200
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

Here is a set of bug-fixes and new hardware-ids for platform-drivers-x86 for 5.14.

Regards,

Hans


The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.14-2

for you to fetch changes up to 2b2c66f607d00d17f879c0d946d44340bfbdc501:

  platform/x86: gigabyte-wmi: add support for B550 Aorus Elite V2 (2021-07-28 12:05:33 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.14-2

Highlights:
-amd-pmc fixes
-think-lmi fixes
-Various new hardware-ids

The following is an automated git shortlog grouped by driver:

amd-pmc:
 -  Fix undefined reference to __udivdi3
 -  Fix missing unlock on error in amd_pmc_send_cmd()
 -  Use return code on suspend
 -  Add new acpi id for future PMC controllers
 -  Add support for ACPI ID AMDI0006
 -  Add support for logging s0ix counters
 -  Add support for logging SMU metrics
 -  call dump registers only once
 -  Fix SMU firmware reporting mechanism
 -  Fix command completion code

gigabyte-wmi:
 -  add support for B550 Aorus Elite V2

intel-hid:
 -  add Alder Lake ACPI device ID

think-lmi:
 -  Fix possible mem-leaks on tlmi_analyze() error-exit
 -  Split kobject_init() and kobject_add() calls
 -  Move pending_reboot_attr to the attributes sysfs dir
 -  Add pending_reboot support

wireless-hotkey:
 -  remove hardcoded "hp" from the error message

----------------------------------------------------------------
Alex Hung (1):
      platform/x86: wireless-hotkey: remove hardcoded "hp" from the error message

Hans de Goede (2):
      platform/x86: think-lmi: Split kobject_init() and kobject_add() calls
      platform/x86: think-lmi: Fix possible mem-leaks on tlmi_analyze() error-exit

Mario Limonciello (1):
      platform/x86: amd-pmc: Use return code on suspend

Mark Pearson (2):
      platform/x86: think-lmi: Add pending_reboot support
      platform/x86: think-lmi: Move pending_reboot_attr to the attributes sysfs dir

Ping Bao (1):
      platform/x86: intel-hid: add Alder Lake ACPI device ID

Shyam Sundar S K (8):
      platform/x86: amd-pmc: Fix command completion code
      platform/x86: amd-pmc: Fix SMU firmware reporting mechanism
      platform/x86: amd-pmc: call dump registers only once
      platform/x86: amd-pmc: Add support for logging SMU metrics
      platform/x86: amd-pmc: Add support for logging s0ix counters
      platform/x86: amd-pmc: Add support for ACPI ID AMDI0006
      platform/x86: amd-pmc: Add new acpi id for future PMC controllers
      platform/x86: amd-pmc: Fix undefined reference to __udivdi3

Thomas Weißschuh (1):
      platform/x86: gigabyte-wmi: add support for B550 Aorus Elite V2

Yang Yingliang (1):
      platform/x86: amd-pmc: Fix missing unlock on error in amd_pmc_send_cmd()

 drivers/platform/x86/amd-pmc.c         | 249 +++++++++++++++++++++++++++++----
 drivers/platform/x86/gigabyte-wmi.c    |   1 +
 drivers/platform/x86/intel-hid.c       |   1 +
 drivers/platform/x86/think-lmi.c       |  45 ++++--
 drivers/platform/x86/think-lmi.h       |   1 +
 drivers/platform/x86/wireless-hotkey.c |   2 +-
 6 files changed, 265 insertions(+), 34 deletions(-)

