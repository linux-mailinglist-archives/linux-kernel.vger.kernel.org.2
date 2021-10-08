Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F688426B79
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbhJHNLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230258AbhJHNLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633698549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkeWK1ymkll3fv7JRhxHQKgb62ps++tnFdlpvzfnQY0=;
        b=iXpsqqizLDOpZ+aP6ijfflNq/K+aIFsXCWV+NRsXwgROkHBa9HscgZlZ7W05HYpO2WXYNV
        xNmrJS9kFJkpImuH30Jx3WuFvStwDvEqzQpKI7M6vUEOV1+r296Gw4hUXc3FXmnkTn+ZwV
        Bu+lw4fSPhmdGUQjLRDmUOjYC69+yiA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-JijDohCZPbipDhY_PdyvEw-1; Fri, 08 Oct 2021 09:09:07 -0400
X-MC-Unique: JijDohCZPbipDhY_PdyvEw-1
Received: by mail-wr1-f70.google.com with SMTP id l6-20020adfa386000000b00160c4c1866eso7284820wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 06:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mkeWK1ymkll3fv7JRhxHQKgb62ps++tnFdlpvzfnQY0=;
        b=xxsgaYVwVQXw4UCRMzfuOJkDLpkMgua7f/0jUjy3d42+TypuO9cGXTDIG+n9TCYH/4
         fVEit4IVUP57tYmHO0AljsoR+Mp72w4diAY10tED4augYaPIv7ECXn8aGQw/DSfU47mj
         3h4uAx8HeA7Eo6x2bRy3CIAsLOUYghWf7GBGlRabLep2NgUhLgQ0boKX8HqdbGh1EfnT
         UqNHWJKw0FVdOaCQ2VZIlyEiDKaLhQbyIP8i+TUudGvFRqrk61E5RUF2OteyrqnV6u4a
         aaJFCE4XK6dMz4l1fK53RpYEP7V4fX7eVtJ00b9LJSsqzPykW7c9CHwU9X0Tv1BYy1WV
         OLUQ==
X-Gm-Message-State: AOAM531NF1M27EPsX8VYz1nrFWwbv2mYvjpsGsdP2yzH42+tQhGEnWgF
        ojrFU6B3oz66bWNdaS6+ovFnaLlW8/2CAaJSMzXddOtAQyLRFA1nt49/5p3qgeuqwpAaVwTd4CJ
        o33uDW66tUMm9gBAX0sBFL1cI
X-Received: by 2002:a1c:35c7:: with SMTP id c190mr3413661wma.57.1633698546495;
        Fri, 08 Oct 2021 06:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6Irh/RgDB4eREIn5qEs9TrdRzyzO0wePSCvFXOLItst3Y02wjnCRA/4hUwEofgOFQ19FxaA==
X-Received: by 2002:a1c:35c7:: with SMTP id c190mr3413605wma.57.1633698545980;
        Fri, 08 Oct 2021 06:09:05 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k8sm2631133wmr.32.2021.10.08.06.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:09:05 -0700 (PDT)
Date:   Fri, 8 Oct 2021 15:09:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] libperf test: Fix build error
Message-ID: <YWBC72+8/CaG7vB5@krava>
References: <20211006095703.477826-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006095703.477826-1-nakamura.shun@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 06:57:03PM +0900, Shunsuke Nakamura wrote:
> In test_stat_user_read, following build error occurs except i386 and 
> x86_64 architectures:
> 
> tests/test-evsel.c:129:31: error: variable 'pc' set but not used [-Werror=unused-but-set-variable]
>   struct perf_event_mmap_page *pc;
> 
> Fix build error.
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/lib/perf/tests/test-evsel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> index a184e4861627..9abd4c0bf6db 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -148,6 +148,7 @@ static int test_stat_user_read(int event)
>  	__T("failed to mmap evsel", err == 0);
>  
>  	pc = perf_evsel__mmap_base(evsel, 0, 0);
> +	__T("failed to get mmapped address", pc);
>  
>  #if defined(__i386__) || defined(__x86_64__)
>  	__T("userspace counter access not supported", pc->cap_user_rdpmc);
> -- 
> 2.25.1
> 

