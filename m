Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9CD35342D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 15:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhDCNip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 09:38:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:19414 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhDCNin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 09:38:43 -0400
IronPort-SDR: pVSKBG2PRO3VB0tUnmeEP1Nehi61q9Fr9YqfcjM+MFwHIf4Tv6F9zhc2epdC+oNTHqTwyTGALs
 93BgEtXmNe9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9943"; a="192649406"
X-IronPort-AV: E=Sophos;i="5.81,302,1610438400"; 
   d="gz'50?scan'50,208,50";a="192649406"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2021 06:38:39 -0700
IronPort-SDR: Pf40DpNsKdBQMtzJ+W6WoElKosXgCdfUhXfmN2REyt9KhZhteMjr1jf1F53LizENpT++ZJuLCf
 P25BbtczJeng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,302,1610438400"; 
   d="gz'50?scan'50,208,50";a="439952890"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2021 06:38:37 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSgU0-0007iN-Sn; Sat, 03 Apr 2021 13:38:36 +0000
Date:   Sat, 3 Apr 2021 21:38:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/accessibility/speakup/serialio.c:48:19: warning: variable
 'quot' set but not used
Message-ID: <202104032109.QNSXkGEO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Samuel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d93a0d43e3d0ba9e19387be4dae4a8d5b175a8d7
commit: 2067fd92d75b6d9085a43caf050bca5d88c491b8 staging/speakup: Move out of staging
date:   8 months ago
config: parisc-randconfig-r003-20210403 (attached as .config)
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

--/04w6evG8XlLl3ft
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--/04w6evG8XlLl3ft--
