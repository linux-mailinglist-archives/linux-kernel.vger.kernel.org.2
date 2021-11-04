Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB8A445384
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhKDNJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhKDNJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:09:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 283D4611C9;
        Thu,  4 Nov 2021 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636031191;
        bh=w9hf0+J1WUYgQSpoES7cJkouqoRd+DnIM0NEtAH+CCY=;
        h=Date:From:To:Cc:Subject:From;
        b=otcV5Xc2W/0usplWOCmQ7sbfpbZPYsPjgvYeUnwXi5Tz1xdpyze6p6bXvtIpjqnm8
         w9W6elMX7Ygmn3KLT1cPD+Sp7+4V53gcVOXE+RYiwYdJpuiZ+AN7oIWi1+b4uqRwD3
         RkfS2vBYLxBivassM19s1FH8C2z2lmc1gwPc2yEk=
Date:   Thu, 4 Nov 2021 14:06:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 5.16-rc1
Message-ID: <YYPa1fcok+OPjFI/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc1

for you to fetch changes up to 536de747bc48262225889a533db6650731ab25d3:

  comedi: dt9812: fix DMA buffers on stack (2021-10-30 10:54:47 +0200)

----------------------------------------------------------------
Char/Misc driver update for 5.16-rc1

Here is the big set of char and misc and other tiny driver subsystem
updates for 5.16-rc1.

Loads of things in here, all of which have been in linux-next for a
while with no reported problems (except for one called out below.)

Included are:
	- habanana labs driver updates, including dma_buf usage,
	  reviewed and acked by the dma_buf maintainers
	- iio driver update (going through this tree not staging as they
	  really do not belong going through that tree anymore)
	- counter driver updates
	- hwmon driver updates that the counter drivers needed, acked by
	  the hwmon maintainer
	- xillybus driver updates
	- binder driver updates
	- extcon driver updates
	- dma_buf module namespaces added (will cause a build error in
	  arm64 for allmodconfig, but that change is on its way through
	  the drm tree)
	- lkdtm driver updates
	- pvpanic driver updates
	- phy driver updates
	- virt acrn and nitr_enclaves driver updates
	- smaller char and misc driver updates

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Vorwerk (1):
      staging: iio: cdc: remove braces from single line if blocks

Alexandru Ardelean (24):
      iio: st_sensors: disable regulators after device unregistration
      iio: st_sensors: remove st_sensors_deallocate_trigger() function
      iio: st_sensors: remove st_sensors_power_disable() function
      iio: st_sensors: remove all driver remove functions
      iio: st_sensors: remove reference to parent device object on st_sensor_data
      iio: adc: ti-ads8344: convert probe to device-managed
      iio: dac: ad7303: convert probe to full device-managed
      staging: iio: ad9832: convert probe to device-managed
      iio: dac: ad5064: convert probe to full device-managed
      iio: gyro: adis16080: use devm_iio_device_register() in probe
      iio: light: max44000: use device-managed functions in probe
      iio: adc: fsl-imx25-gcq: initialize regulators as needed
      iio: inkern: introduce devm_iio_map_array_register() short-hand function
      iio: adc: intel_mrfld_adc: convert probe to full device-managed
      iio: adc: axp288_adc: convert probe to full device-managed
      iio: adc: lp8788_adc: convert probe to full-device managed
      iio: adc: da9150-gpadc: convert probe to full-device managed
      iio: adc: nau7802: convert probe to full device-managed
      iio: adc: max1363: convert probe to full device-managed
      iio: adc: rn5t618-adc: use devm_iio_map_array_register() function
      iio: adc: berlin2-adc: convert probe to device-managed only
      iio: adc: Kconfig: add COMPILE_TEST dep for berlin2-adc
      iio: adc: ad7291: convert probe to device-managed only
      iio: triggered-buffer: extend support to configure output buffers

Alon Mizrahi (1):
      habanalabs: generalize COMMS message sending procedure

Amelie Delaunay (3):
      phy: stm32: restore utmi switch on resume
      dt-bindings: phy: phy-stm32-usbphyc: add optional phy tuning properties
      phy: stm32: add phy tuning support

Andra Paraschiv (7):
      nitro_enclaves: Enable Arm64 support
      nitro_enclaves: Update documentation for Arm64 support
      nitro_enclaves: Add fix for the kernel-doc report
      nitro_enclaves: Update copyright statement to include 2021
      nitro_enclaves: Add fixes for checkpatch match open parenthesis reports
      nitro_enclaves: Add fixes for checkpatch spell check reports
      nitro_enclaves: Add fixes for checkpatch blank line reports

André Gustavo Nakagomi Lopez (1):
      iio: adc: lpc18xx_adc: Convert probe to device managed version

Andy Shevchenko (3):
      pvpanic: Keep single style across modules
      pvpanic: Fix typos in the comments
      pvpanic: Indentation fixes here and there

Antoniu Miclaus (2):
      iio: frequency: adrf6780: add support for ADRF6780
      dt-bindings: iio: frequency: add adrf6780 doc

Arnd Bergmann (1):
      iio: imx8qxp-adc: mark PM functions as __maybe_unused

Bharat Jauhari (1):
      habanalabs: bypass reset for continuous h/w error event

Billy Tsai (13):
      dt-bindings: iio: adc: Add ast2600-adc bindings
      iio: adc: aspeed: completes the bitfield declare.
      iio: adc: aspeed: Keep model data to driver data.
      iio: adc: aspeed: Restructure the model data
      iio: adc: aspeed: Add vref config function
      iio: adc: aspeed: Use model_data to set clk scaler.
      iio: adc: aspeed: Use devm_add_action_or_reset.
      iio: adc: aspeed: Support ast2600 adc.
      iio: adc: aspeed: Fix the calculate error of clock.
      iio: adc: aspeed: Add func to set sampling rate.
      iio: adc: aspeed: Add compensation phase.
      iio: adc: aspeed: Support battery sensing.
      iio: adc: aspeed: Get and set trimming data.

Brian Norris (1):
      coresight: cpu-debug: Control default behavior via Kconfig

Cai Huoqing (34):
      phy: broadcom: Kconfig: Add configuration menu for Broadcom phy drivers
      phy: qcom-qmp: Make use of the helper function devm_add_action_or_reset()
      phy: rockchip-inno-usb2: Make use of the helper function devm_add_action_or_reset()
      iio: ep93xx: Make use of the helper function devm_platform_ioremap_resource()
      iio: dac: stm32-dac: Make use of the helper function devm_platform_ioremap_resource()
      iio: adc: rockchip_saradc: Make use of the helper function devm_platform_ioremap_resource()
      iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC
      dt-bindings: iio: adc: Add binding documentation for NXP IMX8QXP ADC
      MAINTAINERS: Add the driver info of the NXP IMX8QXP
      iio: dac: ad8801: Make use of the helper function dev_err_probe()
      iio: dac: lpc18xx_dac: Make use of the helper function dev_err_probe()
      iio: dac: ltc1660: Make use of the helper function dev_err_probe()
      iio: dac: ds4424: Make use of the helper function dev_err_probe()
      iio: dac: max5821: Make use of the helper function dev_err_probe()
      iio: dac: mcp4922: Make use of the helper function dev_err_probe()
      iio: dac: stm32-dac: Make use of the helper function dev_err_probe()
      iio: dac: ti-dac7311: Make use of the helper function dev_err_probe()
      iio: st_sensors: Make use of the helper function dev_err_probe()
      iio: st_lsm9ds0: Make use of the helper function dev_err_probe()
      iio: health: afe4403: Make use of the helper function dev_err_probe()
      iio: health: afe4404: Make use of the helper function dev_err_probe()
      iio: light: cm36651: Make use of the helper function dev_err_probe()
      iio: light: noa1305: Make use of the helper function dev_err_probe()
      iio: adc: ab8500-gpadc: Make use of the helper function dev_err_probe()
      iio: adc: imx7d_adc: Make use of the helper function dev_err_probe()
      iio: adc: lpc18xx_adc: Make use of the helper function dev_err_probe()
      iio: adc: max1118: Make use of the helper function dev_err_probe()
      iio: adc: max1241: Make use of the helper function dev_err_probe()
      iio: adc: meson_saradc: Make use of the helper function dev_err_probe()
      iio: adc: qcom-pm8xxx-xoadc: Make use of the helper function dev_err_probe()
      iio: adc: rockchip_saradc: Make use of the helper function dev_err_probe()
      iio: adc: ti-ads7950: Make use of the helper function dev_err_probe()
      iio: light: cm3605: Make use of the helper function dev_err_probe()
      iio: light: gp2ap002: Make use of the helper function dev_err_probe()

Christophe JAILLET (9):
      misc: rtsx: Remove usage of the deprecated "pci-dma-compat.h" API
      char: xillybus: Remove usage of the deprecated 'pci-dma-compat.h' API
      char: xillybus: Remove usage of 'pci_unmap_single()'
      char: xillybus: Remove usage of remaining deprecated pci_ API
      char: xillybus: Simplify 'xillybus_init_endpoint()'
      misc: genwqe: Remove usage of the deprecated "pci-dma-compat.h" API
      tifm: Remove usage of the deprecated "pci-dma-compat.h" API
      mei: Remove usage of the deprecated "pci-dma-compat.h" API
      iio: adc: adc128s052: Simplify adc128_probe()

Colin Ian King (2):
      iio: adc: aspeed: Fix spelling mistake "battey" -> "battery"
      iio: buffer: Fix uninitialized variable ret

Dan Carpenter (2):
      iio: adc: max1027: fix error code in max1027_wait_eoc()
      phy: ti: gmii-sel: check of_get_address() for failure

Dani Liberman (3):
      habanalabs: fix race condition in multi CS completion
      habanalabs: fix NULL pointer dereference
      habanalabs: refactor fence handling in hl_cs_poll_fences

Daniel Palmer (2):
      iio: imu: inv_mpu6050: Mark acpi match table as maybe unused
      iio: accel: mma7660: Mark acpi match table as maybe unused

David Heidelberg (2):
      dt-bindings: iio: kionix,kxcjk1013: driver support interrupts
      dt-bindings: iio: magnetometer: asahi-kasei,ak8975 add vid reg

David Lechner (2):
      counter/counter-sysfs: use sysfs_emit everywhere
      counter: drop chrdev_lock

Dmitry Baryshkov (12):
      interconnect: icc-rpm: move bus clocks handling into qnoc_probe
      interconnect: sdm660: expand DEFINE_QNODE macros
      interconnect: sdm660: drop default/unused values
      interconnect: sdm660: merge common code into icc-rpm
      interconnect: icc-rpm: add support for QoS reg offset
      interconnect: msm8916: expand DEFINE_QNODE macros
      interconnect: msm8916: add support for AP-owned nodes
      interconnect: msm8939: expand DEFINE_QNODE macros
      interconnect: msm8939: add support for AP-owned nodes
      interconnect: qcs404: expand DEFINE_QNODE macros
      interconnect: qcom: drop DEFINE_QNODE macro
      phy: qcom-qmp: another fix for the sc8180x PCIe definition

Eddie James (9):
      fsi: occ: Force sequence numbering per OCC
      hwmon: (occ) Remove sequence numbering and checksum calculation
      fsi: occ: Use a large buffer for responses
      fsi: occ: Store the SBEFIFO FFDC in the user response buffer
      docs: ABI: testing: Document the OCC hwmon FFDC binary interface
      hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
      docs: ABI: testing: Document the SBEFIFO timeout interface
      fsi: sbefifo: Add sysfs file indicating a timeout error
      fsi: sbefifo: Use interruptible mutex locking

Eli Billauer (1):
      char: xillybus: Eliminate redundant wrappers to DMA related calls

Eugen Hristev (8):
      dt-bindings: iio: adc: at91-sama5d2: add compatible for sama7g5-adc
      iio: adc: at91-sama5d2_adc: initialize hardware after clock is started
      iio: adc: at91-sama5d2_adc: remove unused definition
      iio: adc: at91-sama5d2_adc: convert to platform specific data structures
      iio: adc: at91-sama5d2_adc: add support for separate end of conversion registers
      iio: adc: at91-sama5d2_adc: add helper for COR register
      iio: adc: at91-sama5d2_adc: add support for sama7g5 device
      iio: adc: at91-sama5d2_adc: update copyright and authors information

Fabio Aiuto (1):
      extcon: extcon-axp288: Use P-Unit semaphore lock for register accesses

Florian Boor (2):
      iio: adc: ad799x: Implement selecting external reference voltage input on AD7991, AD7995 and AD7999.
      dt-bindings: iio: ad779x: Add binding document

Georgi Djakov (1):
      Merge branch 'icc-rpm' into icc-next

Greg Kroah-Hartman (15):
      Merge 5.15-rc3 into char-misc next
      Merge 5.15-rc4 into char-misc-next
      Merge 5.15-rc6 into char-misc-next
      Merge tag 'counter-for-5.16a-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'misc-habanalabs-next-2021-10-18' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-next
      Merge tag 'iio-for-5.16a-split-take4' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'fsi-for-v5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi into char-misc-next
      Merge tag 'icc-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'iio-fixes-for-5.16a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'iio-for-5.16b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'soundwire-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-next
      dma-buf: move dma-buf symbols into the DMA_BUF module namespace
      Merge tag 'extcon-next-for-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge tag 'phy-for-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next
      Merge tag 'coresight-next-v5.16.v3' of gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux into char-misc-next

Jacopo Mondi (4):
      dt-bindings: iio: chemical: Document senseair,sunrise CO2 sensor
      iio: ABI: docs: Document Senseair Sunrise ABI
      iio: chemical: Add Senseair Sunrise 006-0-007 driver
      iio: ABI: Document in_concentration_co2_scale

James Clark (1):
      coresight: Don't immediately close events that are run on invalid CPU/sink combos

Jeya R (2):
      misc: fastrpc: Update number of max fastrpc sessions
      misc: fastrpc: copy to user only for non-DMA-BUF heap buffers

Johan Hovold (7):
      ipack: ipoctal: rename tty-driver pointer
      comedi: vmk80xx: fix transfer-buffer overflows
      comedi: vmk80xx: fix bulk-buffer overflow
      comedi: vmk80xx: fix bulk and interrupt message timeouts
      most: fix control-message timeouts
      comedi: ni_usb6501: fix NULL-deref in command paths
      comedi: dt9812: fix DMA buffers on stack

Johan Jonker (1):
      dt-bindings: phy: rockchip: remove usb-phy fallback string for rk3066a/rk3188

Jonathan Cameron (6):
      counter: microchip-tcb-capture: Tidy up a false kernel-doc /** marking.
      iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()
      iio: adc: ti-adc108s102: Fix alignment of buffer pushed to iio buffers.
      iio: gyro: mpu3050: Fix alignment and size issues with buffers.
      iio: imu: adis16400: Fix buffer alignment requirements.
      iio: accel: sca3000: Use sign_extend32() instead of opencoding sign extension.

Kees Cook (2):
      selftests/lkdtm: Add way to repeat a test
      lkdtm/bugs: Check that a per-task stack canary exists

Krzysztof Kozlowski (3):
      phy: samsung: unify naming and describe driver in KConfig
      interconnect: samsung: describe drivers in KConfig
      iio: adc: exynos: describe drivers in KConfig

Lars-Peter Clausen (2):
      iio: kfifo-buffer: Add output buffer support
      iio: xilinx-xadc: Remove `irq` field from state struct

Len Baker (2):
      tifm: Prefer struct_size over open coded arithmetic
      drivers/iio: Remove all strcpy() uses

Leo Yan (5):
      coresight: tmc-etr: Add barrier after updating AUX ring buffer
      coresight: tmc-etf: Add comment for store ordering
      coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
      coresight: Update comments for removing cs_etm_find_snapshot()
      coresight: tmc-etr: Speed up for bounce buffer in flat mode

Liam Beguin (5):
      iio: adc: ad7949: define and use bitfield names
      iio: adc: ad7949: enable use with non 14/16-bit controllers
      iio: adc: ad7949: add vref selection support
      dt-bindings: iio: adc: ad7949: update voltage reference bindings
      iio: adc: ad7949: use devm managed functions

Linus Walleij (2):
      extcon: usb-gpio: Use the right includes
      extcon: max3355: Drop unused include

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: move max_fifo_size in st_lsm6dsx_fifo_ops

Lucas Stankus (2):
      dt-bindings: iio: accel: Add binding documentation for ADXL313
      iio: accel: Add driver support for ADXL313

Lukas Bulwahn (1):
      iio: gyro: remove dead config dependencies on INPUT_MPU3050

Manivannan Sadhasivam (1):
      MAINTAINERS: Update the entry for MHI bus

Mark Brown (1):
      iio: st_pressure_spi: Add missing entries SPI to device ID table

Matt Ranostay (1):
      iio: magnetometer: ak8975: add AK09116 support

Mauro Carvalho Chehab (4):
      misc: hisi_hikey_usb: change the DT schema
      ABI: sysfs-bus-soundwire-master: use wildcards on What definitions
      ABI: sysfs-bus-soundwire-slave: use wildcards on What definitions
      phy: HiSilicon: Add driver for Kirin 970 PCIe PHY

Mihail Chindris (4):
      drivers: iio: dac: ad5766: Fix dt property name
      Documentation:devicetree:bindings:iio:dac: Fix val
      iio: Add output buffer support
      drivers:iio:dac:ad5766.c: Add trigger buffer

Miquel Raynal (16):
      iio: adc: max1027: Fix style
      iio: adc: max1027: Drop extra warning message
      iio: adc: max1027: Drop useless debug messages
      iio: adc: max1027: Minimize the number of converted channels
      iio: adc: max1027: Rename a helper
      iio: adc: max1027: Create a helper to enable/disable the cnvst trigger
      iio: adc: max1027: Simplify the _set_trigger_state() helper
      iio: adc: max1027: Ensure a default cnvst trigger configuration
      iio: adc: max1027: Create a helper to configure the channels to scan
      iio: adc: max1027: Prevent single channel accesses during buffer reads
      iio: adc: max1027: Separate the IRQ handler from the read logic
      iio: adc: max1027: Introduce an end of conversion helper
      iio: adc: max1027: Stop requesting a threaded IRQ
      iio: adc: max1027: Use the EOC IRQ when populated for single reads
      iio: adc: max1027: Allow all kind of triggers to be used
      iio: adc: max1027: Don't reject external triggers when there is no IRQ

Moti Haimovski (1):
      habanalabs: initialize hpriv fields before adding new node

Nathan Chancellor (1):
      iio: frequency: adrf6780: Fix adrf6780_spi_{read,write}()

Navin Sankar Velliangiri (2):
      iio: temperature: Add MAX31865 RTD Support
      dt-bindings: iio: temperature: add MAXIM max31865 support

Nikita Travkin (4):
      dt-bindings: vendor-prefixes: Document liteon vendor prefix
      dt-bindings: iio: light: Document ltr501 light sensor bindings
      iio: light: ltr501: Add rudimentary regulator support
      iio: light: ltr501: Add of_device_id table

Nuno Sá (7):
      iio: ad5770r: make devicetree property reading consistent
      iio: ltc2983: add support for optional reset gpio
      iio: ltc2983: fail probe if no channels are given
      iio: adis: do not disabe IRQs in 'adis_init()'
      iio: adis: handle devices that cannot unmask the drdy pin
      iio: adis16475: make use of the new unmasked_drdy flag
      iio: adis16460: make use of the new unmasked_drdy flag

Oded Gabbay (7):
      habanalabs: add kernel-doc style comments
      habanalabs: define soft-reset as inference op
      habanalabs: refactor reset log message
      habanalabs: prevent race between fd close/open
      habanalabs: update firmware files
      habanalabs: use only u32
      habanalabs: define uAPI to export FD for DMA-BUF

Ofir Bitton (3):
      habanalabs: add debugfs node for configuring CS timeout
      habanalabs: remove redundant cs validity checks
      habanalabs: add support for a long interrupt target value

Oleksij Rempel (1):
      iio: adc: tsc2046: fix scan interval warning

Olivier Moysan (7):
      dt-bindings: iio: stm32-adc: add generic channel binding
      dt-bindings: iio: stm32-adc: add nvmem support for vrefint internal channel
      iio: adc: stm32-adc: split channel init into several routines
      iio: adc: stm32-adc: add support of generic channels binding
      iio: adc: stm32-adc: add support of internal channels
      iio: adc: stm32-adc: add vrefint calibration support
      iio: adc: stm32-adc: use generic binding for sample-time

Omer Shpigelman (1):
      habanalabs: context cleanup cosmetics

Pavel Begunkov (1):
      /dev/mem: nowait zero/null ops

Pekka Korpinen (1):
      iio: dac: ad5446: Fix ad5622_write() return value

Peter Rosin (2):
      dt-bindings: iio: io-channel-mux: add optional #io-channel-cells
      dt-bindings: iio: io-channel-mux: allow duplicate channel, labels

Philip K. Gisslow (1):
      scripts/tags.sh: Fix obsolete parameter for ctags

Puranjay Mohan (4):
      dt-bindings: iio: accel: Add DT binding doc for ADXL355
      iio: accel: Add driver support for ADXL355
      iio: accel: adxl355: use if(ret) in place of ret < 0
      iio: accel: adxl355: Add triggered buffer support

Rafał Miłecki (1):
      dt-bindings: phy: brcm,ns-usb2-phy: bind just a PHY block

Rajaravi Krishna Katta (3):
      habanalabs: create static map of f/w hwmon enums
      habanalabs: enable power info via HWMON framework
      habanalabs: Unify frequency set/get functionality

Randy Dunlap (2):
      counter: fix docum. build problems after filename change
      iio: chemical: SENSEAIR_SUNRISE_CO2 depends on I2C

Roan van Dijk (5):
      dt-bindings: iio: chemical: sensirion,scd4x: Add yaml description
      MAINTAINERS: Add myself as maintainer of the scd4x driver
      drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor
      iio: documentation: Document scd4x calibration use
      iio: chemical: scd4x: Add a scale for the co2 concentration reading

Sandeep Maheswaram (1):
      phy: qcom-snps: Correct the FSEL_MASK

Sean Nyekjaer (2):
      iio: accel: fxls8962af: add threshold event handling
      iio: accel: fxls8962af: add wake on event

Sebastian Andrzej Siewior (1):
      samples/kfifo: Rename read_lock/write_lock

Shawn Guo (8):
      dt-bindings: phy: qcom,qmp: Update maintainer email
      dt-bindings: phy: qcom,qusb2: Add compatible for QCM2290
      phy: qcom-qusb2: Add compatible for QCM2290
      dt-bindings: phy: qcom,qusb2: Add missing vdd-supply
      phy: qcom-qusb2: Add missing vdd supply
      dt-bindings: phy: qcom,qmp: Add QCM2290 USB3 PHY
      phy: qcom-qmp: Add QCM2290 USB3 PHY support
      dt-bindings: phy: qcom,qmp: IPQ6018 and IPQ8074 PCIe PHY require no supply

Shuo Liu (2):
      virt: acrn: Introduce interfaces for MMIO device passthrough
      virt: acrn: Introduce interfaces for virtual device creating/destroying

Srinivas Kandagatla (6):
      soundwire: debugfs: use controller id and link_id for debugfs
      nvmem: core: rework nvmem cell instance creation
      nvmem: core: add nvmem cell post processing callback
      nvmem: imx-ocotp: add support for post processing
      soundwire: bus: stop dereferencing invalid slave pointer
      soundwire: qcom: add debugfs entry for soundwire register dump

Stephen Rothwell (1):
      fix for "dma-buf: move dma-buf symbols into the DMA_BUF module namespace"

Suzuki K Poulose (28):
      arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
      arm64: errata: Add detection for TRBE overwrite in FILL mode
      arm64: errata: Add workaround for TSB flush failures
      arm64: errata: Add detection for TRBE write to out-of-range
      coresight: etm4x: Save restore TRFCR_EL1
      coresight: etm4x: Use Trace Filtering controls dynamically
      coresight: etm-pmu: Ensure the AUX handle is valid
      coresight: trbe: Ensure the format flag is always set
      coresight: trbe: Drop duplicate TRUNCATE flags
      coresight: trbe: Unify the enabling sequence
      coresight: trbe: irq handler: Do not disable TRBE if no action is needed
      coresight: trbe: Fix handling of spurious interrupts
      coresight: trbe: Do not truncate buffer on IRQ
      coresight: trbe: End the AUX handle on truncation
      coresight: trbe: Prohibit trace before disabling TRBE
      coresight: trbe: Fix incorrect access of the sink specific data
      coresight: trbe: Defer the probe on offline CPUs
      coresight: trbe: Add a helper to calculate the trace generated
      coresight: trbe: Add a helper to pad a given buffer area
      coresight: trbe: Decouple buffer base from the hardware base
      coresight: trbe: Allow driver to choose a different alignment
      coresight: trbe: Add infrastructure for Errata handling
      coresight: trbe: Workaround TRBE errata overwrite in FILL mode
      coresight: trbe: Add a helper to determine the minimum buffer size
      coresight: trbe: Make sure we have enough space
      coresight: trbe: Work around write to out of range
      arm64: errata: Enable workaround for TRBE overwrite in FILL mode
      arm64: errata: Enable TRBE workaround for write to out-of-range address

Swapnil Jakhade (4):
      phy: cadence-torrent: Migrate to clk_hw based registration and OF APIs
      dt-bindings: phy: cadence-torrent: Add clock IDs for derived and received refclk
      phy: cadence-torrent: Model reference clock driver as a clock to enable derived refclk
      phy: cadence-torrent: Add support to output received reference clock

Tang Bin (1):
      iio: adc: twl6030-gpadc: Use the defined variable to clean code

Tanmay Jagdale (2):
      dt-bindings: coresight: Add burst size for TMC
      coresight: tmc: Configure AXI write burst size

Tao Zhang (2):
      coresight: cti: Correct the parameter for pm_runtime_put
      coresight: etm4x: Add ETM PID for Kryo-5XX

Teng Qi (1):
      iio: imu: st_lsm6dsx: Avoid potential array overflow in st_lsm6dsx_set_odr()

Todd Kjos (1):
      binder: don't detect sender/target during buffer cleanup

Tomer Tayar (1):
      habanalabs: add support for dma-buf exporter

Uwe Kleine-König (15):
      misc: lis3lv02d: Make lis3lv02d_remove_fs() return void
      misc: ad525x_dpot: Make ad_dpot_remove() return void
      iio: accel: bma400: Make bma400_remove() return void
      iio: accel: bmc150: Make bmc150_accel_core_remove() return void
      iio: accel: bmi088: Make bmi088_accel_core_remove() return void
      iio: accel: kxsd9: Make kxsd9_common_remove() return void
      iio: accel: mma7455: Make mma7455_core_remove() return void
      iio: dac: ad5380: Make ad5380_remove() return void
      iio: dac: ad5446: Make ad5446_remove() return void
      iio: dac: ad5592r: Make ad5592r_remove() return void
      iio: dac: ad5686: Make ad5686_remove() return void
      iio: health: afe4403: Don't return an error in .remove()
      iio: magn: hmc5843: Make hmc5843_common_remove() return void
      iio: potentiometer: max5487: Don't return an error in .remove()
      iio: pressure: ms5611: Make ms5611_remove() return void

Vegard Nossum (1):
      habanalabs: select CRC32

Vincent Whitchurch (3):
      mux: add support for delay after muxing
      dt-bindings: iio: io-channel-mux: Add property for settle time
      iio: multiplexer: iio-mux: Support settle-time-us property

Vladimir Zapolskiy (1):
      phy: qcom-qusb2: Fix a memory leak on probe

Wan Jiabing (1):
      phy: hisilicon: Add of_node_put() in phy-hisi-inno-usb2

William Breathitt Gray (17):
      counter: stm32-lptimer-cnt: Provide defines for clock polarities
      counter: stm32-timer-cnt: Provide defines for slave mode selection
      counter: Internalize sysfs interface code
      counter: Update counter.h comments to reflect sysfs internalization
      docs: counter: Update to reflect sysfs internalization
      counter: Move counter enums to uapi header
      counter: Add character device interface
      docs: counter: Document character device interface
      tools/counter: Create Counter tools
      counter: Implement signalZ_action_component_id sysfs attribute
      counter: Implement *_component_id sysfs attributes
      counter: Implement events_queue_size sysfs attribute
      counter: 104-quad-8: Replace mutex with spinlock
      counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8
      docs: counter: Include counter-chrdev kernel-doc to generic-counter.rst
      counter: Cleanup lingering atomic.h includes
      counter: Fix use-after-free race condition for events_queue_size write

Yang Yingliang (8):
      iio: buffer: check return value of kstrdup_const()
      iio: buffer: Fix memory leak in __iio_buffer_alloc_sysfs_and_mask()
      iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
      iio: buffer: Fix memory leak in iio_buffer_register_legacy_sysfs_groups()
      iio: core: check return value when calling dev_set_name()
      iio: core: fix double free in iio_device_unregister_sysfs()
      iio: buffer: Fix memory leak in iio_buffers_alloc_sysfs_and_mask()
      phy: Sparx5 Eth SerDes: Fix return value check in sparx5_serdes_probe()

Yassine Oudjana (3):
      extcon: usbc-tusb320: Add support for mode setting and reset
      extcon: usbc-tusb320: Add support for TUSB320L
      dt-bindings: extcon: usbc-tusb320: Add TUSB320L compatible string

Ye Guojin (1):
      misc: enclosure: replace snprintf in show functions with sysfs_emit

Yuri Nudelman (3):
      habanalabs: fix debugfs device memory MMU VA translation
      habanalabs: take timestamp on wait for interrupt
      habanalabs: simplify wait for interrupt with timestamp flow

Ziyang Xuan (1):
      char: xillybus: fix msg_ep UAF in xillyusb_probe()

 .../ABI/testing/debugfs-driver-habanalabs          |    6 +
 Documentation/ABI/testing/sysfs-bus-counter        |   38 +-
 .../ABI/testing/sysfs-bus-fsi-devices-sbefifo      |   10 +
 Documentation/ABI/testing/sysfs-bus-iio            |   42 +
 .../ABI/testing/sysfs-bus-iio-chemical-sunrise-co2 |   38 +
 Documentation/ABI/testing/sysfs-bus-iio-scd30      |   34 -
 .../ABI/testing/sysfs-bus-iio-temperature-max31865 |   20 +
 .../testing/sysfs-bus-platform-devices-occ-hwmon   |   13 +
 .../ABI/testing/sysfs-bus-soundwire-master         |   20 +-
 .../ABI/testing/sysfs-bus-soundwire-slave          |   62 +-
 Documentation/arm64/silicon-errata.rst             |   12 +
 .../devicetree/bindings/arm/coresight.txt          |    5 +
 .../bindings/extcon/extcon-usbc-tusb320.yaml       |    4 +-
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml |   86 +
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml |   88 +
 .../bindings/iio/accel/kionix,kxcjk1013.yaml       |    3 +
 .../devicetree/bindings/iio/adc/adi,ad7949.yaml    |   51 +-
 .../devicetree/bindings/iio/adc/adi,ad799x.yaml    |   73 +
 .../bindings/iio/adc/aspeed,ast2600-adc.yaml       |  100 +
 .../bindings/iio/adc/atmel,sama5d2-adc.yaml        |    1 +
 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml          |   78 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |  108 +-
 .../bindings/iio/chemical/senseair,sunrise.yaml    |   55 +
 .../bindings/iio/chemical/sensirion,scd4x.yaml     |   46 +
 .../devicetree/bindings/iio/dac/adi,ad5766.yaml    |    2 +-
 .../bindings/iio/frequency/adi,adrf6780.yaml       |  131 ++
 .../bindings/iio/light/liteon,ltr501.yaml          |   51 +
 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |    7 +
 .../bindings/iio/multiplexer/io-channel-mux.yaml   |   13 +-
 .../bindings/iio/temperature/maxim,max31865.yaml   |   52 +
 .../devicetree/bindings/phy/bcm-ns-usb2-phy.yaml   |   25 +-
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |  129 ++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   84 +-
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |    7 +
 .../devicetree/bindings/phy/rockchip-usb-phy.yaml  |   11 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    4 +
 Documentation/driver-api/driver-model/devres.rst   |    1 +
 Documentation/driver-api/generic-counter.rst       |  363 +++-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 Documentation/virt/ne_overview.rst                 |   21 +-
 MAINTAINERS                                        |   42 +-
 arch/arm64/Kconfig                                 |  111 ++
 arch/arm64/include/asm/barrier.h                   |   16 +-
 arch/arm64/include/asm/cputype.h                   |    4 +
 arch/arm64/kernel/cpu_errata.c                     |   64 +
 arch/arm64/tools/cpucaps                           |    3 +
 drivers/android/binder.c                           |   14 +-
 drivers/char/mem.c                                 |    8 +-
 drivers/char/xillybus/xillybus.h                   |   31 +-
 drivers/char/xillybus/xillybus_core.c              |  131 +-
 drivers/char/xillybus/xillybus_of.c                |   86 +-
 drivers/char/xillybus/xillybus_pcie.c              |   99 +-
 drivers/char/xillybus/xillyusb.c                   |    1 +
 drivers/comedi/drivers/dt9812.c                    |  115 +-
 drivers/comedi/drivers/ni_usb6501.c                |   10 +
 drivers/comedi/drivers/vmk80xx.c                   |   28 +-
 drivers/counter/104-quad-8.c                       |  699 ++++---
 drivers/counter/Kconfig                            |    6 +-
 drivers/counter/Makefile                           |    1 +
 drivers/counter/counter-chrdev.c                   |  573 ++++++
 drivers/counter/counter-chrdev.h                   |   14 +
 drivers/counter/counter-core.c                     |  191 ++
 drivers/counter/counter-sysfs.c                    |  959 ++++++++++
 drivers/counter/counter-sysfs.h                    |   13 +
 drivers/counter/counter.c                          | 1496 ---------------
 drivers/counter/ftm-quaddec.c                      |   60 +-
 drivers/counter/intel-qep.c                        |  146 +-
 drivers/counter/interrupt-cnt.c                    |   62 +-
 drivers/counter/microchip-tcb-capture.c            |   93 +-
 drivers/counter/stm32-lptimer-cnt.c                |  212 +--
 drivers/counter/stm32-timer-cnt.c                  |  195 +-
 drivers/counter/ti-eqep.c                          |  180 +-
 drivers/dma-buf/dma-buf.c                          |   34 +-
 drivers/extcon/Kconfig                             |    2 +-
 drivers/extcon/extcon-axp288.c                     |   31 +-
 drivers/extcon/extcon-max3355.c                    |    1 -
 drivers/extcon/extcon-usb-gpio.c                   |    3 +-
 drivers/extcon/extcon-usbc-tusb320.c               |  163 +-
 drivers/fsi/fsi-occ.c                              |  218 ++-
 drivers/fsi/fsi-sbefifo.c                          |   28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    3 +
 drivers/gpu/drm/armada/armada_gem.c                |    2 +
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |    3 +
 drivers/gpu/drm/drm_gem_shmem_helper.c             |    2 +
 drivers/gpu/drm/drm_prime.c                        |    3 +
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |    3 +
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |    3 +
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |    3 +
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |    2 +
 drivers/gpu/drm/tegra/gem.c                        |    3 +
 drivers/gpu/drm/vmwgfx/ttm_object.c                |    3 +
 drivers/hwmon/occ/common.c                         |   30 +-
 drivers/hwmon/occ/common.h                         |    3 +-
 drivers/hwmon/occ/p8_i2c.c                         |   15 +-
 drivers/hwmon/occ/p9_sbe.c                         |   90 +-
 drivers/hwtracing/coresight/Kconfig                |   13 +
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |    2 +-
 drivers/hwtracing/coresight/coresight-cti-core.c   |    2 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |    5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   56 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  101 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |    9 +-
 .../coresight/coresight-self-hosted-trace.h        |   33 +
 drivers/hwtracing/coresight/coresight-tmc-core.c   |   21 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   10 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   52 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    6 +-
 drivers/hwtracing/coresight/coresight-trbe.c       |  534 +++++-
 drivers/iio/accel/Kconfig                          |   62 +
 drivers/iio/accel/Makefile                         |    6 +
 drivers/iio/accel/adxl313.h                        |   54 +
 drivers/iio/accel/adxl313_core.c                   |  332 ++++
 drivers/iio/accel/adxl313_i2c.c                    |   66 +
 drivers/iio/accel/adxl313_spi.c                    |   92 +
 drivers/iio/accel/adxl355.h                        |   21 +
 drivers/iio/accel/adxl355_core.c                   |  765 ++++++++
 drivers/iio/accel/adxl355_i2c.c                    |   62 +
 drivers/iio/accel/adxl355_spi.c                    |   65 +
 drivers/iio/accel/adxl372.c                        |    1 +
 drivers/iio/accel/bma400.h                         |    2 +-
 drivers/iio/accel/bma400_core.c                    |    7 +-
 drivers/iio/accel/bma400_i2c.c                     |    4 +-
 drivers/iio/accel/bma400_spi.c                     |    4 +-
 drivers/iio/accel/bmc150-accel-core.c              |    5 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |    4 +-
 drivers/iio/accel/bmc150-accel-spi.c               |    4 +-
 drivers/iio/accel/bmc150-accel.h                   |    2 +-
 drivers/iio/accel/bmi088-accel-core.c              |    4 +-
 drivers/iio/accel/bmi088-accel-spi.c               |    4 +-
 drivers/iio/accel/bmi088-accel.h                   |    2 +-
 drivers/iio/accel/fxls8962af-core.c                |  347 +++-
 drivers/iio/accel/kxsd9-i2c.c                      |    4 +-
 drivers/iio/accel/kxsd9-spi.c                      |    4 +-
 drivers/iio/accel/kxsd9.c                          |    4 +-
 drivers/iio/accel/kxsd9.h                          |    2 +-
 drivers/iio/accel/mma7455.h                        |    2 +-
 drivers/iio/accel/mma7455_core.c                   |    4 +-
 drivers/iio/accel/mma7455_i2c.c                    |    4 +-
 drivers/iio/accel/mma7455_spi.c                    |    4 +-
 drivers/iio/accel/mma7660.c                        |    2 +-
 drivers/iio/accel/sca3000.c                        |    3 +-
 drivers/iio/accel/st_accel_core.c                  |   31 +-
 drivers/iio/accel/st_accel_i2c.c                   |   23 +-
 drivers/iio/accel/st_accel_spi.c                   |   23 +-
 drivers/iio/adc/Kconfig                            |   18 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ab8500-gpadc.c                     |   22 +-
 drivers/iio/adc/ad7291.c                           |   70 +-
 drivers/iio/adc/ad7949.c                           |  254 ++-
 drivers/iio/adc/ad799x.c                           |   68 +-
 drivers/iio/adc/aspeed_adc.c                       |  598 +++++-
 drivers/iio/adc/at91-sama5d2_adc.c                 |  598 ++++--
 drivers/iio/adc/axp288_adc.c                       |   28 +-
 drivers/iio/adc/berlin2-adc.c                      |   34 +-
 drivers/iio/adc/da9150-gpadc.c                     |   27 +-
 drivers/iio/adc/ep93xx_adc.c                       |    4 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |   55 +-
 drivers/iio/adc/imx7d_adc.c                        |   18 +-
 drivers/iio/adc/imx8qxp-adc.c                      |  494 +++++
 drivers/iio/adc/intel_mrfld_adc.c                  |   24 +-
 drivers/iio/adc/lp8788_adc.c                       |   31 +-
 drivers/iio/adc/lpc18xx_adc.c                      |   75 +-
 drivers/iio/adc/max1027.c                          |  278 ++-
 drivers/iio/adc/max1118.c                          |    7 +-
 drivers/iio/adc/max1241.c                          |   17 +-
 drivers/iio/adc/max1363.c                          |   82 +-
 drivers/iio/adc/meson_saradc.c                     |   39 +-
 drivers/iio/adc/nau7802.c                          |   50 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |    9 +-
 drivers/iio/adc/rn5t618-adc.c                      |   13 +-
 drivers/iio/adc/rockchip_saradc.c                  |   31 +-
 drivers/iio/adc/stm32-adc-core.c                   |    1 +
 drivers/iio/adc/stm32-adc-core.h                   |   10 +
 drivers/iio/adc/stm32-adc.c                        |  422 ++++-
 drivers/iio/adc/ti-adc108s102.c                    |   11 +-
 drivers/iio/adc/ti-adc128s052.c                    |   33 +-
 drivers/iio/adc/ti-ads7950.c                       |    4 +-
 drivers/iio/adc/ti-ads8344.c                       |   27 +-
 drivers/iio/adc/ti-tsc2046.c                       |    2 +-
 drivers/iio/adc/twl6030-gpadc.c                    |    6 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |    5 +-
 drivers/iio/adc/xilinx-xadc.h                      |    1 -
 drivers/iio/buffer/industrialio-triggered-buffer.c |    8 +-
 drivers/iio/buffer/kfifo_buf.c                     |   50 +
 drivers/iio/chemical/Kconfig                       |   24 +
 drivers/iio/chemical/Makefile                      |    2 +
 drivers/iio/chemical/scd4x.c                       |  696 +++++++
 drivers/iio/chemical/sunrise_co2.c                 |  537 ++++++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |    5 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   48 +-
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |    1 -
 drivers/iio/common/st_sensors/st_sensors_spi.c     |    1 -
 drivers/iio/common/st_sensors/st_sensors_trigger.c |   53 +-
 drivers/iio/dac/ad5064.c                           |   49 +-
 drivers/iio/dac/ad5380.c                           |   15 +-
 drivers/iio/dac/ad5446.c                           |   21 +-
 drivers/iio/dac/ad5592r-base.c                     |    4 +-
 drivers/iio/dac/ad5592r-base.h                     |    2 +-
 drivers/iio/dac/ad5592r.c                          |    4 +-
 drivers/iio/dac/ad5593r.c                          |    4 +-
 drivers/iio/dac/ad5686-spi.c                       |    4 +-
 drivers/iio/dac/ad5686.c                           |    4 +-
 drivers/iio/dac/ad5686.h                           |    2 +-
 drivers/iio/dac/ad5696-i2c.c                       |    4 +-
 drivers/iio/dac/ad5766.c                           |   48 +-
 drivers/iio/dac/ad5770r.c                          |    2 +-
 drivers/iio/dac/ad7303.c                           |   47 +-
 drivers/iio/dac/ad8801.c                           |   11 +-
 drivers/iio/dac/ds4424.c                           |    9 +-
 drivers/iio/dac/lpc18xx_dac.c                      |   14 +-
 drivers/iio/dac/ltc1660.c                          |    7 +-
 drivers/iio/dac/max5821.c                          |    9 +-
 drivers/iio/dac/mcp4922.c                          |    7 +-
 drivers/iio/dac/stm32-dac-core.c                   |   18 +-
 drivers/iio/dac/ti-dac7311.c                       |    7 +-
 drivers/iio/frequency/Kconfig                      |   12 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adrf6780.c                   |  527 ++++++
 drivers/iio/gyro/Kconfig                           |    1 -
 drivers/iio/gyro/adis16080.c                       |   11 +-
 drivers/iio/gyro/mpu3050-core.c                    |   24 +-
 drivers/iio/gyro/st_gyro_core.c                    |   27 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |   23 +-
 drivers/iio/gyro/st_gyro_spi.c                     |   23 +-
 drivers/iio/health/afe4403.c                       |   14 +-
 drivers/iio/health/afe4404.c                       |    8 +-
 drivers/iio/iio_core.h                             |    4 +
 drivers/iio/imu/adis.c                             |   17 +-
 drivers/iio/imu/adis16400.c                        |   20 +-
 drivers/iio/imu/adis16460.c                        |   18 +-
 drivers/iio/imu/adis16475.c                        |   19 +-
 drivers/iio/imu/adis_trigger.c                     |    4 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         |   36 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   22 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h            |    1 -
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |   29 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |    6 -
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |    6 -
 drivers/iio/industrialio-buffer.c                  |  201 +-
 drivers/iio/industrialio-core.c                    |   10 +-
 drivers/iio/inkern.c                               |   17 +
 drivers/iio/light/cm3605.c                         |   29 +-
 drivers/iio/light/cm36651.c                        |    7 +-
 drivers/iio/light/gp2ap002.c                       |   24 +-
 drivers/iio/light/ltr501.c                         |   37 +
 drivers/iio/light/max44000.c                       |   17 +-
 drivers/iio/light/noa1305.c                        |    7 +-
 drivers/iio/magnetometer/Kconfig                   |    2 +-
 drivers/iio/magnetometer/ak8975.c                  |   35 +
 drivers/iio/magnetometer/hmc5843.h                 |    2 +-
 drivers/iio/magnetometer/hmc5843_core.c            |    4 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |    4 +-
 drivers/iio/magnetometer/hmc5843_spi.c             |    4 +-
 drivers/iio/magnetometer/st_magn_core.c            |   29 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |   23 +-
 drivers/iio/magnetometer/st_magn_spi.c             |   23 +-
 drivers/iio/multiplexer/iio-mux.c                  |    7 +-
 drivers/iio/potentiometer/max5487.c                |    7 +-
 drivers/iio/pressure/ms5611.h                      |    2 +-
 drivers/iio/pressure/ms5611_core.c                 |    4 +-
 drivers/iio/pressure/ms5611_i2c.c                  |    4 +-
 drivers/iio/pressure/ms5611_spi.c                  |    4 +-
 drivers/iio/pressure/st_pressure_core.c            |   27 +-
 drivers/iio/pressure/st_pressure_i2c.c             |   23 +-
 drivers/iio/pressure/st_pressure_spi.c             |   27 +-
 drivers/iio/temperature/Kconfig                    |   10 +
 drivers/iio/temperature/Makefile                   |    1 +
 drivers/iio/temperature/ltc2983.c                  |   16 +
 drivers/iio/temperature/max31865.c                 |  349 ++++
 drivers/infiniband/core/umem_dmabuf.c              |    3 +
 drivers/interconnect/qcom/icc-rpm.c                |  263 ++-
 drivers/interconnect/qcom/icc-rpm.h                |   56 +-
 drivers/interconnect/qcom/msm8916.c                | 1214 +++++++++++-
 drivers/interconnect/qcom/msm8939.c                | 1283 ++++++++++++-
 drivers/interconnect/qcom/qcs404.c                 |  967 +++++++++-
 drivers/interconnect/qcom/sdm660.c                 | 1940 ++++++++++++++------
 drivers/interconnect/samsung/Kconfig               |    6 +-
 drivers/ipack/devices/ipoctal.c                    |   48 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |    1 +
 .../media/common/videobuf2/videobuf2-dma-contig.c  |    1 +
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  |    1 +
 drivers/media/common/videobuf2/videobuf2-vmalloc.c |    1 +
 drivers/misc/ad525x_dpot-i2c.c                     |    3 +-
 drivers/misc/ad525x_dpot-spi.c                     |    3 +-
 drivers/misc/ad525x_dpot.c                         |    4 +-
 drivers/misc/ad525x_dpot.h                         |    2 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |    2 +-
 drivers/misc/enclosure.c                           |   16 +-
 drivers/misc/fastrpc.c                             |   21 +-
 drivers/misc/genwqe/card_utils.c                   |   10 +-
 drivers/misc/habanalabs/Kconfig                    |    2 +
 drivers/misc/habanalabs/common/Makefile            |    2 +-
 .../misc/habanalabs/common/command_submission.c    |  105 +-
 drivers/misc/habanalabs/common/context.c           |    8 +-
 drivers/misc/habanalabs/common/debugfs.c           |   51 +
 drivers/misc/habanalabs/common/device.c            |  159 +-
 drivers/misc/habanalabs/common/firmware_if.c       |   28 +-
 drivers/misc/habanalabs/common/habanalabs.h        |   64 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   24 +-
 .../{gaudi/gaudi_hwmgr.c => common/hwmgr.c}        |   38 +-
 drivers/misc/habanalabs/common/hwmon.c             |  194 +-
 drivers/misc/habanalabs/common/irq.c               |    5 +-
 drivers/misc/habanalabs/common/memory.c            |  515 +++++-
 drivers/misc/habanalabs/common/mmu/mmu.c           |   30 +-
 drivers/misc/habanalabs/common/sysfs.c             |    6 +-
 drivers/misc/habanalabs/gaudi/Makefile             |    2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |   22 +-
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    4 -
 drivers/misc/habanalabs/goya/goya.c                |   13 +-
 drivers/misc/habanalabs/goya/goyaP.h               |    1 -
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |   31 -
 drivers/misc/habanalabs/include/common/cpucp_if.h  |   22 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |  189 +-
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h    |   10 +-
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |    1 +
 drivers/misc/hisi_hikey_usb.c                      |  119 +-
 drivers/misc/lis3lv02d/lis3lv02d.c                 |    3 +-
 drivers/misc/lis3lv02d/lis3lv02d.h                 |    2 +-
 drivers/misc/lis3lv02d/lis3lv02d_spi.c             |    4 +-
 drivers/misc/lkdtm/bugs.c                          |   77 +
 drivers/misc/lkdtm/core.c                          |    1 +
 drivers/misc/lkdtm/lkdtm.h                         |    1 +
 drivers/misc/mei/pci-txe.c                         |    4 +-
 drivers/misc/pvpanic/pvpanic-mmio.c                |    9 +-
 drivers/misc/pvpanic/pvpanic-pci.c                 |   26 +-
 drivers/misc/pvpanic/pvpanic.c                     |   16 +-
 drivers/misc/tifm_7xx1.c                           |    2 +-
 drivers/misc/tifm_core.c                           |    8 +-
 drivers/most/most_usb.c                            |    5 +-
 drivers/mux/core.c                                 |   38 +-
 drivers/nvmem/core.c                               |  174 +-
 drivers/nvmem/imx-ocotp.c                          |   25 +
 drivers/phy/broadcom/Kconfig                       |    4 +
 drivers/phy/cadence/phy-cadence-torrent.c          |  316 +++-
 drivers/phy/hisilicon/Kconfig                      |   10 +
 drivers/phy/hisilicon/Makefile                     |    1 +
 drivers/phy/hisilicon/phy-hi3670-pcie.c            |  845 +++++++++
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |   10 +-
 drivers/phy/microchip/sparx5_serdes.c              |    4 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  157 +-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |    2 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   21 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |    2 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |   11 +-
 drivers/phy/samsung/Kconfig                        |   16 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |  203 ++
 drivers/phy/ti/phy-gmii-sel.c                      |    2 +
 drivers/platform/x86/hp_accel.c                    |    3 +-
 drivers/soundwire/bus.c                            |    2 +-
 drivers/soundwire/debugfs.c                        |    2 +-
 drivers/soundwire/qcom.c                           |   27 +
 drivers/staging/iio/cdc/ad7746.c                   |    4 +-
 drivers/staging/iio/frequency/ad9832.c             |   82 +-
 drivers/staging/media/tegra-vde/dmabuf-cache.c     |    3 +
 drivers/tee/tee_shm.c                              |    3 +
 drivers/virt/acrn/hsm.c                            |   49 +
 drivers/virt/acrn/hypercall.h                      |   52 +
 drivers/virt/nitro_enclaves/Kconfig                |    8 +-
 drivers/virt/nitro_enclaves/ne_misc_dev.c          |   17 +-
 drivers/virt/nitro_enclaves/ne_pci_dev.c           |    2 +-
 drivers/virt/nitro_enclaves/ne_pci_dev.h           |    8 +-
 drivers/virtio/virtio_dma_buf.c                    |    1 +
 drivers/xen/gntdev-dmabuf.c                        |    3 +
 include/dt-bindings/phy/phy-cadence.h              |    2 +
 include/linux/counter.h                            |  715 ++++----
 include/linux/counter_enum.h                       |   45 -
 include/linux/fsi-occ.h                            |    2 +
 include/linux/iio/buffer.h                         |   11 +
 include/linux/iio/buffer_impl.h                    |   11 +
 include/linux/iio/common/st_sensors.h              |   13 -
 include/linux/iio/driver.h                         |   14 +
 include/linux/iio/iio-opaque.h                     |    4 +
 include/linux/iio/imu/adis.h                       |    2 +
 include/linux/iio/triggered_buffer.h               |   11 +-
 include/linux/mfd/stm32-lptimer.h                  |    5 +
 include/linux/mfd/stm32-timers.h                   |    4 +
 include/linux/mux/consumer.h                       |   23 +-
 include/linux/mux/driver.h                         |    4 +
 include/linux/nvmem-provider.h                     |    5 +
 include/uapi/linux/acrn.h                          |   70 +
 include/uapi/linux/counter.h                       |  154 ++
 include/uapi/linux/nitro_enclaves.h                |   10 +-
 include/uapi/misc/habanalabs.h                     |   84 +-
 samples/kfifo/bytestream-example.c                 |   12 +-
 samples/kfifo/inttype-example.c                    |   12 +-
 samples/kfifo/record-example.c                     |   12 +-
 samples/nitro_enclaves/ne_ioctl_sample.c           |    7 +-
 samples/vfio-mdev/mbochs.c                         |    1 +
 scripts/tags.sh                                    |    6 +-
 tools/Makefile                                     |   13 +-
 tools/counter/Build                                |    1 +
 tools/counter/Makefile                             |   53 +
 tools/counter/counter_example.c                    |   92 +
 tools/testing/selftests/lkdtm/config               |    1 +
 tools/testing/selftests/lkdtm/run.sh               |   10 +-
 tools/testing/selftests/lkdtm/tests.txt            |    1 +
 398 files changed, 22333 insertions(+), 6906 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-occ-hwmon
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 drivers/counter/counter-core.c
 create mode 100644 drivers/counter/counter-sysfs.c
 create mode 100644 drivers/counter/counter-sysfs.h
 delete mode 100644 drivers/counter/counter.c
 create mode 100644 drivers/hwtracing/coresight/coresight-self-hosted-trace.h
 create mode 100644 drivers/iio/accel/adxl313.h
 create mode 100644 drivers/iio/accel/adxl313_core.c
 create mode 100644 drivers/iio/accel/adxl313_i2c.c
 create mode 100644 drivers/iio/accel/adxl313_spi.c
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c
 create mode 100644 drivers/iio/adc/imx8qxp-adc.c
 create mode 100644 drivers/iio/chemical/scd4x.c
 create mode 100644 drivers/iio/chemical/sunrise_co2.c
 create mode 100644 drivers/iio/frequency/adrf6780.c
 create mode 100644 drivers/iio/temperature/max31865.c
 rename drivers/misc/habanalabs/{gaudi/gaudi_hwmgr.c => common/hwmgr.c} (61%)
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-pcie.c
 delete mode 100644 include/linux/counter_enum.h
 create mode 100644 include/uapi/linux/counter.h
 create mode 100644 tools/counter/Build
 create mode 100644 tools/counter/Makefile
 create mode 100644 tools/counter/counter_example.c
