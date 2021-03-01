Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29066327D81
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhCALr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:47:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:54863 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233740AbhCALrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:47:42 -0500
IronPort-SDR: qlNWS0oKCRMWD43KYmirCrUXq8wuQiV7QS2ur6BF5rk+P6fKPBG+7nhi/niUXEpAAnySU/1CTI
 W1snxK8lEQ4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="183993225"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="183993225"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 03:45:55 -0800
IronPort-SDR: +qsS9ziWSi/M4gUtKn77TpHPPy2eHBU/uQJPUaJt9R21JbMKH/S1540cAJSatP+XSDdKl5wfKH
 dNAgEygDqsLA==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="397689816"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 03:45:53 -0800
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com> <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com> <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com> <85ft1fjhws.fsf@linux.intel.com> <YDzAY8j6R87BFFI/@kroah.com> <85czwjjh3b.fsf@linux.intel.com> <85a6rnjgys.fsf@linux.intel.com> <YDzF7sGvshN2SG5Q@kroah.com>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v1 01/12] gna: add driver module
In-reply-to: <YDzF7sGvshN2SG5Q@kroah.com>
Date:   Mon, 01 Mar 2021 12:45:51 +0100
Message-ID: <857dmrjdw0.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Mon, Mar 01, 2021 at 11:39:23AM +0100, Maciej Kwapulinski wrote:
>> 
>> Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com> writes:
>> 
>> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> >
>> >> On Mon, Mar 01, 2021 at 11:18:59AM +0100, Maciej Kwapulinski wrote:
>> >>> 
>> >>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>> >>> 
>> >>> > On Tue, Feb 16, 2021 at 6:11 PM Maciej Kwapulinski
>> >>> > <maciej.kwapulinski@linux.intel.com> wrote:
>> >>> >>
>> >>> ....
>> >>> >> +static int __init gna_drv_init(void)
>> >>> >> +{
>> >>> >> +       int ret;
>> >>> >> +
>> >>> >> +       mutex_init(&gna_drv_priv.lock);
>> >>> >> +
>> >>> >> +       gna_class = class_create(THIS_MODULE, "gna");
>> >>> >> +       if (IS_ERR(gna_class)) {
>> >>> >> +               pr_err("class device create failed\n");
>> >>> >> +               return PTR_ERR(gna_class);
>> >>> >> +       }
>> >>> >> +       gna_class->devnode = gna_devnode;
>> >>> >> +
>> >>> >> +       ret = pci_register_driver(&gna_driver);
>> >>> >
>> >>> > Is it possible to decouple a PCI glue driver from the class as many
>> >>> > other existing examples are doing?
>> >>> >
>> >>> 
>> >>> I see many pci drivers (including staging) that do have it glued though.
>> >>> 
>> >>> Examples are:
>> >>> 1. "static int __init kp2000_pcie_init(void)" (commit on May 20 09:34:11
>> >>> 2019)
>> >>> 2. "static int __init hl_init(void)" (commit on Mon Feb 18 09:46:43 2019)
>> >>> 
>> >>> Please give me more details.
>> >>
>> >> Never use a staging driver for any type of example, _EXECPT_ for a bad
>> >> one.  There's a reason the code is in staging and not in the "real" part
>> >> of the kernel.
>> >
>> > ok.
>> >
>> > another one (1) is not staging..
>> 
>> I meant "static int __init hl_init(void)" is not staging one....
>
> Still doesn't mean it is a good thing to do.  Again, why isn't this
> driver just using the misc driver interface instead?  It's much simpler
> to use and should work just fine for this tiny driver, instead of having
> to create a custom class just for it.
>

ok
