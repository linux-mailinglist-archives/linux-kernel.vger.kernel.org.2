Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD4327BF9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhCAKYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:24:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:26261 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233313AbhCAKVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:21:49 -0500
IronPort-SDR: cERMtcsdVXwyqafQ2AUBEQFvaSJFC0VUbJ6N5ovHWBUYBZ0iKntvwRePKEPMfTD9av3a2JPk6P
 QajQMsj+916Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="247828628"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="247828628"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 02:19:04 -0800
IronPort-SDR: qkiqLn92VcK9pLwqBFRZw4prmGsPifCqoo3A9wibuT20R1mnWgt5pvRUnFYtG1lvOPItd3cQRG
 M+keLe/OZiPw==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="444109927"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 02:19:01 -0800
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com> <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com> <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
In-reply-to: <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com>
Date:   Mon, 01 Mar 2021 11:18:59 +0100
Message-ID: <85ft1fjhws.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Tue, Feb 16, 2021 at 6:11 PM Maciej Kwapulinski
> <maciej.kwapulinski@linux.intel.com> wrote:
>>
....
>> +static int __init gna_drv_init(void)
>> +{
>> +       int ret;
>> +
>> +       mutex_init(&gna_drv_priv.lock);
>> +
>> +       gna_class = class_create(THIS_MODULE, "gna");
>> +       if (IS_ERR(gna_class)) {
>> +               pr_err("class device create failed\n");
>> +               return PTR_ERR(gna_class);
>> +       }
>> +       gna_class->devnode = gna_devnode;
>> +
>> +       ret = pci_register_driver(&gna_driver);
>
> Is it possible to decouple a PCI glue driver from the class as many
> other existing examples are doing?
>

I see many pci drivers (including staging) that do have it glued though.

Examples are:
1. "static int __init kp2000_pcie_init(void)" (commit on May 20 09:34:11
2019)
2. "static int __init hl_init(void)" (commit on Mon Feb 18 09:46:43 2019)

Please give me more details.
