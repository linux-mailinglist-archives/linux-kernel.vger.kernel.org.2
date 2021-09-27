Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2C14195C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhI0OCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234712AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F5DD6113A;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=QIR/AZvKaUB5YUKjxRfW+Aj0W2BpAPheeO7XHo4T6d8=;
        h=From:To:Cc:Subject:Date:From;
        b=faBzzLhMoCv55p/1SGPbfuO2mqFBV1uKCBpZcOJkQ77e2bYcI/V+I0Du5QuiA6Yam
         sjj/K0e3D/bRS6Uie5RoaylzqP4FUtCtfaIFh21pHSw8Gqt7w6nfJxK4VJjBPtfMWd
         YqoJgkMeTtSoclP2CIO5w/A/ReGXGnABObb79y+lILdhCyYNDyF3V/abPst3VA5ZY6
         1CBtrN/XiDboAFW5HhSUY1YINX8mj4Mw1PR2uAIYt+Zmse6klPgwRgDWe81TnGW1RI
         R5uAPTevKG0aVcJeGITlfDb9rJVGU12O63FfTyYbX4fPLnUwU9UIulUADlpph0kxQC
         +Nm3Gcai5fBXQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000AtX-6i; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Bean Huo <beanhuo@micron.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Can Guo <cang@codeaurora.org>, Carlos Bilbao <bilbao@vt.edu>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Daejun Park <daejun7.park@samsung.com>,
        David Windsor <dave@nullcore.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leon@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: [PATCH 00/17] ABI: update files to reduce the documentation gap
Date:   Mon, 27 Sep 2021 15:59:33 +0200
Message-Id: <cover.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a recent work, "scripts/get_abi.pl" gained a command that
validates if the files under /sys are properly described inside
Documentation/ABI.

It does that by comparing the What: fields inside Documentation/ABI
with the entries under /sysfs.

This series addresses some of the most commonly missed nodes
(in terms of the number of reported occurencies).

This series is based on next-20210927. Most patches are
independent from the other patches on this series.

-

After this series, the number of warnings reduced a lot on my
desktop (a NUC8i7HNK):

  $  time ./scripts/get_abi.pl undefined |sort >undef && cat undef|perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|sort|uniq -c|sort -nr >undefined_symbols &&  wc -l undef undefined_symbols
  real	0m6,583s
  user	0m5,841s
  sys	0m0,718s
    6663 undef
     774 undefined_symbols
    7437 total

Please notice that this script  runs millions of regular expressions
in order to do such match. So, while here is is running on 6 seconds,
it could take a lot more time on a bigger machine.
  

Mauro Carvalho Chehab (17):
  ABI: stable/sysfs-module: better document modules
  ABI: stable/sysfs-module: document version and srcversion
  ABI: testing/sysfs-module: document initstate
  ABI: sysfs-devices-power: document some RPM statistics
  ABI: sysfs-devices: add /dev ABI
  ABI: sysfs-bus-pci: add documentation for modalias
  ABI: o2cb: add an obsolete file for /sys/o2cb
  ABI: sysfs-kernel-slab: Document some stats
  ABI: sysfs-devices-power: add some debug sysfs files
  ABI: sysfs-bus-pci: add a alternative What fields
  ABI: sysfs-class-bdi: use What: to describe each property
  ABI: sysfs-bus-mdio: add alternate What for mdio symbols
  ABI: sysfs-bus-usb: use a wildcard for interface name on What
  ABI: sysfs-bus-usb: add missing sysfs fields
  ABI: obsolete/sysfs-bus-iio: add some missing blank lines
  ABI: sysfs-driver-ufs: Add another What for platform drivers
  ABI: sysfs-bus-platform: add modalias description

 Documentation/ABI/obsolete/o2cb               |  11 +
 Documentation/ABI/obsolete/sysfs-bus-iio      |   4 +
 Documentation/ABI/stable/o2cb                 |   2 +-
 Documentation/ABI/stable/sysfs-devices        |   7 +
 Documentation/ABI/stable/sysfs-module         |  25 +-
 Documentation/ABI/testing/sysfs-bus-mdio      |   9 +
 Documentation/ABI/testing/sysfs-bus-pci       |  22 ++
 Documentation/ABI/testing/sysfs-bus-platform  |  12 +
 Documentation/ABI/testing/sysfs-bus-usb       | 276 +++++++++++++++++-
 Documentation/ABI/testing/sysfs-class-bdi     |  30 +-
 Documentation/ABI/testing/sysfs-devices-power |  36 +++
 Documentation/ABI/testing/sysfs-driver-ufs    | 126 ++++++++
 Documentation/ABI/testing/sysfs-kernel-slab   |  21 ++
 Documentation/ABI/testing/sysfs-module        |   7 +
 14 files changed, 571 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/o2cb

-- 
2.31.1


