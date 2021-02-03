Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1830D76F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhBCKZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:25:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233619AbhBCKZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612347839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PgAz4MrsS+zW5N77zXxwS56AukbM+WtnyJF1hzHWECk=;
        b=ARYDso+SqMqa0IFVB2qsUhbyHVyxI1lfjK+/ai+fuo0WT3552J/f1gtBH4CwJ7rVqUJo0d
        cpjl4+9Mi7fCCBu9MwMoeqRhdeFHpJLdaTkjdqWm80bZ2u72ikMkmLn9Cp9LCe7BTr0Zkc
        wrSqEEfpRzb92wgfDVLUo960LJF2FVA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-yKZfFFvxNYWaOBwwAhb9ZA-1; Wed, 03 Feb 2021 05:23:55 -0500
X-MC-Unique: yKZfFFvxNYWaOBwwAhb9ZA-1
Received: by mail-ed1-f71.google.com with SMTP id p18so1367770edr.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 02:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PgAz4MrsS+zW5N77zXxwS56AukbM+WtnyJF1hzHWECk=;
        b=OdUMHgPxunsg8gexauk9DUW+MhgE8HOENOpkj4aNvAyXgJUmavpKjyiRxctRIxYs6V
         NNSMiUD2A6hn8VFxNfaFGXysDlihQFDzN/+PMM+SvU2T+hp5lVqyGsEnHueEKbW9Pcig
         uv0Nf+qWW3rmEIhr/N0fVl7Jea+Czh2JTx+BWmQRQqMwZKTCMMCW1izeFpjc/X5+ZMkv
         VaWxkR+OWU91GEiW44amPRvpbHkMRhVhf6c04J09M+VRy6Oli6biclbtzz/h+VZ1Texh
         gmLd8qbhXjevUhVowN1v5wAHx3oRpCs69WBV5Hl2n1VyeFc7+8H1HHJLrunn2dpjnZIX
         37dw==
X-Gm-Message-State: AOAM533bDaPfgaFVqBknxE3pCt2KZk2p0vnTf2xr3fblE6jrjRO34eUs
        7j5jyjdzmnJbrhzNbLF2T1KVbcaq9fpMqDwcG74mBYtuq/CrksosjuG5+XK7E17jnrFQMCXMFp4
        dajFfzsSdy2Cz2StEjY6ohhSu
X-Received: by 2002:aa7:cdcd:: with SMTP id h13mr2186440edw.11.1612347834424;
        Wed, 03 Feb 2021 02:23:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx012jsD6tLqDqC6mBh2rOnYXYjs2Fy2dpQH3GcInyos9pCyFxbGKsOMvEmvYsfA6UWY4tM8Q==
X-Received: by 2002:aa7:cdcd:: with SMTP id h13mr2186434edw.11.1612347834221;
        Wed, 03 Feb 2021 02:23:54 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id lz27sm793054ejb.50.2021.02.03.02.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 02:23:53 -0800 (PST)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.11-3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Message-ID: <368c6b64-1e5b-743d-e255-7e9bade23238@redhat.com>
Date:   Wed, 3 Feb 2021 11:23:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry about the last-minute pull-req. This pull-req contains 2 small but
important bug fixes.

The hp-wmi change fixes an issue which is actively being hit by users:
https://bugzilla.redhat.com/show_bug.cgi?id=1918255
https://gitlab.gnome.org/GNOME/gnome-shell/-/issues/3564

And the dell-wmi-sysman patch fixes a bug in the new dell-wmi-sysman
driver which causes some systems to hang at boot when the driver loads.

Regards,

Hans


The following changes since commit 173aac2fef96972e42d33c0e1189e6f756a0d719:

  platform/x86: thinkpad_acpi: Add P53/73 firmware to fan_quirk_table for dual fan control (2021-01-18 21:42:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.11-3

for you to fetch changes up to 215164bfb7144c5890dd8021ff06e486939862d4:

  platform/x86: dell-wmi-sysman: fix a NULL pointer dereference (2021-01-31 22:05:35 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.11-3

2 last minute small but important fixes for v5.11 .

The following is an automated git shortlog grouped by driver:

dell-wmi-sysman:
 -  fix a NULL pointer dereference

hp-wmi:
 -  Disable tablet-mode reporting by default

----------------------------------------------------------------
Hans de Goede (1):
      platform/x86: hp-wmi: Disable tablet-mode reporting by default

Mario Limonciello (1):
      platform/x86: dell-wmi-sysman: fix a NULL pointer dereference

 drivers/platform/x86/dell-wmi-sysman/sysman.c |  6 +++++-
 drivers/platform/x86/hp-wmi.c                 | 14 ++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

