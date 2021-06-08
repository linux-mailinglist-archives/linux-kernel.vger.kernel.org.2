Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A5139FDE0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhFHRjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhFHRjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:39:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CED4C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:37:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k15so16264636pfp.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VYVl7szFEBK6C42IK2EXBO8BhWc8zsrG6U+k/87a+5E=;
        b=cgGYIpNaZ6iE0KhM2pK2533D8tirYFFO5sH+DLDp6h6o2j5kwQMDrH2fxKCr9QIy/O
         FDmzdwqj2T/+o0YiqJ+YQZkFC6HZUV2R5BMpGuGGMhgu5P9tQtKSTQhhe2PjxrjQSuJI
         ma2t2S0KURAMesD+aZMf8z20bDbvrVf6t6hEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VYVl7szFEBK6C42IK2EXBO8BhWc8zsrG6U+k/87a+5E=;
        b=qGXrMOJ1i0H19ouvckOoz6X+FURJfaSuFSsVOMRtngm19wiKm+o3KtVDJhPwIAVA+Q
         G2wGJ4lUR/ndiG6vVqidODGIuI+XnHlQSB0BDSw3k/vyUj/5xza0jqXfBnEhDWQcoVUm
         QevaUDkcHvxVZnm32AR+S44+MDXmPIESyEog99Xrm1/tdeOnGC92rs3yLm4FH7JpbKu7
         ZnUFd5Ss6gc8wC8xtBB61//v34SarRYmPkaMXcz2lfk6yl8gdEFDWEeTNufEmlmirlrJ
         Lw4VsyVHSVGQxC2V3DgRJmnRYgLREmLKH/0KjbtvUFCzqIBhRESxQjiswvBelPSmixUa
         soTg==
X-Gm-Message-State: AOAM531yrXoCLamdKXjg4Nz7ZmeJZQP5MfnH1uXXzNRNVV7bmzLYu+lm
        alfbqsa4mydPSo7YrHaMs4g2vw==
X-Google-Smtp-Source: ABdhPJyQ8uYoWu20PGLwrzt9tyJVMnFgrFO31FHFR6A9l/q0q9qRSLEOBallutB5qpBq34etUJ1Uwg==
X-Received: by 2002:a05:6a00:9a:b029:2f1:6fd:aa51 with SMTP id c26-20020a056a00009ab02902f106fdaa51mr993390pfj.38.1623173866752;
        Tue, 08 Jun 2021 10:37:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h18sm12025517pgl.87.2021.06.08.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:37:46 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:37:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sysctl: remove trailing spaces and tabs
Message-ID: <202106081037.7FBEA6D63E@keescook>
References: <20210608075700.13173-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608075700.13173-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:57:00PM +0800, Zhen Lei wrote:
> Run the following command to find and remove the trailing spaces and tabs:
> 
> sed -r -i 's/[ \t]+$//' kernel/sysctl*
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
