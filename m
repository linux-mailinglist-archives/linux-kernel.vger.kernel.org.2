Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BA744D413
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhKKJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:33:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231667AbhKKJcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:32:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60D1D610F8;
        Thu, 11 Nov 2021 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636623006;
        bh=kpaVjDNigz+jOaRJxULm4cIpN1ldWoxRAOS0tMCpLf0=;
        h=Date:From:To:Cc:Subject:From;
        b=dIxVSxgrx1UKb7Z3TVdzN6EMINYjEdul2DB66Vjq29l3xAVtRZROABnnjwHDUBf2r
         ehRJGAUzBCpZQOASGNvaDQjsZ2IGtQ5e/xWKQWsYEJ2f4+222XaPFbuFHwyESebvLr
         iCrPblg63YVl5aE+r3zvie7iqOGfsbaGetYko0xQ=
Date:   Thu, 11 Nov 2021 10:30:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.16-rc1
Message-ID: <YYzinMsJuzruCN+4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 048ff8629e117d8411a787559417c781bcd78d7e:

  Merge tag 'usb-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2021-11-04 07:50:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc1

for you to fetch changes up to e1959faf085b004e6c3afaaaa743381f00e7c015:

  xhci: Fix USB 3.1 enumeration issues by increasing roothub power-on-good delay (2021-11-06 15:41:03 +0100)

----------------------------------------------------------------
USB fixes for 5.16-rc1

Here are some small reverts and fixes for USB drivers for issues that
came up during the 5.16-rc1 merge window.

These include:
	- two reverts of xhci and USB core patches that are causing
	  problems in many systems.
	- xhci 3.1 enumeration delay fix for systems that were having
	  problems.

All 3 of these have been in linux-next all week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (2):
      Revert "xhci: Set HCD flag to defer primary roothub registration"
      Revert "usb: core: hcd: Add support for deferring roothub registration"

Mathias Nyman (1):
      xhci: Fix USB 3.1 enumeration issues by increasing roothub power-on-good delay

 drivers/usb/core/hcd.c      | 29 ++++++-----------------------
 drivers/usb/host/xhci-hub.c |  3 ++-
 drivers/usb/host/xhci.c     |  1 -
 include/linux/usb/hcd.h     |  2 --
 4 files changed, 8 insertions(+), 27 deletions(-)
