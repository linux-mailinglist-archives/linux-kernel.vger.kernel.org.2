Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735BF415244
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhIVVBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237819AbhIVVBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632344379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gO65tY85mzxNSiMQSTLAVCO3OAT6edKTBG18pm5kxVg=;
        b=cH127BAtNK9teC7oRRQ+6HyCooTZtke5/R/sR+c6kIbW6Ou5Szo5g42e1R4UyF0M6Vwbkr
        ddzCHUrP6gOJuNQFi1C94HJytypqNHxfPG5ekn9wKJyTmxyGGhWm/o7NjvF44Hr56bd+5N
        lPBdXhPMmDbsDDPCAkhBr8YuWv0LRCU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-PfybcMdIPkue6UI3p7Wdqg-1; Wed, 22 Sep 2021 16:59:37 -0400
X-MC-Unique: PfybcMdIPkue6UI3p7Wdqg-1
Received: by mail-wr1-f70.google.com with SMTP id j16-20020adfa550000000b0016012acc443so3286391wrb.14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gO65tY85mzxNSiMQSTLAVCO3OAT6edKTBG18pm5kxVg=;
        b=sckHb3aPzQPqCFBuPwGQGLoy8tfiETlntwu00YRAd1P9K+lAluWNnLRnrsLb5NuT+C
         QOUqyy0R/4es5nkMVABZajq2hsaQJVKvbn4QL/HnGcAPXQCj8GyXnJEtzbjqWRQx0RYm
         MYIeGzuoGb9j2Vf0aIz8rpcj8oy14tQ0LbgPsxHrJ1xbGnYfMV8StQIzd5gIKhqun/WI
         C6wjlDNho5sjOwvNVDz1LIpO0kHC1TcHvQ0dCxatMiEhdmetPlachrhOALXt1pON91hi
         2B3etges7xPr1M+5GKkp1HlYEmPsR0NyUCls9G1MdZ5x0niGtWJJBzpfxeyZmGbS1uMp
         GvDA==
X-Gm-Message-State: AOAM530O833Fn6Skfk3UpM5c703QtYtkKepW/hMOj1c6rXzhqLMvIxan
        cFKWb+nK2oBNv3eYehg6Y3H9QFcemj/VH0QkslZUhrigBFXFqWizazAmVTE7/I6FZn2ZsrmT6wC
        XQkBih9mXXoxRTMnv9CANwN3G
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr1173112wrc.30.1632344376669;
        Wed, 22 Sep 2021 13:59:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAOX6zR8UdlJwxSo4byiE+o5OmKjpIEKhFgFNFvbI72YCtJS0RXQq3rDy0nRcqeTmyrwcK1Q==
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr1173088wrc.30.1632344376488;
        Wed, 22 Sep 2021 13:59:36 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id c135sm7335517wme.6.2021.09.22.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:59:36 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:59:32 +0200
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
Message-ID: <YUuZNJjphZBHOAAA@krava>
References: <20210918063513.2356923-1-irogers@google.com>
 <20210918063513.2356923-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918063513.2356923-6-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:35:10PM -0700, Ian Rogers wrote:

SNIP

>  
> +struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2)
> +{
> +	size_t bkt;
> +	struct hashmap_entry *cur;
> +	int ret;
> +	struct expr_id_data *old_data = NULL;
> +	char *old_key = NULL;
> +
> +	if (!ids1)
> +		return ids2;
> +
> +	if (!ids2)
> +		return ids1;
> +
> +	if (hashmap__size(ids1) <  hashmap__size(ids2)) {
> +		struct hashmap *tmp = ids1;
> +
> +		ids1 = ids2;
> +		ids2 = tmp;
> +	}
> +	hashmap__for_each_entry(ids2, cur, bkt) {
> +		ret = hashmap__set(ids1, cur->key, cur->value,
> +				(const void **)&old_key, (void **)&old_data);
> +		free(old_key);
> +		free(old_data);
> +
> +		if (ret)
> +			break;

should we return NULL in here?

jirka

> +	}
> +	hashmap__free(ids2);
> +	return ids1;
> +}
> +
> +/* Caller must make sure id is allocated */
> +int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
> +{
> +	return ids__insert(ctx->ids, id, ctx->parent);
> +}
> +

SNIP

