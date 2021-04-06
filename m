Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D30354B83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 06:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhDFELB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:11:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:2871 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhDFELA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:11:00 -0400
IronPort-SDR: SGLRV37uzXuQe68ZULfEaE621Sq3FvqACAGz4TR23XEfPIzalGW5uTZ4g5OlXHSVlKyYpOYFuF
 OcZHA2v9A4YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="192507617"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="gz'50?scan'50,208,50";a="192507617"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 21:10:53 -0700
IronPort-SDR: kNSSCDJSyi/m/wl89m4kihQ5tqGcif4Js9LeHB7oCvfxCSVQKk/PpB+PV93+z7fnQB2PD6ND1Y
 D9G30AgSY3eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="gz'50?scan'50,208,50";a="440761193"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2021 21:10:51 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lTd3C-000BES-Ro; Tue, 06 Apr 2021 04:10:50 +0000
Date:   Tue, 6 Apr 2021 12:10:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: drivers/usb/isp1760/isp1760-udc.c:270:17: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202104061257.czkjL0NQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0a50438c84363bd37fe18fe432888ae9a074dcab
commit: 005b73d0dd83c9cb9420a196bea8070cde30ecac m68knommu: __force type casts for raw IO access
date:   8 months ago
config: m68k-randconfig-s032-20210406 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-279-g6d5d9b42-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=005b73d0dd83c9cb9420a196bea8070cde30ecac
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 005b73d0dd83c9cb9420a196bea8070cde30ecac
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:214:31: sparse: sparse: cast to restricted __le16
   drivers/usb/isp1760/isp1760-udc.c:214:31: sparse: sparse: cast to restricted __le16
   drivers/usb/isp1760/isp1760-udc.c:214:31: sparse: sparse: cast to restricted __le16
   drivers/usb/isp1760/isp1760-udc.c:214:31: sparse: sparse: cast to restricted __le16
   drivers/usb/isp1760/isp1760-udc.c:268:53: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/usb/isp1760/isp1760-udc.c:268:53: sparse:     expected unsigned int [usertype] val
   drivers/usb/isp1760/isp1760-udc.c:268:53: sparse:     got restricted __le32 [usertype]
>> drivers/usb/isp1760/isp1760-udc.c:270:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/isp1760/isp1760-udc.c:270:17: sparse:     expected unsigned short volatile [usertype]
   drivers/usb/isp1760/isp1760-udc.c:270:17: sparse:     got restricted __le16 [usertype]
   drivers/usb/isp1760/isp1760-udc.c:485:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/isp1760/isp1760-udc.c:485:9: sparse:     expected unsigned short volatile [usertype]
   drivers/usb/isp1760/isp1760-udc.c:485:9: sparse:     got restricted __le16 [usertype]

vim +270 drivers/usb/isp1760/isp1760-udc.c

0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  241  
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  242  static void isp1760_udc_transmit(struct isp1760_ep *ep,
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  243  				 struct isp1760_request *req)
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  244  {
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  245  	struct isp1760_udc *udc = ep->udc;
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  246  	u32 *buf = req->req.buf + req->req.actual;
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  247  	int i;
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  248  
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  249  	req->packet_size = min(req->req.length - req->req.actual,
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  250  			       ep->maxpacket);
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  251  
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  252  	dev_dbg(udc->isp->dev, "%s: transferring %u bytes (%u/%u done)\n",
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  253  		__func__, req->packet_size, req->req.actual,
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  254  		req->req.length);
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  255  
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  256  	__isp1760_udc_select_ep(ep, USB_DIR_IN);
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  257  
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  258  	if (req->packet_size)
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  259  		isp1760_udc_write(udc, DC_BUFLEN, req->packet_size);
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  260  
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  261  	/*
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  262  	 * Make sure not to write more than one extra byte, otherwise extra data
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  263  	 * will stay in the FIFO and will be transmitted during the next control
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  264  	 * request. The endpoint control CLBUF bit is supposed to allow flushing
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  265  	 * the FIFO for this kind of conditions, but doesn't seem to work.
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  266  	 */
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  267  	for (i = req->packet_size; i > 2; i -= 4, ++buf)
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  268  		isp1760_udc_write(udc, DC_DATAPORT, cpu_to_le32(*buf));
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  269  	if (i > 0)
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21 @270  		writew(cpu_to_le16(*(u16 *)buf), udc->regs + DC_DATAPORT);
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  271  
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  272  	if (ep->addr == 0)
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  273  		isp1760_udc_write(udc, DC_CTRLFUNC, DC_DSEN);
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  274  	if (!req->packet_size)
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  275  		isp1760_udc_write(udc, DC_CTRLFUNC, DC_VENDP);
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  276  }
0316ca6319b98e drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  277  

:::::: The code at line 270 was first introduced by commit
:::::: 0316ca6319b98e485325be98a47d08fed07ead43 usb: isp1760: Add device controller support

:::::: TO: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
:::::: CC: Felipe Balbi <balbi@ti.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--
