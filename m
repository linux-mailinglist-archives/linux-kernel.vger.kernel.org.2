Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944993D8B71
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbhG1KKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235619AbhG1KKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:10:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64B3860F59;
        Wed, 28 Jul 2021 10:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627467048;
        bh=oYtSaHuCev8H+HQfGDBQNg90APkF9rQSwyALdz0wpvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCM+k+Dny6+IqwHTV4YlhIhO4A5AVFcR/ee40BaiBUZh76jhHy/CsOGmxzggB988W
         p8sx8mTJeTijhiQaHNSFhAtvx2YHUSBcSR//nbBE1Lwz/6FfFZKVD/NkJDg2kvjnfc
         ezZeD8xNg2HrlcIbJT/NifOX52XZNNVjmH7cZTEI=
Date:   Wed, 28 Jul 2021 12:10:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiao Yanbo <qiaoyanbo_310@163.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: kobject_add_internal cleanup
Message-ID: <YQEtJkPFDWMSAd/C@kroah.com>
References: <20210727143212.39142-1-qiaoyanbo_310@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727143212.39142-1-qiaoyanbo_310@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:32:12PM +0800, Qiao Yanbo wrote:
> From: qiaoyanbo <qiaoyanbo_310@163.com>

This does not match your "From:" line in your email address, please use
your real name here and in your signed-off-by line like your email
shows.

> 
> parent assignment in "if" block only need to consider when parent is NULL.

I do not understand, why is this needed?  What does this fix?

> 
> Signed-off-by: qiaoyanbo <qiaoyanbo_310@163.com>
> ---
>  lib/kobject.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index ea53b30cf..d1f4b3411 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -241,10 +241,11 @@ static int kobject_add_internal(struct kobject *kobj)
>  
>  	/* join kset if set, use it as parent if we do not already have one */
>  	if (kobj->kset) {
> -		if (!parent)
> +		if (!parent) {
>  			parent = kobject_get(&kobj->kset->kobj);
> +			kobj->parent = parent;
> +		}
>  		kobj_kset_join(kobj);
> -		kobj->parent = parent;

I think this might break code as well, did you test this?  What about
the root kobjects with no parent, you still need to set that, right?

What problem does this solve that you have run into?

thanks,

greg k-h
