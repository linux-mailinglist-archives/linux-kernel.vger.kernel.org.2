Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72E736791F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhDVFOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhDVFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:14:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2E5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 22:13:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so318105pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 22:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3jzoNMjqJu4u6e3k4lUJ1/0TMWqKsbwyKg5j36YKTrc=;
        b=mI5DCWnPqLY5ZZEmZEtjgpUCoX2ZiJ9sCPHMglKA0Oa2l6g3m3J4Gf17W5LdDADZqR
         ND0foHG1ICIGQUSUp70iV5gVk5SJDitBdpkrj1KsA90RHn3mcMlmZIKYkGwNEnSo+VeK
         EFMmhaFO7gtKUoeENJoM6dsuRe+lUFOxsAe8d0obNVjADEA8v+h9u+cUBF9D86MlL9Ik
         3Qf1P9PDj8cto15MqQiz5iuypbS2xR1s6ssxJOZItN9S3gB0RaohzGhzuZCfgPqMAGTN
         0BZugJIbQUeAlXtDJe6gOsT/Ei1AIUVp9GcUVgXd139wOzk+unx8aBa/URmhibk5QJBY
         3VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3jzoNMjqJu4u6e3k4lUJ1/0TMWqKsbwyKg5j36YKTrc=;
        b=VJzScIzjZPh4NGDaPKRvTFmtNHJpwIB6yroQhH8ikO7k1GlYnm4Y3Srd7fsvBH6p0T
         EuvEYyMXpk1z2QZiHFjeRMBzbOO77W7pDML5VVI7twIFmp6dSxsmaJoVY3DbW4K4Q74V
         LxxiwEAKRFQ+CC//g+QqJkkG1j4jZSIqbRtnqY0V7/oRY/2ebUeaEgnzQwShrxbHuZWA
         n93y0tWG4tiyKR2fWZB/eA+GE3b3rEI/uNyhTzxDo67AqNyAcn+yiPvPOO5oknvQA6fW
         FpKfuKznfR4aoaj1IW6zcf5PxZTCu7x9CgGw5VGGcbaYmpic5c5DQNto0tY1trLuej4u
         AX5w==
X-Gm-Message-State: AOAM532GeN7+D3/tMXOoPjJIGyu/OhS0+V3yxLN5w6F3yhvoWYemBmtb
        gcH7EoNSkvWRPj3jy1RhGSJRq2q9KUiq8Q==
X-Google-Smtp-Source: ABdhPJxXRxrlho+Ufg/M4/EdmndPqzudFYgmXTCKp2YCfVVy0JNCVi9YZ/uaiCn2kLDvSP9ji/wx2A==
X-Received: by 2002:a17:90a:2807:: with SMTP id e7mr2002621pjd.181.1619068428867;
        Wed, 21 Apr 2021 22:13:48 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id o4sm847144pfk.15.2021.04.21.22.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 22:13:48 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:43:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: Re: [PATCH 100/190] Revert "staging: greybus: audio_manager: fix a
 missing check of ida_simple_get"
Message-ID: <20210422051345.gmxlylb5ykal7xqv@vireshk-i7>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-101-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-101-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-21, 14:59, Greg Kroah-Hartman wrote:
> This reverts commit b5af36e3e5aa074605a4d90a89dd8f714b30909b.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/greybus/audio_manager.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
> index 9a3f7c034ab4..7c7ca671876d 100644
> --- a/drivers/staging/greybus/audio_manager.c
> +++ b/drivers/staging/greybus/audio_manager.c
> @@ -45,9 +45,6 @@ int gb_audio_manager_add(struct gb_audio_manager_module_descriptor *desc)
>  	int err;
>  
>  	id = ida_simple_get(&module_id, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> -		return id;
> -
>  	err = gb_audio_manager_module_create(&module, manager_kset,
>  					     id, desc);
>  	if (err) {

FWIW, this patch was doing the right thing IMO. So we may not want to
revert it.

-- 
viresh
