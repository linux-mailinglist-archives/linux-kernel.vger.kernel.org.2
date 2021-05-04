Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A20372CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhEDPI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230086AbhEDPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620140882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GxqMjtSqo6UrPkylZIMzzPAOqGJHe0mXIntTdhhqWP4=;
        b=LcEX/yDB78tqYjqOP3pdkzew5q4f1+fEbvzCdtO3PNtyI7/T9ouH14yJUzaCkdpcv8MLLs
        xoIgbejzk62Vf2EsIxyADy1BXKOpG+JuNUyaPXt1vj2gDsKLcj5tw1pbQI+H31NiBB2Ftj
        NoezB4YM8176KI/2rZyLTc430GhZgUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-KysDyyTGNYefwM_iafrb4Q-1; Tue, 04 May 2021 11:08:00 -0400
X-MC-Unique: KysDyyTGNYefwM_iafrb4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F203F18BA280;
        Tue,  4 May 2021 15:07:58 +0000 (UTC)
Received: from krava (unknown [10.40.192.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id F3BC85D6B1;
        Tue,  4 May 2021 15:07:56 +0000 (UTC)
Date:   Tue, 4 May 2021 17:07:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 2/2] perf header: Support hybrid CPU_PMU_CAPS
Message-ID: <YJFjTCsk9dCd6QP7@krava>
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
 <20210430074602.3028-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430074602.3028-2-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:46:02PM +0800, Jin Yao wrote:
> On hybrid platform, it may have several cpu pmus, such as,
> "cpu_core" and "cpu_atom". The CPU_PMU_CAPS feature in perf
> header needs to be improved to support multiple cpu pmus.
> 
> The new layout in header is defined as:
> 
> <nr_caps>
> <caps string>
> <caps string>
> <pmu name>
> <nr of rest pmus>

not sure why is the 'nr of rest pmus' needed

the current format is:

        u32 nr_cpu_pmu_caps;
        {
                char    name[];
                char    value[];
        } [nr_cpu_pmu_caps]


I guess we could extend it to:

        u32 nr_cpu_pmu_caps;
        {
                char    name[];
                char    value[];
        } [nr_cpu_pmu_caps]
	char pmu_name[]

        u32 nr_cpu_pmu_caps;
        {
                char    name[];
                char    value[];
        } [nr_cpu_pmu_caps]
	char pmu_name[]

	...

and we could detect the old format by checking that there's no
pmu name.. but maybe I'm missing something, I did not check deeply,
please let me know

also would be great to move the format change and storing hybrid
pmus in separate patches

thanks,
jirka

