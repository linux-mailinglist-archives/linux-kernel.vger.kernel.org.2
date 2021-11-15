Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4264344FF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhKOHWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:22:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:9471 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhKOHWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:22:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220602224"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="220602224"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 23:18:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="585144635"
Received: from mkrawczy-mobl1.ger.corp.intel.com (HELO [10.249.254.108]) ([10.249.254.108])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 23:18:56 -0800
Message-ID: <1ff1389b-bf4c-cd09-8bfd-d4303d100eee@linux.intel.com>
Date:   Mon, 15 Nov 2021 08:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [git pull] drm fixes + one missed next for 5.16-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>
Cc:     Matthew Auld <matthew.auld@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9txVydO1fy8sEwVXRZF0zPfWwLYrk-UnGeKhRCEvrW4B7Q@mail.gmail.com>
 <CAHk-=wiZdONN=1Er5eN1bYurrWqhXF7LxQszpPia8hvYUOiZWQ@mail.gmail.com>
 <CAPM=9tw=NTZ-1NbGupgg42gOA1aFKZ2C6wt++q5BxaocaUbmFA@mail.gmail.com>
 <CAHk-=wjpPWyH5ff0LE8Mmt6OEiYbD3LwpvpD==FFZfTMTzL2FQ@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <CAHk-=wjpPWyH5ff0LE8Mmt6OEiYbD3LwpvpD==FFZfTMTzL2FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/14/21 22:19, Linus Torvalds wrote:
> On Sun, Nov 14, 2021 at 1:00 PM Dave Airlie <airlied@gmail.com> wrote:
>> i915 will no longer be x86-64 only in theory, since Intel now produces
>> PCIe graphics cards using the same hw designs.
> Well, at least in my tree, it still has the "depends on X86", along
> with several other x86-only things (like "select INTEL_GTT", which is
> also x86-only)
>
> So by the time that non-x86 theory becomes reality, hopefully the i915
> people will also have figured out how to do the cache flushing
> properly.
>
> And hopefully that "do it properly" ends up being simply that the
> particular configuration that ends up being portable simply doesn't
> need to do it at all and can statically just not build it,
> sidestepping the issue entirely.
>
> Fingers crossed.

For non-x86 / discrete graphics, plan is only coherent mappings, 
although the "Just not build it" part hasn't been properly figured out 
yet I guess. But point taken.

Thanks,

/Thomas

