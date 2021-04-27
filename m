Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B617936C8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhD0Pdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhD0Pdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:33:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=LQWA5Vj4/vDTbjcIAJB1lIQbwCbGR7wOkwAKtHeU/fo=; b=LiBcd29YiOroBKZ3tf8wjAoMRx
        R7P9hHXyjzfRMPScN8KiVdQh1Fl4P/Vb3LNki7eNFchPrLYs+pAB/s8J5J7cghN5CQ2K1PCHOyryG
        D7TmrFM1yuBYk9EP7bZhOB7MsQb/qMaICJfzYsVRMMu034YNqKBmOiR2xCt9tkWv685bDt2JE1HLF
        H8TXCSrueLo9mxh8BJhmYc48h+ftoLHfd0EWmhjRpKo4HxuTymO/z6XzF8KF6kKKKQua7Pvs3RF5I
        Ng7kmJ2apAX9UOSaeY6AIAH2UXD1GcUNt24K55lxson17SN2gxeRKRbHPSNTZ+K5qnrIiJg+7y96q
        qLUHFS4Q==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbPgt-0074eB-GM; Tue, 27 Apr 2021 15:32:10 +0000
Subject: Re: [PATCH] drm: i915: fix build when ACPI is disabled and
 BACKLIGHT=m
To:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Damien Lespiau <damien.lespiau@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20210426183516.18957-1-rdunlap@infradead.org>
 <874kfs5f3d.fsf@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <866940af-bbbf-a1cd-b1e3-aafe94686a22@infradead.org>
Date:   Tue, 27 Apr 2021 08:31:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <874kfs5f3d.fsf@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/21 1:03 AM, Jani Nikula wrote:
> On Mon, 26 Apr 2021, Randy Dunlap <rdunlap@infradead.org> wrote:
>> When CONFIG_DRM_I915=y, CONFIG_ACPI is not set, and
>> CONFIG_BACKLIGHT_CLASS_DEVICE=m, not due to I915 config,
>> there are build errors trying to reference backlight_device_{un}register().
>>
>> Changing the use of IS_ENABLED() to IS_REACHABLE() in intel_panel.[ch]
>> fixes this.
> 
> I feel like a broken record...

Thanks! :)

I'll leave it b0rken as well.


> CONFIG_DRM_I915=y and CONFIG_BACKLIGHT_CLASS_DEVICE=m is an invalid
> configuration. The patch at hand just silently hides the problem,
> leaving you without backlight.
> 
> i915 should *depend* on backlight, not select it. It would express the
> dependency without chances for invalid configuration.
> 
> However, i915 alone can't depend on backlight, all users of backlight
> should depend on backlight, not select it. Otherwise, you end up with
> other configuration problems, circular dependencies and
> whatnot. Everyone should change. See also (*) why select is not a good
> idea here.
> 
> I've sent patches to this effect before, got rejected, and the same
> thing gets repeated ad infinitum.
> 
> Accepting this patch would stop the inflow of these reports and similar
> patches, but it does not fix the root cause. It just sweeps the problem
> under the rug.
> 
> 
> BR,
> Jani.
> 
> (*) Documentation/kbuild/kconfig-language.rst:
> 
> 	select should be used with care. select will force
> 	a symbol to a value without visiting the dependencies.
> 	By abusing select you are able to select a symbol FOO even
> 	if FOO depends on BAR that is not set.
> 	In general use select only for non-visible symbols
> 	(no prompts anywhere) and for symbols with no dependencies.
> 	That will limit the usefulness but on the other hand avoid
> 	the illegal configurations all over.

Yes, I'm well aware of that.

ta.
-- 
~Randy

