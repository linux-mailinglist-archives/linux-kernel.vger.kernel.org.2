Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC73E3B79CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhF2VRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235664AbhF2VRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625001314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BtNniAR3aNmz2uMVQM4AwwxUgN4rwsFqmZzzMcX07mw=;
        b=WqX072UYYF1RXrqE0KipI6CSlq3op3xm15yWe3BLfNe8YiE2pidAXaqKJxJM6ysIBIdTrR
        stBqS++RBjHO4xYV33HgFatz+S4oiYx1CNznaze9YESbbXpdGz9i8wakkuQWLzmYd91MTB
        JlNZ7hb0mmg3mJ++r8CjhC5HZaS+g9E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-eQHgxjaFNjmZMzuNiBND5w-1; Tue, 29 Jun 2021 17:15:12 -0400
X-MC-Unique: eQHgxjaFNjmZMzuNiBND5w-1
Received: by mail-ed1-f71.google.com with SMTP id y17-20020a0564023591b02903951740fab5so8791052edc.23
        for <Linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BtNniAR3aNmz2uMVQM4AwwxUgN4rwsFqmZzzMcX07mw=;
        b=MV1FTSjS/wT6krMt7dy5+V4NTYfncqTZVNSKzL0tdn5Dg9/DxIKkr77xIfgjQUPZpf
         Qu9cK4BaYsBJ6zdgZU5k08VDwvQ2DLg3Qmm3uNDL+/nVYG6F3LKv4VBu9658d6gSyV1U
         7+nLcRpbd+GgxLLclkfjV4t6goQtwiEwLqsuj3Uu4UjO7X0fBmc3d9buJ2PrB2VLsDTW
         kwzA+4uFg9Ml3pbGUFUEvJna+CV3tqmpzrZvRlwAg1GbjnIt6v6AJGUxvqI0uovZWTHg
         T/c2RMAgaY83fuGS+RHSLpoq7ATb1KIkfrAJuKwSNvto4p0IOQXiPFahBwl9jBCErC6y
         JHFw==
X-Gm-Message-State: AOAM532ve4JSkVqdYvZS9u4pZjl4sY8XFxal1o4MbKyn/foCH3sNZvGx
        KokFsjBVq+iQU7jGyxBESvoyPJPpB9yDgRLeiPF7AjtoBYbmcMeY3xFLpMY6ydwcojv8d1bNSHk
        wQn8c77q6QIOY5p897ld/fNIa
X-Received: by 2002:a05:6402:1355:: with SMTP id y21mr43046623edw.136.1625001311421;
        Tue, 29 Jun 2021 14:15:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPdic8ySHCUXUWfvqARJEpfHp6BONt14O8Z9MSLWZoKfOh2DG03I/cr9IwsJHNM3EEneOnhw==
X-Received: by 2002:a05:6402:1355:: with SMTP id y21mr43046609edw.136.1625001311242;
        Tue, 29 Jun 2021 14:15:11 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id r23sm10135142edv.26.2021.06.29.14.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 14:15:10 -0700 (PDT)
Date:   Tue, 29 Jun 2021 23:15:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1] perf tools: Fix pattern matching for same substring
 used in different pmu type
Message-ID: <YNuNW/Afd/X25fNe@krava>
References: <20210609045738.1051-1-yao.jin@linux.intel.com>
 <982714a5-8a5d-8f8a-4e30-bd9a497ffa40@linux.intel.com>
 <4787334d-cf28-5b25-8d11-c767c52288f1@linux.intel.com>
 <YNWr7zsEaNPCn4CR@krava>
 <14a70048-ddd0-3297-9ae9-6b76dd0f1000@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14a70048-ddd0-3297-9ae9-6b76dd0f1000@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 09:52:42AM +0800, Jin, Yao wrote:

SNIP

> > > > > +    /*
> > > > > +     * The pmu_name has substring tok. If the format of
> > > > > +     * pmu_name is <tok> or <tok>_<digit>, return true.
> > > > > +     */
> > > > > +    p = pmu_name + strlen(tok);
> > > > > +    if (*p == 0)
> > > > > +        return true;
> > > > > +
> > > > > +    if (*p != '_')
> > > > > +        return false;
> > > > > +
> > > > > +    ++p;
> > > > > +    if (*p == 0 || !isdigit(*p))
> > > > > +        return false;
> > > > > +
> > > > > +    return true;
> > > > > +}
> > 
> > hum, so we have pattern serch and then another function checking
> > if that search was ok..
> 
> Yes, that's what this patch does.
> 
> I understand that's convenient, because
> > it's on 2 different places
> 
> Yes, on pmu_uncore_alias_match() and on parse-events.y.
> 
> but could we have some generic solution,
> > line one function/search that returns/search for valid pmu name?
> > 
> 
> Sorry, I don't understand this idea well. Would you like to further explain?
> 
> Or can you accept the regex approach?

I don't really have any suggestion, just would be great to have
this encapsulated in one function.. but if there's not any good
one, we can go with this change

Andi, Kan, are you ok with this change?

thanks,
jirka

