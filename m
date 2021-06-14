Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE313A6517
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhFNLd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235725AbhFNLTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623669436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mW1OhhDo4BbGrvSu5PYyNkiZcO4Nso/XH9TpPHO3tX8=;
        b=RK8D9LTf5CY/pQrCwLVXpsHWsDjHYLFLdV1LSK6to1kvgIKI/4dFJcQz73PT4dJkYwZw44
        aG4rdLgo98nu11fPE4b4Gp2zHF8DyWYCdcTtOZ2usRBZ9gUfiZanY83jyFSlCZEr0qwrwY
        e9GUTAEInXHKmRmKEM+SoqDAO4+nb+c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ec5Ex6nHPiy7ePk0BMn3zg-1; Mon, 14 Jun 2021 07:17:14 -0400
X-MC-Unique: ec5Ex6nHPiy7ePk0BMn3zg-1
Received: by mail-ej1-f72.google.com with SMTP id q7-20020a1709063607b02903f57f85ac45so2901658ejb.15
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 04:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mW1OhhDo4BbGrvSu5PYyNkiZcO4Nso/XH9TpPHO3tX8=;
        b=OvYYiZU0weRm/IhnFxCbwu6fmCt3pWNnkBh6GHtln9uJ8byS86vtS03pM4hc5BjWKM
         lstLOx7DQzKkKTiOXRj3nC0QTMX25JPqrZQF4jnE35bVCTvQEbKwG+hu2CR6W2C2iUgG
         qnbIeVm+McTBGuM9nIBJN5y91ex/+JJMCrzRX4hxIhEiVWJI/pSZ4ri/U0u2iOInkT2H
         PlE8EZudziqunkK6m6jZDlSH6tSlAb3r2qWkmWDRfCHfZv9BjAmyobmVu7Zx2a26fTJH
         xYXN+c+LMB6X4r7MmFw/fX0207nMuWlu8C4vlBfD0soB94RKoUOBEQR+F8iixFjf++Dw
         6XCQ==
X-Gm-Message-State: AOAM533WmqgzLM6qVT7edj/Xs+Lg9RmJapne2JaflZpAMy1SoHaioRDs
        du+DmjWhfTiQOwy1LKu9mCY/uS9gupffAP9Hnc7N1bO1B63iEf+JPISyO+aDqzJ5gr8LycrE8hm
        jtyIyIj751tpBDHxh3Q5Hcx9Z
X-Received: by 2002:a17:906:b74a:: with SMTP id fx10mr14622063ejb.248.1623669433806;
        Mon, 14 Jun 2021 04:17:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTrZC854XsPGiSNTA3MALRfR8LN8qGTzOISTOOj/IDn7AHGzR1WW2pb8jHa6tJKhC285AzvQ==
X-Received: by 2002:a17:906:b74a:: with SMTP id fx10mr14622049ejb.248.1623669433667;
        Mon, 14 Jun 2021 04:17:13 -0700 (PDT)
Received: from krava ([83.240.60.126])
        by smtp.gmail.com with ESMTPSA id y20sm3602394ejm.44.2021.06.14.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 04:17:09 -0700 (PDT)
Date:   Mon, 14 Jun 2021 13:17:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: libperf : Can not create event group
Message-ID: <YMc6tBoIQiUQkRbq@krava>
References: <OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 07:17:53AM +0000, nakamura.shun@fujitsu.com wrote:
> Hello.
> 
> perf_evsel__open cannot create an event group because it set group_fd
> to -1 when it ran perf_event_open.
> Is there any reason why group_fd is fixed at -1?

hi,
there'no leader link on this level yet (in struct evsel)
so this is not implemented at the moment

jirka

> 
> Best Regards
> Shunsuke

