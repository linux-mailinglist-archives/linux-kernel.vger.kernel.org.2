Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3A631A60F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBLUal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:30:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:28138 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhBLUag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:30:36 -0500
IronPort-SDR: dpM2bMWZXEZc/Y9Ajt3+Xi/sp/kefVM46wS36+jLK59N43AHRnU3waJE8x5iPsG7cHqAS4603O
 sI3ePYXFW1yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="161615171"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="gz'50?scan'50,208,50";a="161615171"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 12:29:50 -0800
IronPort-SDR: c2Fgyh75xMHhDfwnm71EiZaFyj9aplsGJaWhFZ/NI5voKRC6F03zazwFjG9BIXdHNOmWyBKlor
 61V3mVsXtZ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="gz'50?scan'50,208,50";a="437703184"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2021 12:29:48 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lAf4V-0004ra-B8; Fri, 12 Feb 2021 20:29:47 +0000
Date:   Sat, 13 Feb 2021 04:29:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/accessibility/speakup/serialio.c:48:19: warning: variable
 'quot' set but not used
Message-ID: <202102130435.2o8FizQw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Samuel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcc0b49040c70ad827a7f3d58a21b01fdb14e749
commit: 2067fd92d75b6d9085a43caf050bca5d88c491b8 staging/speakup: Move out of staging
date:   7 months ago
config: parisc-randconfig-r025-20210212 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2067fd92d75b6d9085a43caf050bca5d88c491b8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2067fd92d75b6d9085a43caf050bca5d88c491b8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/accessibility/speakup/serialio.c: In function 'spk_serial_init':
>> drivers/accessibility/speakup/serialio.c:48:19: warning: variable 'quot' set but not used [-Wunused-but-set-variable]
      48 |  int baud = 9600, quot = 0;
         |                   ^~~~
   drivers/accessibility/speakup/serialio.c: In function 'spk_serial_tiocmset':
   drivers/accessibility/speakup/serialio.c:165:6: warning: unused variable 'old' [-Wunused-variable]
     165 |  int old = inb(speakup_info.port_tts + UART_MCR);
         |      ^~~


vim +/quot +48 drivers/accessibility/speakup/serialio.c

1e441594e509c3 drivers/staging/speakup/serialio.c Okash Khawaja          2017-03-14   45  
3ee0017e03cd79 drivers/staging/speakup/serialio.c Jiri Slaby             2012-03-05   46  const struct old_serial_port *spk_serial_init(int index)
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   47  {
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  @48  	int baud = 9600, quot = 0;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   49  	unsigned int cval = 0;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   50  	int cflag = CREAD | HUPCL | CLOCAL | B9600 | CS8;
327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   51  	const struct old_serial_port *ser;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   52  	int err;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   53  
327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   54  	if (index >= ARRAY_SIZE(rs_table)) {
327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   55  		pr_info("no port info for ttyS%d\n", index);
327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   56  		return NULL;
327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   57  	}
327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   58  	ser = rs_table + index;
327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   59  
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   60  	/*	Divisor, bytesize and parity */
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   61  	quot = ser->baud_base / baud;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   62  	cval = cflag & (CSIZE | CSTOPB);
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   63  #if defined(__powerpc__) || defined(__alpha__)
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   64  	cval >>= 8;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   65  #else /* !__powerpc__ && !__alpha__ */
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   66  	cval >>= 4;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   67  #endif /* !__powerpc__ && !__alpha__ */
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   68  	if (cflag & PARENB)
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   69  		cval |= UART_LCR_PARITY;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   70  	if (!(cflag & PARODD))
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   71  		cval |= UART_LCR_EPAR;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   72  	if (synth_request_region(ser->port, 8)) {
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   73  		/* try to take it back. */
3a046c19158e89 drivers/staging/speakup/serialio.c Keerthimai Janarthanan 2014-03-18   74  		pr_info("Ports not available, trying to steal them\n");
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   75  		__release_region(&ioport_resource, ser->port, 8);
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   76  		err = synth_request_region(ser->port, 8);
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   77  		if (err) {
3ee0017e03cd79 drivers/staging/speakup/serialio.c Jiri Slaby             2012-03-05   78  			pr_warn("Unable to allocate port at %x, errno %i",
baf9ac9ff8864c drivers/staging/speakup/serialio.c William Hubbs          2010-10-15   79  				ser->port, err);
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   80  			return NULL;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   81  		}
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   82  	}
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   83  
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   84  	/*	Disable UART interrupts, set DTR and RTS high
13d825edd4441d drivers/staging/speakup/serialio.c Aleksei Fedotov        2015-08-14   85  	 *	and set speed.
13d825edd4441d drivers/staging/speakup/serialio.c Aleksei Fedotov        2015-08-14   86  	 */
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   87  	outb(cval | UART_LCR_DLAB, ser->port + UART_LCR);	/* set DLAB */
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   88  	outb(quot & 0xff, ser->port + UART_DLL);	/* LS of divisor */
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   89  	outb(quot >> 8, ser->port + UART_DLM);		/* MS of divisor */
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   90  	outb(cval, ser->port + UART_LCR);		/* reset DLAB */
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   91  
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   92  	/* Turn off Interrupts */
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   93  	outb(0, ser->port + UART_IER);
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   94  	outb(UART_MCR_DTR | UART_MCR_RTS, ser->port + UART_MCR);
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   95  
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   96  	/* If we read 0xff from the LSR, there is no UART here. */
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   97  	if (inb(ser->port + UART_LSR) == 0xff) {
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   98  		synth_release_region(ser->port, 8);
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   99  		serstate = NULL;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  100  		return NULL;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  101  	}
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  102  
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  103  	mdelay(1);
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  104  	speakup_info.port_tts = ser->port;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  105  	serstate = ser;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  106  
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  107  	start_serial_interrupt(ser->irq);
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  108  
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  109  	return ser;
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  110  }
c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  111  

:::::: The code at line 48 was first introduced by commit
:::::: c6e3fd22cd538365bfeb82997d5b89562e077d42 Staging: add speakup to the staging directory

:::::: TO: William Hubbs <w.d.hubbs@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--82I3+IH0IqGh5yIs--
