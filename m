Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347EC40FAAB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhIQOrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229920AbhIQOpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631889867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xzE/NLJgfwAVxkat0RFh+f6sNWwm03C3DeUhhSSlfLM=;
        b=fhqMfGZambCsXrC0/+U0nzVEFz8r60bezasaLVZuc+pKvVDnRd1bDnFpUYUOuMm1NBhAAX
        yWH32yS7bwRwaZ92Ks3KndYD+8d0RvhG6iVUgGXVjNr1GlNliyWF1h04Hc5YV/uYqj0Jhy
        6YMdP8jd71eKYQiTwf1YS3d9f7JvcsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-Is39RrGqPm-8BizvYNITvw-1; Fri, 17 Sep 2021 10:44:24 -0400
X-MC-Unique: Is39RrGqPm-8BizvYNITvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 996F010055B9;
        Fri, 17 Sep 2021 14:44:21 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7692E5DEB8;
        Fri, 17 Sep 2021 14:43:56 +0000 (UTC)
Date:   Fri, 17 Sep 2021 22:43:52 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [PATCH 3/5] kernel/watchdog: adapt the watchdog_hld interface
 for async model
Message-ID: <YUSpqCqA4jLboCVP@piliu.users.ipa.redhat.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-4-kernelfans@gmail.com>
 <YUMAUE5RFJAtAS/z@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUMAUE5RFJAtAS/z@alley>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 10:29:04AM +0200, Petr Mladek wrote:
> On Wed 2021-09-15 11:51:01, Pingfan Liu wrote:
> > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > yet. E.g. on arm64, PMU is not ready until
> > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > with the driver model and cpuhp. Hence it is hard to push this
> > initialization before smp_init().
> > 
> > But it is easy to take an opposite approach by enabling watchdog_hld to
> > get the capability of PMU async.
> 
> This is another cryptic description. I have probably got it after
> looking at the 5th patch (was not Cc :-(
> 
> > The async model is achieved by introducing an extra parameter notifier
> > of watchdog_nmi_probe().
> 
> I would say that the code is horrible and looks too complex.
> 
> What about simply calling watchdog_nmi_probe() and
> lockup_detector_setup() once again when watchdog_nmi_probe()
> failed in lockup_detector_init()?
> 
It may work. But there is still a way to report the PMU NMI capability
to watchdog layer accurately. And the API should be extened somehow.

I am thinking something, maybe I can model in another way.
> Or do not call lockup_detector_init() at all in
> kernel_init_freeable() when PMU is not ready yet.
> 

This may be not a good choice. Since lockup_detector_init() had better
be ready as early as possible, especially before drivers.


Thanks,

	Pingfan

