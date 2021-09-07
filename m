Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05D2402B91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbhIGPSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:18:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:35756 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236041AbhIGPSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:18:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="220248607"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="220248607"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 08:14:11 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="464857924"
Received: from ikcrook-mobl.amr.corp.intel.com (HELO [10.213.197.103]) ([10.213.197.103])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 08:14:09 -0700
Subject: Re: [Intel-gfx] [PATCH v7 3/8] i915/gvt: use
 DEFINE_DYNAMIC_DEBUG_CATEGORIES to create "gvt:core:" etc categories
To:     jim.cromie@gmail.com, Sean Paul <seanpaul@chromium.org>,
        Jason Baron <jbaron@akamai.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
References: <20210831202133.2165222-1-jim.cromie@gmail.com>
 <20210831202133.2165222-4-jim.cromie@gmail.com>
 <9fe5e962-e65e-6844-269a-058cce944a89@linux.intel.com>
 <CAJfuBxz+cZyyDSBrDR0+Rf7K9fqpmeAfcWb1x2MkwD0P9LuDcQ@mail.gmail.com>
 <2bfbd75c-8f7f-e756-05c3-13dff41264e4@linux.intel.com>
 <CAJfuBxymoFx79kQzGw_Gxv1vk7kVaTN-V0Hn694C6kT=kP7u2A@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <92c7639b-c8f4-cfa4-f9ca-82c0a06e0337@linux.intel.com>
Date:   Tue, 7 Sep 2021 16:14:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJfuBxymoFx79kQzGw_Gxv1vk7kVaTN-V0Hn694C6kT=kP7u2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/09/2021 18:41, jim.cromie@gmail.com wrote:
> On Mon, Sep 6, 2021 at 6:26 AM Tvrtko Ursulin 
> <tvrtko.ursulin@linux.intel.com <mailto:tvrtko.ursulin@linux.intel.com>> 
> wrote:
>  >
>  >
>  > On 03/09/2021 20:22, jim.cromie@gmail.com 
> <mailto:jim.cromie@gmail.com> wrote:
>  > > On Fri, Sep 3, 2021 at 5:07 AM Tvrtko Ursulin
>  > > <tvrtko.ursulin@linux.intel.com 
> <mailto:tvrtko.ursulin@linux.intel.com>> wrote:
>  > >>
>  > >>
>  > >> On 31/08/2021 21:21, Jim Cromie wrote:
>  > >>> The gvt component of this driver has ~120 pr_debugs, in 9 categories
>  > >>> quite similar to those in DRM.  Following the interface model of
>  > >>> drm.debug, add a parameter to map bits to these categorizations.
>  > >>>
>  > >>> DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_gvt, __gvt_debug,
>  > >>>        "dyndbg bitmap desc",
>  > >>>        { "gvt:cmd: ",  "command processing" },
> 
>  > >>> v7:
>  > >>> . move ccflags addition up to i915/Makefile from i915/gvt
>  > >>> ---
>  > >>>    drivers/gpu/drm/i915/Makefile      |  4 ++++
>  > >>>    drivers/gpu/drm/i915/i915_params.c | 35 
> ++++++++++++++++++++++++++++++
>  > >>
>  > >> Can this work if put under gvt/ or at least intel_gvt.h|c?
> 
> I tried this.
> I moved the code block into gvt/debug.c (new file)
> added it to Makefile GVT_SOURCES
> dunno why it wont make.
> frustratig basic err, Im not seeing.
> It does seem proper placement, will resolve...
> 
> 
>  > >>
>  > >
>  > > I thought it belonged here more, at least according to the name of the
>  > > config.var
>  >
>  > Hmm bear with me please - the categories this patch creates are intended
>  > to be used explicitly from the GVT "sub-module", or they somehow even
>  > get automatically used with no further intervention to callers required?
>  >
> 
> 2009 - v5.9.0  the only users were admins reading/echoing 
> /proc/dynamic_debug/control
> presumably cuz they wanted more info in the logs, episodically.
> v5.9.0 exported dynamic_debug_exec_queries for in-kernel use,
> reusing the stringy: echo $query_command > control  idiom.
> My intention was to let in-kernel users roll their own drm.debug type 
> interface,
> or whatever else they needed.  nobodys using it yet.

What is 2009 referring to?

I am still not quite following. In case of the GVT categories you added, 
in order for them to be used, would you or not also need to use some new 
logging macros?

> patch 1/8 implements that drm.debug interface.
> 5/8 is the primary use case
> 3/8 (this patch) & 4/8 are patches of opportunity, test cases, proof of 
> function/utility.
> its value as such is easier control of those pr-debugs than given by 
> echo > control
> 
> Sean Paul seanpaul@chromium.org <mailto:seanpaul@chromium.org> worked up 
> a patchset to do runtime steering of drm-debug stream,
> in particular watching for drm:atomic:fail: type activity (a subcategory 
> which doesnt exist yet).
> 5/8 conflicts with his patchset, I have an rfc approach to that, so his 
> concerns are mine too.

What kind of runtime steering is that - would you happen to have a link?

One idea we in the GEM team have mentioned a few time is the ability of 
making the debug log stream per DRM client. That means opening 
"something" (socket, fd, etc), enabling debug, which would only show 
debug logs belonging to one client. That can sometimes be useful (and 
more secure) than enabling a lot of debug for the system as a whole. But 
of course there isn't much overlap with your dyndbg work. So just 
mentioning this since the word "runtime steering" reminded me of it.

<snip>

>      > unsigned long __gvt_debug;
>      > EXPORT_SYMBOL(__gvt_debug);
>      >
>      >
>      >>> +
>      >>>    # Please keep these build lists sorted!
>      >>>
>      >>>    # core driver code
>      >>> diff --git a/drivers/gpu/drm/i915/i915_params.c
>     b/drivers/gpu/drm/i915/i915_params.c
>      >>> index e07f4cfea63a..e645e149485e 100644
>      >>> --- a/drivers/gpu/drm/i915/i915_params.c
>      >>> +++ b/drivers/gpu/drm/i915/i915_params.c
>      >>> @@ -265,3 +265,38 @@ void i915_params_free(struct i915_params
>     *params)
>      >>> +                             _DD_cat_("gvt:mmio:"),
>      >>> +                             _DD_cat_("gvt:render:"),
>      >>> +                             _DD_cat_("gvt:sched:"));
>      >>> +
>      >>> +#endif
>      >>
>      >> So just the foundation - no actual use sites I mean? How would
>     these be
>      >> used from the code?
>      >>
>      >
>      > there are 120 pr_debug "users" :-)
>      >
>      > no users per se, but anyone using drm.debug
>      > /sys/module/drm/parameters/debug
>      > might use this too.
>      > its a bit easier than composing queries for
>      >/proc/dyamic_debug/control
> 
>     Same as my previous question, perhaps I am not up to speed with this
>     yet.. Even if pr_debug is used inside GVT - are the categories and
>     debug_gvt global as of this patch (or series)?
> 
> 
> they are already global in the sense that if kernel is built with 
> DYNAMIC_DEBUG,
> the admin can turn those pr_debugs on and off, and change their 
> decorations in the log (mod,func.line).
> Nor are modules protected from each other; drm-core could use 
> dd-exec-queries to enable/disable
> pr-debugs in i915 etc
> 
> This patch just adds a gvt-debug knob like drm-debug. using the existing 
> format prefixes to categorize them.
> Whether those prefixes should be bent towards consistency with the rest 
> of drm-debug
> or adapted towards some gvt community need I couldnt say.
> 
> Its no save-the-world feature, but its pretty cheap.
> 
> Id expect the same users as those who play with drm.debug, for similar 
> reasons.
> 
> does this clarify ?

Not yet I'm afraid. :) When you say "using the existing format 
prefixes", but it is not using __drm_debug but __gvt_debug (which isn't 
a modparam). So I am lost as to what is __gvt_debug for and how does it 
tie to existing DRM categories.

Regards,

Tvrtko
