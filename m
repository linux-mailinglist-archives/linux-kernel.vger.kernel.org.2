Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D4433313C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhCIVoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:44:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231904AbhCIVo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615326268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=koe2J3N8r9a5CU+J8F/n0A6tOoEJ/6fnrqwsvp2b9PY=;
        b=iJYGyBOzQzGhODVEl0EaB13fd0vXjRtj7AwKSEdjhC5/XgwnaauNPXAgSfdryiSFc3Hmrd
        vcAqESEMNtsgrlZ+7QKAJWlgPOS9J5m3+oGOGxqvKLQTmk2wOQaeAOmrP62NUI6J4mV3Ch
        CSVUjfSZD+DXylqBjyK/+rZbQZYqmw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-OcC09FOQOBGjl8yUKioDCA-1; Tue, 09 Mar 2021 16:44:26 -0500
X-MC-Unique: OcC09FOQOBGjl8yUKioDCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7CDF94DC1;
        Tue,  9 Mar 2021 21:44:24 +0000 (UTC)
Received: from krava (unknown [10.40.194.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id A187F60C13;
        Tue,  9 Mar 2021 21:44:22 +0000 (UTC)
Date:   Tue, 9 Mar 2021 22:44:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf pmu: Validate raw event with sysfs exported
 format bits
Message-ID: <YEfsNSM6kcR+Ygux@krava>
References: <20210308031506.23019-1-yao.jin@linux.intel.com>
 <YEX91MTGMU41zeuF@krava>
 <c06cdd0d-fee2-ab6d-1d22-49a6590996ea@linux.intel.com>
 <YEYjQOYI7utqnCq6@krava>
 <b84f76b1-1300-ef04-9845-ff206dec9f10@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b84f76b1-1300-ef04-9845-ff206dec9f10@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 11:00:02AM +0800, Jin, Yao wrote:

SNIP

> > > if (format->value != PERF_PMU_FORMAT_VALUE_CONFIG)
> > > 	continue;
> > > 
> > > Is it right?
> > 
> > sure, what I meant was to process only PERF_PMU_FORMAT_VALUE_CONFIG
> > and then call break, because there's no need to iterate further
> > 
> > jirka
> > 
> 
> Sorry, maybe I still misunderstood what you suggested.
> 
> My understanding is we still need to iterate the whole formats list even we
> find a PERF_PMU_FORMAT_VALUE_CONFIG.
> 
> root@kbl-ppc:/sys/devices/cpu/format# ls
> any  cmask  edge  event  frontend  in_tx  in_tx_cp  inv  ldlat  offcore_rsp  pc  umask
> root@kbl-ppc:/sys/devices/cpu/format# cat any
> config:21
> root@kbl-ppc:/sys/devices/cpu/format# cat cmask
> config:24-31
> root@kbl-ppc:/sys/devices/cpu/format# cat edge
> config:18
> root@kbl-ppc:/sys/devices/cpu/format# cat edge
> config:18
> root@kbl-ppc:/sys/devices/cpu/format# cat event
> config:0-7
> root@kbl-ppc:/sys/devices/cpu/format# cat frontend
> config1:0-23
> root@kbl-ppc:/sys/devices/cpu/format# cat in_tx_cp
> config:33
> root@kbl-ppc:/sys/devices/cpu/format# cat inv
> config:23
> root@kbl-ppc:/sys/devices/cpu/format# cat ldlat
> config1:0-15
> root@kbl-ppc:/sys/devices/cpu/format# cat offcore_rsp
> config1:0-63
> root@kbl-ppc:/sys/devices/cpu/format# cat pc
> config:19
> root@kbl-ppc:/sys/devices/cpu/format# cat umask
> config:8-15
> 
> If we break the loop when we get the first PERF_PMU_FORMAT_VALUE_CONFIG, we
> will only get the format 'any', right?

ugh, yep.. we need all of them ;-) sry

thanks,
jirka

