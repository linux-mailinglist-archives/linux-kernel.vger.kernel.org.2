Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED0832BEC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575790AbhCCRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:35:57 -0500
Received: from 7.mo52.mail-out.ovh.net ([188.165.59.253]:51604 "EHLO
        7.mo52.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359427AbhCCOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:19:28 -0500
X-Greylist: delayed 3289 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 09:19:26 EST
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.250])
        by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 04DA6240D89;
        Wed,  3 Mar 2021 14:23:46 +0100 (CET)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 3 Mar 2021
 14:23:44 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-101G0041df797e7-eca5-4642-af97-01170dd1b56e,
                    24CAEE7A76C7E725A9866EAA9907F8E378F99BC5) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Subject: Re: arch/powerpc/sysdev/xive/common.c:1614 xive_debug_show_irq()
 warn: variable dereferenced before check 'd' (see line 1596)
To:     Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>
CC:     <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kurz <groug@kaod.org>
References: <20210227150325.GI2087@kadam>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5624492f-7484-f6db-f779-be90a658044f@kaod.org>
Date:   Wed, 3 Mar 2021 14:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210227150325.GI2087@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: cea6c17b-f604-45f7-9749-cf0175b3a5f5
X-Ovh-Tracer-Id: 10223734107060210537
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddtvddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeduudefffelleffgfelueegueelvddvveefkedvteeivdefkeegfeehhedutedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpohiilhgrsghsrdhorhhgpddtuddrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/21 4:03 PM, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3fb6d0e00efc958d01c2f109c8453033a2d96796
> commit: 930914b7d528fc6b0249bffc00564100bcf6ef75 powerpc/xive: Add a debugfs file to dump internal XIVE state
> config: powerpc64-randconfig-m031-20210226 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> arch/powerpc/sysdev/xive/common.c:1614 xive_debug_show_irq() warn: variable dereferenced before check 'd' (see line 1596)

This should be addressed by patch : 

  http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210209161936.377760-5-clg@kaod.org/

> Old smatch warnings:
> arch/powerpc/sysdev/xive/common.c:280 xmon_xive_get_irq_config() warn: variable dereferenced before check 'd' (see line 262)
This one needs a very similar fix which can come as a followup.

Thanks,

C.

> vim +/d +1614 arch/powerpc/sysdev/xive/common.c
> 
> 930914b7d528fc Cédric Le Goater 2020-03-06  1594  void xive_debug_show_irq(struct seq_file *m, u32 hw_irq, struct irq_data *d)
> 930914b7d528fc Cédric Le Goater 2020-03-06  1595  {
> 930914b7d528fc Cédric Le Goater 2020-03-06 @1596  	struct irq_chip *chip = irq_data_get_irq_chip(d);
>                                                                                                       ^
> Dereferenced inside function
> 
> 930914b7d528fc Cédric Le Goater 2020-03-06  1597  	int rc;
> 930914b7d528fc Cédric Le Goater 2020-03-06  1598  	u32 target;
> 930914b7d528fc Cédric Le Goater 2020-03-06  1599  	u8 prio;
> 930914b7d528fc Cédric Le Goater 2020-03-06  1600  	u32 lirq;
> 930914b7d528fc Cédric Le Goater 2020-03-06  1601  
> 930914b7d528fc Cédric Le Goater 2020-03-06  1602  	if (!is_xive_irq(chip))
> 930914b7d528fc Cédric Le Goater 2020-03-06  1603  		return;
> 930914b7d528fc Cédric Le Goater 2020-03-06  1604  
> 930914b7d528fc Cédric Le Goater 2020-03-06  1605  	rc = xive_ops->get_irq_config(hw_irq, &target, &prio, &lirq);
> 930914b7d528fc Cédric Le Goater 2020-03-06  1606  	if (rc) {
> 930914b7d528fc Cédric Le Goater 2020-03-06  1607  		seq_printf(m, "IRQ 0x%08x : no config rc=%d\n", hw_irq, rc);
> 930914b7d528fc Cédric Le Goater 2020-03-06  1608  		return;
> 930914b7d528fc Cédric Le Goater 2020-03-06  1609  	}
> 930914b7d528fc Cédric Le Goater 2020-03-06  1610  
> 930914b7d528fc Cédric Le Goater 2020-03-06  1611  	seq_printf(m, "IRQ 0x%08x : target=0x%x prio=%02x lirq=0x%x ",
> 930914b7d528fc Cédric Le Goater 2020-03-06  1612  		   hw_irq, target, prio, lirq);
> 930914b7d528fc Cédric Le Goater 2020-03-06  1613  
> 930914b7d528fc Cédric Le Goater 2020-03-06 @1614  	if (d) {
>                                                         ^^^^^^^^
> Checked too late.
> 
> 930914b7d528fc Cédric Le Goater 2020-03-06  1615  		struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> 930914b7d528fc Cédric Le Goater 2020-03-06  1616  		u64 val = xive_esb_read(xd, XIVE_ESB_GET);
> 930914b7d528fc Cédric Le Goater 2020-03-06  1617  
> 930914b7d528fc Cédric Le Goater 2020-03-06  1618  		seq_printf(m, "flags=%c%c%c PQ=%c%c",
> 930914b7d528fc Cédric Le Goater 2020-03-06  1619  			   xd->flags & XIVE_IRQ_FLAG_STORE_EOI ? 'S' : ' ',
> 930914b7d528fc Cédric Le Goater 2020-03-06  1620  			   xd->flags & XIVE_IRQ_FLAG_LSI ? 'L' : ' ',
> 930914b7d528fc Cédric Le Goater 2020-03-06  1621  			   xd->flags & XIVE_IRQ_FLAG_H_INT_ESB ? 'H' : ' ',
> 930914b7d528fc Cédric Le Goater 2020-03-06  1622  			   val & XIVE_ESB_VAL_P ? 'P' : '-',
> 930914b7d528fc Cédric Le Goater 2020-03-06  1623  			   val & XIVE_ESB_VAL_Q ? 'Q' : '-');
> 930914b7d528fc Cédric Le Goater 2020-03-06  1624  	}
> 930914b7d528fc Cédric Le Goater 2020-03-06  1625  	seq_puts(m, "\n");
> 930914b7d528fc Cédric Le Goater 2020-03-06  1626  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

