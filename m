Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD143AB104
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFQKMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhFQKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:12:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C187C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:10:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y7so6058861wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E56FkjuuXNFtVViqYy8TeoNuBVG48wVdRyq4qMxFT7Q=;
        b=cc92lm3cqq/4WRpp0rUpFPx8Z+kvoT4Tx9ZXfF2YT8NU5TfFQc7Wu7KIUgsllEZhTt
         tTVl8t/ihrCA/UUKO+40t+HDheJxpctblabfjHtnjOgN7mokTL4QSRrLIED9HWgr+ueK
         FgcOs3X7/WZliyyHXF1GjikreFMAMfG1X+/aq7MmYZ6TPdltTIB6jEP2sE8gUjjWouio
         kQX19Iw+5lWapWejeVYiQv3dVdEg3ir2b2fu7OGHYwN/QcGXsGUOtquXcjpdVQCBNJNE
         ofJggyrxvf+OhJYLkkQIzDrdKReoFVgooZWf6d7BShiHhauhTvXx+AKuZFDAh1Wf83XD
         +LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E56FkjuuXNFtVViqYy8TeoNuBVG48wVdRyq4qMxFT7Q=;
        b=ScQUQC6FZHxgBTLa9pDp6//b4ANqy2T61GUkfF/NBKKvKp1W2S7s8CIl8MFS+nHrx6
         GJvC5KXm7pG4w80mjB6QH1KKaugvS/XoQJ5WkIW2U2ir5eK01GVcI70WZAiKLCANf6oE
         tqUg39zgHMxHYBSheGVXSy7GY1+/k+3Ql6L9pYIiWzZKOMm5tsyGTw6LT1QIzojCQH9G
         mYn/8uyQfv2Xhj0kuvcPUZJR0ulL0k90eDtTuyfEcAkRffjXcFcBxgZ/NxA3RcUZLXFY
         rMmpvDyI02ye95zbkIOxK44CJLVHBAnO1Sqk3Na/YhfkvMy4QRMbf2w4g8NLkJriKj/Q
         33iw==
X-Gm-Message-State: AOAM53303k0Ud3AoerY7Y1NuhWciZdGwo1UfsTLuPuElDHKcQzVkinuC
        cQ6cOcQ/YlwLCmdmKGspY8z41Q==
X-Google-Smtp-Source: ABdhPJzZueI2euycUe9mgA6BJPJridBC6QGjBnvNomu7DIPEiFbFNp6XB+4L70zQGY3jU7Qc4Ta1kA==
X-Received: by 2002:a5d:6e0d:: with SMTP id h13mr4833617wrz.118.1623924620141;
        Thu, 17 Jun 2021 03:10:20 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o18sm7707395wmq.23.2021.06.17.03.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:10:19 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:10:18 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] kgdb: Fix fall-through warning for Clang
Message-ID: <20210617101018.6st3dshblabvdok2@maple.lan>
References: <20210528200222.GA39201@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528200222.GA39201@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 03:02:22PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> fall-through warning by explicitly adding a goto statement instead
> of letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied, thanks.


> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 25 in linux-next. This is one of those last remaining
>       warnings.
> 
>  kernel/debug/debug_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 4708aec492df..431749dd9ab6 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1038,6 +1038,7 @@ dbg_notify_reboot(struct notifier_block *this, unsigned long code, void *x)
>  	switch (kgdbreboot) {
>  	case 1:
>  		kgdb_breakpoint();
> +		goto done;
>  	case -1:
>  		goto done;
>  	}
> -- 
> 2.27.0
