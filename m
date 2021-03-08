Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2447C331974
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCHVjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhCHVja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:39:30 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF0CC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 13:39:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso3928099pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 13:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EWvWBXtE6LC0x5+EhuqOJ3oY9GpYiZIHnEJDU3K8dog=;
        b=V9eyL2u0XJmDG5RNYn9VW90WFHdcLmUmrYjRFb2W/FI5PHN2qvuoIt5fk6pFca77Qr
         GYVTw1ZGOEblHLF50/wN+6S4KnZVPUBFIVEyw9sjutI1VELk6x0ePk65StCSMbubi6CX
         ylNgM7vahd33gB3HCxv2YFdQEBdcbYToEXRrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWvWBXtE6LC0x5+EhuqOJ3oY9GpYiZIHnEJDU3K8dog=;
        b=AB180OOKVwcCaMhCT0f17VXeV1sM1TrN/py8GpA2Thcijym99BfvySTeSO+cXojtA6
         KMSHHvbp3Fpp2PRyi3hBZGQkqU2JmYgVhBsS/w06O6WJku9R/C/KbvSxYiDtcDsY/fzk
         I6J76O7brFxpwv5SwEQQQiF9Nafwjx9u0LoEfNVeNhpDX99GQusKmV2XBG/AQm97hQct
         Tcp2I6vJDaPj1XlRhsmeWZsF0MkM3Oc23YLnBR1+YeVnKnHB9M1CBcVovy8/XytkEznp
         C4TUDY8pTJwOYJDKGB5NdMvPHV/fS74Gt0Fvyl7YQdJll2GxwCUH4AOrMixALZS6HdIS
         gSbg==
X-Gm-Message-State: AOAM531Bx0gxNvFwyzKdu5529hPieAi03cpZaxtkyGg4wIw6b192FKYa
        A4Ou/ZmfW+xy4H8yheMMlG1udg==
X-Google-Smtp-Source: ABdhPJxf/G9ECz/bN816wfYNhj9BXuNY8J89BAuOifZ7SnfHj190OKd5RixxaJ24ptL97/yYoLaveQ==
X-Received: by 2002:a17:90a:29a3:: with SMTP id h32mr960430pjd.209.1615239570482;
        Mon, 08 Mar 2021 13:39:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n5sm11149305pfq.44.2021.03.08.13.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 13:39:29 -0800 (PST)
Date:   Mon, 8 Mar 2021 13:39:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alistair Delva <adelva@google.com>
Subject: Re: [PATCH] kbuild: Allow LTO to be selected with KASAN_HW_TAGS
Message-ID: <202103081339.B18898E@keescook>
References: <20210308184656.1914947-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308184656.1914947-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 10:46:56AM -0800, Sami Tolvanen wrote:
> While LTO with KASAN is normally not useful, hardware tag-based KASAN
> can be used also in production kernels with ARM64_MTE. Therefore, allow
> KASAN_HW_TAGS to be selected together with HAS_LTO_CLANG.
> 
> Reported-by: Alistair Delva <adelva@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
