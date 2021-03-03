Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4264B32BE47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385411AbhCCRTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:19:19 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:47383 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382826AbhCCNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:31:44 -0500
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 08:31:42 EST
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.7])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id B71E88C97504;
        Wed,  3 Mar 2021 14:21:25 +0100 (CET)
Received: from kaod.org (37.59.142.95) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 3 Mar 2021
 14:21:24 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-95G001ede01854-56b8-48d4-abfd-1b9f7756edc3,
                    24CAEE7A76C7E725A9866EAA9907F8E378F99BC5) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Subject: Re: arch/powerpc/sysdev/xive/common.c:279 xmon_xive_get_irq_config()
 warn: variable dereferenced before check 'd' (see line 261)
To:     Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>
CC:     <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kurz <groug@kaod.org>
References: <20210227093050.GE2087@kadam>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <05a4c050-c279-d0d6-9920-b0063bc82b0f@kaod.org>
Date:   Wed, 3 Mar 2021 14:21:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210227093050.GE2087@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: fe9b15cb-ed73-4835-bacb-fcbd4d77db9c
X-Ovh-Tracer-Id: 10184046136024796009
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddtvddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeduudefffelleffgfelueegueelvddvveefkedvteeivdefkeegfeehhedutedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpohiilhgrsghsrdhorhhgpddtuddrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehgrhhouhhgsehkrghougdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/21 10:30 AM, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8b83369ddcb3fb9cab5c1088987ce477565bb630
> commit: 97ef275077932c65b1b8ec5022abd737a9fbf3e0 powerpc/xive: Fix xmon support on the PowerNV platform
> config: powerpc64-randconfig-m031-20210226 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> arch/powerpc/sysdev/xive/common.c:279 xmon_xive_get_irq_config() warn: variable dereferenced before check 'd' (see line 261)

Yes. That's ugly :/

I would prefer to address this issue after the cleanup provided
by the patchset adding an IRQ domain for IPIs.

  http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=228762

Most of the mess comes from the XIVE IPI HW IRQ number which
hijacks IRQ number 0. It should be easier after this is fixed.

Thanks,

C. 

> vim +/d +279 arch/powerpc/sysdev/xive/common.c
> 
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  259  int xmon_xive_get_irq_config(u32 hw_irq, struct irq_data *d)
> b4868ff55d082bc Cédric Le Goater 2019-08-14  260  {
> 97ef275077932c6 Cédric Le Goater 2020-03-06 @261  	struct irq_chip *chip = irq_data_get_irq_chip(d);
>                                                                                                       ^
> Dereferenced inside function
> 
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  262  	int rc;
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  263  	u32 target;
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  264  	u8 prio;
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  265  	u32 lirq;
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  266  
> 97ef275077932c6 Cédric Le Goater 2020-03-06  267  	if (!is_xive_irq(chip))
> 97ef275077932c6 Cédric Le Goater 2020-03-06  268  		return -EINVAL;
> 97ef275077932c6 Cédric Le Goater 2020-03-06  269  
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  270  	rc = xive_ops->get_irq_config(hw_irq, &target, &prio, &lirq);
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  271  	if (rc) {
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  272  		xmon_printf("IRQ 0x%08x : no config rc=%d\n", hw_irq, rc);
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  273  		return rc;
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  274  	}
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  275  
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  276  	xmon_printf("IRQ 0x%08x : target=0x%x prio=%02x lirq=0x%x ",
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  277  		    hw_irq, target, prio, lirq);
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  278  
> 5896163f7f91c05 Cédric Le Goater 2019-09-10 @279  	if (d) {
>                                                         ^^^^^^
> Checked too late
> 
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  280  		struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  281  		u64 val = xive_esb_read(xd, XIVE_ESB_GET);
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  282  
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  283  		xmon_printf("PQ=%c%c",
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  284  			    val & XIVE_ESB_VAL_P ? 'P' : '-',
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  285  			    val & XIVE_ESB_VAL_Q ? 'Q' : '-');
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  286  	}
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  287  
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  288  	xmon_printf("\n");
> 5896163f7f91c05 Cédric Le Goater 2019-09-10  289  	return 0;
> b4868ff55d082bc Cédric Le Goater 2019-08-14  290  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

