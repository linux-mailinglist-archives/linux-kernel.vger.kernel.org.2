Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A843EB956
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhHMPod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:44:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:32407 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236037AbhHMPoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:44:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="202771790"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="202771790"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 08:44:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="571833136"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 08:43:52 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mEZLU-009Hky-Ik; Fri, 13 Aug 2021 18:43:44 +0300
Date:   Fri, 13 Aug 2021 18:43:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     gregkh@linuxfoundation.org, seanpaul@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Huang Rui <ray.huang@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        Aaron Liu <aaron.liu@amd.com>,
        John Clements <john.clements@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Marco Elver <elver@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Johannes Berg <johannes.berg@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v5 2/9] moduleparam: add data member to struct
 kernel_param
Message-ID: <YRaTMFzUFCeC6ELA@smile.fi.intel.com>
References: <20210813151734.1236324-1-jim.cromie@gmail.com>
 <20210813151734.1236324-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813151734.1236324-3-jim.cromie@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 09:17:10AM -0600, Jim Cromie wrote:
> Add a const void* data member to the struct, to allow attaching
> private data that will be used soon by a setter method (via kp->data)
> to perform more elaborate actions.
> 
> To attach the data at compile time, add new macros:
> 
> module_param_cbd() derives from module_param_cb(), adding data param,
> and latter is redefined to use former.
> 
> It calls __module_param_call_wdata(), which accepts a new data param
> and inits .data with it. Re-define __module_param_call() to use it.
> 
> Use of this new data member will be rare, it might be worth redoing
> this as a separate/sub-type to de-bloat the base case.

...

> +#define module_param_cbd(name, ops, arg, perm, data)				\
> +	__module_param_call_wdata(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0, data)

Cryptic name. Moreover, inconsistent with the rest.
What about module_param_cb_data() ?

>  #define module_param_cb_unsafe(name, ops, arg, perm)			      \
>  	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1,    \
>  			    KERNEL_PARAM_FL_UNSAFE)

(above left for the above comment)

...

> +#define __module_param_call_wdata(prefix, name, ops, arg, perm, level, flags, data) \

Similar __module_param_call_with_data()

-- 
With Best Regards,
Andy Shevchenko


