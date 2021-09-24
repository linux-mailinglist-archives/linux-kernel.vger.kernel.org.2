Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA516417773
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347045AbhIXPZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhIXPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 11:25:37 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65743C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=w/RM/8BO7l8xctNYRjJvsYUrVn8YVpOUoLpdN3in2KY=; b=d0XKonSq79aq4Y7rBB9oWbf/L8
        fR8k4wS6hdbutVD5x0nvLdA8Gx8OUEPjWvvr8Yi3QYvaCCUcBTbjHsKn0ArsN2By+ls2JJqkQtnh5
        SSi7f+W79H4S9lkzXSnekMt5mCvEQNT6iTzLnv6kK0GyIvgpkyh7A+gwXZdTmjBWf8rL6nDgy3jws
        C4RWN8RDxlbTh0AZPAEp81+kiMhlguW6q1L92etJWKMGzVii7ETEalqCXhZg5uBfXKYVaoIwqAfkF
        02dpt+wt3BRajk/w3z6wmWTHWDmIkc0IlnggACvARm00wxr9Ff5TYrf5R+LPvENdfRnJCr49Jys/u
        ffMrQRWw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTn3M-00Ewqi-CI; Fri, 24 Sep 2021 15:23:56 +0000
Subject: Re: [PATCH] drm/edid: Fix EDID quirk compile error on older compilers
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     a.hajda@samsung.com, smyakam@microsoft.com,
        jani.nikula@linux.intel.com, linus.walleij@linaro.org,
        stanislav.lisovskiy@intel.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
References: <20210924075317.1.I1e58d74d501613f1fe7585958f451160d11b8a98@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fe48df3f-a6ec-d787-4672-254c8bd4c313@infradead.org>
Date:   Fri, 24 Sep 2021 08:23:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924075317.1.I1e58d74d501613f1fe7585958f451160d11b8a98@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 7:53 AM, Douglas Anderson wrote:
> Apparently some compilers [1] cannot handle doing math on dereferenced
> string constants at compile time. This has led to reports [2] of
> compile errors like:
> 
>    In file included from drivers/gpu/drm/drm_edid.c:42:0:
>    ./include/drm/drm_edid.h:525:2: error: initializer element is not constant
>      ((((u32)((vend)[0]) - '@') & 0x1f) << 26 | \
> 
> Go back to the syntax I used in v4 of the patch series [3] that added
> this code instead of what landed (v5). This syntax is slightly uglier
> but should be much more compatible with varied compilers.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69960#c18
> [2] https://lore.kernel.org/r/874kaabdt5.fsf@intel.com/
> [3] https://lore.kernel.org/r/20210909135838.v4.4.I6103ce2b16e5e5a842b14c7022a034712b434609@changeid/
> 
> Fixes: d9f91a10c3e8 ("drm/edid: Allow querying/working with the panel ID from the EDID")
> Reported-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
> Reported-by: Srikanth Myakam <smyakam@microsoft.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/gpu/drm/drm_edid.c        | 121 +++++++++++++++---------------
>   drivers/gpu/drm/panel/panel-edp.c |  23 +++---
>   include/drm/drm_edid.h            |  14 ++--
>   3 files changed, 81 insertions(+), 77 deletions(-)
> 

Works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


-- 
~Randy
