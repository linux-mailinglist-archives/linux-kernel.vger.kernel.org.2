Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5B33A33E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 07:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhCNF5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 00:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhCNF4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 00:56:19 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F1CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 21:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Xefqu3vKkF6QxL4rotZMwFoLVYhsZK1Asts4uTOyJk8=; b=XPThki4oj5XZ/Ldj9sJKNOZUs5
        R2hzmrSuXfIbd7dL6vAp7G2vTuVpjRfMghkAGqmz20Gl19LAzbKvPBXqdp19qPiofOqSB2YkRXUhx
        Kn9Pl/ZbCazdZAjSlJli+ZfJdlqoxVfGI018IJ23g+qmUkkmaRSaabhRE6I7ZVY6d67F+iU+ftqYV
        iGHAeOsoq2L0AOcFnNCw57gUeyiRtb9u+VeCJ1LiJ0ZtnS6bskQzaJ2zXX0r7D/DvWkogUAFcJgaJ
        alr86IhbXZmIWXeJWyxGil8gmotozfwTxO6pLmSkOMBF2pbDXNtc9W4RmDAt8NIHP2YjSSjENVKOj
        pAtzlrXg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLJjW-001B1C-G6; Sun, 14 Mar 2021 05:56:10 +0000
Subject: Re: [PATCH] gpu: drm: i915: gt: Rudimentary typo fix in the file
 intel_timeline.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        chris@chris-wilson.co.uk, tvrtko.ursulin@intel.com,
        mika.kuoppala@linux.intel.com, maarten.lankhorst@linux.intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210314044303.9220-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <26e08f86-47a9-fd3d-2d68-5b53c2e1d692@infradead.org>
Date:   Sat, 13 Mar 2021 21:56:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314044303.9220-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/21 8:43 PM, Bhaskar Chowdhury wrote:
> 
> s/bariers/barriers/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/gpu/drm/i915/gt/intel_timeline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_timeline.c b/drivers/gpu/drm/i915/gt/intel_timeline.c
> index 8015964043eb..2b921c1796dc 100644
> --- a/drivers/gpu/drm/i915/gt/intel_timeline.c
> +++ b/drivers/gpu/drm/i915/gt/intel_timeline.c
> @@ -416,7 +416,7 @@ void intel_timeline_exit(struct intel_timeline *tl)
>  	spin_unlock(&timelines->lock);
> 
>  	/*
> -	 * Since this timeline is idle, all bariers upon which we were waiting
> +	 * Since this timeline is idle, all barriers upon which we were waiting
>  	 * must also be complete and so we can discard the last used barriers
>  	 * without loss of information.
>  	 */
> --


-- 
~Randy

