Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFB032FCA5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhCFTOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231545AbhCFTOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615058062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=067NlXgZGX5cEwswUaBCII34LWy1uIJf9RQVJw75l/w=;
        b=C4bCDBjRQ1VnW5z6n03CjqazrYFiCIUX5lMrR0AEbI7QwpPkge18UgDFnGobRX1dcX8YHO
        JEwagReP3a2PXeRpKo3Igx2yon2FelxQh8gCAIeHAqrOKFTKPqEGpY1S0Wq4ek1CNiueC7
        fL9IGIMz1O5k1zxBr4MaqN1qQ7z9Xa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-Bw1eYs0TPKWAoRD0eowtSg-1; Sat, 06 Mar 2021 14:14:20 -0500
X-MC-Unique: Bw1eYs0TPKWAoRD0eowtSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6FD480006E;
        Sat,  6 Mar 2021 19:14:17 +0000 (UTC)
Received: from krava (unknown [10.40.192.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id AC6025D6A1;
        Sat,  6 Mar 2021 19:14:14 +0000 (UTC)
Date:   Sat, 6 Mar 2021 20:14:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] perf tools: Add lexical definition of event name
Message-ID: <YEPUhZPoUZrzGvaJ@krava>
References: <20210304032610.3112996-1-nakamura.shun@fujitsu.com>
 <20210304032610.3112996-3-nakamura.shun@fujitsu.com>
 <74955041-45ab-10df-e044-5d64898c81d9@huawei.com>
 <OSBPR01MB4600C6910F2AFFC5819C8145F7969@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4600C6910F2AFFC5819C8145F7969@OSBPR01MB4600.jpnprd01.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 10:09:20AM +0000, nakamura.shun@fujitsu.com wrote:
> Hi, John
> 
> > > From: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
> > > 
> > > Add the lexical definition of event name so that the numbers are recognizable.
> > > 
> > 
> > Sorry for the hassle, but it's not clear that we got a definitive 
> > conclusion on this patch from v6 series:
> > 
> > https://lore.kernel.org/lkml/YCuo01Wxxe%2FMCrC5@krava/
> > 
> > Would it be so much worse for you to change format of these event names 
> > to not start with a numberic?
> I was trying to match the specifications published by Fujitsu exactly.
> We also thought that being able to parse event names starting with a number would be an improvement for perf.
> We've discussed it with the team, but we decided to change the event name.

hum, I'm not sure what's the final decision in here.. are you keeping
numbers in the start? would be much easier if you did not ;-)

jirka

