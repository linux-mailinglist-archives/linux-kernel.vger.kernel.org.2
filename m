Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754E4314ED4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBIMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhBIMSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:18:21 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB6BC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 04:17:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lw17so1434350pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 04:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M4M3lgI0AiHnck1BpGtXoCQVfKDXy6OoSScnliIi8SA=;
        b=oxpjz1lUh2QZYmT1IZmfh2T06m/ZD+e+XkMx6f3RuqMGTItZQGmVL4gbOoWbaHMAep
         kdpixkhqFpihWMhX7fimU0rl2i25XsWJl1BzZ7Qb+iCRCNgspwp/0DBULcliH8pdxcDE
         r5cx3cWN/q3YSh60xHqLaNq4oXgjy8lnHFyCzbsWnxODMY3Kw01CfM8kR0HMDWFA/1V6
         XuDH457Zx13B43LzvGu3/zdNzDBHRgcG47bqEx/xU6ZAU0Ae79gyN3YqZF3DDApd636s
         Z/RWTegScccjJ4Ulo/Ux/gbVCLtS2VcZX+X1mbkcKbclJjYEc83vHmFDviyyqB51RdL9
         SS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M4M3lgI0AiHnck1BpGtXoCQVfKDXy6OoSScnliIi8SA=;
        b=K+uU5AMyajQqc6GuLoYVZpFIgBgvLVHBEAPlvCGgdGyRgMBimrYJb8WixfTKO3fIju
         79Ik5ZrGbpaAW6TwsQfDmEG4fiWxF1BPoDFelYtvnVTn2VhIBFnz3+ZV8IX/zY2Ka810
         JKn8wYsWFvkq1kyG2xiew8wibxfkaLcd2Bq+jrR5+vjUBa2KLwZx6ctUDkoGLp1+o9NA
         Y56R6y1wqemJwiSLKKpxZmNAgf1rbvupjcYyP7FhVMoS/e55sWeun8GhXtX44yjwOBCS
         kIFsNTqYDfeqDbwFZ6V6Lpq9Glw4Jkr8m7dFGwfyr5bkyLARUH9pDUn2/tpocjQyyMOi
         XF8w==
X-Gm-Message-State: AOAM533mEQmypxXhQ7UasY2g5NUlh2ySIDRz/m5nl9Jzz5cc5VtfK7JP
        xFyacClaDrvzBBvuyNBKiqlr6Q==
X-Google-Smtp-Source: ABdhPJwX8G4jb4EcS9xarvblRcTLcufntd4b95wwMK2zc7gV0uhSj3xzqDyPsVJqMMIIBiD8nu6njg==
X-Received: by 2002:a17:903:2285:b029:e1:58a2:b937 with SMTP id b5-20020a1709032285b02900e158a2b937mr20569330plh.68.1612873060895;
        Tue, 09 Feb 2021 04:17:40 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([198.44.243.100])
        by smtp.gmail.com with ESMTPSA id y5sm19817811pfp.42.2021.02.09.04.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 04:17:40 -0800 (PST)
Date:   Tue, 9 Feb 2021 20:17:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix arm64 build error with gcc-11
Message-ID: <20210209121728.GA12546@leoy-ThinkPad-X240s>
References: <20210209113357.1535104-1-Jianlin.Lv@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209113357.1535104-1-Jianlin.Lv@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianlin,

On Tue, Feb 09, 2021 at 07:33:57PM +0800, Jianlin Lv wrote:
> gcc version: 11.0.0 20210208 (experimental) (GCC)
> 
> Following build error on arm64:
> 
> .......
> In function ‘printf’,
>     inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
>     inlined from ‘regs__printf’ at util/session.c:1169:2:
> /usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
>   error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]
> 
> 107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
>                 __va_arg_pack ());
> 
> ......
> In function ‘fprintf’,
>   inlined from ‘perf_sample__fprintf_regs.isra’ at \
>     builtin-script.c:622:14:
> /usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
> 	error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
>   100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>   101 |                         __va_arg_pack ());
> 
> cc1: all warnings being treated as errors
> .......
> 
> This patch fixes Wformat-overflow warnings by replacing the return
> value NULL of perf_reg_name with "unknown".
> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> ---
>  tools/perf/arch/arm64/include/perf_regs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
> index baaa5e64a3fb..901419f907c0 100644
> --- a/tools/perf/arch/arm64/include/perf_regs.h
> +++ b/tools/perf/arch/arm64/include/perf_regs.h
> @@ -85,10 +85,10 @@ static inline const char *perf_reg_name(int id)
>  	case PERF_REG_ARM64_PC:
>  		return "pc";
>  	default:
> -		return NULL;
> +		return "unknown";
>  	}
>  
> -	return NULL;
> +	return "unknown";

This issue is a common issue crossing all archs.  So it's better to
change the code in the places where calls perf_reg_name(), e.g. in
util/session.c:

--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1135,12 +1135,14 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 static void regs_dump__printf(u64 mask, u64 *regs)
 {
        unsigned rid, i = 0;
+       char *reg_name;
 
        for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
                u64 val = regs[i++];
 
+               reg_name = perf_reg_name(rid);
                printf(".... %-5s 0x%016" PRIx64 "\n",
-                      perf_reg_name(rid), val);
+                      reg_name ?: "Unknown", val);
        }
 }

And another potential issue is the format specifier "%-5s", it prints
out maximum to 5 chars, but actually string "Unknown" has 7 chars.
Actually the format specifier breaks other archs register names, e.g.
[1][2], seems to me, it's better to change as "%-8s", you might need
to use a dedicated patch for format specifier changes.

Thanks,
Leo


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/powerpc/include/perf_regs.h#n57
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/csky/include/perf_regs.h#n83
