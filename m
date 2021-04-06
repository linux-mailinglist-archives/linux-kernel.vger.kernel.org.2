Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C670435571E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbhDFO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:58:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:39841 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233155AbhDFO6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:58:35 -0400
IronPort-SDR: DVbJorUWv6hFl/uJAqjtTuRQKzV9PF8LL2bgZx41Vqry2Dz1/xSu3ZpjRZaBkYPGCXZjP9rNpK
 Smg8sLMithYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180212868"
X-IronPort-AV: E=Sophos;i="5.81,309,1610438400"; 
   d="scan'208";a="180212868"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 07:58:17 -0700
IronPort-SDR: fiFrUVJOYBijNDSYd8YfSnVrVO43Eiwcw7E79dUIh9AmdPS/0mn11FiveoK1e64UsqswJHiCu7
 P4dGbcu4gEtA==
X-IronPort-AV: E=Sophos;i="5.81,309,1610438400"; 
   d="scan'208";a="519067118"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 07:58:14 -0700
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com> <20210324183610.4574-3-maciej.kwapulinski@linux.intel.com> <CAHp75Vdbb2f10MyN_xwZNk8fjB2d2MjP3qCVoSZqbrOrJ_DHNQ@mail.gmail.com>
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
Subject: Re: [PATCH v2 02/13] intel_gna: add component of hardware operation
In-reply-to: <CAHp75Vdbb2f10MyN_xwZNk8fjB2d2MjP3qCVoSZqbrOrJ_DHNQ@mail.gmail.com>
Date:   Tue, 06 Apr 2021 16:58:12 +0200
Message-ID: <85wntfo3y3.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Wed, Mar 24, 2021 at 8:38 PM Maciej Kwapulinski
> <maciej.kwapulinski@linux.intel.com> wrote:
>> +#define gna_reg_write(addr, offset, value)     writel((value), (addr) + (offset))
>
> No point And make them functions, not macros.
>
>> +
>> +#endif // __GNA_HW_H__
>> --
>> 2.28.0
>>

Andy, Thank You for all Your comments on these two patches.

I'm starting to work with them. Just as with v1 patch series, I'll
get back to You in case of any questions
Regards,
Maciej
