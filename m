Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0745B304
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 05:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbhKXERt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 23:17:49 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:51041 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232238AbhKXERs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 23:17:48 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7B9633201591;
        Tue, 23 Nov 2021 23:14:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 23 Nov 2021 23:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fx2a3Y
        MMc9CZgusUarOijYfoLwcgJyWbyGsE0/lU9Zs=; b=LSrEmYFbmNLR5F++BsYDU5
        C3pUUt6oYP+Zz57Oy/ve9LHN/Ymy13qtr2s4N+Qnu/XeuouVuROJ/GSODdjRCRk8
        pV1Hrq49BslHyADNPsXSOJzCA2l8hYSVZzIDUV/mMUYSEeQAAFFQAG6yWYuJvKOr
        4+b4FWVMg8DEaEEU8sU/kkZr1dsy59bPZmTtDQT+BpYQ3g0WiqcUv7HGYJkdzQfa
        FUIWRYkJnxedQV0UxzaCCBKVLBdDBHvI9qZ0D2nmrnsOCdYukCKmoozZlg9dO85C
        SAClERhXZwoMDr1v4OObrnujbV+SlP00LgHuPl8GE3cQKNFc+8M6Mj5r1TZ6wLtQ
        ==
X-ME-Sender: <xms:LbydYSQ71TqBR78p5m88R-W2xwtzGt0ZvzfkN5Q-e3QIQxzTVeotUg>
    <xme:LbydYXyiEqVL75m2MEc5_Lo5-c7lSvd3sQxVt8d_-e_iIrJ-DVP-O2B3Q0sUbORHA
    8EX3mtcVAZLbh_YuQQ>
X-ME-Received: <xmr:LbydYf3umlD57ing0-P2FdLuHLhSpFtg2xX09O8QWoS1xYgvG6zKgx9T9Sth3TcAuXk-30DsnsmOsXy3vy07oRBx3HNYpe5aXcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeejgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpefhhfejjedvjedtjeejfeeffeejgfeiieejgeevleejfeffgfeuveekheeikedv
    teenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddtuddrohhrghdpghhithhhuhgsuh
    hsvghrtghonhhtvghnthdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:LbydYeB7zoDLC-G1UvdZEtimbJ31m5yj0H9ECciayyO7tTOIyYiqcQ>
    <xmx:LbydYbjC-Qlcec4Kl94woapuQMx2KUZkZRBhP1krHhEZAkCMpuZf3Q>
    <xmx:LbydYarUzzZbrmkKERZURSrmXQSubsGV-oTA6mabMKNu1VmYhGJmiA>
    <xmx:LrydYTYjRfxrQvrOqBtTubuXaSf10smhMUlI178aW-7kgG9hT_O5_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 23:14:35 -0500 (EST)
Date:   Wed, 24 Nov 2021 15:14:37 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     kernel test robot <lkp@intel.com>
cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: drivers/ata/pata_falcon.c:58:41: sparse: sparse: cast removes
 address space '__iomem' of expression
In-Reply-To: <202111240519.TR4XadIt-lkp@intel.com>
Message-ID: <93c33f2-dd5d-fdfd-c5b8-fe18ce153a91@linux-m68k.org>
References: <202111240519.TR4XadIt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021, kernel test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   136057256686de39cc3a07c2e39ef6bc43003ff6
> commit: 44b1fbc0f5f30e66a56d29575349f0b1ebe2b0ee m68k/q40: Replace q40ide driver with pata_falcon and falconide

That's the wrong commit. The missing annotations actually date back to
commit 7e11aabd48eb ("ata: add Atari Falcon PATA controller driver").
It was not my commit but I'll send a patch anyway.

> date:   6 months ago
> config: m68k-randconfig-s031-20211123 (https://download.01.org/0day-ci/archive/20211124/202111240519.TR4XadIt-lkp@intel.com/config.gz)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44b1fbc0f5f30e66a56d29575349f0b1ebe2b0ee
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 44b1fbc0f5f30e66a56d29575349f0b1ebe2b0ee
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash drivers/ata/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/ata/pata_falcon.c:58:41: sparse: sparse: cast removes address space '__iomem' of expression
> >> drivers/ata/pata_falcon.c:58:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>    drivers/ata/pata_falcon.c:58:41: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>    drivers/ata/pata_falcon.c:58:41: sparse:     got unsigned short [usertype] *
>    drivers/ata/pata_falcon.c:60:35: sparse: sparse: cast removes address space '__iomem' of expression
>    drivers/ata/pata_falcon.c:60:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>    drivers/ata/pata_falcon.c:60:35: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>    drivers/ata/pata_falcon.c:60:35: sparse:     got unsigned short [usertype] *
>    drivers/ata/pata_falcon.c:63:42: sparse: sparse: cast removes address space '__iomem' of expression
>    drivers/ata/pata_falcon.c:63:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>    drivers/ata/pata_falcon.c:63:42: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>    drivers/ata/pata_falcon.c:63:42: sparse:     got unsigned short [usertype] *
>    drivers/ata/pata_falcon.c:65:36: sparse: sparse: cast removes address space '__iomem' of expression
>    drivers/ata/pata_falcon.c:65:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>    drivers/ata/pata_falcon.c:65:36: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>    drivers/ata/pata_falcon.c:65:36: sparse:     got unsigned short [usertype] *
>    drivers/ata/pata_falcon.c:77:49: sparse: sparse: cast removes address space '__iomem' of expression
>    drivers/ata/pata_falcon.c:77:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>    drivers/ata/pata_falcon.c:77:49: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>    drivers/ata/pata_falcon.c:77:49: sparse:     got unsigned short [usertype] *
>    drivers/ata/pata_falcon.c:79:43: sparse: sparse: cast removes address space '__iomem' of expression
>    drivers/ata/pata_falcon.c:79:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>    drivers/ata/pata_falcon.c:79:43: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>    drivers/ata/pata_falcon.c:79:43: sparse:     got unsigned short [usertype] *
>    drivers/ata/pata_falcon.c:84:50: sparse: sparse: cast removes address space '__iomem' of expression
>    drivers/ata/pata_falcon.c:84:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>    drivers/ata/pata_falcon.c:84:50: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>    drivers/ata/pata_falcon.c:84:50: sparse:     got unsigned short [usertype] *
>    drivers/ata/pata_falcon.c:86:44: sparse: sparse: cast removes address space '__iomem' of expression
>    drivers/ata/pata_falcon.c:86:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>    drivers/ata/pata_falcon.c:86:44: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>    drivers/ata/pata_falcon.c:86:44: sparse:     got unsigned short [usertype] *
> 
> vim +/__iomem +58 drivers/ata/pata_falcon.c
> 
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  39  
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  40  static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  41  					  unsigned char *buf,
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  42  					  unsigned int buflen, int rw)
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  43  {
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  44  	struct ata_device *dev = qc->dev;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  45  	struct ata_port *ap = dev->link->ap;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  46  	void __iomem *data_addr = ap->ioaddr.data_addr;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  47  	unsigned int words = buflen >> 1;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  48  	struct scsi_cmnd *cmd = qc->scsicmd;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  49  	bool swap = 1;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  50  
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  51  	if (dev->class == ATA_DEV_ATA && cmd && cmd->request &&
> 79f4d1d5c0d7d1 Linus Torvalds            2017-02-21  52  	    !blk_rq_is_passthrough(cmd->request))
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  53  		swap = 0;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  54  
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  55  	/* Transfer multiple of 2 bytes */
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  56  	if (rw == READ) {
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  57  		if (swap)
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30 @58  			raw_insw_swapw((u16 *)data_addr, (u16 *)buf, words);
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  59  		else
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  60  			raw_insw((u16 *)data_addr, (u16 *)buf, words);
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  61  	} else {
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  62  		if (swap)
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  63  			raw_outsw_swapw((u16 *)data_addr, (u16 *)buf, words);
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  64  		else
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  65  			raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  66  	}
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  67  
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  68  	/* Transfer trailing byte, if any. */
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  69  	if (unlikely(buflen & 0x01)) {
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  70  		unsigned char pad[2] = { };
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  71  
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  72  		/* Point buf to the tail of buffer */
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  73  		buf += buflen - 1;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  74  
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  75  		if (rw == READ) {
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  76  			if (swap)
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  77  				raw_insw_swapw((u16 *)data_addr, (u16 *)pad, 1);
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  78  			else
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  79  				raw_insw((u16 *)data_addr, (u16 *)pad, 1);
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  80  			*buf = pad[0];
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  81  		} else {
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  82  			pad[0] = *buf;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  83  			if (swap)
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  84  				raw_outsw_swapw((u16 *)data_addr, (u16 *)pad, 1);
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  85  			else
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  86  				raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  87  		}
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  88  		words++;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  89  	}
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  90  
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  91  	return words << 1;
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  92  }
> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  93  
> 
> :::::: The code at line 58 was first introduced by commit
> :::::: 7e11aabd48eb00240b280bf927cba9198664dcf6 ata: add Atari Falcon PATA controller driver
> 
> :::::: TO: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> :::::: CC: Tejun Heo <tj@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
