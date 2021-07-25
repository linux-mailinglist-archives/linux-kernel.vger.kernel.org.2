Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84C3D4AE2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 03:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGYBMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 21:12:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:30004 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhGYBMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 21:12:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10055"; a="275870588"
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="gz'50?scan'50,208,50";a="275870588"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2021 18:53:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="gz'50?scan'50,208,50";a="515145951"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2021 18:53:03 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7TKA-0003z1-OP; Sun, 25 Jul 2021 01:53:02 +0000
Date:   Sun, 25 Jul 2021 09:52:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [printk:for-5.15-printk-index 4/8]
 drivers/media/usb/pvrusb2/pvrusb2-encoder.c:288 pvr2_encoder_cmd() warn:
 inconsistent indenting
Message-ID: <202107250913.OiKJhpRZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git for-5.15-printk-index
head:   894d9c2e994946ffbd5401c2391f0a4ca6243a08
commit: 337015573718b161891a3473d25f59273f2e626b [4/8] printk: Userspace format indexing support
config: x86_64-randconfig-m001-20210724 (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/media/usb/pvrusb2/pvrusb2-encoder.c:288 pvr2_encoder_cmd() warn: inconsistent indenting
drivers/media/usb/pvrusb2/pvrusb2-hdw.c:1730 pvr2_hdw_set_streaming() warn: inconsistent indenting
drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3461 pvr2_hdw_cpufw_set_enabled() warn: inconsistent indenting
drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3501 pvr2_hdw_cpufw_get() warn: inconsistent indenting

vim +288 drivers/media/usb/pvrusb2/pvrusb2-encoder.c

d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  120  
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  121  
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  122  /* This prototype is set up to be compatible with the
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  123     cx2341x_mbox_func prototype in cx2341x.h, which should be in
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  124     kernels 2.6.18 or later.  We do this so that we can enable
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  125     cx2341x.ko to write to our encoder (by handing it a pointer to this
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  126     function).  For earlier kernels this doesn't really matter. */
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  127  static int pvr2_encoder_cmd(void *ctxt,
ea48c13ad0e562 drivers/media/video/pvrusb2/pvrusb2-encoder.c Hans Verkuil          2007-12-12  128  			    u32 cmd,
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  129  			    int arg_cnt_send,
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  130  			    int arg_cnt_recv,
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  131  			    u32 *argp)
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  132  {
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  133  	unsigned int poll_count;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  134  	unsigned int try_count = 0;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  135  	int retry_flag;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  136  	int ret = 0;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  137  	unsigned int idx;
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  138  	/* These sizes look to be limited by the FX2 firmware implementation */
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  139  	u32 wrData[16];
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  140  	u32 rdData[16];
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  141  	struct pvr2_hdw *hdw = (struct pvr2_hdw *)ctxt;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  142  
c05c0462da0e3a drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  143  
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  144  	/*
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  145  
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  146  	The encoder seems to speak entirely using blocks 32 bit words.
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  147  	In ivtv driver terms, this is a mailbox at MBOX_BASE which we
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  148  	populate with data and watch what the hardware does with it.
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  149  	The first word is a set of flags used to control the
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  150  	transaction, the second word is the command to execute, the
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  151  	third byte is zero (ivtv driver suggests that this is some
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  152  	kind of return value), and the fourth byte is a specified
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  153  	timeout (windows driver always uses 0x00060000 except for one
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  154  	case when it is zero).  All successive words are the argument
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  155  	words for the command.
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  156  
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  157  	First, write out the entire set of words, with the first word
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  158  	being zero.
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  159  
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  160  	Next, write out just the first word again, but set it to
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  161  	IVTV_MBOX_DRIVER_DONE | IVTV_DRIVER_BUSY this time (which
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  162  	probably means "go").
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  163  
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  164  	Next, read back the return count words.  Check the first word,
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  165  	which should have IVTV_MBOX_FIRMWARE_DONE set.  If however
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  166  	that bit is not set, then the command isn't done so repeat the
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  167  	read until it is set.
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  168  
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  169  	Finally, write out just the first word again, but set it to
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  170  	0x0 this time (which probably means "idle").
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  171  
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  172  	*/
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  173  
eca8ebfc11d193 drivers/media/video/pvrusb2/pvrusb2-encoder.c Ahmed S. Darwish      2007-01-20  174  	if (arg_cnt_send > (ARRAY_SIZE(wrData) - 4)) {
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  175  		pvr2_trace(
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  176  			PVR2_TRACE_ERROR_LEGS,
96292c89cf1fa7 drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Mauro Carvalho Chehab 2016-10-18  177  			"Failed to write cx23416 command - too many input arguments (was given %u limit %lu)",
69b04f0dc1c489 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mauro Carvalho Chehab 2007-01-21  178  			arg_cnt_send, (long unsigned) ARRAY_SIZE(wrData) - 4);
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  179  		return -EINVAL;
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  180  	}
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  181  
eca8ebfc11d193 drivers/media/video/pvrusb2/pvrusb2-encoder.c Ahmed S. Darwish      2007-01-20  182  	if (arg_cnt_recv > (ARRAY_SIZE(rdData) - 4)) {
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  183  		pvr2_trace(
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  184  			PVR2_TRACE_ERROR_LEGS,
96292c89cf1fa7 drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Mauro Carvalho Chehab 2016-10-18  185  			"Failed to write cx23416 command - too many return arguments (was given %u limit %lu)",
69b04f0dc1c489 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mauro Carvalho Chehab 2007-01-21  186  			arg_cnt_recv, (long unsigned) ARRAY_SIZE(rdData) - 4);
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  187  		return -EINVAL;
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  188  	}
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  189  
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  190  
1ad371deb9b0be drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Mauro Carvalho Chehab 2017-06-26  191  	LOCK_TAKE(hdw->ctl_lock); while (1) {
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  192  
681c739944018d drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-11-26  193  		if (!hdw->state_encoder_ok) {
9a607f01b044dd drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-10-14  194  			ret = -EIO;
9a607f01b044dd drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-10-14  195  			break;
9a607f01b044dd drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-10-14  196  		}
9a607f01b044dd drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-10-14  197  
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  198  		retry_flag = 0;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  199  		try_count++;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  200  		ret = 0;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  201  		wrData[0] = 0;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  202  		wrData[1] = cmd;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  203  		wrData[2] = 0;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  204  		wrData[3] = 0x00060000;
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  205  		for (idx = 0; idx < arg_cnt_send; idx++) {
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  206  			wrData[idx+4] = argp[idx];
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  207  		}
eca8ebfc11d193 drivers/media/video/pvrusb2/pvrusb2-encoder.c Ahmed S. Darwish      2007-01-20  208  		for (; idx < ARRAY_SIZE(wrData) - 4; idx++) {
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  209  			wrData[idx+4] = 0;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  210  		}
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  211  
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  212  		ret = pvr2_encoder_write_words(hdw,MBOX_BASE,wrData,idx);
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  213  		if (ret) break;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  214  		wrData[0] = IVTV_MBOX_DRIVER_DONE|IVTV_MBOX_DRIVER_BUSY;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  215  		ret = pvr2_encoder_write_words(hdw,MBOX_BASE,wrData,1);
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  216  		if (ret) break;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  217  		poll_count = 0;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  218  		while (1) {
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  219  			poll_count++;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  220  			ret = pvr2_encoder_read_words(hdw,MBOX_BASE,rdData,
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  221  						      arg_cnt_recv+4);
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  222  			if (ret) {
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  223  				break;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  224  			}
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  225  			if (rdData[0] & IVTV_MBOX_FIRMWARE_DONE) {
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  226  				break;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  227  			}
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  228  			if (rdData[0] && (poll_count < 1000)) continue;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  229  			if (!rdData[0]) {
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  230  				retry_flag = !0;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  231  				pvr2_trace(
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  232  					PVR2_TRACE_ERROR_LEGS,
96292c89cf1fa7 drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Mauro Carvalho Chehab 2016-10-18  233  					"Encoder timed out waiting for us; arranging to retry");
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  234  			} else {
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  235  				pvr2_trace(
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  236  					PVR2_TRACE_ERROR_LEGS,
96292c89cf1fa7 drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Mauro Carvalho Chehab 2016-10-18  237  					"***WARNING*** device's encoder appears to be stuck (status=0x%08x)",
96292c89cf1fa7 drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Mauro Carvalho Chehab 2016-10-18  238  rdData[0]);
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  239  			}
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  240  			pvr2_trace(
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  241  				PVR2_TRACE_ERROR_LEGS,
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  242  				"Encoder command: 0x%02x",cmd);
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  243  			for (idx = 4; idx < arg_cnt_send; idx++) {
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  244  				pvr2_trace(
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  245  					PVR2_TRACE_ERROR_LEGS,
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  246  					"Encoder arg%d: 0x%08x",
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  247  					idx-3,wrData[idx]);
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  248  			}
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  249  			ret = -EBUSY;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  250  			break;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  251  		}
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  252  		if (retry_flag) {
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  253  			if (try_count < 20) continue;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  254  			pvr2_trace(
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  255  				PVR2_TRACE_ERROR_LEGS,
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  256  				"Too many retries...");
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  257  			ret = -EBUSY;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  258  		}
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  259  		if (ret) {
d913d6303072ca drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2008-04-06  260  			del_timer_sync(&hdw->encoder_run_timer);
681c739944018d drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-11-26  261  			hdw->state_encoder_ok = 0;
681c739944018d drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-11-26  262  			pvr2_trace(PVR2_TRACE_STBITS,
681c739944018d drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-11-26  263  				   "State bit %s <-- %s",
681c739944018d drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-11-26  264  				   "state_encoder_ok",
681c739944018d drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-11-26  265  				   (hdw->state_encoder_ok ? "true" : "false"));
d913d6303072ca drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2008-04-06  266  			if (hdw->state_encoder_runok) {
d913d6303072ca drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2008-04-06  267  				hdw->state_encoder_runok = 0;
d913d6303072ca drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2008-04-06  268  				pvr2_trace(PVR2_TRACE_STBITS,
d913d6303072ca drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2008-04-06  269  				   "State bit %s <-- %s",
d913d6303072ca drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2008-04-06  270  					   "state_encoder_runok",
d913d6303072ca drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2008-04-06  271  					   (hdw->state_encoder_runok ?
d913d6303072ca drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2008-04-06  272  					    "true" : "false"));
d913d6303072ca drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2008-04-06  273  			}
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  274  			pvr2_trace(
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  275  				PVR2_TRACE_ERROR_LEGS,
96292c89cf1fa7 drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Mauro Carvalho Chehab 2016-10-18  276  				"Giving up on command.  This is normally recovered via a firmware reload and re-initialization; concern is only warranted if this happens repeatedly and rapidly.");
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  277  			break;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  278  		}
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  279  		wrData[0] = 0x7;
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  280  		for (idx = 0; idx < arg_cnt_recv; idx++) {
eacbe7c51f0fe7 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-25  281  			argp[idx] = rdData[idx+4];
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  282  		}
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  283  
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  284  		wrData[0] = 0x0;
c43000ef0c9f21 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2007-01-28  285  		ret = pvr2_encoder_write_words(hdw,MBOX_BASE,wrData,1);
1ad371deb9b0be drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Mauro Carvalho Chehab 2017-06-26  286  		break;
11c48e41d5fcc5 drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Ma Feng               2019-12-19  287  	}
11c48e41d5fcc5 drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Ma Feng               2019-12-19 @288  	LOCK_GIVE(hdw->ctl_lock);
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  289  
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  290  	return ret;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  291  }
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-encoder.c Mike Isely            2006-06-26  292  

:::::: The code at line 288 was first introduced by commit
:::::: 11c48e41d5fcc5b4cf17aa74388be128ca5444f8 media: pvrusb2: Remove unneeded semicolon and add newline

:::::: TO: Ma Feng <mafeng.ma@huawei.com>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gBBFr7Ir9EOA20Yy--
