Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C8A32695D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBZVYm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Feb 2021 16:24:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:23780 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhBZVYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:24:39 -0500
IronPort-SDR: Fc4IG+LyJ5FwE+XqeXm8mwgU6KmuWYUWBZSTJdgV1430ba2zC/ZFEl4c4yHxytPG77APygS2+7
 Jw4g30cAdjfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="186116703"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="186116703"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 13:22:51 -0800
IronPort-SDR: 0eUhk/VHMCt2DCyWtnllR79YoOH6qTZI0+sNZESz7u/LYpxBIqefAi0yMIuyjTBRb+jLTWmZWr
 ovyGgWldfULQ==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="367912304"
Received: from mumar-mobl1.amr.corp.intel.com ([10.209.42.188])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 13:22:51 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH v1 01/12] gna: add driver module
From:   Jianxun Zhang <jianxun.zhang@linux.intel.com>
In-Reply-To: <85tupysmwc.fsf@linux.intel.com>
Date:   Fri, 26 Feb 2021 13:22:20 -0800
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5A98CC3E-EAA4-46FC-8FCC-36DE862E52A2@linux.intel.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
 <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com>
 <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com>
 <85tupysmwc.fsf@linux.intel.com>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 26, 2021, at 10:29 AM, Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com> wrote:
> 
> 
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> 
>> On Tue, Feb 16, 2021 at 6:11 PM Maciej Kwapulinski
>> <maciej.kwapulinski@linux.intel.com> wrote:
>>> 
> ....
>>> +#define GNA_DRV_VER    "1.2.0"
>> 
>> Nowadays the version is the Git SHA sum.
>> 
> 
> right, "version" is present in about 7% of all modules
> 
> do You mean version should be skipped over (automatically generated)
> srcversion field? or maybe You suggest any (better) technique?

Just my 0.02. We should identify who will consume this version string for what purposes. Then we can decide if a hardcoded macro or any auto-gen tags should be used. If we don’t find such need, perhaps we just remove it since a snapshot of the code is always tagged  by commit SHA1 in git. (maybe this is what Andy suggested?).

Having such hardcoded version string requires an update policy in return, to make it really useful, IMO.

