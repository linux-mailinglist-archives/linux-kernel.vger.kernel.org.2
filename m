Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C11415241
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbhIVVAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237592AbhIVVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632344321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WOUQ1umT9EVazlsaxah7aOEpG+BSYoIBiyUBV41kXfo=;
        b=Kpcro+Sscw9O0B6Hr0y2Md5ee80QjSTBmxVCXNUuAcnw/UI4RiC2bI6qVYz9LrbmrpcAzx
        tuS41z55DhWdPIbki5rvsqQ0coWJT1PpGlr4lCOgJOTYYJXNoFrUPu/i6zZGNNXKJN3Z4D
        21nqiUOD1nCDMRRzfb8++cxlZ1BU+JU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-hkLEd8ShMf2o_Eo7pe0XWg-1; Wed, 22 Sep 2021 16:58:38 -0400
X-MC-Unique: hkLEd8ShMf2o_Eo7pe0XWg-1
Received: by mail-wr1-f71.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so3352806wrh.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WOUQ1umT9EVazlsaxah7aOEpG+BSYoIBiyUBV41kXfo=;
        b=jJBaSguvBr6DnEKlHh1dmPq9vITt7huWYD0kdSV0yPf9dEYf2KCYmLxyZLR5inAMpT
         qlauSenyt9CGon9NorIQNjQLH+sRQm6s7hwluKCRUP3qYveeVXc4C1Xyx2ofCt/zcKf7
         lh34tDAYmTOJWOxWCC/F4gHCe7nYl6jAZjmfcqbQ8/nyJNGkn/rm9DJF4tHiwJMEaQGU
         SHU7x+AGBex0oUbMli9meUOhngMbdAMSHLBNuWbYwsuUJwn9lgNBE6S7FvL3DjYsbPNV
         WuJu2obvD7W5Nkf4J5Yh13Y8o+5b/jr2/lGaOyFmwP+rQJHhmBcIlUblblTgxbfPFqni
         7Y6A==
X-Gm-Message-State: AOAM533xRUcMWqrF9hVHD9LBu4IWQ3tQ0YI3Kv1zW0MQojGA7WmCJXU/
        exAAPS4unNeroztByGqq8L1TiKsLnWr2WvR3HozvMfgo5NhTcxm9nuhvfQoJMfXKqUX9ZubKybi
        Xbrkfu5QX6e1ujTWebM5FMarK
X-Received: by 2002:a1c:403:: with SMTP id 3mr995695wme.161.1632344317359;
        Wed, 22 Sep 2021 13:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfe21pwgdBihcn0HQ0laMXCh8q0TyvBnWeQZwWGFzNVHBjJ9vABjhZqodTrXXNQFkfbmE13Q==
X-Received: by 2002:a1c:403:: with SMTP id 3mr995681wme.161.1632344317199;
        Wed, 22 Sep 2021 13:58:37 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id h18sm3250118wrb.33.2021.09.22.13.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:58:36 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:58:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH v8 5/8] perf metric: Add utilities to work on ids map.
Message-ID: <YUuY+WhB3Y3VQm2w@krava>
References: <20210918063513.2356923-1-irogers@google.com>
 <20210918063513.2356923-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918063513.2356923-6-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SNIP

> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index adf16bb7571a..34b51ca5e87f 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -59,8 +59,48 @@ static bool key_equal(const void *key1, const void *key2,
>  	return !strcmp((const char *)key1, (const char *)key2);
>  }
>  
> -/* Caller must make sure id is allocated */
> -int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
> +struct hashmap *ids__new(void)
> +{
> +	return hashmap__new(key_hash, key_equal, NULL);
> +}
> +
> +void ids__free(struct hashmap *ids)
> +{
> +	struct hashmap_entry *cur;
> +	size_t bkt;
> +
> +	if (ids == NULL)
> +		return;
> +
> +#ifdef PARSER_DEBUG
> +	fprintf(stderr, "freeing ids: ");
> +	ids__print(ids);
> +	fprintf(stderr, "\n");
> +#endif

hum, is this intended or forgotten debug leftover?

jirka

> +
> +	hashmap__for_each_entry(ids, cur, bkt) {
> +		free((char *)cur->key);
> +		free(cur->value);
> +	}
> +
> +	hashmap__free(ids);
> +}
> +
> +void ids__print(struct hashmap *ids)

SNIP

