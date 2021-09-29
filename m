Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB54B41CC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346311AbhI2SoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244341AbhI2SoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632940947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AE5fljvyYNG+Yl+9MBrwwlc+KGiDiGbxgTld+BD8ecY=;
        b=IBdfMdzPKZ7dEWDkJZ9jziwZHcwMp8MiBlcAujEtIEzNp0RKXjdz8XuSevL8mbcBj9L+Zd
        T4J9p0bEPdRec10/9Rr+eFPYNPiLjZ2MIS9VwXdsJkoBtttJ3z1hoAND/dE3gKlrAyrG7Z
        XOH2s7JbdisrKsy0YjmlqPJ0d0GvlmQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-R1IgoRytNZ2qChn3BTtMqA-1; Wed, 29 Sep 2021 14:42:26 -0400
X-MC-Unique: R1IgoRytNZ2qChn3BTtMqA-1
Received: by mail-ed1-f70.google.com with SMTP id a7-20020a509e87000000b003da71d1b065so3446378edf.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AE5fljvyYNG+Yl+9MBrwwlc+KGiDiGbxgTld+BD8ecY=;
        b=eYX6OpOAfLIu6dOz5ZDmoxoVLB/zGLYljDUwY0NTd9em0kVN72aSYa67pQt0IVOdJw
         OfOS5Bfrf9qUezFxky5wc260IvUmJr8uqgW50scm9iKpxg7+Rss3Epzhn0DixE/sgFoa
         hxspa8Q8Xq0jifR7mZHqkx6Fu2tPN/vDM32zWn+7fAUQdeBVqenLCHFkZcFTkX3TEjGZ
         vADkTOYzzLgBdydQoTym4memcTx8G1M9eThSAA/GNgdE6f+UDPSSiDJTfwA9WnZDkqaL
         1x4vK97Qy+mJOSmYKnDLjWz8biCwJ2qhwpEaeX56kUbP3yyuJC75D1klQC1ZfTTNW9qq
         QQHQ==
X-Gm-Message-State: AOAM532Ts0B/xxIUsZhL+5ZPGGhJwR7UQFNUxHXlyieZNIhWeJ+BhdO3
        HgWSy58h+NEz8qI6G0VqcZDDpc/wmAy0H8Xx+JLvzevoKo+wAAFo3D0xdj2lAIaMVgjx0hriLHm
        NInmCdyodIqdXnxhBYAHfvBlN
X-Received: by 2002:a50:8147:: with SMTP id 65mr1798816edc.60.1632940945093;
        Wed, 29 Sep 2021 11:42:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXOVvaFkMpe9KAE6UjBWZE2jS8+3X63yqX8oZPY5DZ8E27Npd1ezc4LB1XiOt51mpWJ5wUSQ==
X-Received: by 2002:a50:8147:: with SMTP id 65mr1798793edc.60.1632940944885;
        Wed, 29 Sep 2021 11:42:24 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id di4sm389079edb.34.2021.09.29.11.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:42:24 -0700 (PDT)
Date:   Wed, 29 Sep 2021 20:42:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Joe Mario <jmario@redhat.com>, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf script: Fix PERF_SAMPLE_WEIGHT_STRUCT support
Message-ID: <YVSzjzV+Jb7loGxI@krava>
References: <1632929894-102778-1-git-send-email-kan.liang@linux.intel.com>
 <YVSaT54dsMjJV4dF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVSaT54dsMjJV4dF@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 01:54:39PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 29, 2021 at 08:38:13AM -0700, kan.liang@linux.intel.com escreveu:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > -F weight in perf script is broken.
> > 
> >   # ./perf mem record
> >   # ./perf script -F weight
> >   Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot
> > print 'weight' field.
> > 
> > The sample type, PERF_SAMPLE_WEIGHT_STRUCT, is an alternative of the
> > PERF_SAMPLE_WEIGHT sample type. They share the same space, weight. The
> > lower 32 bits are exactly the same for both sample type. The higher 32
> > bits may be different for different architecture. For a new kernel on
> > x86, the PERF_SAMPLE_WEIGHT_STRUCT is used. For an old kernel or other
> > ARCHs, the PERF_SAMPLE_WEIGHT is used.
> > 
> > With -F weight, current perf script will only check the input string
> > "weight" with the PERF_SAMPLE_WEIGHT sample type. Because the commit
> > ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT") didn't
> > update the PERF_SAMPLE_WEIGHT_STRUCT sample type for perf script. For a
> > new kernel on x86, the check fails.
> > 
> > Use PERF_SAMPLE_WEIGHT_TYPE, which supports both sample types, to
> > replace PERF_SAMPLE_WEIGHT.
> > 
> > Reported-by: Joe Mario <jmario@redhat.com>
> > Fixes: ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT")
> 
> Hey Joe, Jiri,
> 
> 	Can I have your Tested-by?

Acked/Tested-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Thanks,
> 
> - Arnaldo
> 
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >  tools/perf/builtin-script.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 6211d0b..9f62ac6 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -459,7 +459,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
> >  		return -EINVAL;
> >  
> >  	if (PRINT_FIELD(WEIGHT) &&
> > -	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT", PERF_OUTPUT_WEIGHT))
> > +	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT))
> >  		return -EINVAL;
> >  
> >  	if (PRINT_FIELD(SYM) &&
> > -- 
> > 2.7.4
> 
> -- 
> 
> - Arnaldo
> 

