Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4815335F03D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350390AbhDNJBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhDNI6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:58:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 991B661158;
        Wed, 14 Apr 2021 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618390693;
        bh=cAFF5p1D/LLYc1PAkqM+XFkOq+KSBfrqraWXhRkJhEs=;
        h=Date:From:To:Cc:Subject:From;
        b=I18G5HU4Xr9Bp08LrhORS6dwrRhpyhg50BDBNHuWiYOObm0wgW8/IYxf+17ChBdOY
         r48ODzC393YrzQSz4MtJyU/M01YSGo7sNX6E6i193EAqdTmqOLjIJA+N4o5UUfDDO6
         gTg+QzVQGovl+caHeuM08Ilp0vmExqcTwk36nWRo=
Date:   Wed, 14 Apr 2021 10:58:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-staging@lists.linux.dev, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: move out of staging directory
Message-ID: <YHauop4u3sP6lz8j@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comedi code came into the kernel back in 2008, but traces its
lifetime to much much earlier.  It's been polished and buffed and
there's really nothing preventing it from being part of the "real"
portion of the kernel.

So move it to drivers/comedi/ as it belongs there.

Many thanks to the hundreds of developers who did the work to make this
happen.

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS                                          | 12 ++++++------
 drivers/Kconfig                                      |  2 ++
 drivers/Makefile                                     |  1 +
 drivers/{staging => }/comedi/Kconfig                 |  0
 drivers/{staging => }/comedi/Makefile                |  0
 drivers/{staging => }/comedi/TODO                    |  0
 drivers/{staging => }/comedi/comedi.h                |  0
 drivers/{staging => }/comedi/comedi_buf.c            |  0
 drivers/{staging => }/comedi/comedi_fops.c           |  0
 drivers/{staging => }/comedi/comedi_internal.h       |  0
 drivers/{staging => }/comedi/comedi_pci.c            |  0
 drivers/{staging => }/comedi/comedi_pci.h            |  0
 drivers/{staging => }/comedi/comedi_pcmcia.c         |  0
 drivers/{staging => }/comedi/comedi_pcmcia.h         |  0
 drivers/{staging => }/comedi/comedi_usb.c            |  0
 drivers/{staging => }/comedi/comedi_usb.h            |  0
 drivers/{staging => }/comedi/comedidev.h             |  0
 drivers/{staging => }/comedi/comedilib.h             |  0
 drivers/{staging => }/comedi/drivers.c               |  0
 drivers/{staging => }/comedi/drivers/8255.c          |  0
 drivers/{staging => }/comedi/drivers/8255.h          |  0
 drivers/{staging => }/comedi/drivers/8255_pci.c      |  0
 drivers/{staging => }/comedi/drivers/Makefile        |  0
 .../{staging => }/comedi/drivers/addi_apci_1032.c    |  0
 .../{staging => }/comedi/drivers/addi_apci_1500.c    |  0
 .../{staging => }/comedi/drivers/addi_apci_1516.c    |  0
 .../{staging => }/comedi/drivers/addi_apci_1564.c    |  0
 .../{staging => }/comedi/drivers/addi_apci_16xx.c    |  0
 .../{staging => }/comedi/drivers/addi_apci_2032.c    |  0
 .../{staging => }/comedi/drivers/addi_apci_2200.c    |  0
 .../{staging => }/comedi/drivers/addi_apci_3120.c    |  0
 .../{staging => }/comedi/drivers/addi_apci_3501.c    |  0
 .../{staging => }/comedi/drivers/addi_apci_3xxx.c    |  0
 drivers/{staging => }/comedi/drivers/addi_tcw.h      |  0
 drivers/{staging => }/comedi/drivers/addi_watchdog.c |  0
 drivers/{staging => }/comedi/drivers/addi_watchdog.h |  0
 drivers/{staging => }/comedi/drivers/adl_pci6208.c   |  0
 drivers/{staging => }/comedi/drivers/adl_pci7x3x.c   |  0
 drivers/{staging => }/comedi/drivers/adl_pci8164.c   |  0
 drivers/{staging => }/comedi/drivers/adl_pci9111.c   |  0
 drivers/{staging => }/comedi/drivers/adl_pci9118.c   |  0
 drivers/{staging => }/comedi/drivers/adq12b.c        |  0
 drivers/{staging => }/comedi/drivers/adv_pci1710.c   |  0
 drivers/{staging => }/comedi/drivers/adv_pci1720.c   |  0
 drivers/{staging => }/comedi/drivers/adv_pci1723.c   |  0
 drivers/{staging => }/comedi/drivers/adv_pci1724.c   |  0
 drivers/{staging => }/comedi/drivers/adv_pci1760.c   |  0
 drivers/{staging => }/comedi/drivers/adv_pci_dio.c   |  0
 drivers/{staging => }/comedi/drivers/aio_aio12_8.c   |  0
 drivers/{staging => }/comedi/drivers/aio_iiro_16.c   |  0
 drivers/{staging => }/comedi/drivers/amcc_s5933.h    |  0
 drivers/{staging => }/comedi/drivers/amplc_dio200.c  |  0
 drivers/{staging => }/comedi/drivers/amplc_dio200.h  |  0
 .../comedi/drivers/amplc_dio200_common.c             |  0
 .../{staging => }/comedi/drivers/amplc_dio200_pci.c  |  0
 drivers/{staging => }/comedi/drivers/amplc_pc236.c   |  0
 drivers/{staging => }/comedi/drivers/amplc_pc236.h   |  0
 .../comedi/drivers/amplc_pc236_common.c              |  0
 drivers/{staging => }/comedi/drivers/amplc_pc263.c   |  0
 drivers/{staging => }/comedi/drivers/amplc_pci224.c  |  0
 drivers/{staging => }/comedi/drivers/amplc_pci230.c  |  0
 drivers/{staging => }/comedi/drivers/amplc_pci236.c  |  0
 drivers/{staging => }/comedi/drivers/amplc_pci263.c  |  0
 drivers/{staging => }/comedi/drivers/c6xdigio.c      |  0
 drivers/{staging => }/comedi/drivers/cb_das16_cs.c   |  0
 drivers/{staging => }/comedi/drivers/cb_pcidas.c     |  0
 drivers/{staging => }/comedi/drivers/cb_pcidas64.c   |  0
 drivers/{staging => }/comedi/drivers/cb_pcidda.c     |  0
 drivers/{staging => }/comedi/drivers/cb_pcimdas.c    |  0
 drivers/{staging => }/comedi/drivers/cb_pcimdda.c    |  0
 drivers/{staging => }/comedi/drivers/comedi_8254.c   |  0
 drivers/{staging => }/comedi/drivers/comedi_8254.h   |  0
 drivers/{staging => }/comedi/drivers/comedi_8255.c   |  0
 drivers/{staging => }/comedi/drivers/comedi_bond.c   |  0
 drivers/{staging => }/comedi/drivers/comedi_isadma.c |  0
 drivers/{staging => }/comedi/drivers/comedi_isadma.h |  0
 .../{staging => }/comedi/drivers/comedi_parport.c    |  0
 drivers/{staging => }/comedi/drivers/comedi_test.c   |  0
 .../{staging => }/comedi/drivers/contec_pci_dio.c    |  0
 drivers/{staging => }/comedi/drivers/dac02.c         |  0
 drivers/{staging => }/comedi/drivers/daqboard2000.c  |  0
 drivers/{staging => }/comedi/drivers/das08.c         |  0
 drivers/{staging => }/comedi/drivers/das08.h         |  0
 drivers/{staging => }/comedi/drivers/das08_cs.c      |  0
 drivers/{staging => }/comedi/drivers/das08_isa.c     |  0
 drivers/{staging => }/comedi/drivers/das08_pci.c     |  0
 drivers/{staging => }/comedi/drivers/das16.c         |  0
 drivers/{staging => }/comedi/drivers/das16m1.c       |  0
 drivers/{staging => }/comedi/drivers/das1800.c       |  0
 drivers/{staging => }/comedi/drivers/das6402.c       |  0
 drivers/{staging => }/comedi/drivers/das800.c        |  0
 drivers/{staging => }/comedi/drivers/dmm32at.c       |  0
 drivers/{staging => }/comedi/drivers/dt2801.c        |  0
 drivers/{staging => }/comedi/drivers/dt2811.c        |  0
 drivers/{staging => }/comedi/drivers/dt2814.c        |  0
 drivers/{staging => }/comedi/drivers/dt2815.c        |  0
 drivers/{staging => }/comedi/drivers/dt2817.c        |  0
 drivers/{staging => }/comedi/drivers/dt282x.c        |  0
 drivers/{staging => }/comedi/drivers/dt3000.c        |  0
 drivers/{staging => }/comedi/drivers/dt9812.c        |  0
 drivers/{staging => }/comedi/drivers/dyna_pci10xx.c  |  0
 drivers/{staging => }/comedi/drivers/fl512.c         |  0
 drivers/{staging => }/comedi/drivers/gsc_hpdi.c      |  0
 drivers/{staging => }/comedi/drivers/icp_multi.c     |  0
 drivers/{staging => }/comedi/drivers/ii_pci20kc.c    |  0
 drivers/{staging => }/comedi/drivers/jr3_pci.c       |  0
 drivers/{staging => }/comedi/drivers/jr3_pci.h       |  0
 drivers/{staging => }/comedi/drivers/ke_counter.c    |  0
 drivers/{staging => }/comedi/drivers/me4000.c        |  0
 drivers/{staging => }/comedi/drivers/me_daq.c        |  0
 drivers/{staging => }/comedi/drivers/mf6x4.c         |  0
 drivers/{staging => }/comedi/drivers/mite.c          |  0
 drivers/{staging => }/comedi/drivers/mite.h          |  0
 drivers/{staging => }/comedi/drivers/mpc624.c        |  0
 drivers/{staging => }/comedi/drivers/multiq3.c       |  0
 drivers/{staging => }/comedi/drivers/ni_6527.c       |  0
 drivers/{staging => }/comedi/drivers/ni_65xx.c       |  0
 drivers/{staging => }/comedi/drivers/ni_660x.c       |  0
 drivers/{staging => }/comedi/drivers/ni_670x.c       |  0
 drivers/{staging => }/comedi/drivers/ni_at_a2150.c   |  0
 drivers/{staging => }/comedi/drivers/ni_at_ao.c      |  0
 drivers/{staging => }/comedi/drivers/ni_atmio.c      |  0
 drivers/{staging => }/comedi/drivers/ni_atmio16d.c   |  0
 drivers/{staging => }/comedi/drivers/ni_daq_700.c    |  0
 drivers/{staging => }/comedi/drivers/ni_daq_dio24.c  |  0
 drivers/{staging => }/comedi/drivers/ni_labpc.c      |  0
 drivers/{staging => }/comedi/drivers/ni_labpc.h      |  0
 .../{staging => }/comedi/drivers/ni_labpc_common.c   |  0
 drivers/{staging => }/comedi/drivers/ni_labpc_cs.c   |  0
 .../{staging => }/comedi/drivers/ni_labpc_isadma.c   |  0
 .../{staging => }/comedi/drivers/ni_labpc_isadma.h   |  0
 drivers/{staging => }/comedi/drivers/ni_labpc_pci.c  |  0
 drivers/{staging => }/comedi/drivers/ni_labpc_regs.h |  0
 drivers/{staging => }/comedi/drivers/ni_mio_common.c |  0
 drivers/{staging => }/comedi/drivers/ni_mio_cs.c     |  0
 drivers/{staging => }/comedi/drivers/ni_pcidio.c     |  0
 drivers/{staging => }/comedi/drivers/ni_pcimio.c     |  0
 drivers/{staging => }/comedi/drivers/ni_routes.c     |  0
 drivers/{staging => }/comedi/drivers/ni_routes.h     |  0
 .../{staging => }/comedi/drivers/ni_routing/README   |  0
 .../comedi/drivers/ni_routing/ni_device_routes.c     |  0
 .../comedi/drivers/ni_routing/ni_device_routes.h     |  0
 .../comedi/drivers/ni_routing/ni_device_routes/all.h |  0
 .../drivers/ni_routing/ni_device_routes/pci-6070e.c  |  0
 .../drivers/ni_routing/ni_device_routes/pci-6220.c   |  0
 .../drivers/ni_routing/ni_device_routes/pci-6221.c   |  0
 .../drivers/ni_routing/ni_device_routes/pci-6229.c   |  0
 .../drivers/ni_routing/ni_device_routes/pci-6251.c   |  0
 .../drivers/ni_routing/ni_device_routes/pci-6254.c   |  0
 .../drivers/ni_routing/ni_device_routes/pci-6259.c   |  0
 .../drivers/ni_routing/ni_device_routes/pci-6534.c   |  0
 .../drivers/ni_routing/ni_device_routes/pci-6602.c   |  0
 .../drivers/ni_routing/ni_device_routes/pci-6713.c   |  0
 .../drivers/ni_routing/ni_device_routes/pci-6723.c   |  0
 .../drivers/ni_routing/ni_device_routes/pci-6733.c   |  0
 .../drivers/ni_routing/ni_device_routes/pxi-6030e.c  |  0
 .../drivers/ni_routing/ni_device_routes/pxi-6224.c   |  0
 .../drivers/ni_routing/ni_device_routes/pxi-6225.c   |  0
 .../drivers/ni_routing/ni_device_routes/pxi-6251.c   |  0
 .../drivers/ni_routing/ni_device_routes/pxi-6733.c   |  0
 .../drivers/ni_routing/ni_device_routes/pxie-6251.c  |  0
 .../drivers/ni_routing/ni_device_routes/pxie-6535.c  |  0
 .../drivers/ni_routing/ni_device_routes/pxie-6738.c  |  0
 .../comedi/drivers/ni_routing/ni_route_values.c      |  0
 .../comedi/drivers/ni_routing/ni_route_values.h      |  0
 .../comedi/drivers/ni_routing/ni_route_values/all.h  |  0
 .../drivers/ni_routing/ni_route_values/ni_660x.c     |  0
 .../drivers/ni_routing/ni_route_values/ni_eseries.c  |  0
 .../drivers/ni_routing/ni_route_values/ni_mseries.c  |  0
 .../comedi/drivers/ni_routing/tools/.gitignore       |  0
 .../comedi/drivers/ni_routing/tools/Makefile         |  0
 .../drivers/ni_routing/tools/convert_c_to_py.c       |  0
 .../drivers/ni_routing/tools/convert_csv_to_c.py     |  0
 .../drivers/ni_routing/tools/convert_py_to_csv.py    |  0
 .../drivers/ni_routing/tools/csv_collection.py       |  0
 .../drivers/ni_routing/tools/make_blank_csv.py       |  0
 .../comedi/drivers/ni_routing/tools/ni_names.py      |  0
 drivers/{staging => }/comedi/drivers/ni_stc.h        |  0
 drivers/{staging => }/comedi/drivers/ni_tio.c        |  0
 drivers/{staging => }/comedi/drivers/ni_tio.h        |  0
 .../{staging => }/comedi/drivers/ni_tio_internal.h   |  0
 drivers/{staging => }/comedi/drivers/ni_tiocmd.c     |  0
 drivers/{staging => }/comedi/drivers/ni_usb6501.c    |  0
 drivers/{staging => }/comedi/drivers/pcl711.c        |  0
 drivers/{staging => }/comedi/drivers/pcl724.c        |  0
 drivers/{staging => }/comedi/drivers/pcl726.c        |  0
 drivers/{staging => }/comedi/drivers/pcl730.c        |  0
 drivers/{staging => }/comedi/drivers/pcl812.c        |  0
 drivers/{staging => }/comedi/drivers/pcl816.c        |  0
 drivers/{staging => }/comedi/drivers/pcl818.c        |  0
 drivers/{staging => }/comedi/drivers/pcm3724.c       |  0
 drivers/{staging => }/comedi/drivers/pcmad.c         |  0
 drivers/{staging => }/comedi/drivers/pcmda12.c       |  0
 drivers/{staging => }/comedi/drivers/pcmmio.c        |  0
 drivers/{staging => }/comedi/drivers/pcmuio.c        |  0
 drivers/{staging => }/comedi/drivers/plx9052.h       |  0
 drivers/{staging => }/comedi/drivers/plx9080.h       |  0
 .../{staging => }/comedi/drivers/quatech_daqp_cs.c   |  0
 drivers/{staging => }/comedi/drivers/rtd520.c        |  0
 drivers/{staging => }/comedi/drivers/rti800.c        |  0
 drivers/{staging => }/comedi/drivers/rti802.c        |  0
 drivers/{staging => }/comedi/drivers/s526.c          |  0
 drivers/{staging => }/comedi/drivers/s626.c          |  0
 drivers/{staging => }/comedi/drivers/s626.h          |  0
 drivers/{staging => }/comedi/drivers/ssv_dnp.c       |  0
 drivers/{staging => }/comedi/drivers/tests/Makefile  |  0
 .../comedi/drivers/tests/comedi_example_test.c       |  0
 .../comedi/drivers/tests/ni_routes_test.c            |  0
 .../{staging => }/comedi/drivers/tests/unittest.h    |  0
 drivers/{staging => }/comedi/drivers/usbdux.c        |  0
 drivers/{staging => }/comedi/drivers/usbduxfast.c    |  0
 drivers/{staging => }/comedi/drivers/usbduxsigma.c   |  0
 drivers/{staging => }/comedi/drivers/vmk80xx.c       |  0
 drivers/{staging => }/comedi/drivers/z8536.h         |  0
 drivers/{staging => }/comedi/kcomedilib/Makefile     |  0
 .../comedi/kcomedilib/kcomedilib_main.c              |  0
 drivers/{staging => }/comedi/proc.c                  |  0
 drivers/{staging => }/comedi/range.c                 |  0
 drivers/staging/Kconfig                              |  2 --
 drivers/staging/Makefile                             |  1 -
 220 files changed, 9 insertions(+), 9 deletions(-)
 rename drivers/{staging => }/comedi/Kconfig (100%)
 rename drivers/{staging => }/comedi/Makefile (100%)
 rename drivers/{staging => }/comedi/TODO (100%)
 rename drivers/{staging => }/comedi/comedi.h (100%)
 rename drivers/{staging => }/comedi/comedi_buf.c (100%)
 rename drivers/{staging => }/comedi/comedi_fops.c (100%)
 rename drivers/{staging => }/comedi/comedi_internal.h (100%)
 rename drivers/{staging => }/comedi/comedi_pci.c (100%)
 rename drivers/{staging => }/comedi/comedi_pci.h (100%)
 rename drivers/{staging => }/comedi/comedi_pcmcia.c (100%)
 rename drivers/{staging => }/comedi/comedi_pcmcia.h (100%)
 rename drivers/{staging => }/comedi/comedi_usb.c (100%)
 rename drivers/{staging => }/comedi/comedi_usb.h (100%)
 rename drivers/{staging => }/comedi/comedidev.h (100%)
 rename drivers/{staging => }/comedi/comedilib.h (100%)
 rename drivers/{staging => }/comedi/drivers.c (100%)
 rename drivers/{staging => }/comedi/drivers/8255.c (100%)
 rename drivers/{staging => }/comedi/drivers/8255.h (100%)
 rename drivers/{staging => }/comedi/drivers/8255_pci.c (100%)
 rename drivers/{staging => }/comedi/drivers/Makefile (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_1032.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_1500.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_1516.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_1564.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_16xx.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_2032.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_2200.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_3120.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_3501.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_3xxx.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_tcw.h (100%)
 rename drivers/{staging => }/comedi/drivers/addi_watchdog.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_watchdog.h (100%)
 rename drivers/{staging => }/comedi/drivers/adl_pci6208.c (100%)
 rename drivers/{staging => }/comedi/drivers/adl_pci7x3x.c (100%)
 rename drivers/{staging => }/comedi/drivers/adl_pci8164.c (100%)
 rename drivers/{staging => }/comedi/drivers/adl_pci9111.c (100%)
 rename drivers/{staging => }/comedi/drivers/adl_pci9118.c (100%)
 rename drivers/{staging => }/comedi/drivers/adq12b.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci1710.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci1720.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci1723.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci1724.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci1760.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci_dio.c (100%)
 rename drivers/{staging => }/comedi/drivers/aio_aio12_8.c (100%)
 rename drivers/{staging => }/comedi/drivers/aio_iiro_16.c (100%)
 rename drivers/{staging => }/comedi/drivers/amcc_s5933.h (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_dio200.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_dio200.h (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_dio200_common.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_dio200_pci.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pc236.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pc236.h (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pc236_common.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pc263.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pci224.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pci230.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pci236.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pci263.c (100%)
 rename drivers/{staging => }/comedi/drivers/c6xdigio.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_das16_cs.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_pcidas.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_pcidas64.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_pcidda.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_pcimdas.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_pcimdda.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_8254.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_8254.h (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_8255.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_bond.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_isadma.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_isadma.h (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_parport.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_test.c (100%)
 rename drivers/{staging => }/comedi/drivers/contec_pci_dio.c (100%)
 rename drivers/{staging => }/comedi/drivers/dac02.c (100%)
 rename drivers/{staging => }/comedi/drivers/daqboard2000.c (100%)
 rename drivers/{staging => }/comedi/drivers/das08.c (100%)
 rename drivers/{staging => }/comedi/drivers/das08.h (100%)
 rename drivers/{staging => }/comedi/drivers/das08_cs.c (100%)
 rename drivers/{staging => }/comedi/drivers/das08_isa.c (100%)
 rename drivers/{staging => }/comedi/drivers/das08_pci.c (100%)
 rename drivers/{staging => }/comedi/drivers/das16.c (100%)
 rename drivers/{staging => }/comedi/drivers/das16m1.c (100%)
 rename drivers/{staging => }/comedi/drivers/das1800.c (100%)
 rename drivers/{staging => }/comedi/drivers/das6402.c (100%)
 rename drivers/{staging => }/comedi/drivers/das800.c (100%)
 rename drivers/{staging => }/comedi/drivers/dmm32at.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt2801.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt2811.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt2814.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt2815.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt2817.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt282x.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt3000.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt9812.c (100%)
 rename drivers/{staging => }/comedi/drivers/dyna_pci10xx.c (100%)
 rename drivers/{staging => }/comedi/drivers/fl512.c (100%)
 rename drivers/{staging => }/comedi/drivers/gsc_hpdi.c (100%)
 rename drivers/{staging => }/comedi/drivers/icp_multi.c (100%)
 rename drivers/{staging => }/comedi/drivers/ii_pci20kc.c (100%)
 rename drivers/{staging => }/comedi/drivers/jr3_pci.c (100%)
 rename drivers/{staging => }/comedi/drivers/jr3_pci.h (100%)
 rename drivers/{staging => }/comedi/drivers/ke_counter.c (100%)
 rename drivers/{staging => }/comedi/drivers/me4000.c (100%)
 rename drivers/{staging => }/comedi/drivers/me_daq.c (100%)
 rename drivers/{staging => }/comedi/drivers/mf6x4.c (100%)
 rename drivers/{staging => }/comedi/drivers/mite.c (100%)
 rename drivers/{staging => }/comedi/drivers/mite.h (100%)
 rename drivers/{staging => }/comedi/drivers/mpc624.c (100%)
 rename drivers/{staging => }/comedi/drivers/multiq3.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_6527.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_65xx.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_660x.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_670x.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_at_a2150.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_at_ao.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_atmio.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_atmio16d.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_daq_700.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_daq_dio24.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_common.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_cs.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_isadma.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_isadma.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_pci.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_regs.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_mio_common.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_mio_cs.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_pcidio.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_pcimio.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routes.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routes.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/README (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/all.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values/all.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values/ni_660x.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/.gitignore (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/Makefile (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/convert_c_to_py.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/convert_csv_to_c.py (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/convert_py_to_csv.py (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/csv_collection.py (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/make_blank_csv.py (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/ni_names.py (100%)
 rename drivers/{staging => }/comedi/drivers/ni_stc.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_tio.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_tio.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_tio_internal.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_tiocmd.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_usb6501.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl711.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl724.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl726.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl730.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl812.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl816.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl818.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcm3724.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcmad.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcmda12.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcmmio.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcmuio.c (100%)
 rename drivers/{staging => }/comedi/drivers/plx9052.h (100%)
 rename drivers/{staging => }/comedi/drivers/plx9080.h (100%)
 rename drivers/{staging => }/comedi/drivers/quatech_daqp_cs.c (100%)
 rename drivers/{staging => }/comedi/drivers/rtd520.c (100%)
 rename drivers/{staging => }/comedi/drivers/rti800.c (100%)
 rename drivers/{staging => }/comedi/drivers/rti802.c (100%)
 rename drivers/{staging => }/comedi/drivers/s526.c (100%)
 rename drivers/{staging => }/comedi/drivers/s626.c (100%)
 rename drivers/{staging => }/comedi/drivers/s626.h (100%)
 rename drivers/{staging => }/comedi/drivers/ssv_dnp.c (100%)
 rename drivers/{staging => }/comedi/drivers/tests/Makefile (100%)
 rename drivers/{staging => }/comedi/drivers/tests/comedi_example_test.c (100%)
 rename drivers/{staging => }/comedi/drivers/tests/ni_routes_test.c (100%)
 rename drivers/{staging => }/comedi/drivers/tests/unittest.h (100%)
 rename drivers/{staging => }/comedi/drivers/usbdux.c (100%)
 rename drivers/{staging => }/comedi/drivers/usbduxfast.c (100%)
 rename drivers/{staging => }/comedi/drivers/usbduxsigma.c (100%)
 rename drivers/{staging => }/comedi/drivers/vmk80xx.c (100%)
 rename drivers/{staging => }/comedi/drivers/z8536.h (100%)
 rename drivers/{staging => }/comedi/kcomedilib/Makefile (100%)
 rename drivers/{staging => }/comedi/kcomedilib/kcomedilib_main.c (100%)
 rename drivers/{staging => }/comedi/proc.c (100%)
 rename drivers/{staging => }/comedi/range.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 250390c4233d..7ea89f5f4886 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4419,6 +4419,12 @@ S:	Supported
 F:	Documentation/process/code-of-conduct-interpretation.rst
 F:	Documentation/process/code-of-conduct.rst
 
+COMEDI DRIVERS
+M:	Ian Abbott <abbotti@mev.co.uk>
+M:	H Hartley Sweeten <hsweeten@visionengravers.com>
+S:	Odd Fixes
+F:	drivers/comedi/
+
 COMMON CLK FRAMEWORK
 M:	Michael Turquette <mturquette@baylibre.com>
 M:	Stephen Boyd <sboyd@kernel.org>
@@ -16969,12 +16975,6 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/media/atomisp/
 
-STAGING - COMEDI
-M:	Ian Abbott <abbotti@mev.co.uk>
-M:	H Hartley Sweeten <hsweeten@visionengravers.com>
-S:	Odd Fixes
-F:	drivers/staging/comedi/
-
 STAGING - FIELDBUS SUBSYSTEM
 M:	Sven Van Asbroeck <TheSven73@gmail.com>
 S:	Maintained
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 62c753a73651..47980c6b1945 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -149,6 +149,8 @@ source "drivers/xen/Kconfig"
 
 source "drivers/greybus/Kconfig"
 
+source "drivers/comedi/Kconfig"
+
 source "drivers/staging/Kconfig"
 
 source "drivers/platform/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 6fba7daba591..8f3fee8281ad 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -148,6 +148,7 @@ obj-$(CONFIG_VHOST_IOTLB)	+= vhost/
 obj-$(CONFIG_VHOST)		+= vhost/
 obj-$(CONFIG_VLYNQ)		+= vlynq/
 obj-$(CONFIG_GREYBUS)		+= greybus/
+obj-$(CONFIG_COMEDI)		+= comedi/
 obj-$(CONFIG_STAGING)		+= staging/
 obj-y				+= platform/
 
diff --git a/drivers/staging/comedi/Kconfig b/drivers/comedi/Kconfig
similarity index 100%
rename from drivers/staging/comedi/Kconfig
rename to drivers/comedi/Kconfig
diff --git a/drivers/staging/comedi/Makefile b/drivers/comedi/Makefile
similarity index 100%
rename from drivers/staging/comedi/Makefile
rename to drivers/comedi/Makefile
diff --git a/drivers/staging/comedi/TODO b/drivers/comedi/TODO
similarity index 100%
rename from drivers/staging/comedi/TODO
rename to drivers/comedi/TODO
diff --git a/drivers/staging/comedi/comedi.h b/drivers/comedi/comedi.h
similarity index 100%
rename from drivers/staging/comedi/comedi.h
rename to drivers/comedi/comedi.h
diff --git a/drivers/staging/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
similarity index 100%
rename from drivers/staging/comedi/comedi_buf.c
rename to drivers/comedi/comedi_buf.c
diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
similarity index 100%
rename from drivers/staging/comedi/comedi_fops.c
rename to drivers/comedi/comedi_fops.c
diff --git a/drivers/staging/comedi/comedi_internal.h b/drivers/comedi/comedi_internal.h
similarity index 100%
rename from drivers/staging/comedi/comedi_internal.h
rename to drivers/comedi/comedi_internal.h
diff --git a/drivers/staging/comedi/comedi_pci.c b/drivers/comedi/comedi_pci.c
similarity index 100%
rename from drivers/staging/comedi/comedi_pci.c
rename to drivers/comedi/comedi_pci.c
diff --git a/drivers/staging/comedi/comedi_pci.h b/drivers/comedi/comedi_pci.h
similarity index 100%
rename from drivers/staging/comedi/comedi_pci.h
rename to drivers/comedi/comedi_pci.h
diff --git a/drivers/staging/comedi/comedi_pcmcia.c b/drivers/comedi/comedi_pcmcia.c
similarity index 100%
rename from drivers/staging/comedi/comedi_pcmcia.c
rename to drivers/comedi/comedi_pcmcia.c
diff --git a/drivers/staging/comedi/comedi_pcmcia.h b/drivers/comedi/comedi_pcmcia.h
similarity index 100%
rename from drivers/staging/comedi/comedi_pcmcia.h
rename to drivers/comedi/comedi_pcmcia.h
diff --git a/drivers/staging/comedi/comedi_usb.c b/drivers/comedi/comedi_usb.c
similarity index 100%
rename from drivers/staging/comedi/comedi_usb.c
rename to drivers/comedi/comedi_usb.c
diff --git a/drivers/staging/comedi/comedi_usb.h b/drivers/comedi/comedi_usb.h
similarity index 100%
rename from drivers/staging/comedi/comedi_usb.h
rename to drivers/comedi/comedi_usb.h
diff --git a/drivers/staging/comedi/comedidev.h b/drivers/comedi/comedidev.h
similarity index 100%
rename from drivers/staging/comedi/comedidev.h
rename to drivers/comedi/comedidev.h
diff --git a/drivers/staging/comedi/comedilib.h b/drivers/comedi/comedilib.h
similarity index 100%
rename from drivers/staging/comedi/comedilib.h
rename to drivers/comedi/comedilib.h
diff --git a/drivers/staging/comedi/drivers.c b/drivers/comedi/drivers.c
similarity index 100%
rename from drivers/staging/comedi/drivers.c
rename to drivers/comedi/drivers.c
diff --git a/drivers/staging/comedi/drivers/8255.c b/drivers/comedi/drivers/8255.c
similarity index 100%
rename from drivers/staging/comedi/drivers/8255.c
rename to drivers/comedi/drivers/8255.c
diff --git a/drivers/staging/comedi/drivers/8255.h b/drivers/comedi/drivers/8255.h
similarity index 100%
rename from drivers/staging/comedi/drivers/8255.h
rename to drivers/comedi/drivers/8255.h
diff --git a/drivers/staging/comedi/drivers/8255_pci.c b/drivers/comedi/drivers/8255_pci.c
similarity index 100%
rename from drivers/staging/comedi/drivers/8255_pci.c
rename to drivers/comedi/drivers/8255_pci.c
diff --git a/drivers/staging/comedi/drivers/Makefile b/drivers/comedi/drivers/Makefile
similarity index 100%
rename from drivers/staging/comedi/drivers/Makefile
rename to drivers/comedi/drivers/Makefile
diff --git a/drivers/staging/comedi/drivers/addi_apci_1032.c b/drivers/comedi/drivers/addi_apci_1032.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_apci_1032.c
rename to drivers/comedi/drivers/addi_apci_1032.c
diff --git a/drivers/staging/comedi/drivers/addi_apci_1500.c b/drivers/comedi/drivers/addi_apci_1500.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_apci_1500.c
rename to drivers/comedi/drivers/addi_apci_1500.c
diff --git a/drivers/staging/comedi/drivers/addi_apci_1516.c b/drivers/comedi/drivers/addi_apci_1516.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_apci_1516.c
rename to drivers/comedi/drivers/addi_apci_1516.c
diff --git a/drivers/staging/comedi/drivers/addi_apci_1564.c b/drivers/comedi/drivers/addi_apci_1564.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_apci_1564.c
rename to drivers/comedi/drivers/addi_apci_1564.c
diff --git a/drivers/staging/comedi/drivers/addi_apci_16xx.c b/drivers/comedi/drivers/addi_apci_16xx.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_apci_16xx.c
rename to drivers/comedi/drivers/addi_apci_16xx.c
diff --git a/drivers/staging/comedi/drivers/addi_apci_2032.c b/drivers/comedi/drivers/addi_apci_2032.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_apci_2032.c
rename to drivers/comedi/drivers/addi_apci_2032.c
diff --git a/drivers/staging/comedi/drivers/addi_apci_2200.c b/drivers/comedi/drivers/addi_apci_2200.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_apci_2200.c
rename to drivers/comedi/drivers/addi_apci_2200.c
diff --git a/drivers/staging/comedi/drivers/addi_apci_3120.c b/drivers/comedi/drivers/addi_apci_3120.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_apci_3120.c
rename to drivers/comedi/drivers/addi_apci_3120.c
diff --git a/drivers/staging/comedi/drivers/addi_apci_3501.c b/drivers/comedi/drivers/addi_apci_3501.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_apci_3501.c
rename to drivers/comedi/drivers/addi_apci_3501.c
diff --git a/drivers/staging/comedi/drivers/addi_apci_3xxx.c b/drivers/comedi/drivers/addi_apci_3xxx.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_apci_3xxx.c
rename to drivers/comedi/drivers/addi_apci_3xxx.c
diff --git a/drivers/staging/comedi/drivers/addi_tcw.h b/drivers/comedi/drivers/addi_tcw.h
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_tcw.h
rename to drivers/comedi/drivers/addi_tcw.h
diff --git a/drivers/staging/comedi/drivers/addi_watchdog.c b/drivers/comedi/drivers/addi_watchdog.c
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_watchdog.c
rename to drivers/comedi/drivers/addi_watchdog.c
diff --git a/drivers/staging/comedi/drivers/addi_watchdog.h b/drivers/comedi/drivers/addi_watchdog.h
similarity index 100%
rename from drivers/staging/comedi/drivers/addi_watchdog.h
rename to drivers/comedi/drivers/addi_watchdog.h
diff --git a/drivers/staging/comedi/drivers/adl_pci6208.c b/drivers/comedi/drivers/adl_pci6208.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adl_pci6208.c
rename to drivers/comedi/drivers/adl_pci6208.c
diff --git a/drivers/staging/comedi/drivers/adl_pci7x3x.c b/drivers/comedi/drivers/adl_pci7x3x.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adl_pci7x3x.c
rename to drivers/comedi/drivers/adl_pci7x3x.c
diff --git a/drivers/staging/comedi/drivers/adl_pci8164.c b/drivers/comedi/drivers/adl_pci8164.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adl_pci8164.c
rename to drivers/comedi/drivers/adl_pci8164.c
diff --git a/drivers/staging/comedi/drivers/adl_pci9111.c b/drivers/comedi/drivers/adl_pci9111.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adl_pci9111.c
rename to drivers/comedi/drivers/adl_pci9111.c
diff --git a/drivers/staging/comedi/drivers/adl_pci9118.c b/drivers/comedi/drivers/adl_pci9118.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adl_pci9118.c
rename to drivers/comedi/drivers/adl_pci9118.c
diff --git a/drivers/staging/comedi/drivers/adq12b.c b/drivers/comedi/drivers/adq12b.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adq12b.c
rename to drivers/comedi/drivers/adq12b.c
diff --git a/drivers/staging/comedi/drivers/adv_pci1710.c b/drivers/comedi/drivers/adv_pci1710.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adv_pci1710.c
rename to drivers/comedi/drivers/adv_pci1710.c
diff --git a/drivers/staging/comedi/drivers/adv_pci1720.c b/drivers/comedi/drivers/adv_pci1720.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adv_pci1720.c
rename to drivers/comedi/drivers/adv_pci1720.c
diff --git a/drivers/staging/comedi/drivers/adv_pci1723.c b/drivers/comedi/drivers/adv_pci1723.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adv_pci1723.c
rename to drivers/comedi/drivers/adv_pci1723.c
diff --git a/drivers/staging/comedi/drivers/adv_pci1724.c b/drivers/comedi/drivers/adv_pci1724.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adv_pci1724.c
rename to drivers/comedi/drivers/adv_pci1724.c
diff --git a/drivers/staging/comedi/drivers/adv_pci1760.c b/drivers/comedi/drivers/adv_pci1760.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adv_pci1760.c
rename to drivers/comedi/drivers/adv_pci1760.c
diff --git a/drivers/staging/comedi/drivers/adv_pci_dio.c b/drivers/comedi/drivers/adv_pci_dio.c
similarity index 100%
rename from drivers/staging/comedi/drivers/adv_pci_dio.c
rename to drivers/comedi/drivers/adv_pci_dio.c
diff --git a/drivers/staging/comedi/drivers/aio_aio12_8.c b/drivers/comedi/drivers/aio_aio12_8.c
similarity index 100%
rename from drivers/staging/comedi/drivers/aio_aio12_8.c
rename to drivers/comedi/drivers/aio_aio12_8.c
diff --git a/drivers/staging/comedi/drivers/aio_iiro_16.c b/drivers/comedi/drivers/aio_iiro_16.c
similarity index 100%
rename from drivers/staging/comedi/drivers/aio_iiro_16.c
rename to drivers/comedi/drivers/aio_iiro_16.c
diff --git a/drivers/staging/comedi/drivers/amcc_s5933.h b/drivers/comedi/drivers/amcc_s5933.h
similarity index 100%
rename from drivers/staging/comedi/drivers/amcc_s5933.h
rename to drivers/comedi/drivers/amcc_s5933.h
diff --git a/drivers/staging/comedi/drivers/amplc_dio200.c b/drivers/comedi/drivers/amplc_dio200.c
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_dio200.c
rename to drivers/comedi/drivers/amplc_dio200.c
diff --git a/drivers/staging/comedi/drivers/amplc_dio200.h b/drivers/comedi/drivers/amplc_dio200.h
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_dio200.h
rename to drivers/comedi/drivers/amplc_dio200.h
diff --git a/drivers/staging/comedi/drivers/amplc_dio200_common.c b/drivers/comedi/drivers/amplc_dio200_common.c
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_dio200_common.c
rename to drivers/comedi/drivers/amplc_dio200_common.c
diff --git a/drivers/staging/comedi/drivers/amplc_dio200_pci.c b/drivers/comedi/drivers/amplc_dio200_pci.c
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_dio200_pci.c
rename to drivers/comedi/drivers/amplc_dio200_pci.c
diff --git a/drivers/staging/comedi/drivers/amplc_pc236.c b/drivers/comedi/drivers/amplc_pc236.c
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_pc236.c
rename to drivers/comedi/drivers/amplc_pc236.c
diff --git a/drivers/staging/comedi/drivers/amplc_pc236.h b/drivers/comedi/drivers/amplc_pc236.h
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_pc236.h
rename to drivers/comedi/drivers/amplc_pc236.h
diff --git a/drivers/staging/comedi/drivers/amplc_pc236_common.c b/drivers/comedi/drivers/amplc_pc236_common.c
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_pc236_common.c
rename to drivers/comedi/drivers/amplc_pc236_common.c
diff --git a/drivers/staging/comedi/drivers/amplc_pc263.c b/drivers/comedi/drivers/amplc_pc263.c
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_pc263.c
rename to drivers/comedi/drivers/amplc_pc263.c
diff --git a/drivers/staging/comedi/drivers/amplc_pci224.c b/drivers/comedi/drivers/amplc_pci224.c
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_pci224.c
rename to drivers/comedi/drivers/amplc_pci224.c
diff --git a/drivers/staging/comedi/drivers/amplc_pci230.c b/drivers/comedi/drivers/amplc_pci230.c
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_pci230.c
rename to drivers/comedi/drivers/amplc_pci230.c
diff --git a/drivers/staging/comedi/drivers/amplc_pci236.c b/drivers/comedi/drivers/amplc_pci236.c
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_pci236.c
rename to drivers/comedi/drivers/amplc_pci236.c
diff --git a/drivers/staging/comedi/drivers/amplc_pci263.c b/drivers/comedi/drivers/amplc_pci263.c
similarity index 100%
rename from drivers/staging/comedi/drivers/amplc_pci263.c
rename to drivers/comedi/drivers/amplc_pci263.c
diff --git a/drivers/staging/comedi/drivers/c6xdigio.c b/drivers/comedi/drivers/c6xdigio.c
similarity index 100%
rename from drivers/staging/comedi/drivers/c6xdigio.c
rename to drivers/comedi/drivers/c6xdigio.c
diff --git a/drivers/staging/comedi/drivers/cb_das16_cs.c b/drivers/comedi/drivers/cb_das16_cs.c
similarity index 100%
rename from drivers/staging/comedi/drivers/cb_das16_cs.c
rename to drivers/comedi/drivers/cb_das16_cs.c
diff --git a/drivers/staging/comedi/drivers/cb_pcidas.c b/drivers/comedi/drivers/cb_pcidas.c
similarity index 100%
rename from drivers/staging/comedi/drivers/cb_pcidas.c
rename to drivers/comedi/drivers/cb_pcidas.c
diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/comedi/drivers/cb_pcidas64.c
similarity index 100%
rename from drivers/staging/comedi/drivers/cb_pcidas64.c
rename to drivers/comedi/drivers/cb_pcidas64.c
diff --git a/drivers/staging/comedi/drivers/cb_pcidda.c b/drivers/comedi/drivers/cb_pcidda.c
similarity index 100%
rename from drivers/staging/comedi/drivers/cb_pcidda.c
rename to drivers/comedi/drivers/cb_pcidda.c
diff --git a/drivers/staging/comedi/drivers/cb_pcimdas.c b/drivers/comedi/drivers/cb_pcimdas.c
similarity index 100%
rename from drivers/staging/comedi/drivers/cb_pcimdas.c
rename to drivers/comedi/drivers/cb_pcimdas.c
diff --git a/drivers/staging/comedi/drivers/cb_pcimdda.c b/drivers/comedi/drivers/cb_pcimdda.c
similarity index 100%
rename from drivers/staging/comedi/drivers/cb_pcimdda.c
rename to drivers/comedi/drivers/cb_pcimdda.c
diff --git a/drivers/staging/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
similarity index 100%
rename from drivers/staging/comedi/drivers/comedi_8254.c
rename to drivers/comedi/drivers/comedi_8254.c
diff --git a/drivers/staging/comedi/drivers/comedi_8254.h b/drivers/comedi/drivers/comedi_8254.h
similarity index 100%
rename from drivers/staging/comedi/drivers/comedi_8254.h
rename to drivers/comedi/drivers/comedi_8254.h
diff --git a/drivers/staging/comedi/drivers/comedi_8255.c b/drivers/comedi/drivers/comedi_8255.c
similarity index 100%
rename from drivers/staging/comedi/drivers/comedi_8255.c
rename to drivers/comedi/drivers/comedi_8255.c
diff --git a/drivers/staging/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/comedi_bond.c
similarity index 100%
rename from drivers/staging/comedi/drivers/comedi_bond.c
rename to drivers/comedi/drivers/comedi_bond.c
diff --git a/drivers/staging/comedi/drivers/comedi_isadma.c b/drivers/comedi/drivers/comedi_isadma.c
similarity index 100%
rename from drivers/staging/comedi/drivers/comedi_isadma.c
rename to drivers/comedi/drivers/comedi_isadma.c
diff --git a/drivers/staging/comedi/drivers/comedi_isadma.h b/drivers/comedi/drivers/comedi_isadma.h
similarity index 100%
rename from drivers/staging/comedi/drivers/comedi_isadma.h
rename to drivers/comedi/drivers/comedi_isadma.h
diff --git a/drivers/staging/comedi/drivers/comedi_parport.c b/drivers/comedi/drivers/comedi_parport.c
similarity index 100%
rename from drivers/staging/comedi/drivers/comedi_parport.c
rename to drivers/comedi/drivers/comedi_parport.c
diff --git a/drivers/staging/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
similarity index 100%
rename from drivers/staging/comedi/drivers/comedi_test.c
rename to drivers/comedi/drivers/comedi_test.c
diff --git a/drivers/staging/comedi/drivers/contec_pci_dio.c b/drivers/comedi/drivers/contec_pci_dio.c
similarity index 100%
rename from drivers/staging/comedi/drivers/contec_pci_dio.c
rename to drivers/comedi/drivers/contec_pci_dio.c
diff --git a/drivers/staging/comedi/drivers/dac02.c b/drivers/comedi/drivers/dac02.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dac02.c
rename to drivers/comedi/drivers/dac02.c
diff --git a/drivers/staging/comedi/drivers/daqboard2000.c b/drivers/comedi/drivers/daqboard2000.c
similarity index 100%
rename from drivers/staging/comedi/drivers/daqboard2000.c
rename to drivers/comedi/drivers/daqboard2000.c
diff --git a/drivers/staging/comedi/drivers/das08.c b/drivers/comedi/drivers/das08.c
similarity index 100%
rename from drivers/staging/comedi/drivers/das08.c
rename to drivers/comedi/drivers/das08.c
diff --git a/drivers/staging/comedi/drivers/das08.h b/drivers/comedi/drivers/das08.h
similarity index 100%
rename from drivers/staging/comedi/drivers/das08.h
rename to drivers/comedi/drivers/das08.h
diff --git a/drivers/staging/comedi/drivers/das08_cs.c b/drivers/comedi/drivers/das08_cs.c
similarity index 100%
rename from drivers/staging/comedi/drivers/das08_cs.c
rename to drivers/comedi/drivers/das08_cs.c
diff --git a/drivers/staging/comedi/drivers/das08_isa.c b/drivers/comedi/drivers/das08_isa.c
similarity index 100%
rename from drivers/staging/comedi/drivers/das08_isa.c
rename to drivers/comedi/drivers/das08_isa.c
diff --git a/drivers/staging/comedi/drivers/das08_pci.c b/drivers/comedi/drivers/das08_pci.c
similarity index 100%
rename from drivers/staging/comedi/drivers/das08_pci.c
rename to drivers/comedi/drivers/das08_pci.c
diff --git a/drivers/staging/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
similarity index 100%
rename from drivers/staging/comedi/drivers/das16.c
rename to drivers/comedi/drivers/das16.c
diff --git a/drivers/staging/comedi/drivers/das16m1.c b/drivers/comedi/drivers/das16m1.c
similarity index 100%
rename from drivers/staging/comedi/drivers/das16m1.c
rename to drivers/comedi/drivers/das16m1.c
diff --git a/drivers/staging/comedi/drivers/das1800.c b/drivers/comedi/drivers/das1800.c
similarity index 100%
rename from drivers/staging/comedi/drivers/das1800.c
rename to drivers/comedi/drivers/das1800.c
diff --git a/drivers/staging/comedi/drivers/das6402.c b/drivers/comedi/drivers/das6402.c
similarity index 100%
rename from drivers/staging/comedi/drivers/das6402.c
rename to drivers/comedi/drivers/das6402.c
diff --git a/drivers/staging/comedi/drivers/das800.c b/drivers/comedi/drivers/das800.c
similarity index 100%
rename from drivers/staging/comedi/drivers/das800.c
rename to drivers/comedi/drivers/das800.c
diff --git a/drivers/staging/comedi/drivers/dmm32at.c b/drivers/comedi/drivers/dmm32at.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dmm32at.c
rename to drivers/comedi/drivers/dmm32at.c
diff --git a/drivers/staging/comedi/drivers/dt2801.c b/drivers/comedi/drivers/dt2801.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dt2801.c
rename to drivers/comedi/drivers/dt2801.c
diff --git a/drivers/staging/comedi/drivers/dt2811.c b/drivers/comedi/drivers/dt2811.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dt2811.c
rename to drivers/comedi/drivers/dt2811.c
diff --git a/drivers/staging/comedi/drivers/dt2814.c b/drivers/comedi/drivers/dt2814.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dt2814.c
rename to drivers/comedi/drivers/dt2814.c
diff --git a/drivers/staging/comedi/drivers/dt2815.c b/drivers/comedi/drivers/dt2815.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dt2815.c
rename to drivers/comedi/drivers/dt2815.c
diff --git a/drivers/staging/comedi/drivers/dt2817.c b/drivers/comedi/drivers/dt2817.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dt2817.c
rename to drivers/comedi/drivers/dt2817.c
diff --git a/drivers/staging/comedi/drivers/dt282x.c b/drivers/comedi/drivers/dt282x.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dt282x.c
rename to drivers/comedi/drivers/dt282x.c
diff --git a/drivers/staging/comedi/drivers/dt3000.c b/drivers/comedi/drivers/dt3000.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dt3000.c
rename to drivers/comedi/drivers/dt3000.c
diff --git a/drivers/staging/comedi/drivers/dt9812.c b/drivers/comedi/drivers/dt9812.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dt9812.c
rename to drivers/comedi/drivers/dt9812.c
diff --git a/drivers/staging/comedi/drivers/dyna_pci10xx.c b/drivers/comedi/drivers/dyna_pci10xx.c
similarity index 100%
rename from drivers/staging/comedi/drivers/dyna_pci10xx.c
rename to drivers/comedi/drivers/dyna_pci10xx.c
diff --git a/drivers/staging/comedi/drivers/fl512.c b/drivers/comedi/drivers/fl512.c
similarity index 100%
rename from drivers/staging/comedi/drivers/fl512.c
rename to drivers/comedi/drivers/fl512.c
diff --git a/drivers/staging/comedi/drivers/gsc_hpdi.c b/drivers/comedi/drivers/gsc_hpdi.c
similarity index 100%
rename from drivers/staging/comedi/drivers/gsc_hpdi.c
rename to drivers/comedi/drivers/gsc_hpdi.c
diff --git a/drivers/staging/comedi/drivers/icp_multi.c b/drivers/comedi/drivers/icp_multi.c
similarity index 100%
rename from drivers/staging/comedi/drivers/icp_multi.c
rename to drivers/comedi/drivers/icp_multi.c
diff --git a/drivers/staging/comedi/drivers/ii_pci20kc.c b/drivers/comedi/drivers/ii_pci20kc.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ii_pci20kc.c
rename to drivers/comedi/drivers/ii_pci20kc.c
diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
similarity index 100%
rename from drivers/staging/comedi/drivers/jr3_pci.c
rename to drivers/comedi/drivers/jr3_pci.c
diff --git a/drivers/staging/comedi/drivers/jr3_pci.h b/drivers/comedi/drivers/jr3_pci.h
similarity index 100%
rename from drivers/staging/comedi/drivers/jr3_pci.h
rename to drivers/comedi/drivers/jr3_pci.h
diff --git a/drivers/staging/comedi/drivers/ke_counter.c b/drivers/comedi/drivers/ke_counter.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ke_counter.c
rename to drivers/comedi/drivers/ke_counter.c
diff --git a/drivers/staging/comedi/drivers/me4000.c b/drivers/comedi/drivers/me4000.c
similarity index 100%
rename from drivers/staging/comedi/drivers/me4000.c
rename to drivers/comedi/drivers/me4000.c
diff --git a/drivers/staging/comedi/drivers/me_daq.c b/drivers/comedi/drivers/me_daq.c
similarity index 100%
rename from drivers/staging/comedi/drivers/me_daq.c
rename to drivers/comedi/drivers/me_daq.c
diff --git a/drivers/staging/comedi/drivers/mf6x4.c b/drivers/comedi/drivers/mf6x4.c
similarity index 100%
rename from drivers/staging/comedi/drivers/mf6x4.c
rename to drivers/comedi/drivers/mf6x4.c
diff --git a/drivers/staging/comedi/drivers/mite.c b/drivers/comedi/drivers/mite.c
similarity index 100%
rename from drivers/staging/comedi/drivers/mite.c
rename to drivers/comedi/drivers/mite.c
diff --git a/drivers/staging/comedi/drivers/mite.h b/drivers/comedi/drivers/mite.h
similarity index 100%
rename from drivers/staging/comedi/drivers/mite.h
rename to drivers/comedi/drivers/mite.h
diff --git a/drivers/staging/comedi/drivers/mpc624.c b/drivers/comedi/drivers/mpc624.c
similarity index 100%
rename from drivers/staging/comedi/drivers/mpc624.c
rename to drivers/comedi/drivers/mpc624.c
diff --git a/drivers/staging/comedi/drivers/multiq3.c b/drivers/comedi/drivers/multiq3.c
similarity index 100%
rename from drivers/staging/comedi/drivers/multiq3.c
rename to drivers/comedi/drivers/multiq3.c
diff --git a/drivers/staging/comedi/drivers/ni_6527.c b/drivers/comedi/drivers/ni_6527.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_6527.c
rename to drivers/comedi/drivers/ni_6527.c
diff --git a/drivers/staging/comedi/drivers/ni_65xx.c b/drivers/comedi/drivers/ni_65xx.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_65xx.c
rename to drivers/comedi/drivers/ni_65xx.c
diff --git a/drivers/staging/comedi/drivers/ni_660x.c b/drivers/comedi/drivers/ni_660x.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_660x.c
rename to drivers/comedi/drivers/ni_660x.c
diff --git a/drivers/staging/comedi/drivers/ni_670x.c b/drivers/comedi/drivers/ni_670x.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_670x.c
rename to drivers/comedi/drivers/ni_670x.c
diff --git a/drivers/staging/comedi/drivers/ni_at_a2150.c b/drivers/comedi/drivers/ni_at_a2150.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_at_a2150.c
rename to drivers/comedi/drivers/ni_at_a2150.c
diff --git a/drivers/staging/comedi/drivers/ni_at_ao.c b/drivers/comedi/drivers/ni_at_ao.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_at_ao.c
rename to drivers/comedi/drivers/ni_at_ao.c
diff --git a/drivers/staging/comedi/drivers/ni_atmio.c b/drivers/comedi/drivers/ni_atmio.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_atmio.c
rename to drivers/comedi/drivers/ni_atmio.c
diff --git a/drivers/staging/comedi/drivers/ni_atmio16d.c b/drivers/comedi/drivers/ni_atmio16d.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_atmio16d.c
rename to drivers/comedi/drivers/ni_atmio16d.c
diff --git a/drivers/staging/comedi/drivers/ni_daq_700.c b/drivers/comedi/drivers/ni_daq_700.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_daq_700.c
rename to drivers/comedi/drivers/ni_daq_700.c
diff --git a/drivers/staging/comedi/drivers/ni_daq_dio24.c b/drivers/comedi/drivers/ni_daq_dio24.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_daq_dio24.c
rename to drivers/comedi/drivers/ni_daq_dio24.c
diff --git a/drivers/staging/comedi/drivers/ni_labpc.c b/drivers/comedi/drivers/ni_labpc.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_labpc.c
rename to drivers/comedi/drivers/ni_labpc.c
diff --git a/drivers/staging/comedi/drivers/ni_labpc.h b/drivers/comedi/drivers/ni_labpc.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_labpc.h
rename to drivers/comedi/drivers/ni_labpc.h
diff --git a/drivers/staging/comedi/drivers/ni_labpc_common.c b/drivers/comedi/drivers/ni_labpc_common.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_labpc_common.c
rename to drivers/comedi/drivers/ni_labpc_common.c
diff --git a/drivers/staging/comedi/drivers/ni_labpc_cs.c b/drivers/comedi/drivers/ni_labpc_cs.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_labpc_cs.c
rename to drivers/comedi/drivers/ni_labpc_cs.c
diff --git a/drivers/staging/comedi/drivers/ni_labpc_isadma.c b/drivers/comedi/drivers/ni_labpc_isadma.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_labpc_isadma.c
rename to drivers/comedi/drivers/ni_labpc_isadma.c
diff --git a/drivers/staging/comedi/drivers/ni_labpc_isadma.h b/drivers/comedi/drivers/ni_labpc_isadma.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_labpc_isadma.h
rename to drivers/comedi/drivers/ni_labpc_isadma.h
diff --git a/drivers/staging/comedi/drivers/ni_labpc_pci.c b/drivers/comedi/drivers/ni_labpc_pci.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_labpc_pci.c
rename to drivers/comedi/drivers/ni_labpc_pci.c
diff --git a/drivers/staging/comedi/drivers/ni_labpc_regs.h b/drivers/comedi/drivers/ni_labpc_regs.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_labpc_regs.h
rename to drivers/comedi/drivers/ni_labpc_regs.h
diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_mio_common.c
rename to drivers/comedi/drivers/ni_mio_common.c
diff --git a/drivers/staging/comedi/drivers/ni_mio_cs.c b/drivers/comedi/drivers/ni_mio_cs.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_mio_cs.c
rename to drivers/comedi/drivers/ni_mio_cs.c
diff --git a/drivers/staging/comedi/drivers/ni_pcidio.c b/drivers/comedi/drivers/ni_pcidio.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_pcidio.c
rename to drivers/comedi/drivers/ni_pcidio.c
diff --git a/drivers/staging/comedi/drivers/ni_pcimio.c b/drivers/comedi/drivers/ni_pcimio.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_pcimio.c
rename to drivers/comedi/drivers/ni_pcimio.c
diff --git a/drivers/staging/comedi/drivers/ni_routes.c b/drivers/comedi/drivers/ni_routes.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routes.c
rename to drivers/comedi/drivers/ni_routes.c
diff --git a/drivers/staging/comedi/drivers/ni_routes.h b/drivers/comedi/drivers/ni_routes.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routes.h
rename to drivers/comedi/drivers/ni_routes.h
diff --git a/drivers/staging/comedi/drivers/ni_routing/README b/drivers/comedi/drivers/ni_routing/README
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/README
rename to drivers/comedi/drivers/ni_routing/README
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes.c b/drivers/comedi/drivers/ni_routing/ni_device_routes.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes.h b/drivers/comedi/drivers/ni_routing/ni_device_routes.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes.h
rename to drivers/comedi/drivers/ni_routing/ni_device_routes.h
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/all.h b/drivers/comedi/drivers/ni_routing/ni_device_routes/all.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/all.h
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/all.h
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
rename to drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values.c b/drivers/comedi/drivers/ni_routing/ni_route_values.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_route_values.c
rename to drivers/comedi/drivers/ni_routing/ni_route_values.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values.h b/drivers/comedi/drivers/ni_routing/ni_route_values.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_route_values.h
rename to drivers/comedi/drivers/ni_routing/ni_route_values.h
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/all.h b/drivers/comedi/drivers/ni_routing/ni_route_values/all.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_route_values/all.h
rename to drivers/comedi/drivers/ni_routing/ni_route_values/all.h
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_660x.c b/drivers/comedi/drivers/ni_routing/ni_route_values/ni_660x.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_660x.c
rename to drivers/comedi/drivers/ni_routing/ni_route_values/ni_660x.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c b/drivers/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
rename to drivers/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c b/drivers/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
rename to drivers/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/.gitignore b/drivers/comedi/drivers/ni_routing/tools/.gitignore
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/tools/.gitignore
rename to drivers/comedi/drivers/ni_routing/tools/.gitignore
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/Makefile b/drivers/comedi/drivers/ni_routing/tools/Makefile
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/tools/Makefile
rename to drivers/comedi/drivers/ni_routing/tools/Makefile
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/tools/convert_c_to_py.c
rename to drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/convert_csv_to_c.py b/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
rename to drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/convert_py_to_csv.py b/drivers/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
rename to drivers/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/csv_collection.py b/drivers/comedi/drivers/ni_routing/tools/csv_collection.py
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/tools/csv_collection.py
rename to drivers/comedi/drivers/ni_routing/tools/csv_collection.py
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/make_blank_csv.py b/drivers/comedi/drivers/ni_routing/tools/make_blank_csv.py
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/tools/make_blank_csv.py
rename to drivers/comedi/drivers/ni_routing/tools/make_blank_csv.py
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/ni_names.py b/drivers/comedi/drivers/ni_routing/tools/ni_names.py
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_routing/tools/ni_names.py
rename to drivers/comedi/drivers/ni_routing/tools/ni_names.py
diff --git a/drivers/staging/comedi/drivers/ni_stc.h b/drivers/comedi/drivers/ni_stc.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_stc.h
rename to drivers/comedi/drivers/ni_stc.h
diff --git a/drivers/staging/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_tio.c
rename to drivers/comedi/drivers/ni_tio.c
diff --git a/drivers/staging/comedi/drivers/ni_tio.h b/drivers/comedi/drivers/ni_tio.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_tio.h
rename to drivers/comedi/drivers/ni_tio.h
diff --git a/drivers/staging/comedi/drivers/ni_tio_internal.h b/drivers/comedi/drivers/ni_tio_internal.h
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_tio_internal.h
rename to drivers/comedi/drivers/ni_tio_internal.h
diff --git a/drivers/staging/comedi/drivers/ni_tiocmd.c b/drivers/comedi/drivers/ni_tiocmd.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_tiocmd.c
rename to drivers/comedi/drivers/ni_tiocmd.c
diff --git a/drivers/staging/comedi/drivers/ni_usb6501.c b/drivers/comedi/drivers/ni_usb6501.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ni_usb6501.c
rename to drivers/comedi/drivers/ni_usb6501.c
diff --git a/drivers/staging/comedi/drivers/pcl711.c b/drivers/comedi/drivers/pcl711.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcl711.c
rename to drivers/comedi/drivers/pcl711.c
diff --git a/drivers/staging/comedi/drivers/pcl724.c b/drivers/comedi/drivers/pcl724.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcl724.c
rename to drivers/comedi/drivers/pcl724.c
diff --git a/drivers/staging/comedi/drivers/pcl726.c b/drivers/comedi/drivers/pcl726.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcl726.c
rename to drivers/comedi/drivers/pcl726.c
diff --git a/drivers/staging/comedi/drivers/pcl730.c b/drivers/comedi/drivers/pcl730.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcl730.c
rename to drivers/comedi/drivers/pcl730.c
diff --git a/drivers/staging/comedi/drivers/pcl812.c b/drivers/comedi/drivers/pcl812.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcl812.c
rename to drivers/comedi/drivers/pcl812.c
diff --git a/drivers/staging/comedi/drivers/pcl816.c b/drivers/comedi/drivers/pcl816.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcl816.c
rename to drivers/comedi/drivers/pcl816.c
diff --git a/drivers/staging/comedi/drivers/pcl818.c b/drivers/comedi/drivers/pcl818.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcl818.c
rename to drivers/comedi/drivers/pcl818.c
diff --git a/drivers/staging/comedi/drivers/pcm3724.c b/drivers/comedi/drivers/pcm3724.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcm3724.c
rename to drivers/comedi/drivers/pcm3724.c
diff --git a/drivers/staging/comedi/drivers/pcmad.c b/drivers/comedi/drivers/pcmad.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcmad.c
rename to drivers/comedi/drivers/pcmad.c
diff --git a/drivers/staging/comedi/drivers/pcmda12.c b/drivers/comedi/drivers/pcmda12.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcmda12.c
rename to drivers/comedi/drivers/pcmda12.c
diff --git a/drivers/staging/comedi/drivers/pcmmio.c b/drivers/comedi/drivers/pcmmio.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcmmio.c
rename to drivers/comedi/drivers/pcmmio.c
diff --git a/drivers/staging/comedi/drivers/pcmuio.c b/drivers/comedi/drivers/pcmuio.c
similarity index 100%
rename from drivers/staging/comedi/drivers/pcmuio.c
rename to drivers/comedi/drivers/pcmuio.c
diff --git a/drivers/staging/comedi/drivers/plx9052.h b/drivers/comedi/drivers/plx9052.h
similarity index 100%
rename from drivers/staging/comedi/drivers/plx9052.h
rename to drivers/comedi/drivers/plx9052.h
diff --git a/drivers/staging/comedi/drivers/plx9080.h b/drivers/comedi/drivers/plx9080.h
similarity index 100%
rename from drivers/staging/comedi/drivers/plx9080.h
rename to drivers/comedi/drivers/plx9080.h
diff --git a/drivers/staging/comedi/drivers/quatech_daqp_cs.c b/drivers/comedi/drivers/quatech_daqp_cs.c
similarity index 100%
rename from drivers/staging/comedi/drivers/quatech_daqp_cs.c
rename to drivers/comedi/drivers/quatech_daqp_cs.c
diff --git a/drivers/staging/comedi/drivers/rtd520.c b/drivers/comedi/drivers/rtd520.c
similarity index 100%
rename from drivers/staging/comedi/drivers/rtd520.c
rename to drivers/comedi/drivers/rtd520.c
diff --git a/drivers/staging/comedi/drivers/rti800.c b/drivers/comedi/drivers/rti800.c
similarity index 100%
rename from drivers/staging/comedi/drivers/rti800.c
rename to drivers/comedi/drivers/rti800.c
diff --git a/drivers/staging/comedi/drivers/rti802.c b/drivers/comedi/drivers/rti802.c
similarity index 100%
rename from drivers/staging/comedi/drivers/rti802.c
rename to drivers/comedi/drivers/rti802.c
diff --git a/drivers/staging/comedi/drivers/s526.c b/drivers/comedi/drivers/s526.c
similarity index 100%
rename from drivers/staging/comedi/drivers/s526.c
rename to drivers/comedi/drivers/s526.c
diff --git a/drivers/staging/comedi/drivers/s626.c b/drivers/comedi/drivers/s626.c
similarity index 100%
rename from drivers/staging/comedi/drivers/s626.c
rename to drivers/comedi/drivers/s626.c
diff --git a/drivers/staging/comedi/drivers/s626.h b/drivers/comedi/drivers/s626.h
similarity index 100%
rename from drivers/staging/comedi/drivers/s626.h
rename to drivers/comedi/drivers/s626.h
diff --git a/drivers/staging/comedi/drivers/ssv_dnp.c b/drivers/comedi/drivers/ssv_dnp.c
similarity index 100%
rename from drivers/staging/comedi/drivers/ssv_dnp.c
rename to drivers/comedi/drivers/ssv_dnp.c
diff --git a/drivers/staging/comedi/drivers/tests/Makefile b/drivers/comedi/drivers/tests/Makefile
similarity index 100%
rename from drivers/staging/comedi/drivers/tests/Makefile
rename to drivers/comedi/drivers/tests/Makefile
diff --git a/drivers/staging/comedi/drivers/tests/comedi_example_test.c b/drivers/comedi/drivers/tests/comedi_example_test.c
similarity index 100%
rename from drivers/staging/comedi/drivers/tests/comedi_example_test.c
rename to drivers/comedi/drivers/tests/comedi_example_test.c
diff --git a/drivers/staging/comedi/drivers/tests/ni_routes_test.c b/drivers/comedi/drivers/tests/ni_routes_test.c
similarity index 100%
rename from drivers/staging/comedi/drivers/tests/ni_routes_test.c
rename to drivers/comedi/drivers/tests/ni_routes_test.c
diff --git a/drivers/staging/comedi/drivers/tests/unittest.h b/drivers/comedi/drivers/tests/unittest.h
similarity index 100%
rename from drivers/staging/comedi/drivers/tests/unittest.h
rename to drivers/comedi/drivers/tests/unittest.h
diff --git a/drivers/staging/comedi/drivers/usbdux.c b/drivers/comedi/drivers/usbdux.c
similarity index 100%
rename from drivers/staging/comedi/drivers/usbdux.c
rename to drivers/comedi/drivers/usbdux.c
diff --git a/drivers/staging/comedi/drivers/usbduxfast.c b/drivers/comedi/drivers/usbduxfast.c
similarity index 100%
rename from drivers/staging/comedi/drivers/usbduxfast.c
rename to drivers/comedi/drivers/usbduxfast.c
diff --git a/drivers/staging/comedi/drivers/usbduxsigma.c b/drivers/comedi/drivers/usbduxsigma.c
similarity index 100%
rename from drivers/staging/comedi/drivers/usbduxsigma.c
rename to drivers/comedi/drivers/usbduxsigma.c
diff --git a/drivers/staging/comedi/drivers/vmk80xx.c b/drivers/comedi/drivers/vmk80xx.c
similarity index 100%
rename from drivers/staging/comedi/drivers/vmk80xx.c
rename to drivers/comedi/drivers/vmk80xx.c
diff --git a/drivers/staging/comedi/drivers/z8536.h b/drivers/comedi/drivers/z8536.h
similarity index 100%
rename from drivers/staging/comedi/drivers/z8536.h
rename to drivers/comedi/drivers/z8536.h
diff --git a/drivers/staging/comedi/kcomedilib/Makefile b/drivers/comedi/kcomedilib/Makefile
similarity index 100%
rename from drivers/staging/comedi/kcomedilib/Makefile
rename to drivers/comedi/kcomedilib/Makefile
diff --git a/drivers/staging/comedi/kcomedilib/kcomedilib_main.c b/drivers/comedi/kcomedilib/kcomedilib_main.c
similarity index 100%
rename from drivers/staging/comedi/kcomedilib/kcomedilib_main.c
rename to drivers/comedi/kcomedilib/kcomedilib_main.c
diff --git a/drivers/staging/comedi/proc.c b/drivers/comedi/proc.c
similarity index 100%
rename from drivers/staging/comedi/proc.c
rename to drivers/comedi/proc.c
diff --git a/drivers/staging/comedi/range.c b/drivers/comedi/range.c
similarity index 100%
rename from drivers/staging/comedi/range.c
rename to drivers/comedi/range.c
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 7b57b755bfa3..808e78d6cd98 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -26,8 +26,6 @@ if STAGING
 
 source "drivers/staging/wlan-ng/Kconfig"
 
-source "drivers/staging/comedi/Kconfig"
-
 source "drivers/staging/olpc_dcon/Kconfig"
 
 source "drivers/staging/rtl8192u/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 4350423f65aa..5a871f0ff2f4 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -3,7 +3,6 @@
 
 obj-y				+= media/
 obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
-obj-$(CONFIG_COMEDI)		+= comedi/
 obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
 obj-$(CONFIG_RTL8192U)		+= rtl8192u/
 obj-$(CONFIG_RTL8192E)		+= rtl8192e/
-- 
2.31.1

