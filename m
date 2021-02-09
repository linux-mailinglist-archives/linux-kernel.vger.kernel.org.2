Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5600D314B13
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhBIJBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:01:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:58066 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229891AbhBII6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:58:06 -0500
IronPort-SDR: nIf9ZSCQco600GEwbKOGJ2u10nNRQdXvQKCgD/99ITdV+aYnmkgGSS6YGDqzj0gu+aAJn75DaR
 T7id+gM7vBOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="266684592"
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; 
   d="scan'208";a="266684592"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 00:57:46 -0800
IronPort-SDR: jS6fqE6CFHTv8+2qp9aMc0TJVcgVwSflAoyHxTBq5ljJK8sbgJ2FX02Iimi6jE7zlejl2rl6Fs
 A2JPXGTbFmkg==
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; 
   d="scan'208";a="436016444"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 00:57:42 -0800
Subject: Re: [kbuild-all] Re: [patch 06/12] x86/entry: Convert system vectors
 to irq stack macro
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        x86@kernel.org, Kees Cook <keescook@chromium.org>
References: <20210204211154.713523041@linutronix.de>
 <202102051148.WIj5O4Ry-lkp@intel.com>
 <YB1SdvRbHMY7IRrY@hirez.programming.kicks-ass.net>
 <ad03c046-3249-8ac2-96af-03b2312454c0@intel.com>
 <20210208141957.GA18227@zn.tnic>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <536a6b24-fadb-cb2a-8259-dadd3730c6ce@intel.com>
Date:   Tue, 9 Feb 2021 16:57:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210208141957.GA18227@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/21 10:19 PM, Borislav Petkov wrote:
> On Sun, Feb 07, 2021 at 04:15:11PM +0800, Rong Chen wrote:
>> Thanks for the advice, we'll add the check to our cluster,
>> and sorry for the inconvenience.
> When it comes to the tip tree, I'd say you guys are much better off not
> scraping any patches from the mailing list but simply testing the tip
> branches. That would be more than enough and you already do that anyway.
>
> Thx.
>

Hi Borislav,

Thanks for the help, how can we identify the patches for tip tree,
could you please guide us?

Best Regards,
Rong Chen
