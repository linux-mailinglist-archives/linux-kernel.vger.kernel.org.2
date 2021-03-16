Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A14D33CF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhCPIRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhCPIR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:17:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A1C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:17:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id jt13so70682652ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p9kC/FfaYsWrKdpd44ySqOr9EeItGYJ7tqAoRplpcIw=;
        b=EFjyEtLu7bg1hNv+88oPUzWFOq+7jZJ1JjL06HqzKU/TlfkEl1+HRe4/aFCgmsHASK
         l4L9IRJYPnHUI5TnHzB51mEyaEH2wA1K+JGeag2qgdeECYLIpkSEFh70xoCt/tTGodcd
         8ACpxYRZgaf4XJHaxUUuyAvrWxr92vlxsRsFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p9kC/FfaYsWrKdpd44ySqOr9EeItGYJ7tqAoRplpcIw=;
        b=hUf+myK1x/eLRxz+XvhWIUQsUl9MjiYFWybj1+dK6P8DfSOKuzdrtc2Jzl/nmeeo+t
         CYrJM1Fl5CWy5o0YCL6nFGQnT3wv/j3DUU2iHuJco2OuRilm8OFL3R+Xwq6JoZxd6qiF
         bCi2xks2i2KyrwAoPBjZ1iaaVsHF2O0W2tFfhaNLYU5LXf9k1Li56ASp4F2g8PAgGw12
         sqS2l3mvADj6YGYXSrdmjWgSQ9JOStsJKmLJiTcuSuEEhxDOyotuJ483eH3v+paoNpaI
         T/S8CsO0dYONnGJ81VaWBgUNSNyJPTR3j06JjF538qT0C6dZSPt60ieNI27E7zIP8cMr
         eYlA==
X-Gm-Message-State: AOAM533dXtWqewEygsYrEtreT9kejg+y/4Tz6/2ERZD1RJTkgskSW75/
        CiFXata0jmwSIpwdLaqPG83iyw==
X-Google-Smtp-Source: ABdhPJwhMeO22Wisys4V+O8q3o0fM/7YfKkWeuBs/dpVq2nKIcG5cqRzvmDIEMex6Byh+X4q3Gsohw==
X-Received: by 2002:a17:906:5902:: with SMTP id h2mr28099654ejq.416.1615882646474;
        Tue, 16 Mar 2021 01:17:26 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id u13sm8931351ejy.31.2021.03.16.01.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 01:17:26 -0700 (PDT)
Subject: Re: [PATCH 01/13] tools: disable -Wno-type-limits
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-2-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2ec71f83-f903-2775-bf04-7f0a83c9f4cb@rasmusvillemoes.dk>
Date:   Tue, 16 Mar 2021 09:17:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316015424.1999082-2-yury.norov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2021 02.54, Yury Norov wrote:
> GENMASK(h, l) may be passed with unsigned types. In such case, type-limits
> warning is generated for example in case of GENMASK(h, 0).
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  tools/scripts/Makefile.include | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index 84dbf61a7eca..15e99905cb7d 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -38,6 +38,7 @@ EXTRA_WARNINGS += -Wswitch-enum
>  EXTRA_WARNINGS += -Wundef
>  EXTRA_WARNINGS += -Wwrite-strings
>  EXTRA_WARNINGS += -Wformat
> +EXTRA_WARNINGS += -Wno-type-limits
>

I don't like that kind of collateral damage. I seem to recall another
instance where a macro was instead rewritten to avoid triggering the
type-limits warning (with a comment explaining the uglyness). Something like

foo > bar      is the same as
!(foo <= bar)  which is the same as
!(foo == bar || foo < bar)

Dunno if that would work here, but if it did, it would have the bonus
that when somebody builds the kernel proper with Wtype-limits enabled
(maybe W=1 or W=2) there would be no false positives from GENMASK to
wade through.

Alternatively, we really should consider making use of _Pragma to
locally disable/re-enable certain warnings.

Rasmus
