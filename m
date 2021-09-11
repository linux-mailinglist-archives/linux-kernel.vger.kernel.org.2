Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F440762D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhIKK6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 06:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232648AbhIKK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 06:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631357839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pSF3d7oFsiChuon48yxIyZuCvN+vfA1FIqrAvIeRgRM=;
        b=XvtLBaTfDFg0NFOesa5GTNTe5zG5F8tRsDuZvUIms1r5UB/NJ9/EU3o7s59/bv3T5gqSBO
        MET4bjxJRoHxarfZt+kNHYv5LKGYetEoW0w2uaKVmCU3vCfcLH7S8M6XzyGMIC3rdv2rT7
        +VZpToz8+xTwfX3ZBwDk9nBUbU5tixk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-iqjAKZCyNsuOkClm4jV21Q-1; Sat, 11 Sep 2021 06:57:18 -0400
X-MC-Unique: iqjAKZCyNsuOkClm4jV21Q-1
Received: by mail-ej1-f72.google.com with SMTP id ga42-20020a1709070c2a00b005dc8c1cc3a1so1958199ejc.17
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 03:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pSF3d7oFsiChuon48yxIyZuCvN+vfA1FIqrAvIeRgRM=;
        b=3n2f5N4yrzng1oNt9EtpgH/ze23QV4x90czd2IVlultnKrMxdcV5lat6yYqPbtYAjx
         PU4hCjQ2Z+UyTPLPP5dpZgMjdg3WOm4HJ7DsqEoywNlGqbl7BFjAohDJMpVTsSnE2tMF
         /FQo+gjIK87paeWiwqQg7Xjgft45yngKmiF7g9ODvRx33L+9hvdmSjxCKi5J4hcsuccj
         rI72zZhaMQc8/KnBVMGB5g2Wzdb+JdSzdt4yAzexp5k1FMsfhldqr4A7MnNxoNVbC1IH
         WjNyCMT55HpSLBAO1m+JDNSy/oABVAxCdQCS/pGkDOfgqO/nhq9eKj+Ya8TcI7ga3dqG
         SGBQ==
X-Gm-Message-State: AOAM5329VXYMnyxe87rEr9AZNQFOQAchb/0X74gVcBdQQAMrA3sHWc+a
        N27570RFjGF5n9NE0OvlWX/VVCZX1VAdfsVUvoICv6jyurxC1bU6Rs0x6gjxxGzvMOXPOF98PJl
        B1QSpfW1Ut+hIyJTLo5Kuwqvc
X-Received: by 2002:a05:6402:2317:: with SMTP id l23mr2733153eda.265.1631357837173;
        Sat, 11 Sep 2021 03:57:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGUs9TE/epFdOfUzbGa65wko5BN7EQpD8zzOpfNiddDPUpG18qUUIAd+JUCfDfO6xM+lrDLw==
X-Received: by 2002:a05:6402:2317:: with SMTP id l23mr2733140eda.265.1631357836974;
        Sat, 11 Sep 2021 03:57:16 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id q6sm615098ejm.106.2021.09.11.03.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 03:57:16 -0700 (PDT)
Date:   Sat, 11 Sep 2021 12:57:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf tools: Fix hybrid config terms list corruption
Message-ID: <YTyLipYOF8cSB/YC@krava>
References: <20210909125508.28693-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909125508.28693-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 03:55:06PM +0300, Adrian Hunter wrote:
> Hi
> 
> Here is a fix for an issue using perf on ADL.
> 
> 
> Adrian Hunter (2):
>       perf tools: Factor out copy_config_terms() and free_config_terms()
>       perf tools: Fix hybrid config terms list corruption

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  tools/perf/util/evsel.c               | 20 +++++++++++++++-----
>  tools/perf/util/evsel.h               |  3 +++
>  tools/perf/util/parse-events-hybrid.c | 18 +++++++++++++++---
>  tools/perf/util/parse-events.c        | 27 +++++++++++++--------------
>  4 files changed, 46 insertions(+), 22 deletions(-)
> 
> 
> Regards
> Adrian
> 

