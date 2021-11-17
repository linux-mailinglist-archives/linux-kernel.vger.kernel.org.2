Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771E145461C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhKQMJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:09:23 -0500
Received: from smtp93.ord1c.emailsrvr.com ([108.166.43.93]:39331 "EHLO
        smtp93.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237123AbhKQMJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1637150784;
        bh=vkkLyzKH7g52Hs7isRtjj3PYvph2IfEueQfVGbtIW1U=;
        h=From:To:Subject:Date:From;
        b=ja35mwa5sNOwmsMYsnhZJvE4sL+jCocl5Ttc/Z90oZnwk2RSHwJ1ycJ+vT+C3pDMB
         FwMimtFtQMsGAIFub69r/90jc78WvLNDjQYh4WPweCTS0riEG7V2IH8qYYzulopKgj
         5KAVJlzUx8nlC38nQZAAFRlBiN+sRAh+RGcOEv+U=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 7EF42E00F0;
        Wed, 17 Nov 2021 07:06:23 -0500 (EST)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 0/5] comedi: Move COMEDI headers
Date:   Wed, 17 Nov 2021 12:05:58 +0000
Message-Id: <20211117120604.117740-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b7289a69-3998-4ed4-bad0-ca7f3c79a866-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves the "comedi.h" file to "include/uapi/linux/" to make
it available to user-space code, and moves various common COMEDI driver
header files to "include/linux/comedi/" to make them available to
out-of-tree drivers or to drivers located outside of "drivers/comedi/".

1) comedi: Move the main COMEDI headers
2) comedi: ni_routing: tools: Update due to moved COMEDI headers
3) comedi: Move and rename "8255.h" to <linux/comedi/comedi_8255.h>
4) comedi: Move "comedi_8254.h" to <linux/comedi/comedi_8254.h>
5) comedi: Move "comedi_isadma.h" to <linux/comedi/comedi_isadma.h>

 MAINTAINERS                                        |  2 ++
 drivers/comedi/comedi_buf.c                        |  3 +--
 drivers/comedi/comedi_fops.c                       |  2 +-
 drivers/comedi/comedi_pci.c                        |  3 +--
 drivers/comedi/comedi_pcmcia.c                     |  3 +--
 drivers/comedi/comedi_usb.c                        |  3 +--
 drivers/comedi/drivers.c                           |  3 +--
 drivers/comedi/drivers/8255.c                      |  5 ++--
 drivers/comedi/drivers/8255_pci.c                  |  6 ++---
 drivers/comedi/drivers/addi_apci_1032.c            |  2 +-
 drivers/comedi/drivers/addi_apci_1500.c            |  2 +-
 drivers/comedi/drivers/addi_apci_1516.c            |  2 +-
 drivers/comedi/drivers/addi_apci_1564.c            |  2 +-
 drivers/comedi/drivers/addi_apci_16xx.c            |  3 +--
 drivers/comedi/drivers/addi_apci_2032.c            |  2 +-
 drivers/comedi/drivers/addi_apci_2200.c            |  2 +-
 drivers/comedi/drivers/addi_apci_3120.c            |  2 +-
 drivers/comedi/drivers/addi_apci_3501.c            |  2 +-
 drivers/comedi/drivers/addi_apci_3xxx.c            |  3 +--
 drivers/comedi/drivers/addi_watchdog.c             |  2 +-
 drivers/comedi/drivers/adl_pci6208.c               |  3 +--
 drivers/comedi/drivers/adl_pci7x3x.c               |  3 +--
 drivers/comedi/drivers/adl_pci8164.c               |  3 +--
 drivers/comedi/drivers/adl_pci9111.c               |  5 ++--
 drivers/comedi/drivers/adl_pci9118.c               |  5 ++--
 drivers/comedi/drivers/adq12b.c                    |  3 +--
 drivers/comedi/drivers/adv_pci1710.c               |  5 ++--
 drivers/comedi/drivers/adv_pci1720.c               |  3 +--
 drivers/comedi/drivers/adv_pci1723.c               |  3 +--
 drivers/comedi/drivers/adv_pci1724.c               |  3 +--
 drivers/comedi/drivers/adv_pci1760.c               |  3 +--
 drivers/comedi/drivers/adv_pci_dio.c               |  8 +++---
 drivers/comedi/drivers/aio_aio12_8.c               |  7 +++---
 drivers/comedi/drivers/aio_iiro_16.c               |  3 +--
 drivers/comedi/drivers/amplc_dio200.c              |  2 +-
 drivers/comedi/drivers/amplc_dio200_common.c       |  7 +++---
 drivers/comedi/drivers/amplc_dio200_pci.c          |  3 +--
 drivers/comedi/drivers/amplc_pc236.c               |  3 +--
 drivers/comedi/drivers/amplc_pc236_common.c        |  5 ++--
 drivers/comedi/drivers/amplc_pc263.c               |  2 +-
 drivers/comedi/drivers/amplc_pci224.c              |  6 ++---
 drivers/comedi/drivers/amplc_pci230.c              |  8 +++---
 drivers/comedi/drivers/amplc_pci236.c              |  3 +--
 drivers/comedi/drivers/amplc_pci263.c              |  3 +--
 drivers/comedi/drivers/c6xdigio.c                  |  3 +--
 drivers/comedi/drivers/cb_das16_cs.c               |  6 ++---
 drivers/comedi/drivers/cb_pcidas.c                 |  7 +++---
 drivers/comedi/drivers/cb_pcidas64.c               |  5 ++--
 drivers/comedi/drivers/cb_pcidda.c                 |  6 ++---
 drivers/comedi/drivers/cb_pcimdas.c                |  7 +++---
 drivers/comedi/drivers/cb_pcimdda.c                |  6 ++---
 drivers/comedi/drivers/comedi_8254.c               |  6 ++---
 drivers/comedi/drivers/comedi_8255.c               |  5 ++--
 drivers/comedi/drivers/comedi_bond.c               |  6 ++---
 drivers/comedi/drivers/comedi_isadma.c             |  6 ++---
 drivers/comedi/drivers/comedi_parport.c            |  3 +--
 drivers/comedi/drivers/comedi_test.c               |  4 +--
 drivers/comedi/drivers/contec_pci_dio.c            |  3 +--
 drivers/comedi/drivers/dac02.c                     |  3 +--
 drivers/comedi/drivers/daqboard2000.c              |  5 ++--
 drivers/comedi/drivers/das08.c                     |  7 +++---
 drivers/comedi/drivers/das08_cs.c                  |  3 +--
 drivers/comedi/drivers/das08_isa.c                 |  2 +-
 drivers/comedi/drivers/das08_pci.c                 |  3 +--
 drivers/comedi/drivers/das16.c                     | 10 +++-----
 drivers/comedi/drivers/das16m1.c                   |  7 +++---
 drivers/comedi/drivers/das1800.c                   |  8 +++---
 drivers/comedi/drivers/das6402.c                   |  6 ++---
 drivers/comedi/drivers/das800.c                    |  6 ++---
 drivers/comedi/drivers/dmm32at.c                   |  5 ++--
 drivers/comedi/drivers/dt2801.c                    |  2 +-
 drivers/comedi/drivers/dt2811.c                    |  3 +--
 drivers/comedi/drivers/dt2814.c                    |  3 +--
 drivers/comedi/drivers/dt2815.c                    |  3 +--
 drivers/comedi/drivers/dt2817.c                    |  2 +-
 drivers/comedi/drivers/dt282x.c                    |  6 ++---
 drivers/comedi/drivers/dt3000.c                    |  3 +--
 drivers/comedi/drivers/dt9812.c                    |  3 +--
 drivers/comedi/drivers/dyna_pci10xx.c              |  3 +--
 drivers/comedi/drivers/fl512.c                     |  3 +--
 drivers/comedi/drivers/gsc_hpdi.c                  |  3 +--
 drivers/comedi/drivers/icp_multi.c                 |  3 +--
 drivers/comedi/drivers/ii_pci20kc.c                |  2 +-
 drivers/comedi/drivers/jr3_pci.c                   |  3 +--
 drivers/comedi/drivers/ke_counter.c                |  3 +--
 drivers/comedi/drivers/me4000.c                    |  5 ++--
 drivers/comedi/drivers/me_daq.c                    |  3 +--
 drivers/comedi/drivers/mf6x4.c                     |  3 +--
 drivers/comedi/drivers/mite.c                      |  3 +--
 drivers/comedi/drivers/mpc624.c                    |  3 +--
 drivers/comedi/drivers/multiq3.c                   |  3 +--
 drivers/comedi/drivers/ni_6527.c                   |  3 +--
 drivers/comedi/drivers/ni_65xx.c                   |  3 +--
 drivers/comedi/drivers/ni_660x.c                   |  3 +--
 drivers/comedi/drivers/ni_670x.c                   |  3 +--
 drivers/comedi/drivers/ni_at_a2150.c               |  8 +++---
 drivers/comedi/drivers/ni_at_ao.c                  |  6 ++---
 drivers/comedi/drivers/ni_atmio.c                  |  5 ++--
 drivers/comedi/drivers/ni_atmio16d.c               |  5 ++--
 drivers/comedi/drivers/ni_daq_700.c                |  3 +--
 drivers/comedi/drivers/ni_daq_dio24.c              |  5 ++--
 drivers/comedi/drivers/ni_labpc.c                  |  3 +--
 drivers/comedi/drivers/ni_labpc_common.c           |  7 +++---
 drivers/comedi/drivers/ni_labpc_cs.c               |  3 +--
 drivers/comedi/drivers/ni_labpc_isadma.c           |  5 ++--
 drivers/comedi/drivers/ni_labpc_pci.c              |  3 +--
 drivers/comedi/drivers/ni_mio_common.c             |  2 +-
 drivers/comedi/drivers/ni_mio_cs.c                 |  4 +--
 drivers/comedi/drivers/ni_pcidio.c                 |  3 +--
 drivers/comedi/drivers/ni_pcimio.c                 |  4 +--
 drivers/comedi/drivers/ni_routes.c                 |  3 +--
 drivers/comedi/drivers/ni_routes.h                 |  2 +-
 .../comedi/drivers/ni_routing/ni_route_values.h    |  2 +-
 drivers/comedi/drivers/ni_routing/tools/.gitignore |  1 +
 drivers/comedi/drivers/ni_routing/tools/Makefile   | 29 ++++++++++++++--------
 drivers/comedi/drivers/ni_tio.h                    |  2 +-
 drivers/comedi/drivers/ni_usb6501.c                |  3 +--
 drivers/comedi/drivers/pcl711.c                    |  6 ++---
 drivers/comedi/drivers/pcl724.c                    |  5 ++--
 drivers/comedi/drivers/pcl726.c                    |  3 +--
 drivers/comedi/drivers/pcl730.c                    |  2 +-
 drivers/comedi/drivers/pcl812.c                    |  8 +++---
 drivers/comedi/drivers/pcl816.c                    |  8 +++---
 drivers/comedi/drivers/pcl818.c                    |  8 +++---
 drivers/comedi/drivers/pcm3724.c                   |  5 ++--
 drivers/comedi/drivers/pcmad.c                     |  2 +-
 drivers/comedi/drivers/pcmda12.c                   |  2 +-
 drivers/comedi/drivers/pcmmio.c                    |  3 +--
 drivers/comedi/drivers/pcmuio.c                    |  3 +--
 drivers/comedi/drivers/quatech_daqp_cs.c           |  3 +--
 drivers/comedi/drivers/rtd520.c                    |  5 ++--
 drivers/comedi/drivers/rti800.c                    |  2 +-
 drivers/comedi/drivers/rti802.c                    |  2 +-
 drivers/comedi/drivers/s526.c                      |  2 +-
 drivers/comedi/drivers/s626.c                      |  3 +--
 drivers/comedi/drivers/ssv_dnp.c                   |  2 +-
 drivers/comedi/drivers/usbdux.c                    |  3 +--
 drivers/comedi/drivers/usbduxfast.c                |  2 +-
 drivers/comedi/drivers/usbduxsigma.c               |  3 +--
 drivers/comedi/drivers/vmk80xx.c                   |  3 +--
 drivers/comedi/kcomedilib/kcomedilib_main.c        |  6 ++---
 drivers/comedi/proc.c                              |  2 +-
 drivers/comedi/range.c                             |  2 +-
 .../drivers => include/linux/comedi}/comedi_8254.h |  0
 .../8255.h => include/linux/comedi/comedi_8255.h   |  8 +++---
 .../linux/comedi}/comedi_isadma.h                  |  0
 {drivers => include/linux}/comedi/comedi_pci.h     |  3 +--
 {drivers => include/linux}/comedi/comedi_pcmcia.h  |  3 +--
 {drivers => include/linux}/comedi/comedi_usb.h     |  3 +--
 {drivers => include/linux}/comedi/comedidev.h      |  3 +--
 {drivers => include/linux}/comedi/comedilib.h      |  0
 {drivers/comedi => include/uapi/linux}/comedi.h    |  2 +-
 152 files changed, 235 insertions(+), 358 deletions(-)

