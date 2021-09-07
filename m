Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297D1403186
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 01:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhIGXaF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Sep 2021 19:30:05 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:62950 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhIGXaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:30:02 -0400
X-Greylist: delayed 1024 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Sep 2021 19:30:02 EDT
Received: from [88.78.105.74] (helo=sju.home.jstuber.net)
        by smtprelay04.ispgateway.de with esmtpa (Exim 4.94.2)
        (envelope-from <juergen@jstuber.net>)
        id 1mNfiD-000511-CP; Tue, 07 Sep 2021 20:20:49 +0200
Date:   Tue, 7 Sep 2021 20:23:10 +0200
From:   Juergen Stuber <juergen@jstuber.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ricky Wu <ricky_wu@realtek.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Thunderbolt 3 Dock, USB issues when undocking then docking
Message-ID: <20210907202310.77dea423@sju.home.jstuber.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: OTE4MDk1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

In Linux versions 5.10-rc1 or newer (exact bisect see below) I have
issues when I undock and then dock my Thunderbolt 3 dock.
Afterwards I see

- log messages like "retire_capture_urb: 571 callbacks suppressed"
  (always)
- audio glitches when playing audio via the dock on USB speakers
  (almost always)
- keyboard events are lost on a dock-connected keyboard (sometimes)

I tested this by undocking, waiting a short while, then redocking, and
after that playing audio via USB speakers connected to the dock.
It seems to be deterministic, that is, in affected kernels it seems to
happen on every undock-dock cycle.

This is a Thinkpad T14 Gen1 Intel (20S0000HGE) and
a Thinkpad Thunderbolt 3 Dock Gen2 (40AN / SD20M70247), 
the USB speakers are Logitech Z-10,
the distribution is Debian bullseye.

I bisected the issue, this pointed to the first bad commit

726eb70e0d34 Merge tag 'char-misc-5.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc

Since that was a big merge and thus not too helpful, I bisected the two
branches that were merged. That is, I bisected one branch and merged
into the head of the other branch and tested the merge.
On char-misc this pointed to

7c33e3c4c79a misc: rtsx: Add power saving functions and fix driving
parameter

The affected driver is in use for a device in my system:
02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTS522A PCI Express Card Reader [10ec:522a] (rev 01)

Log output:
[    1.179205] rtsx_pci 0000:02:00.0: enabling device (0000 -> 0002)

On the mainline side the bisect points to

edc649a82341 xhci: Tune interrupt blocking for isochronous transfers


I tried to revert each of these, but that was not easily possible.


RedHat has a bug report about this issue:
https://bugzilla.redhat.com/show_bug.cgi?id=1951372

Please ask if you need more info or testing.


Jürgen

-- 
Jürgen Stuber <juergen@jstuber.net>
http://www.jstuber.net/

