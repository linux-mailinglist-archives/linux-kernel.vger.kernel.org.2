Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7313D3F1467
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhHSHhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229501AbhHSHhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629358598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EGoAqiXMaqUmTnBvOsdIXNuYmSfBYahpZQJKl7y5rt4=;
        b=hoVuZYdaOhxiJLOL3AuW2IpgPN8fr5EmjG4FdkuLs+VQiiTZehnbpAfqaZ6KX/Ol+V8riC
        nv3xoLM9zDvrm+ngj5bC+do1DyzS4l/MDYLpOqbpStgS+3L5r6nqjrVr7dgFO95cbqd7yq
        zQgPvSKLrN4dkpuFmj3HQIvkmH8Khac=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-kuejwGsiMYmfhBOyc3GyUw-1; Thu, 19 Aug 2021 03:36:37 -0400
X-MC-Unique: kuejwGsiMYmfhBOyc3GyUw-1
Received: by mail-ej1-f69.google.com with SMTP id ja25-20020a1709079899b02905b2a2bf1a62so1896204ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=EGoAqiXMaqUmTnBvOsdIXNuYmSfBYahpZQJKl7y5rt4=;
        b=gCzcev66I0DWpDACMfRsiwXcODiH4CJPpGO2ly7W1lMAQY/MLZ78wyI0VdIBzz6LU0
         +WPn0n7na5sO1wS4ObCQrTD47d2uQJPjsQGBsf0OMROHrQdjKSjFul+hKw/LclRToA3q
         vLgRyQvlc6/Dqy4BExArGjtXsv3ZaXjBNlXTO9UexKWDTO69YSwmR1Cx9h6rga3hCbZD
         upq1TPwD3V9UCKCGBAJbTHLEEesv84sRhhoQR3fXuFr6oimUTDJuzJBSYJQ2uBQunK72
         0E107kNz1YvvbyvJbbCxKQ4UxsebW4b/m1fOpCRqkrLsvJQnSq/W6Lvpb3eKrWZkwAC0
         IWyQ==
X-Gm-Message-State: AOAM5306ox8wD9lrVXCrQFWJQNPaen268+ljb8eiTkJQs3cq68vkW9LF
        rTrMyXbiG4bN9JRKNz0F6eiqmvz5FyCdfSoil6SO+yTNs/khp1wLdwO68dZoUtMsBDepKtEggzd
        em95F3m0iHK7f8AHHppZ3ijYa
X-Received: by 2002:aa7:c502:: with SMTP id o2mr14981357edq.86.1629358596134;
        Thu, 19 Aug 2021 00:36:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhoishZRqWaTBsxqhiz0xnk+GI815zExuOZ46CXo4J7GQ/QaAj7nnhoVu6BSycVn18zzXFoA==
X-Received: by 2002:aa7:c502:: with SMTP id o2mr14981341edq.86.1629358595936;
        Thu, 19 Aug 2021 00:36:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v12sm1285528ede.16.2021.08.19.00.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 00:36:35 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.14-4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Message-ID: <2c41a5a1-f773-06c5-71ab-05537cb276b0@redhat.com>
Date:   Thu, 19 Aug 2021 09:36:34 +0200
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

Here is a small set of pdx86 fixes for 5.14:
- asus-nb-wmi: Enable SW_TABLET_MODE support for the TP200s (DMI quirk)
- gigabyte-wmi: Enable on 2 more Gigabyte motherboards (2 DMI quirks)

Regards,

Hans


The following changes since commit 9d7b132e62e41b7d49bf157aeaf9147c27492e0f:

  platform/x86: pcengines-apuv2: Add missing terminating entries to gpio-lookup tables (2021-08-06 14:04:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.14-4

for you to fetch changes up to 1e35b8a7780a0c043cc5389420f069b69343f5d9:

  platform/x86: gigabyte-wmi: add support for B450M S2H V2 (2021-08-18 19:39:31 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.14-4

A small set of pdx86 fixes for 5.14:
- asus-nb-wmi: Enable SW_TABLET_MODE support for the TP200s (DMI quirk)
- gigabyte-wmi: Enable on 2 more Gigabyte motherboards (2 DMI quirks)

The following is an automated git shortlog grouped by driver:

asus-nb-wmi:
 -  Add tablet_mode_sw=lid-flip quirk for the TP200s
 -  Allow configuring SW_TABLET_MODE method with a module option

gigabyte-wmi:
 -  add support for B450M S2H V2
 -  add support for X570 GAMING X

----------------------------------------------------------------
Hans de Goede (2):
      platform/x86: asus-nb-wmi: Allow configuring SW_TABLET_MODE method with a module option
      platform/x86: asus-nb-wmi: Add tablet_mode_sw=lid-flip quirk for the TP200s

Thomas Weißschuh (2):
      platform/x86: gigabyte-wmi: add support for X570 GAMING X
      platform/x86: gigabyte-wmi: add support for B450M S2H V2

 drivers/platform/x86/asus-nb-wmi.c  | 28 ++++++++++++++++++++++++++++
 drivers/platform/x86/gigabyte-wmi.c |  2 ++
 2 files changed, 30 insertions(+)

