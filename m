Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70124362016
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbhDPMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:47:12 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42204 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240732AbhDPMrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:47:11 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 86731C06B9;
        Fri, 16 Apr 2021 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577207; bh=kWSqxBFfNzPqZXKFtbkyGNxYXWGWs6bIBI9fB3s0wjA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=l132or2Beis8jwFKsCEKPrMEhJQDunM36t1/hY57ypyRnfC3hx99V63b6SCrbq4v1
         iRjy8FnBwhwb71A0q1jNJZuFSS6xlGmbhUm1LHxUkDkzEKaj3bnVItWs2YohKAQ+n2
         x0ukwh0fdS8WuE1gsqw1ZWokfTF2n4ya77YvHP+nOi5dN1gDTlhd6BC/1EyptJwoAm
         bfGRJCbj6FLeK/d0552SWz/Fk/8HfKev1lJAU7MSju+Ucwhij5hFNJadzT1IYkOqgM
         jRhAYsU9Rlz+B3RBNbrQqqOprlLIHQz6qu3WOPlV3fyYoRk8FaGtkt4Fwgml9guyl2
         MiqTcOhNKm0MQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 72FD8A005D;
        Fri, 16 Apr 2021 12:46:42 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:46:40 +0400
Date:   Fri, 16 Apr 2021 16:46:40 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 00/15] usb: dwc2: Fix Hibernation issues.
To:     John Youn <John.Youn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Vardan Mikayelyan <Vardan.Mikayelyan@synopsys.com>,
        Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>
Message-Id: <20210416124642.72FD8A005D@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes and improves hibernation mode for dwc2 core.
It adds support for the following cases
    1. Hibernation entering/exiting flow by system suspend/resume.
    2. Exiting hibernation mode before removing driver and urb enqueue.
    3. Exiting hibernation from gpwrdn rst detect.

It updates the implementation of dwc2 entering and exiting
hibernation mode when a port is suspended or resumed or reset asserted.

It fixes hibernation issues between host and device mode when core
enters to hibernation in host mode and mode change happens. Also, a fix
is introduced for remote wakeup flow.

The patch set also improves implementation of entering to hibernation
from dwc2_handle_usb_suspend_intr() handler.

Changes since V1:
Updated bellow patches. Moved duplicated error checking *if* conditions
from innermost to outside if.
1. usb: dwc2: Add exit hibernation mode before removing drive
2. usb: dwc2: Allow exit hibernation in urb enqueue

Fixed an uninitialized pointer variable which was reported by
kernel test robot in "usb: dwc2: Add exit hibernation mode before
removing drive" patch. After fixing added Reported-by tags for
kernel test robot and Dan Carpenter.

Also removed some text from cover letter because I think that is
why vger.kernel.org was rejecting it.


Artur Petrosyan (15):
  usb: dwc2: Update exit hibernation when port reset is asserted
  usb: dwc2: Reset DEVADDR after exiting gadget hibernation.
  usb: dwc2: Fix host mode hibernation exit with remote wakeup flow.
  usb: dwc2: Fix hibernation between host and device modes.
  usb: dwc2: Allow exiting hibernation from gpwrdn rst detect
  usb: dwc2: Clear fifo_map when resetting core.
  usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is generated.
  usb: dwc2: Move enter hibernation to dwc2_port_suspend() function
  usb: dwc2: Move exit hibernation to dwc2_port_resume() function
  usb: dwc2: Allow exit hibernation in urb enqueue
  usb: dwc2: Add hibernation entering flow by system suspend
  usb: dwc2: Add hibernation exiting flow by system resume
  usb: dwc2: Add exit hibernation mode before removing drive
  usb: dwc2: Update dwc2_handle_usb_suspend_intr function.
  usb: dwc2: Get rid of useless error checks in suspend interrupt

 drivers/usb/dwc2/core.c      |  25 ++++-
 drivers/usb/dwc2/core.h      |   3 +
 drivers/usb/dwc2/core_intr.c | 205 +++++++++++++++++++----------------
 drivers/usb/dwc2/gadget.c    |   4 +
 drivers/usb/dwc2/hcd.c       |  92 +++++++++++++---
 drivers/usb/dwc2/platform.c  |  15 +++
 6 files changed, 233 insertions(+), 111 deletions(-)


base-commit: 4b853c236c7b5161a2e444bd8b3c76fe5aa5ddcb
-- 
2.25.1

