Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64C93E31C8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 00:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245544AbhHFWaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 18:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245534AbhHFWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 18:30:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDF7C06179A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 15:30:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j18-20020a17090aeb12b029017737e6c349so13507084pjz.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6t4R3/clPInEWqQYAYEqGtfb7Px8wNaCjYlpj80+2H8=;
        b=KzU0uWQel4rrqucZdeNEFegtyMHl2eu1JNNVShfFEqSIZQRwT9iIriyUSrEtpZic3k
         xGxqvfScDKAIukCjdhuRPVuxXq1bn5BBIFzAWjRZHxpKhDPQbRw8G6JLb+nhuFX04iXD
         dzpXkbjuO3UPaRbJ37MGU7vlcPgt8zRMN2W2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6t4R3/clPInEWqQYAYEqGtfb7Px8wNaCjYlpj80+2H8=;
        b=EFdZ+qlLx/MTjBS3kEQ7GYgNYNsZltF+37UztdK185LARgCxKDaOfrsuBXs+OKm2g5
         xrd/K8MEn1TdU9EFvBTAbsOdURhwb0xrs8SPtdaCbQlrGw3E5P/Txz1oR/vKsvNOzt5c
         P6rq1sKZ/BSNVnNhBBhnrIeKVnDhKavrCsoe/smiH6VVw0jcN80NFQKZFFXYHLXhYpAL
         c+6FCRBaL/1ERbufnM4aEsULbmI9283etfqb6AqKQ3bq3gRYJsC+ocNIGlkl0JR8u3RT
         P6i+jaXP3AAAWZAtwuOdBueCnNgSPJPDwPHYrjY8rLGkUJQzQHrVbTLkc0RMNBR7WPsc
         +eTA==
X-Gm-Message-State: AOAM531kFRt5urktGDUakP0tGH2jk4PTKJhQfdIa+yYhNMwT+Q6Iuplz
        catsq2x8VeiCuolep0OkD0H1+A==
X-Google-Smtp-Source: ABdhPJzJNM8Y2Fq8MMmxSifX6jMF7S2TiaF1k771cOv/hwziioYA+1qaKgY1XfHH80q4W3Y3DA4Nvw==
X-Received: by 2002:a62:3342:0:b029:3b7:6395:a93 with SMTP id z63-20020a6233420000b02903b763950a93mr6951533pfz.71.1628289015923;
        Fri, 06 Aug 2021 15:30:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2sm4058945pfe.37.2021.08.06.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:30:15 -0700 (PDT)
Date:   Fri, 6 Aug 2021 15:30:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipw2x00: Avoid field-overflowing memcpy()
Message-ID: <202108061529.07216CBF7@keescook>
References: <20210806200855.2870554-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806200855.2870554-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 01:08:55PM -0700, Kees Cook wrote:
> -	if (element_info == NULL)
> +	if (!element_info || info_element || info_element->len != size - 2)
>  		return -1;
> -	if (info_element == NULL)
> -		return -1;

Gah, a let a typo in. (should be !info_element.) v2 coming...

-- 
Kees Cook
