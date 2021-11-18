Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D25B45584B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbhKRJxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:53:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245288AbhKRJxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637229002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TYzIt72Y0GLEBCHWpV2i6CZMp5top3e9SI2S0V0GzMw=;
        b=V3z94lnduvAaalIZcYh8ibAnnRHPmrUqQFyPzbN4QPyOsszpg/alpo14CdQFDgHoO4bKnF
        +WKOJS2S/NGjIUo5aBarBrooUETm/OhL5fjGU35vYagCMiabTC9vGaDFrr/Qdhg9GvhDzV
        g/i02gSbax3q8mmP8i/oOQctYVHuXXs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-HarLLI7-MS2j-_GzCzhWDg-1; Thu, 18 Nov 2021 04:50:01 -0500
X-MC-Unique: HarLLI7-MS2j-_GzCzhWDg-1
Received: by mail-ed1-f70.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso4740810edj.20
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=TYzIt72Y0GLEBCHWpV2i6CZMp5top3e9SI2S0V0GzMw=;
        b=m45unGULAOAxyzq2n7J9FIwoqCkbKx5XdYascLrmOcFH+1VgCoMep6qsA5Jg+MgPU2
         +drl4E8EBtQjl6Dap16J1TwuxmgVIq4PTfgCFjiFOlCIdj7gehGNpTEPfir/bawmMY67
         U/jMVHMsBV++IFERIK3uAwW4CWlLIVMjtMxJdTdc8qMbcgygGUERwVi1XlGS7IawbyOy
         tHk974jI8s+YVeCy111Lk6jysv2bFQKMrpRDPKV8RE8uNqOB9JuIG0/T3caNmDJRSQHo
         kXkZaYn8FysS5rpLNl+yGsIHfSdrx8V/3FYoGBa11Q/iRrJUmBot8mVH4muw5XFcrdSO
         fvWA==
X-Gm-Message-State: AOAM533ZBhlEiTT2jqyZ+uRGCVB1dRV78xvgNvdteHi4tNLJkTf2l7Ou
        UYVuImMXryNw43LfYXpNVPaxO+USSK+wR16KDnhPhIcXip8ucMQ/9vI+QYzzOt4sVpt6akH/OA0
        QX+z9P7psQB/HWhTuLnZYm+Gn
X-Received: by 2002:a05:6402:22a5:: with SMTP id cx5mr9325864edb.334.1637228999806;
        Thu, 18 Nov 2021 01:49:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4nR554SfrGYJi4G12EFLOiXUxJBtxE+zltb9yfvA2VIZ0bHmrREihf7KmA/EVx5tzXplNHA==
X-Received: by 2002:a05:6402:22a5:: with SMTP id cx5mr9325844edb.334.1637228999682;
        Thu, 18 Nov 2021 01:49:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id kx3sm1034912ejc.112.2021.11.18.01.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 01:49:59 -0800 (PST)
Message-ID: <f5ff716f-ba1d-31b1-bad3-e1aadea02931@redhat.com>
Date:   Thu, 18 Nov 2021 10:49:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.16-2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the first round of bug-fixes for platform-drivers-x86
for 5.16.

This consists of various build- and bug-fixes as well as
1 hardware-id addition.

Regards,

Hans


The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-2

for you to fetch changes up to d477a907cba317cfa58a8c89c09454d3fced1964:

  platform/x86: thinkpad_acpi: fix documentation for adaptive keyboard (2021-11-16 10:56:53 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.16-2

Various build- and bug-fixes as well as 1 hardware-id addition.

The following is an automated git shortlog grouped by driver:

amd-pmc:
 -  Make CONFIG_AMD_PMC depend on RTC_CLASS

dell-wmi-descriptor:
 -  disable by default

hp_accel:
 -  Fix an error handling path in 'lis3lv02d_probe()'

platform/mellanox:
 -  mlxreg-lc: fix error code in mlxreg_lc_create_static_devices()

samsung-laptop:
 -  Fix typo in a comment

think-lmi:
 -  Abort probe on analyze failure

thinkpad_acpi:
 -  fix documentation for adaptive keyboard
 -  Fix WWAN device disabled issue after S3 deep
 -  Add support for dual fan control

----------------------------------------------------------------
Alex Williamson (1):
      platform/x86: think-lmi: Abort probe on analyze failure

Christophe JAILLET (1):
      platform/x86: hp_accel: Fix an error handling path in 'lis3lv02d_probe()'

Dan Carpenter (1):
      platform/mellanox: mlxreg-lc: fix error code in mlxreg_lc_create_static_devices()

Hans de Goede (1):
      platform/x86: amd-pmc: Make CONFIG_AMD_PMC depend on RTC_CLASS

Jason Wang (1):
      platform/x86: samsung-laptop: Fix typo in a comment

Jimmy Wang (1):
      platform/x86: thinkpad_acpi: Add support for dual fan control

Slark Xiao (1):
      platform/x86: thinkpad_acpi: Fix WWAN device disabled issue after S3 deep

Thomas Weißschuh (1):
      platform/x86: dell-wmi-descriptor: disable by default

Vincent Bernat (1):
      platform/x86: thinkpad_acpi: fix documentation for adaptive keyboard

 Documentation/admin-guide/laptops/thinkpad-acpi.rst | 12 ++++++------
 drivers/platform/mellanox/mlxreg-lc.c               |  5 +++--
 drivers/platform/x86/Kconfig                        |  2 +-
 drivers/platform/x86/dell/Kconfig                   |  2 +-
 drivers/platform/x86/hp_accel.c                     |  2 ++
 drivers/platform/x86/samsung-laptop.c               |  2 +-
 drivers/platform/x86/think-lmi.c                    | 13 ++++++++++---
 drivers/platform/x86/think-lmi.h                    |  1 -
 drivers/platform/x86/thinkpad_acpi.c                | 13 +------------
 9 files changed, 25 insertions(+), 27 deletions(-)

