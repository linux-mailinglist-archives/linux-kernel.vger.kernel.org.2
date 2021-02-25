Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B84325777
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhBYUSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhBYURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:17:41 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:17:00 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g20so3838180plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9jhOqg6r1RI16qcHYH2Ga+IvE/GRGzd6JVW7UgxwI8A=;
        b=ZzWvGhPZTTPYal91SdN5CmabX0igGsDXwUDeQ/cYGops9w/MJXvQfG5X1hLNnnHRw0
         Nmo3Yv0P+QsKfEDC+/rSY10t8M8tttOoG9v2DXbvACjcQ+fLgHQ3RMHe69XpBZjlztvX
         Y8BKjpUM/kfETaJJzH6vzy6vrTELfyBbEEhrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9jhOqg6r1RI16qcHYH2Ga+IvE/GRGzd6JVW7UgxwI8A=;
        b=kcBNfgjVZusrtW290mULbl4IWn3k4R73pAwzlhJ3sMfluoAQ4NNdNYduy9Il//bHUS
         YUAoBETBsNUs+mnx2grHE6q7lb+OllZdumhX+dwlYfvMRg1e4wgSGLcC9M8cGEmFIYn+
         c1tV2BZZz+GlSze4D8AAaNTV6Os5HA0/3mWJG9bBsgOGX1Znu4iEfuvuVfODDOWpl9S6
         TVNqWH6RYtXosh+d5hGtaH1eCCTuq/ONof+kL6XjJ5pdZZBapVk25aLHERtlQ565pa7A
         Yq18SDbolapkURDi3Pg3LhiE8ji1MkACH9w8oKzulJccg+lpAZuYTkFK+M9OLmfvttwz
         gmnA==
X-Gm-Message-State: AOAM532DL/0e7NyWK13oCEPTz2AVlDK/n/xrlz7qc4PAmLb9MCTYlmL0
        xBTgWm3XyOSSHkZq0rBSR+UWKAqCT7C76Q==
X-Google-Smtp-Source: ABdhPJzSn2dIwbVr+U3m4pRomSnqhpO4l2jVPJ50mi/OaQx4Jl2gWT2sTffZi7bX+/Tns4FYoMyRvg==
X-Received: by 2002:a17:902:8d95:b029:e2:c956:f085 with SMTP id v21-20020a1709028d95b02900e2c956f085mr4516993plo.35.1614284220067;
        Thu, 25 Feb 2021 12:17:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l3sm7083563pfc.81.2021.02.25.12.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:16:59 -0800 (PST)
Date:   Thu, 25 Feb 2021 12:16:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFT] m68k: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <202102251216.F53A012@keescook>
References: <20210225111505.1936566-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225111505.1936566-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:14:45PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While experimenting with CONFIG_TRIM_UNUSED_KSYMS across architectures,
> I noticed that this unsurprisingly works best when combined with the
> --gc-sections linker flag, which is not currently allowed on m68k.
> 
> Enabling it with this patch shows significant improvements
> for kernel size, looking at m68k defconfig with gcc-10, I get
> 
> 4005135 1374302 167108 5546545 54a231 vmlinux-normal
> 3916254 1378078 167108 5461440 5355c0 vmlinux+trim
> 4012933 1362514 164280 5539727 54878f vmlinux+gcsection
> 3797884 1334194 164640 5296718 50d24e vmlinux+gcsection+trim
> 
> There are probably bugs somewhere, but if someone is able to test this
> patch and fix any issues that come up, would be a useful improvement
> for memory-limited machines.
> 
> Link: https://lore.kernel.org/lkml/CAK8P3a05VZ9hSKRzVTxTn+1nf9E+gqebJWTj6N23nfm+ELHt9A@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
