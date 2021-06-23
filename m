Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA43B1D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhFWPNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWPNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:13:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 817B36100B;
        Wed, 23 Jun 2021 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624461089;
        bh=nrvJ03WJxT1u5DpvKe8AOm5b/1uT3Kw3Au08RLSPaug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvxlS0WKBQLoF9tZaUTkYitgt3y9mLMASLVmfYrurORcj9vP8TgPJglZRhqg8SH7P
         lZsShvwdr0MCrbp7CTk7e8YgKNi56l/zEKFeeGe9R9Juj0QT0M1J9qgjnIl4qbPB6Y
         a6PvHy6rrpgyJXTvGeaj4FX/gz41hib3z3uPkNWg=
Date:   Wed, 23 Jun 2021 17:11:26 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Safe return of kobject_get_path with NULL
Message-ID: <YNNPHvFWoeI4UwEZ@kroah.com>
References: <CWXP265MB2680094534A5559B0A904B76C4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CWXP265MB2680094534A5559B0A904B76C4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 02:47:35PM +0000, Christian Löhle wrote:
> Prevent NULL dereference within get_kobj_path_length
> 
> Calling kobject_get_path could provoke a NULL dereference
> if NULL was passed. while fill_kobj_path will return
> with a sane 0 for NULL, kobjet_get_path_length did not.

Who passes NULL into that function?  Shouldn't that be fixed first?

> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  lib/kobject.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index ea53b30cf483..735159c13a94 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -130,6 +130,8 @@ static int get_kobj_path_length(struct kobject *kobj)
>  {
>  	int length = 1;
>  	struct kobject *parent = kobj;
> +	if (!kobj)
> +		return 0;
>  
>  	/* walk up the ancestors until we hit the one pointing to the
>  	 * root.
> -- 
> 2.32.0
> 
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
> 

Pleaase always run your patches through checkpatch.pl so you do not get
maintainers asking you to use checkpatch.pl...

thanks,

greg k-h
