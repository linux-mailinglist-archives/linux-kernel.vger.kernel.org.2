Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2544434B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJTMWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230111AbhJTMWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634732426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7p6x4ndhUF9o+vT5JDjX3kZy/boxNOuzWqDxZizdvqQ=;
        b=BtOJO2PTsl6L7xVctmzw3xOxxKqbfuHKNzjmF+ic/AYrmOOH4XIIie8mBb6wy3VBj1+t3h
        hRbjQANoIUUXjZdyMduwdZLAVYSoD961p/2BwU8d/Se561WWqPkadJueEm4k6lrGnj7gk2
        v7mpTfTrqZ0vzeepcnsDShLtpNfmB74=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-vFCpbkxdP0KvqHj9k8QIQg-1; Wed, 20 Oct 2021 08:20:25 -0400
X-MC-Unique: vFCpbkxdP0KvqHj9k8QIQg-1
Received: by mail-ed1-f69.google.com with SMTP id l22-20020aa7c316000000b003dbbced0731so20810383edq.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7p6x4ndhUF9o+vT5JDjX3kZy/boxNOuzWqDxZizdvqQ=;
        b=4WyAOdVWCdaut5DY/wHdvXZ5wMy/AEdzntb93K/Lvs9cKytzOyNurGlKav/x4+Hr4r
         2h4PePjOtEHQVWoxD7usgKoE8V35ptrh1DnKGcOO5liGgds+INPstLeip6RRSsu2J2Io
         KIocNFcGdzHE5whRfntbthMRt2T+yl6vL36ZRIfJrH6xnGEoUus/JCsTiJkPPJt34Jo6
         3gF41ikJMviVoWFMARXmlRaWfRGM7kldIGBQ6UdevHN56eO5NgowGyfjDW53Hrjurhws
         /9s0KBRVfaJdbERjCxI5p2wlNmVjDWDO6Z0wwDGENxkuGoxwaHX3KmD6gpIrvpYBsMHG
         cnOA==
X-Gm-Message-State: AOAM530GmqLbVmnRHUxe/Lnl79XzH51a1bZ8tbaAUqRYl+/uN5wkfstI
        jUlBDYjdFV+7taQjyWMdLZ8n4DaBl+dUSlZX6e78THpNj8SKIe9A1V7MTYQXxcacopsIMvNz2nT
        UPeLCtdN7kdepnR15aJrdfsKc
X-Received: by 2002:a17:906:354a:: with SMTP id s10mr48288541eja.475.1634732423842;
        Wed, 20 Oct 2021 05:20:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlAbGB3D1m0sTdbPjRJxUCMmCXB5d+7UNoiPcwqC+By0xn4WMvRb1lfmC3kZiHnFK/bWrYeQ==
X-Received: by 2002:a17:906:354a:: with SMTP id s10mr48288519eja.475.1634732423699;
        Wed, 20 Oct 2021 05:20:23 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id l23sm987340ejn.15.2021.10.20.05.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:20:23 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:20:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: libperf: lack of interface
Message-ID: <YXAJhTC9aqOS/GWy@krava>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YS+B6PVHtiTmqZS+@kernel.org>
 <YTCOVGyffe+VwL6G@krava>
 <OSBPR01MB4600E7C8C79D64125270D034F7A19@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB4600A616AD3341EAF6AA3DE8F7BC9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB4600A616AD3341EAF6AA3DE8F7BC9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 08:57:20AM +0000, nakamura.shun@fujitsu.com wrote:
> Hi
> 
> > > On Wed, Sep 01, 2021 at 10:36:40AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Wed, Sep 01, 2021 at 09:45:10AM +0000, nakamura.shun@fujitsu.com escreveu:
> > > > > Hello.
> > > > >
> > > > > I'm trying to change rdpmc test in perf_event_tests[1] to use libperf, but libperf doesn't have enough interfaces.
> > > > > Does anyone plan to implement any of these libperf features?
> > > > >
> > > > > - Interfaces that can run ioctl (PERF_EVENT_IOC_RESET) from userland
> > > > > - Interfaces that can run fcntl (SIGIO) from userland
> > >
> > > hi,
> > > we could add perf_evsel__fd like below, would it help your usecase?
> > >
> > > if you described your usecases in more details we could
> > > see if we could add/move something to libperf for that
> > >
> > > as Arnaldo said below it could be already in tools/perf/util/*.c
> > > somewhere ;-)
> > 
> > As Peter says, I understood that for rdpmc, no reset is needed.
> > 
> > However, PAPI resets it explicitly, for example, at PAPI_reset.
> > In other, PAPI also has the ability to call PERF_EVENT_IOC_REFLESH on overflow to call a user-registered handler, using SIGIO.
> > 
> > I think it is desirable to be able to achieve similar functionality.
> 
> Does anyone have any comments?

I'll try to add that functionality soon,
I'll cc you on patch

jirka

