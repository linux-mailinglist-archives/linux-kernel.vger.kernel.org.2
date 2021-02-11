Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D752D319087
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhBKRBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:01:24 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:40054 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhBKPwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:52:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 66AE2FB07;
        Thu, 11 Feb 2021 16:51:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EccKblzD4Y8j; Thu, 11 Feb 2021 16:51:05 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 279B14188A; Thu, 11 Feb 2021 16:51:05 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v1 0/4] usb: typec: tps6598x: Add IRQ flag and register tracing
Date:   Thu, 11 Feb 2021 16:51:01 +0100
Message-Id: <cover.1613058605.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds tracing events for the chips IRQ and registers that are useful
to figure out the current data and power status. This came about since
diagnosing why a certain usb-c hub or dp-alt-mode adapter fails is hard with
the information in /sys/class/typec alone since this does not have a timeline
of events (and we don't want every typec user having to also buy a PD
analyzer). With this series debugging these kinds of things starts to become
fun:

   # echo 1 > /sys/kernel/debug/tracing/events/tps6598x/enable
   # cat /sys/kernel/debug/tracing/trace_pipe
   irq/79-0-003f-526     [003] ....   512.717871: tps6598x_irq: event1=PLUG_EVENT|DATA_STATUS_UPDATE|STATUS_UPDATE, event2=
   irq/79-0-003f-526     [003] ....   512.722408: tps6598x_status: conn: conn-Ra, pp_5v0: off, pp_hv: off, pp_ext: off, pp_cable: off, pwr-src: vin-3p3, vbus: vSafe0V, usb-host: no, legacy: no, flags: PLUG_PRESENT|PORTROLE|DATAROLE
   irq/79-0-003f-526     [003] ....   512.727127: tps6598x_data_status: DATA_CONNECTION|USB2_CONNECTION|USB3_CONNECTION
   irq/79-0-003f-526     [003] ....   512.769571: tps6598x_irq: event1=PP_SWITCH_CHANGED|STATUS_UPDATE, event2=
   irq/79-0-003f-526     [003] ....   512.773380: tps6598x_status: conn: conn-Ra, pp_5v0: out, pp_hv: off, pp_ext: off, pp_cable: in, pwr-src: vin-3p3, vbus: vSafe0V, usb-host: no, legacy: no, flags: PLUG_PRESENT|PORTROLE|DATAROLE|VCONN
   irq/79-0-003f-526     [003] ....   512.872450: tps6598x_irq: event1=POWER_STATUS_UPDATE|PD_STATUS_UPDATE, event2=
   irq/79-0-003f-526     [003] ....   512.876311: tps6598x_status: conn: conn-Ra, pp_5v0: out, pp_hv: off, pp_ext: off, pp_cable: in, pwr-src: vin-3p3, vbus: vSafe0V, usb-host: no, legacy: no, flags: PLUG_PRESENT|PORTROLE|DATAROLE|VCONN
   irq/79-0-003f-526     [003] ....   512.880237: tps6598x_power_status: conn: 1, pwr-role: source, typec: usb, bc: sdp
   irq/79-0-003f-526     [003] ....   513.072682: tps6598x_irq: event1=STATUS_UPDATE, event2=
   irq/79-0-003f-526     [003] ....   513.076390: tps6598x_status: conn: conn-Ra, pp_5v0: out, pp_hv: off, pp_ext: off, pp_cable: in, pwr-src: vin-3p3, vbus: vSafe5V, usb-host: no, legacy: no, flags: PLUG_PRESENT|PORTROLE|DATAROLE|VCONN
   irq/79-0-003f-526     [003] ....   513.090676: tps6598x_irq: event1=ERROR_CANNOT_PROVIDE_PWR, event2=
   irq/79-0-003f-526     [003] ....   513.094368: tps6598x_status: conn: conn-Ra, pp_5v0: out, pp_hv: off, pp_ext: off, pp_cable: in, pwr-src: vin-3p3, vbus: vSafe5V, usb-host: no, legacy: no, flags: PLUG_PRESENT|PORTROLE|DATAROLE|VCONN
   irq/79-0-003f-526     [003] ....   513.109606: tps6598x_irq: event1=NEW_CONTRACT_AS_PROVIDER|POWER_STATUS_UPDATE|STATUS_UPDATE|SRC_TRANSITION, event2=
   irq/79-0-003f-526     [003] ....   513.113777: tps6598x_status: conn: conn-Ra, pp_5v0: out, pp_hv: off, pp_ext: off, pp_cable: in, pwr-src: vin-3p3, vbus: pd, usb-host: no, legacy: no, flags: PLUG_PRESENT|PORTROLE|DATAROLE|VCONN
   irq/79-0-003f-526     [003] ....   513.117475: tps6598x_power_status: conn: 1, pwr-role: source, typec: pd, bc: sdp
   irq/79-0-003f-526     [003] ....   513.137469: tps6598x_irq: event1=VDM_RECEIVED, event2=
   irq/79-0-003f-526     [003] ....   513.141570: tps6598x_status: conn: conn-Ra, pp_5v0: out, pp_hv: off, pp_ext: off, pp_cable: in, pwr-src: vin-3p3, vbus: pd, usb-host: no, legacy: no, flags: PLUG_PRESENT|PORTROLE|DATAROLE|VCONN
   irq/79-0-003f-526     [003] ....   513.281926: tps6598x_irq: event1=VDM_RECEIVED, event2=
   irq/79-0-003f-526     [003] ....   513.285638: tps6598x_status: conn: conn-Ra, pp_5v0: out, pp_hv: off, pp_ext: off, pp_cable: in, pwr-src: vin-3p3, vbus: pd, usb-host: no, legacy: no, flags: PLUG_PRESENT|PORTROLE|DATAROLE|VCONN
   irq/79-0-003f-526     [003] ....   513.300515: tps6598x_irq: event1=VDM_RECEIVED|DATA_STATUS_UPDATE, event2=
   irq/79-0-003f-526     [003] ....   513.304226: tps6598x_status: conn: conn-Ra, pp_5v0: out, pp_hv: off, pp_ext: off, pp_cable: in, pwr-src: vin-3p3, vbus: pd, usb-host: no, legacy: no, flags: PLUG_PRESENT|PORTROLE|DATAROLE|VCONN
   irq/79-0-003f-526     [003] ....   513.308302: tps6598x_data_status: DATA_CONNECTION|USB2_CONNECTION|USB3_CONNECTION|DP_CONNECTION, DP pinout D

It should not impose any problems for firmwares that don't have IRQs for the
registers enabled. The trace will then just be missing those events.

Patch is against next-20210210.



Guido Günther (4):
  usb: typec: tps6598x: Add trace event for IRQ events
  usb: typec: tps6598x: Add trace event for status register
  usb: typec: tps6598x: Add trace event for power status register
  usb: typec: tps6598x: Add trace event for data status

 drivers/usb/typec/Makefile         |   3 +
 drivers/usb/typec/tps6598x.c       |  66 ++++---
 drivers/usb/typec/tps6598x.h       | 182 +++++++++++++++++++
 drivers/usb/typec/tps6598x_trace.h | 283 +++++++++++++++++++++++++++++
 4 files changed, 508 insertions(+), 26 deletions(-)
 create mode 100644 drivers/usb/typec/tps6598x.h
 create mode 100644 drivers/usb/typec/tps6598x_trace.h

-- 
2.30.0

