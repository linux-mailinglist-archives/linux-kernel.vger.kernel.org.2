Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08E0366FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbhDUQFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244225AbhDUQFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:05:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48613C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XHthP/flvcnD9WPMwE3WBFicv5jL7de75V4TawaXxpA=; b=bwTX+Poy8a5vED5MWK8h65DCcg
        OZxc3/wzzlU06PUZoT0RTHujCWYgG3RLRyokIHYF2+Ke0EZMlwUr/iXT9YRdmM0woeySHS5Tt18wv
        vhqosPvU68sjgpRIr3yRyR/cwYryUBIVFwZSfouSgdpZmD19444ppxKiBUNSFZhyjgf6Q6UWc+Drx
        rNBDBiu4ly9shovOjpa1VSdnPXhFGs2ZsbbCzZfTmyq70AlzpVateynSeHqWaRwyoM9xFOp5XK1hR
        P7dvV62tdzuwn0pFa+Zxvrry+/3k7r5boXNeLm6cjVDfe3KWn+zMvq4xHlghgPvgO7Ou3Vk4a/sA3
        QES3XOKA==;
Received: from [2601:1c0:6280:3f0:d7c4:8ab4:31d7:f0ba]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZFL8-00EioC-Fl; Wed, 21 Apr 2021 16:04:34 +0000
Subject: Re: [PATCH 4/4] x86/speculation: Add PSF mitigation kernel parameters
To:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210421090117.22315-1-rsaripal@amd.com>
 <20210421090117.22315-5-rsaripal@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4c688fc7-67df-3187-54b2-bf20e510fb39@infradead.org>
Date:   Wed, 21 Apr 2021 09:04:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210421090117.22315-5-rsaripal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/21/21 2:01 AM, Ramakrishna Saripalli wrote:
> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
> 
> PSF mitigation introduces a new kernel parameter called
> 	predict_store_fwd.
> 
> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..58f6bd02385b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3940,6 +3940,11 @@
>  			Format: {"off"}
>  			Disable Hardware Transactional Memory
>  
> +	predict_store_fwd	[X86] This option controls PSF mitigation
> +			off - Turns on PSF mitigation.
> +			on  - Turns off PSF mitigation.
> +			default : on.

This should be formatted more like:

+	predict_store_fwd=	[X86] This option controls PSF mitigation
+			off - Turns on PSF mitigation.
+			on  - Turns off PSF mitigation.
+			default: on.

But why does "off" turn it on and "on" turn it off?


> +
>  	preempt=	[KNL]
>  			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
>  			none - Limited to cond_resched() calls
> 

thanks.
-- 
~Randy

