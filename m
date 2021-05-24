Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A9E38E37A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhEXJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232313AbhEXJmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621849237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEjqJcjwBItF1yzxfdl36Bmpov8c1JuS0sajBHJlriQ=;
        b=OhU3ZJLxd9wVZThTooiHxqujjZGAzqEdGMiIPsCUkiF3yAGEWhz9KggGWClFuf1QngUO03
        HujPSSCCB/xEfuPmItmK0pYLlgHm5D/2IaJg4BPhEguwTJEpQrv1+XJTZ8LsQABVuBicq4
        YwAr7kvc73mriq4vk24isModbOneUcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-0Jlo4_EqP4WG01Nezmr1Ug-1; Mon, 24 May 2021 05:40:34 -0400
X-MC-Unique: 0Jlo4_EqP4WG01Nezmr1Ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 174351B18BC6;
        Mon, 24 May 2021 09:40:34 +0000 (UTC)
Received: from krava (unknown [10.40.195.130])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3A76461F20;
        Mon, 24 May 2021 09:40:33 +0000 (UTC)
Date:   Mon, 24 May 2021 11:40:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] perf script: Find script file relative to exec path
Message-ID: <YKt0kMqeIq5ypW4O@krava>
References: <20210524065718.11421-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524065718.11421-1-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 09:57:18AM +0300, Adrian Hunter wrote:
> Allow perf script to find a script in the exec path.
> 
> Example:
> 
> Before:
> 
>  $ perf record -a -e intel_pt/branch=0/ sleep 0.1
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.954 MB perf.data ]
>  $ perf script intel-pt-events.py 2>&1 | head -3
>    Error: Couldn't find script `intel-pt-events.py'
>    See perf script -l for available scripts.
>  $ perf script -s intel-pt-events.py 2>&1 | head -3
>  Can't open python script "intel-pt-events.py": No such file or directory
>  $ perf script ~/libexec/perf-core/scripts/python/intel-pt-events.py 2>&1 | head -3
>    Error: Couldn't find script `/home/ahunter/libexec/perf-core/scripts/python/intel-pt-events.py'
>    See perf script -l for available scripts.
>  $
> 
> After:
> 
>  $ perf script intel-pt-events.py 2>&1 | head -3
>  Intel PT Power Events and PTWRITE
>             perf  8123/8123  [000]       551.230753986     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
>             perf  8123/8123  [001]       551.230808216     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
>  $ perf script -s intel-pt-events.py 2>&1 | head -3
>  Intel PT Power Events and PTWRITE
>             perf  8123/8123  [000]       551.230753986     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
>             perf  8123/8123  [001]       551.230808216     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
>  $ perf script ~/libexec/perf-core/scripts/python/intel-pt-events.py 2>&1 | head -3
>  Intel PT Power Events and PTWRITE
>             perf  8123/8123  [000]       551.230753986     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
>             perf  8123/8123  [001]       551.230808216     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
>  $
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

