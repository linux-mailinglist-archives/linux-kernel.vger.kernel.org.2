Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F833C6D81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhGMJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234986AbhGMJfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626168740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUfa8peh4EProvCzGePhsPSlqxOJ32hePZg6qQ0HeAY=;
        b=B6AxOdHFw2bDxzbeXuAduEVJBgLwRbEiK61HZeijlH2Cd/7+E6FpSAXiWq0Up8mmShAAVr
        lb6syGcIVPXSbMqprKadZKYS0AGYoJOC2O4ZoAoNuknFLlny2STYKFyDiC9o5KjhOzKDo4
        N5Xr1Et/uZlPYzr0JasJLelGol0P+ZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-NZXDBK0UMW2FVDjjvMp2qw-1; Tue, 13 Jul 2021 05:32:18 -0400
X-MC-Unique: NZXDBK0UMW2FVDjjvMp2qw-1
Received: by mail-wr1-f71.google.com with SMTP id k3-20020a5d52430000b0290138092aea94so8483822wrc.20
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 02:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PUfa8peh4EProvCzGePhsPSlqxOJ32hePZg6qQ0HeAY=;
        b=i6/EFxCsS2n816XIz8mi3bWsP7NjCp54OjD0p1TUGQfa/oz/btCm1QbbJg/E7BLA6v
         NGUqgrRToYZ2ZKOFKPLPJSJncCtwdwKnMnG5tltQvIMLPKyT77x48Ujcz4IbcnpazH/b
         KT7Kl1ctTZmaLOIwzCytV23WGH+nSXP0ewF6syTrtzG9pCabVOsjXeogZUH/7M1HKuWo
         /NNBfsxsej1fA8s3bOuVxL3QJsF4bI/1GgBoqUIioqmIyILOjm6UmWb3BtvbUGcjFUaf
         4cVLRluQTPQoSM2kA5v3aYmfOX1kKdg7W5my3rqT7W4Q7l/Sc6AJpuwAsZ7pKrerkMw3
         bD7Q==
X-Gm-Message-State: AOAM531VOKSXuTCH5mu1FwzjhlrqVwjGtYYM0dnfXRqH4ahYM38iK0Y3
        aDFkm1FKlniAS8DtpiH4o9PyuM8OBTzANU51gOu+ZGnRCKBcaY7UZ5A+pU9Cj45XSkhxgWrGjPb
        YpoaYyrRXWkI/dvDDXw2+SZT+
X-Received: by 2002:a1c:2c43:: with SMTP id s64mr17979774wms.9.1626168737801;
        Tue, 13 Jul 2021 02:32:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMJurEW/0Q64xKOCxt5ctYrt4Wb7q6JeVABU+bbnF1ypD2SxX3hsknLvihnmJBpFjXE6U5Bg==
X-Received: by 2002:a1c:2c43:: with SMTP id s64mr17979756wms.9.1626168737628;
        Tue, 13 Jul 2021 02:32:17 -0700 (PDT)
Received: from krava ([5.171.209.239])
        by smtp.gmail.com with ESMTPSA id f13sm17510226wrt.86.2021.07.13.02.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:32:17 -0700 (PDT)
Date:   Tue, 13 Jul 2021 11:32:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: fix build error with LIBPFM4=1
Message-ID: <YO1dngCS/v0j3cAE@krava>
References: <20210713091907.1555560-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210713091907.1555560-1-hca@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 11:19:07AM +0200, Heiko Carstens wrote:
> Fix build error with LIBPFM4=1:
>   CC      util/pfm.o
> util/pfm.c: In function ‘parse_libpfm_events_option’:
> util/pfm.c:102:30: error: ‘struct evsel’ has no member named ‘leader’
>   102 |                         evsel->leader = grp_leader;
>       |                              ^~
> 
> Fixes: fba7c86601e2 ("libperf: Move 'leader' from tools/perf to perf_evsel::leader")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/pfm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> index dd9ed56e0504..756295dedccc 100644
> --- a/tools/perf/util/pfm.c
> +++ b/tools/perf/util/pfm.c
> @@ -99,7 +99,7 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
>  			grp_leader = evsel;
>  
>  		if (grp_evt > -1) {
> -			evsel->leader = grp_leader;
> +			evsel__set_leader(evsel, grp_leader);
>  			grp_leader->core.nr_members++;
>  			grp_evt++;
>  		}
> -- 
> 2.25.1
> 

