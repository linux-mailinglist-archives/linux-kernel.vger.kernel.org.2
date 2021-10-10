Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7104428288
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhJJQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 12:47:33 -0400
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:37198 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229689AbhJJQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 12:47:32 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A27B1837F24D;
        Sun, 10 Oct 2021 16:45:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 146F417276;
        Sun, 10 Oct 2021 16:45:31 +0000 (UTC)
Message-ID: <b04a10ea9682c51764053c1be73d4b3be59d1e7f.camel@perches.com>
Subject: Use of '%#02x' is almost always wrong
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>
Date:   Sun, 10 Oct 2021 09:45:30 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 146F417276
X-Spam-Status: No, score=-0.79
X-Stat-Signature: hcq179sc7trmtusdtnqfqs6auksat93b
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/kEBlXZzjxZBRITPcSRhmjJHc4x63gsJo=
X-HE-Tag: 1633884331-937673
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps too many developers do not know that using '%#<width>x'
in printf output _includes_ the 0x prefix in the output width.

So %#02x already has the width taken by the 0x prefix and will
always emit 3 or more output bytes.

sprintf(buf, "%#02x", 1) emits 0x1 (3 bytes of output)
sprintf(buf, "%#02x", 255) emits 0xff (4 bytes of output)

So presumably all the uses of %#02x in the kernel are not outputting
what is actually expected.  Perhaps all of these should use %#04x.

Instances of the nominally defective '%#02x' from today's -next are:

$ git grep -i '%#02x'
arch/arc/kernel/setup.c:		       "\nIDENTITY\t: ARCVER [%#02x] ARCNUM [%#02x] CHIPID [%#4x]\n",
drivers/gpu/drm/bridge/analogix/analogix-anx6345.c:		DRM_DEBUG_KMS("DP bandwidth (%#02x) not supported\n", dp_bw);
drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c:		DRM_DEBUG_KMS("DP bandwidth (%#02x) not supported\n", dp_bw);
drivers/gpu/drm/drm_hdcp.c:	DRM_DEBUG("\t%#02x, %#02x, %#02x, %#02x, %#02x\n",
drivers/gpu/drm/omapdrm/dss/dsi.c:		DSSDBG("\t\tb1 %#02x b2 %#02x b3 %#02x b4 %#02x\n",
drivers/gpu/drm/rockchip/rockchip_drm_vop.c:		DRM_DEV_ERROR(vop->dev, "Unknown VOP IRQs: %#02x\n",
drivers/hid/hid-ft260.c:	ft260_dbg("bus_status %#02x, clock %u\n", report.bus_status,
drivers/hid/hid-ft260.c:		ft260_dbg("rep %#02x addr %#02x off %d len %d d[0] %#02x\n",
drivers/hid/hid-ft260.c:	ft260_dbg("rep %#02x addr %#02x cmd %#02x datlen %d replen %d\n",
drivers/hid/hid-ft260.c:	ft260_dbg("rep %#02x addr %#02x len %d\n", rep.report, rep.address,
drivers/hid/hid-ft260.c:		hid_err(hdev, "unknown report: %#02x\n", xfer->report);
drivers/hid/hid-ft260.c:	ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report, xfer->length);
drivers/i2c/algos/i2c-algo-pca.c:				printk(KERN_INFO "    [%02d] RD %d bytes from %#02x [%#02x, ...]\n",
drivers/i2c/algos/i2c-algo-pca.c:				printk(KERN_INFO "    [%02d] WR %d bytes to %#02x [%#02x%s",
drivers/iio/imu/inv_icm42600/inv_icm42600_core.c:		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
drivers/input/misc/atmel_captouch.c:			"I2C read error: register address does not match (%#02x vs %02x)\n",
drivers/input/misc/atmel_captouch.c:	dev_dbg(dev, "%s: button state %#02x\n", __func__, new_btn);
drivers/input/mouse/elantech.c:			    "failed to read register %#02x\n", reg);
drivers/input/mouse/elantech.c:			    "failed to write register %#02x with value %#02x%#02x\n",
drivers/input/mouse/elantech.c:			     "Elan ic body: %#04x, current fw version: %#02x\n",
drivers/input/rmi4/rmi_f01.c:			"Device was reset during configuration process, status: %#02x!\n",
drivers/input/rmi4/rmi_f34.c:			"%s: Failed to read cmd register: %d (command %#02x)\n",
drivers/input/rmi4/rmi_f34.c:			"Failed to write F34 command %#02x: %d\n",
drivers/input/rmi4/rmi_f34.c:				"%s: cmd %#02x timed out: %d\n",
drivers/input/rmi4/rmi_f34.c:				"%s: cmd %#02x timed out, status: %#02x\n",
drivers/input/rmi4/rmi_f34.c:		rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: status: %#02x, ret: %d\n",
drivers/input/rmi4/rmi_f34.c:		rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: status: %#02x, ret: %d\n",
drivers/input/serio/libps2.c:				"failed to write %#02x: %d\n", byte, error);
drivers/input/serio/libps2.c:		dev_dbg(&ps2dev->serio->dev, "unexpected %#02x\n", data);
drivers/input/touchscreen/ad7879.c:		dev_err(ts->dev, "failed to read register %#02x: %d\n",
drivers/input/touchscreen/ad7879.c:			"failed to write %#04x to register %#02x: %d\n",
drivers/input/touchscreen/ad7879.c:		dev_err_ratelimited(ts->dev, "failed to read %#02x: %d\n",
drivers/input/touchscreen/bu21029_ts.c:				"failed to write %#02x to register %#02x: %d\n",
drivers/input/touchscreen/ektf2127.c:		dev_err(dev, "Unexpected packet header byte %#02x\n", buf[0]);
drivers/input/touchscreen/ektf2127.c:		dev_err(dev, "Unexpected %s data: %#02x %#02x\n",
drivers/input/touchscreen/hideep.c:						"%s: mismatch @%#08x: (%#02x vs %#02x)\n",
drivers/input/touchscreen/melfas_mip4.c:				"Unexpected bootloader status: %#02x\n",
drivers/input/touchscreen/sis_i2c.c:				"%s: invalid packet ID %#02x\n",
drivers/input/touchscreen/sis_i2c.c:		dev_err(&ts->client->dev, "Unexpected touch status: %#02x\n",
drivers/input/touchscreen/stmfts.c:			 "unknown key event: %#02x\n", event[2]);
drivers/input/touchscreen/stmfts.c:				"unknown event %#02x\n", event[0]);
drivers/input/touchscreen/stmfts.c:	return sprintf(buf, "%#02x\n", status[0]);
drivers/macintosh/adbhid.c:		pr_err("ADB HID on ID %d not yet registered, packet %#02x, %#02x, %#02x, %#02x\n",
drivers/macintosh/adbhid.c:		pr_info("Unhandled ADB key (scancode %#02x) %s.\n", keycode,
drivers/mtd/chips/cfi_cmdset_0002.c:				       "version %c.%c (%#02x/%#02x).\n",
drivers/mtd/nand/raw/brcmnand/brcmnand.c:			"timeout waiting for command %#02x\n", cmd);
drivers/net/ethernet/amd/ariadne.c:			netdev_dbg(dev, "interrupt  csr0=%#02x new csr=%#02x [",
drivers/net/ethernet/dec/tulip/timer.c:					netdev_dbg(dev, "Transceiver monitor tick CSR12=%#02x, no media sense\n",
drivers/net/ethernet/dec/tulip/timer.c:				netdev_dbg(dev, "Transceiver monitor tick: CSR12=%#02x bit %d is %d, expecting %d\n",
drivers/net/ethernet/netronome/nfp/bpf/verifier.c:		pr_vlog(env, "instruction %#02x not supported\n",
drivers/net/ethernet/xircom/xirc2ps_cs.c:	    pr_debug("rsr=%#02x packet_length=%u\n", rsr, pktlen);
drivers/net/ethernet/xircom/xirc2ps_cs.c:	    pr_debug("rsr=%#02x\n", rsr);
drivers/net/ethernet/xircom/xirc2ps_cs.c:	pr_debug("%s: ESR is: %#02x\n", dev->name, value);
drivers/net/ethernet/xircom/xirc2ps_cs.c:    pr_debug("%s: ECR is: %#02x\n", dev->name, value);
drivers/pci/controller/pcie-iproc.c:		dev_err(dev, "in EP mode, hdr=%#02x\n", hdr_type);
drivers/pci/pci.c:		pci_info(dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:		pci_info(dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:		pci_info(dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:		pci_info(dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/probe.c:			dev_dbg(&bus->dev, "%pR extended by %#02x\n",
drivers/pnp/quirks.c:					 "from %#02x to 0x0A (1, 3)\n",
drivers/s390/cio/qdio_main.c:		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in nop:%1d %#02x",
drivers/scsi/aic7xxx/aic79xx_core.c:		printk("%#02x", hscb->shared_data.idata.cdb[i]);
drivers/scsi/aic7xxx/aic7xxx_core.c:		printk("%#02x", hscb->shared_data.cdb[i]);
drivers/scsi/ibmvscsi/ibmvscsi.c:				 "bad SRP RSP type %#02x\n", rsp->opcode);
drivers/scsi/qla2xxx/qla_init.c:	    "%s %s: mask=%#02x gen=%#04x ver=%u.%u map=%#01x sum=%#08x sig=%#08x\n",
drivers/scsi/virtio_scsi.c:		"cmd %p response %u status %#02x sense_len %u\n",
drivers/scsi/virtio_scsi.c:		"cmd %p CDB: %#02x\n", sc, sc->cmnd[0]);
drivers/soc/qcom/cpr.c:	dev_dbg(drv->dev, "IRQ_STATUS = %#02x\n", val);
drivers/soc/qcom/cpr.c:				    "Interrupt broken? RBCPR_CTL = %#02x\n",
drivers/soc/qcom/cpr.c:	seq_printf(s, "rbcpr_gcnt_target (%u) = %#02X\n", ro_sel, gcnt);
drivers/soc/qcom/cpr.c:	seq_printf(s, "rbcpr_ctl = %#02X\n", ctl);
drivers/soc/qcom/cpr.c:	seq_printf(s, "rbcpr_irq_status = %#02X\n", irq_status);
drivers/soc/qcom/cpr.c:	seq_printf(s, "rbcpr_result_0 = %#02X\n", reg);
drivers/staging/wfx/fwio.c:		dev_info(wdev->dev, "secure boot: Error %#02x\n", reg);
drivers/target/target_core_transport.c:		pr_debug("%scmd %#02x:%#02x with tag %#llx dir %s i_state %d t_state %s len %d refcnt %d transport_state %s\n",
drivers/vhost/scsi.c:		pr_debug("%s tv_cmd %p resid %u status %#02x\n", __func__,
drivers/vhost/scsi.c:		pr_debug("vhost_scsi got command opcode: %#02x, lun: %d\n",
drivers/video/fbdev/omap2/omapfb/dss/dsi.c:		DSSDBG("\t\tb1 %#02x b2 %#02x b3 %#02x b4 %#02x\n",
fs/jffs2/debug.c:		printk(JFFS2_DBG "compr:\t%#02x\n", node.i.compr);
fs/jffs2/debug.c:		printk(JFFS2_DBG "usercompr:\t%#02x\n", node.i.usercompr);
fs/jffs2/debug.c:		printk(JFFS2_DBG "nsize:\t%#02x\n", node.d.nsize);
fs/jffs2/debug.c:		printk(JFFS2_DBG "type:\t%#02x\n", node.d.type);
fs/jffs2/readinode.c:			JFFS2_ERROR("illegal nsize in node at %#08x: nsize %#02x, totlen %#04x\n",
include/drm/drm_mipi_dbi.h:		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret, cmd); \
lib/test_printf.c:		test("0xfffffff0|0xf0|0xf0", "%#02x|%#02x|%#02x", val, val & 0xff, (u8)val);
net/mac80211/debugfs_sta.c:	p += scnprintf(p, sizeof(buf) + buf - p, "next dialog_token: %#02x\n",
sound/soc/codecs/rt5640.c:		dev_dbg(component->dev, "detect status %#02x\n", status);
sound/soc/codecs/rt5651.c:		dev_dbg(component->dev, "detect report %#02x\n", report);
sound/usb/card.c:			 "unknown interface protocol %#02x, assuming v1\n",
sound/usb/stream.c:			dev_dbg(&dev->dev, "%u:%d: unknown interface protocol %#02x, assuming v1\n",


