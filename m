Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A33939BD86
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFDQrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:47:21 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:45958 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFDQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:47:21 -0400
Received: by mail-pg1-f178.google.com with SMTP id q15so8306734pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kZ1ty6Q2/qYPYXmHUvpObsq2hl1IWLrGEYr/5Ax9090=;
        b=H9epVpfIO4mAVOzRFo/F/i35XhuYbNYKogMwm+dYceP3QBbYTKvotZ5mcX0W7MSkKy
         w8NbNL+/J4C18pZc4mmRGu4C/cBV1rYLPk0kFOpjgQMTsnlSjT87wYf3w7MsGl9EenUd
         LE1jrd9Vxg7c57AJxmqCW7+XK8wrs3AvN+hNw3NjFbGHUAxf5kVojQgoWscjJm7UbHvH
         5pk8486fVe23rC010kSKHWXevxIb1NHM7ixmnLXRpUaU7SDJqMRvzVCo6Gfc4bIwlMgt
         GVp05eMCBdwDYdOgtrSefYNlMlmbcXl6mSkeatC+6sK4kyhLhXK7minxOwPOk+hvKMkp
         Doxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kZ1ty6Q2/qYPYXmHUvpObsq2hl1IWLrGEYr/5Ax9090=;
        b=p24SfhFFY/D+DSUr5uMYRApV9EcCoLd10BtogV5mQIgZXcm65Zcj7HYbvYtLR4DtcF
         GQRX/jZ67T67QXBMHE/8qM7bSH5kxB3g/Gyasn6mbvgHS7K0tRYZfOm54dCnIysgoWrA
         ROJdzAydkfE9Q7uJS/SXZ4vZOPmUGmtb35OdQneovB38FvqmXeAOJTtw/XhpLMQ6lKYO
         x3wuILiWX+Cq1Kz0uNFqB/xvWem+QKlH5JfTuU7GWmgCh1foGZYeLlUPJT3Q9OWhCyde
         7PyHqSgd9R2FXHu15wSGxU5Ac2/BsMk/XCl/3ez9mqdNZ8dcBLV8jWgEifmMgsywsAP1
         TPVw==
X-Gm-Message-State: AOAM532EG0O3wDwuvvoFpWrIxG/n6nrH19Rg+uXry11ReDY+KmU6wmTj
        yA3EmyoKoJR0m98T+2jImKtAfw==
X-Google-Smtp-Source: ABdhPJw9eyQ64MLHnCVxzeffHwskk+7VoqbzRZQBPYcFx5Qlj/+TdAdcrZETsLJ/v8RgpInOiBqPgA==
X-Received: by 2002:a05:6a00:88a:b029:261:6d37:dac6 with SMTP id q10-20020a056a00088ab02902616d37dac6mr5514227pfj.18.1622825074441;
        Fri, 04 Jun 2021 09:44:34 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id i2sm5034086pjj.25.2021.06.04.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:44:33 -0700 (PDT)
Date:   Fri, 4 Jun 2021 16:44:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v2] notifier: Return non-null when callback is already
 registered
Message-ID: <YLpYbQnswxZUB5sW@google.com>
References: <20210604144102.13849-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604144102.13849-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
>
> The notifier registration routine doesn't return a proper error value
> when a callback has already been registered, leading people to track
> whether that regisration has happened at the call site:
               ^^^^^^^^^^^
               registration
>
>   https://lore.kernel.org/amd-gfx/20210512013058.6827-1-mukul.joshi@amd.com/
>
> Which is unnecessary.

The WARN is still going to make that "necessary", and the vast number of callers
and variations that don't check the return value means that WARN isn't going
anywhere for quite some time.  Returning an error code still makes sense, but
the changelog is misleading in that it implies callers can blindly register
without any repercussions.

> Return -EEXIST to signal that case so that callers can act accordingly.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  kernel/notifier.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index 1b019cbca594..5a31bc9b24b4 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -25,7 +25,7 @@ static int notifier_chain_register(struct notifier_block **nl,
>       while ((*nl) != NULL) {
>               if (unlikely((*nl) == n)) {
>                       WARN(1, "double register detected");
> -                     return 0;
> +                     return -EEXIST;

Opportunistically squish the WARN into the if?

                if (WARN((*nl) == n, "double register detected"))
                        return -EEXIST;

>               }
>               if (n->priority > (*nl)->priority)
>                       break;
> @@ -134,7 +134,7 @@ static int notifier_call_chain_robust(struct notifier_block **nl,
>   *
>   *	Adds a notifier to an atomic notifier chain.
>   *
> - *	Currently always returns zero.
> + *	Returns 0 on success, !0 on error.

Maybe explicitly call out %-EEXIST to be consistent with the unregister wrappers?
Those are tightly coupled to the notifier_chain_unregister() behavior.

  Returns zero on success or %-ENOENT on failure.

If that's unpalatable, it's probably a good idea to at least clarify that it
returns a -errno, there's at least one call site that explicitly checks for a
negative return value.

  static int __init gic_clocksource_of_init(struct device_node *node)
  {
	...

	ret = gic_clockevent_init();
	if (!ret && !IS_ERR(clk)) {
		if (clk_notifier_register(clk, &gic_clk_nb) < 0)  <-------
			pr_warn("Unable to register clock notifier\n");
	}

>   */
>  int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
>  		struct notifier_block *n)
