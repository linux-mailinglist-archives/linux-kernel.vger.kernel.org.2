Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5908333C40D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhCORYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235276AbhCORYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615829049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKoqRez6iHkkAn0kUlsim0iXUzTtxVRQH4dqQm3EPzc=;
        b=ZQ+k0QnGoPf5tHc/mZ62j/BYOGE6RTWVGBYqQ1TgLv5Q+ect50cWEPnJV1bbNtehxETlnO
        tFSi04nMyE/GxUG8xdfbW/LNBvQitLQqYWrm8I8wh3lr0UssaRBeHQcW6KnDH6lsp/xY5E
        B6PLyeruLU0DpLcPSmzuWjj+MPu4b1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-svTClTDnMU-RMDcmyeSC2w-1; Mon, 15 Mar 2021 13:24:04 -0400
X-MC-Unique: svTClTDnMU-RMDcmyeSC2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A720D19067F1;
        Mon, 15 Mar 2021 17:24:02 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id C7D3119EF2;
        Mon, 15 Mar 2021 17:24:00 +0000 (UTC)
Date:   Mon, 15 Mar 2021 18:23:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)" 
        <dzagorui@cisco.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: build reproducibility improvements
Message-ID: <YE+YL4Rzsj77TJmS@krava>
References: <20210312151700.79714-1-dzagorui@cisco.com>
 <YE9TAY05BtXbuHxq@krava>
 <BY5PR11MB40246F1699546B84817D826AD96C9@BY5PR11MB4024.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB40246F1699546B84817D826AD96C9@BY5PR11MB4024.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 04:45:55PM +0000, Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco) wrote:
> > Makefile.config:1026: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> > cp: '/home/jolsa/kernel/linux-perf/tools/perf/Documentation/tips.txt' and 'Documentation/tips.txt' are the same file
> >  BISON    util/parse-events-bison.c
> > bison: unrecognized option '--file-prefix-map=='
> 
> I thought that this flag was added in v3.6.3 because in git history next tag after corresponding bison patch was v3.6.3. But this is not true.
> 
> > hum, do we actualy want this? I think we want the exact path
> > we used for compilation, no? what's the benefit?
> ...
> > same here, we want to be sure to use the python path
> > from the exact build laction no?
> 
> This patch makes perf build more deterministic. This means that if we build perf on two different
> build machines from exactly the same sources we will have absolutely identical binaries. To achieve
> this absolute paths should not be stored in resulting binary. That is why i tried to determine those paths
> in runtime instead of storing them in binary compile time.
> There is ongoing project
> https://reproducible-builds.org/reports/2021-02/ project
> Kernel already achieved this
> https://www.kernel.org/doc/html/latest/kbuild/reproducible-builds.html

ok, haven't heard about this

> 
> This patch doesn't make perf 100% reproducible. There is one more known issue with pmu event ordering
> https://bugzilla.opensuse.org/show_bug.cgi?id=1180882

nice, the reason of pmu events is in random fashion,
so the resulting binary differs.. perhaps we could
use scandir with sort instead

jirka

