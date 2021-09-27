Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2C54192E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhI0LNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233959AbhI0LMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DDB36108E;
        Mon, 27 Sep 2021 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632741062;
        bh=P47FrSTuUz2xeiOIAAHA2YwBt3bEeWW94qpmD8mk2ps=;
        h=From:To:Cc:Subject:Date:From;
        b=YCWxIS3tp3DlVBAGjIlE0002bkC4XgWXRg/uBUKFF/eNnaYUGRbMthkceJimLsOrj
         78PjGHJduzSpE9QiBuV89lOq6U4wyAbIpFclH1FhlCwQhfLddhxJUXRy3Yn7OQGV9Z
         RAYKemKi8NUEUYqur5MhLOvnRCbFGhc/uN3CaXP5znAlHTzLe/dfWCxVhL//JwyA7H
         u1Aigz8F9C5QHvm3/sfFZUCpBl6Z0ncbA9MO14wkhRjo4kzPApTwcXCcqux2EYJZIq
         vkg7ccF9UY6aVBFPYSdZ1bbEaLifTXxEPyFwg8n9uv+Ey82vk09fh/z0o5zZQNH9wc
         fDBr4D0SQmL6A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUoXE-0005y6-73; Mon, 27 Sep 2021 13:11:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David E Box <david.e.box@intel.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Perry Yuan <perry_yuan@dell.com>,
        Rajat Jain <rajatja@google.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/7] Fix some issues with ABI files
Date:   Mon, 27 Sep 2021 13:10:49 +0200
Message-Id: <cover.1632740376.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

All patches in this series are independent each other. This series is
based on today's next (next-20210927). 

As you know, I've been busy those days adding a new feature for
get_abi.pl to identify missing documentation. While doing that, 
I noticed several issues at the ABI files on "make htmldocs".
This series address them, and it is independent from the other
patches for get_abi.pl.

Patch 1 is actually a small improvement to get_abi.pl, addressing an
issue when there are multiple definitions for the same ABI symbol.
While this is not allowed, and produce warnings, there are still
3 occurrences:

	./scripts/get_abi.pl validate
	Warning: /sys/bus/iio/devices/iio:deviceX/fault_ovuv is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856:14  Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865:0
	Warning: /sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865:12  Documentation/ABI/testing/sysfs-bus-iio:1911
	Warning: /sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  Documentation/ABI/testing/sysfs-bus-iio:91

Once those got fixed, perhaps a future patch could make get_abi.pl to
generate an error causing the compilation to break, if WERROR is defined.

Anyway, it is better to to make the script more reliable anyway, specially 
since it is just one extra line of code.

Patches 2-7 fix random warnings introduced by new patches.

Regards,
Mauro

Mauro Carvalho Chehab (7):
  scripts: get_abi.pl: create a valid ReST with duplicated tags
  ABI: sysfs-platform-dell-privacy-wmi: correct ABI entries
  ABI: sysfs-platform-dptf: Add tables markup to a table
  ABI: configfs-usb-gadget-uac1: fix a broken table
  ABI: configfs-usb-gadget-uac2: fix a broken table
  ABI: sysfs-devices-removable: make a table valid as ReST markup
  ABI: sysfs-platform-intel-pmc: add blank lines to make it valid for
    ReST

 .../ABI/testing/configfs-usb-gadget-uac1      | 42 +++++++------
 .../ABI/testing/configfs-usb-gadget-uac2      | 43 +++++++------
 .../ABI/testing/sysfs-devices-removable       |  8 ++-
 .../testing/sysfs-platform-dell-privacy-wmi   | 60 ++++++++++++-------
 Documentation/ABI/testing/sysfs-platform-dptf |  4 ++
 .../ABI/testing/sysfs-platform-intel-pmc      |  2 +
 scripts/get_abi.pl                            |  1 +
 7 files changed, 99 insertions(+), 61 deletions(-)

-- 
2.31.1


