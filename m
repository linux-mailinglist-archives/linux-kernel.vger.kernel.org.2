Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5DC3F2213
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 23:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhHSVGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 17:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhHSVGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:06:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9568C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 14:05:24 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f6a00c0b6242459a20f3a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:c0b6:2424:59a2:f3a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E943A1EC0588;
        Thu, 19 Aug 2021 23:05:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629407119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ed4mXwmRVqLclUiNXnj7DXqaHYC42Xp4b2eHflFyFHg=;
        b=sRBztmFayDjLguvromcB5N4O75dmPHYZEtz1HPOVKzaOcAdC5sdQtJIePgw9o8wDFlOHOO
        RkfwaSPShkwPTJwH7ubD4ecrtbyLun/JC7m7BjkTyh7SvQ/kczfkxP3YIow0y9p2KNdGLZ
        joS9pS5+7wi5TLjnqjuGcqITPvT2ADI=
Date:   Thu, 19 Aug 2021 23:05:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 064855a69003c24bd6b473b367d364e418c57625
Message-ID: <YR7HtVf3OzM7/3qj@zn.tnic>
References: <6118d218.4ZZRXYKZCzQSq1Km%lkp@intel.com>
 <YRjTkkpDjaWxEpjb@zn.tnic>
 <ced3f2ab-54b6-95d7-7f5b-b6bb6a299330@intel.com>
 <YR4dr079URttZRrg@zn.tnic>
 <bf20583c-80d4-a037-c5dc-ba243ac6cb0f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf20583c-80d4-a037-c5dc-ba243ac6cb0f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 01:39:46PM -0700, Reinette Chatre wrote:
> I can confirm that the removed comment explains why m would be initialized
> when used in the code that follows.
> 
> How would you prefer to address this? We could add just the comment back in
> support of future reports or perhaps by adding the default case back with
> the same error that would be returned earlier when there is an invalid
> EVENT_ID. Something like:
> 
> ---8<---
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 57e4bb695ff9..05b99e4d621c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -304,6 +304,12 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read
> *rr)
>  	case QOS_L3_MBM_LOCAL_EVENT_ID:
>  		m = &rr->d->mbm_local[rmid];
>  		break;
> +	default:
> +		/*
> +		 * Code would never reach here because
> +		 * an invalid event id would fail the __rmid_read.
> +		 */
> +		return RMID_VAL_ERROR;
>  	}
> 
>  	if (rr->first) {

Right, I would normally not take a patch just to fix a tool because it
cannot see it correctly.

But Babu has another use case which breaks the build so I guess that's
serious enough to make an exception.

Babu, can you please explain?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
