Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED13151E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhBIOpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBIOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:45:28 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA92C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:44:42 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d26so10808783pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m43GcCmrGgyICwlzdM/wEfH8JrnRWAAON/4lsGEnOhc=;
        b=lebTCOIYhwMBLFPbnw5/H5ScrZLGcAq+WALz9SFhXT9MySh3GEF07ng7mO03jg9h74
         rVJJwMYYlnVarSEeS84SvX1Qmmkh2ki0cZqJL+rNlJ3oKXFhokibYjCRjh2r7fAf9Iii
         BgC58ee/emsR/KQEPrbW9CY7TCO39g+jy5b7v05GIRxHlxTqsURyha+GqmzjuD/nWmt2
         MCIcnDgzBAy5D62uGguQ0/XWygJ3AWfxEC87wNwUoFGj3Pti764NRai81BJ6GXD9VVfL
         +RolIIC5IeZYXF5xC+RPrWsgGzalL+UvaFcWy/rCRMsAkiDaNBb3w6XHhe0mf6OfZzij
         3+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m43GcCmrGgyICwlzdM/wEfH8JrnRWAAON/4lsGEnOhc=;
        b=QsFqpoczgrs8xPGMwp6UIoSCzKVU13NjN5uq5AtE3EhNcVUgp+kishVDjWZwCe+JrD
         Fvegz0LdELBQWYeUf3Ka/bykJKPF2FG3vuXX5/vG4rg+n0KOzoPYqbJHh4UpKXwfZc1C
         spsNolFOx/WKoiLfqZ/qsPmABU6ImF53JKH62FPLcs/NlV5K2LiU2Oc0efmC5BOS1E7T
         NzxuG8rzeK/gSbM9wgufCkXOB0QKElV7X1pEIe/rQHUzyVXAkmdRskHi/C9mnILRfINc
         sNYRza2m2E6e7FA9SKNBOn6Cem10CmS4TV9hZ6OWFa73La6NsSL2J6YbePK+OrAHCj/z
         43MQ==
X-Gm-Message-State: AOAM531aF6r7zzwg44I81CxIZ0FFG+gZobgR+5FAfqUbR/OC/MU8JjYE
        XEB7Rm1EiUgK/EGabszOypPpsg==
X-Google-Smtp-Source: ABdhPJwOf0dUmoIpGjyGIJauHJCrxUnDoHC4tSX7kvvEemWzXq/xT5+MuoYrsenK1JSXo1odBkdyNg==
X-Received: by 2002:aa7:9a4c:0:b029:1db:1c54:d52d with SMTP id x12-20020aa79a4c0000b02901db1c54d52dmr13829377pfj.35.1612881882131;
        Tue, 09 Feb 2021 06:44:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id v23sm20214565pgo.43.2021.02.09.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:44:40 -0800 (PST)
Date:   Tue, 9 Feb 2021 22:44:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Jianlin Lv <Jianlin.Lv@arm.com>, will@kernel.org,
        mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix arm64 build error with gcc-11
Message-ID: <20210209144435.GB18774@leoy-ThinkPad-X240s>
References: <20210209113357.1535104-1-Jianlin.Lv@arm.com>
 <20210209121728.GA12546@leoy-ThinkPad-X240s>
 <66c8385e-b9fb-4a5b-a55e-e1543ad3d3c3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66c8385e-b9fb-4a5b-a55e-e1543ad3d3c3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:18:26PM +0000, John Garry wrote:
> On 09/02/2021 12:17, Leo Yan wrote:
> > Hi Jianlin,
> > 
> > On Tue, Feb 09, 2021 at 07:33:57PM +0800, Jianlin Lv wrote:
> > > gcc version: 11.0.0 20210208 (experimental) (GCC)
> > > 
> > > Following build error on arm64:
> > > 
> > > .......
> > > In function ‘printf’,
> > >      inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
> > >      inlined from ‘regs__printf’ at util/session.c:1169:2:
> > > /usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
> > >    error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]
> > > 
> > > 107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
> > >                  __va_arg_pack ());
> > > 
> > > ......
> > > In function ‘fprintf’,
> > >    inlined from ‘perf_sample__fprintf_regs.isra’ at \
> > >      builtin-script.c:622:14:
> > > /usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
> > > 	error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
> > >    100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
> > >    101 |                         __va_arg_pack ());
> > > 
> > > cc1: all warnings being treated as errors
> > > .......
> > > 
> > > This patch fixes Wformat-overflow warnings by replacing the return
> > > value NULL of perf_reg_name with "unknown".
> > > 
> > > Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> > > ---
> > >   tools/perf/arch/arm64/include/perf_regs.h | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
> > > index baaa5e64a3fb..901419f907c0 100644
> > > --- a/tools/perf/arch/arm64/include/perf_regs.h
> > > +++ b/tools/perf/arch/arm64/include/perf_regs.h
> > > @@ -85,10 +85,10 @@ static inline const char *perf_reg_name(int id)
> > >   	case PERF_REG_ARM64_PC:
> > >   		return "pc";
> > >   	default:
> > > -		return NULL;
> > > +		return "unknown";
> > >   	}
> > > -	return NULL;
> > > +	return "unknown";
> > 
> > This issue is a common issue crossing all archs.  So it's better to
> > change the code in the places where calls perf_reg_name(), e.g. in
> > util/session.c:
> > 
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1135,12 +1135,14 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
> >   static void regs_dump__printf(u64 mask, u64 *regs)
> >   {
> >          unsigned rid, i = 0;
> > +       char *reg_name;
> >          for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
> >                  u64 val = regs[i++];
> > +               reg_name = perf_reg_name(rid);
> >                  printf(".... %-5s 0x%016" PRIx64 "\n",
> > -                      perf_reg_name(rid), val);
> > +                      reg_name ?: "Unknown", val);
> >          }
> >   }
> > 
> > And another potential issue is the format specifier "%-5s", it prints
> > out maximum to 5 chars,
> 
> Doesn't the width field specify the min, not max, number of characters?

Thanks for correction, John.

I wrongly understood it and sorry for confusion.  Wiki says [1]:

"The Width field specifies a minimum number of characters to output,
and is typically used to pad fixed-width fields in tabulated output,
where the fields would otherwise be smaller, although it does not
cause truncation of oversized fields."

Thanks,
Leo

[1] https://en.wikipedia.org/wiki/Printf_format_string#Width_field
