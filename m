Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25C43266E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBZSbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:31:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:24447 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhBZSbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:31:42 -0500
IronPort-SDR: 5SEavgwx7D6PmT+zkhHEcOe/MStSkl+Q6sJlMyXd6J2iZbQvAxDwAbfytF8YZnPGWltee20yrn
 9c7bXNeMy9MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="205502798"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="205502798"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 10:29:46 -0800
IronPort-SDR: XduxGCmDmR6LTHB5zJHhF2YIG2jOE4ipOdQHfDupRL0Bde6Q+/XFfs/1n7j+l+PnPXzWjKMTIu
 xtshLmL9tlAg==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="405078296"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 10:29:43 -0800
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
Date:   Fri, 26 Feb 2021 19:29:39 +0100
Message-ID: <85tupysmwc.fsf@linux.intel.com>
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
>> +#define GNA_DRV_VER    "1.2.0"
>
> Nowadays the version is the Git SHA sum.
>

right, "version" is present in about 7% of all modules

do You mean version should be skipped over (automatically generated)
srcversion field? or maybe You suggest any (better) technique?
