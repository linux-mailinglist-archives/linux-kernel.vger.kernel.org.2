Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C414E37A736
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhEKM5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:57:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:14379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhEKM5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:57:50 -0400
IronPort-SDR: BqnuO4epzvQ8GCyO/XLfZObalOMJ3d282GVXWAxzfaQjPf0gL693Eu1S9B6989ovHC/ECUcfwG
 BfIxzi5hd9Uw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="260694306"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="260694306"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:56:43 -0700
IronPort-SDR: IuvjxKpluZHPFjuGczJEoD1k9qODbiH+ABvlrtGiH2pVsKJE6vXYYbNegVxKMCJ5BG5C8IMbnS
 OCcX0gi53Rhg==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="434433649"
Received: from ialvarez-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.32.67])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:56:40 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Paul Zimmerman <pauldzim@gmail.com>,
        Timo Aaltonen <tjaalton@ubuntu.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH RFC] Revert "drm/i915: Try to use fast+narrow link on eDP again and fall back to the old max strategy on failure"
In-Reply-To: <87a6p1v39b.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210509044330.4655-1-pauldzim@gmail.com> <02957632-b050-f9eb-fcd8-75db9c92b8e0@ubuntu.com> <CADBGO7_cH2e1-zgVNvwVPRogqeFjTfJhKcuTfdF=xc_GoMmknA@mail.gmail.com> <87a6p1v39b.fsf@intel.com>
Date:   Tue, 11 May 2021 15:56:38 +0300
Message-ID: <877dk5v37d.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Mon, 10 May 2021, Paul Zimmerman <pauldzim@gmail.com> wrote:
>> On Mon, May 10, 2021 at 7:00 AM Timo Aaltonen <tjaalton@ubuntu.com> wrote:
>>>
>>> On 9.5.2021 7.43, Paul Zimmerman wrote:
>>> > This reverts commit 2bbd6dba84d44219387df051a1c799b7bac46099.
>>> >
>>> > Since 5.12-rc2, my Dell XPS-15 laptop has had a blank screen on boot.
>>> > The system seems to run fine other than having no display, I am able
>>> > to ssh into the machine. I don't see anything interesting in the dmesg
>>> > log. I bisected the problem down to this commit, and reverting it fixes
>>> > the problem.
>>>
>>> Have you tried with drm-tip? It has acca7762eb71bc0 which hopefully
>>> helps here.
>>
>> I picked that one commit from the drm-tip tree (wasn't sure how to merge
>> the entire tree into the kernel) and can confirm that it does fix the problem.
>> Thank you! I hope the fix will be sent to Linus pretty soon, and it will need
>> backporting to the 5.12 kernel as well.
>
> I've picked up 2bbd6dba84d4 ("drm/i915: Try to use fast+narrow link on
> eDP again and fall back to the old max strategy on failure") to
> drm-intel-fixes, and it should find itself in v5.13-rc2 and subsequently
> v5.12 stable in the coming weeks.

I mean I've picked up acca7762eb71 ("drm/i915/dp: Use slow and wide link
training for everything").


>
> BR,
> Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
