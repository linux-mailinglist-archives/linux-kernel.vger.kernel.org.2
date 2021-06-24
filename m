Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9383F3B3505
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 19:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhFXRwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 13:52:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:5641 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhFXRwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:52:03 -0400
IronPort-SDR: vk4NrxwoQKmi6tjevlZMKVmfs25YFhSgyx9wXStqpasdDnIXkSDfY+cDsAyynB/QVfGDNZ09IB
 nyzxhFXM4Dwg==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="204519317"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="204519317"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:49:44 -0700
IronPort-SDR: SfVF8QNFENIjP2+AkMOtwdg4oRmtBGnPnJo5206IEx8McrFWCf9qUXCkpCprZV9Typ+y0nZ2Xv
 tto7YZe6Zgiw==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="406720618"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.74.185]) ([10.209.74.185])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:49:43 -0700
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
To:     Greg KH <greg@kroah.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <33bccec9-c4c4-d52b-9ee4-9a09e7353812@linux.intel.com>
 <YNTCa5QO1YMy8fJ0@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <1d77c148-7ea6-4631-d799-e8ec3d31f347@linux.intel.com>
Date:   Thu, 24 Jun 2021 10:49:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNTCa5QO1YMy8fJ0@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> That is not how sysfs and the driver model works, sorry.  You don't get
> to keep both names, otherwise sysfs would be even more of a mess than it
> currently is.  What happens if you need "another" name in the future?
> When do you stop

I don't see any scenario where we would ever need more than a single 
symlink.

I believe there is already precedent for this elsewhere.

>
> this isn't ok, please do it right.

I don't see what exactly are you proposing.

Are you proposing to break every perf script on a kernel update? Doesn't 
seem acceptable to me.

Or move the compatibility into the perf tool? That would require the 
users to both update the perf tool and the kernel. I suppose it would be 
possible, but it would be totally against the standard perf abstraction 
design. Besides there are other consumers of this than just the perf 
tool, so it could possibly have a wide impact.

-Andi

