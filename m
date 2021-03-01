Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEF9327C71
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhCAKmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:42:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:40724 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234628AbhCAKlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:41:13 -0500
IronPort-SDR: Voar9rS4Y1lFwKGwtUL8Jq19FElQpDCE/rvPdzggvso5+NXpkfqr+TS7Kx48dCXH3Zfty3BC0a
 31GPgbV/Wgdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="173553342"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="173553342"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 02:39:27 -0800
IronPort-SDR: yPwqVElsZe8iQCA5iJ+kwDO4Y9NYP0m+r547zvuxwLazlQqTcP5Drdi8Y3sbWR61aw6hqxoo4A
 C44Qx8pUmzsw==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="504923472"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 02:39:25 -0800
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com> <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com> <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com> <85ft1fjhws.fsf@linux.intel.com> <YDzAY8j6R87BFFI/@kroah.com> <85czwjjh3b.fsf@linux.intel.com>
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
In-reply-to: <85czwjjh3b.fsf@linux.intel.com>
Date:   Mon, 01 Mar 2021 11:39:23 +0100
Message-ID: <85a6rnjgys.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com> writes:

> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>
>> On Mon, Mar 01, 2021 at 11:18:59AM +0100, Maciej Kwapulinski wrote:
>>> 
>>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>> 
>>> > On Tue, Feb 16, 2021 at 6:11 PM Maciej Kwapulinski
>>> > <maciej.kwapulinski@linux.intel.com> wrote:
>>> >>
>>> ....
>>> >> +static int __init gna_drv_init(void)
>>> >> +{
>>> >> +       int ret;
>>> >> +
>>> >> +       mutex_init(&gna_drv_priv.lock);
>>> >> +
>>> >> +       gna_class = class_create(THIS_MODULE, "gna");
>>> >> +       if (IS_ERR(gna_class)) {
>>> >> +               pr_err("class device create failed\n");
>>> >> +               return PTR_ERR(gna_class);
>>> >> +       }
>>> >> +       gna_class->devnode = gna_devnode;
>>> >> +
>>> >> +       ret = pci_register_driver(&gna_driver);
>>> >
>>> > Is it possible to decouple a PCI glue driver from the class as many
>>> > other existing examples are doing?
>>> >
>>> 
>>> I see many pci drivers (including staging) that do have it glued though.
>>> 
>>> Examples are:
>>> 1. "static int __init kp2000_pcie_init(void)" (commit on May 20 09:34:11
>>> 2019)
>>> 2. "static int __init hl_init(void)" (commit on Mon Feb 18 09:46:43 2019)
>>> 
>>> Please give me more details.
>>
>> Never use a staging driver for any type of example, _EXECPT_ for a bad
>> one.  There's a reason the code is in staging and not in the "real" part
>> of the kernel.
>
> ok.
>
> another one (1) is not staging..

I meant "static int __init hl_init(void)" is not staging one....
