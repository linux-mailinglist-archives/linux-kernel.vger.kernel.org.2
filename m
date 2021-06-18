Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93D43AD619
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 01:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhFRXqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbhFRXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:46:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEAEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:43:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso7917076pjx.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VaxeR6kq1TatKHxRpRVY2RGQ7tO/m+vKgd0wWV7OHFE=;
        b=oKpBYtD2pXCHjq5y/Nt8YG3X6Hc+aprbg2b9ZkAsrU+kH2cTN5vRzPu4dhgdPq/BMg
         YXfowyn9ZKcrfjQU2uBOSxrSmWRwg+rw+35xxmHk+/WEnlFCFefwGdPe+yGDw18U+/v5
         fpDCZe8f7Xg4iY29vtdBl9/pA7c436jM7zKjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VaxeR6kq1TatKHxRpRVY2RGQ7tO/m+vKgd0wWV7OHFE=;
        b=d43Or/9ad2dVK8kMpIAD8Ib/UrxvikYBqRPwTRxhRuVGgQkrAGO+4bdWGwd0rJhF+P
         9FUbYAP1xU/2h9qMz3g9npCV/TvKbA07hZnVWQF8XgT4iMD6DH3csIV3Zutdgc+n37vl
         uDjWAa4iQD+uA3TlTjvx5FgQo3Pp7qLg66OpHg4YPJvaymlp6YxmZfkr/VrXbHeC4iF3
         jJufNN19qSrgSIHTFpkMwKapiqujNAb+Wlp59tjT5cucYGYEPI6eV1fPwx2o4Gy2EUGQ
         D9RHJs+X/PndPVUOSPhHUH4ENOYyldSJIbMVEg0QoQXZhOJRpaMgUMTELfQfpTJqooSt
         ekAQ==
X-Gm-Message-State: AOAM532rIrXROQ8qSfBOQ8lkhvQ5j7xfh6o2Bf7ZDyyAPXYrjr6aD3LR
        M506RcUEDw1BYw3O2iQ8I0nMJA==
X-Google-Smtp-Source: ABdhPJxCYWIunQzevcI7fFjpJx4ABhcng0aYoYnWLpsnKsb7BHY1Kizbat1j8IK9uKd7lLwjs1tOIg==
X-Received: by 2002:a17:902:aa4a:b029:10e:f98c:2b83 with SMTP id c10-20020a170902aa4ab029010ef98c2b83mr6883721plr.62.1624059831217;
        Fri, 18 Jun 2021 16:43:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n23sm9178485pff.93.2021.06.18.16.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 16:43:50 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:43:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xfs: Fix multiple fall-through warnings for Clang
Message-ID: <202106181643.99B75165@keescook>
References: <20210616191714.GA104231@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616191714.GA104231@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 02:17:14PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix
> the following warnings by replacing /* fallthrough */ comments,
> and its variants, with the new pseudo-keyword macro fallthrough:
> 
> fs/xfs/libxfs/xfs_attr.c:487:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:500:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:532:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:594:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:607:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:1410:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:1445:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:1473:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> 
> Notice that Clang doesn't recognize /* fallthrough */ comments as
> implicit fall-through markings, so in order to globally enable
> -Wimplicit-fallthrough for Clang, these comments need to be
> replaced with fallthrough; in the whole codebase.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for carrying these!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
