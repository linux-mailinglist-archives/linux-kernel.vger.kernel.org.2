Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3710345765F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhKSS31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhKSS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:29:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3DDC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:26:22 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b11so8731726pld.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9DlGTN7Qf7Ih3sgz22eokhwuPXp2v1jWtJCK8cZnkjw=;
        b=a/NGcBNkciMHrO1NIuWo4GADEyiNdWAldzXFAihYFgTQrxCfIyMR1wLZDX+9jTIsEh
         J3p0Fzgr0kMN7+TNMAbZIyoKFNksnJs1M0LjMp/vB423igsRP3uDUi8MJG4n3cNDj+jL
         Hj8kwJHSLjjEGWB/uzGO/Nimqb6n7KOQ1lsO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9DlGTN7Qf7Ih3sgz22eokhwuPXp2v1jWtJCK8cZnkjw=;
        b=W2KPBChu7s/fgxvqIRMCuAblTdEDq3dKLMldjfhWSN77s8RMgHmkOI9xiWcDl1Kj6r
         6F0gcpVCDALUp3FI7Ps8iFQTZvWHIbXHBN+Ga1Gm0wAY16KEVrdLoWl/j2aH8HaMDlKZ
         VA0m+XGNItiMlAQwjAvuTZeFcPFb5UjcHkj1tj16Ew/4SIX39gTnkegQZ5l1PNa+mmwt
         ib2m8hiXSzRTODrscuz/4/QSJv+3CDT1X03lksLoHUjccCd8gs6Bd0NJZA5qcWQxFiQA
         LHo5KmKY0mgl457yyMCcE3aD88XaLwoaigyK+aCSnTy4QYDvQCuK7wRCZQ76lf6eRZct
         GlyA==
X-Gm-Message-State: AOAM532Vt0wW7PBIQ0VvClJmi4mxmXzwcmdKIL24+IfwrnxACZBJyayb
        vtLz3gwknOql0XMfBv/RkDrbRA==
X-Google-Smtp-Source: ABdhPJyOqQz8idH7cSV5BVRoiuqwbUEIYSGwMWy267I6HNSSKZ43xmLMBY94sDQSjeEi7DfAgmWbiw==
X-Received: by 2002:a17:90a:ac0b:: with SMTP id o11mr2032931pjq.143.1637346381329;
        Fri, 19 Nov 2021 10:26:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p19sm375250pfo.92.2021.11.19.10.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:26:21 -0800 (PST)
Date:   Fri, 19 Nov 2021 10:26:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Talal Ahmad <talalahmad@google.com>,
        Kevin Hao <haokexin@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        linux-kernel@vger.kernel.org, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] skbuff: Switch structure bounds to struct_group()
Message-ID: <202111191015.509A0BD@keescook>
References: <20211118183615.1281978-1-keescook@chromium.org>
 <20211118231355.7a39d22f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118231355.7a39d22f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 11:13:55PM -0800, Jakub Kicinski wrote:
> On Thu, 18 Nov 2021 10:36:15 -0800 Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring fields.
> > 
> > Replace the existing empty member position markers "headers_start" and
> > "headers_end" with a struct_group(). This will allow memcpy() and sizeof()
> > to more easily reason about sizes, and improve readability.
> > 
> > "pahole" shows no size nor member offset changes to struct sk_buff.
> > "objdump -d" shows no object code changes (outside of WARNs affected by
> > source line number changes).
> 
> This adds ~27k of these warnings to W=1 gcc builds:
> 
> include/linux/skbuff.h:851:1: warning: directive in macro's argument list

Hrm, I can't reproduce this, using several GCC versions and net-next. What
compiler version[1] and base commit[2] were used here?

-Kees

[1] https://github.com/kuba-moo/nipa/pull/10
[2] https://github.com/kuba-moo/nipa/pull/11

-- 
Kees Cook
