Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7A3066FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhA0WEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:04:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236548AbhA0WDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611784889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=quFy3TP6PfexKvPdLCvkfsnJJbwk3h8uFwcXYAFmn2w=;
        b=al2Wgo4nBAdWL0x+JwO3R8QUeHJbrDAIgiVAJhoe7UnfC5y1HVUXcEgG5blqVyi8Bt0aFn
        iH5GeuWpydM78/NG5qXwr/bNNTgYCyRofh9QNRXnGE+80VxoMQ2RzBuUjg4vGVmFPX4URi
        vX6jJlhs2Lzl0ov52mlEDGoFnAN8zis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-rd23hgCSOPexHAKq3Ixqww-1; Wed, 27 Jan 2021 17:01:25 -0500
X-MC-Unique: rd23hgCSOPexHAKq3Ixqww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DF48193578B;
        Wed, 27 Jan 2021 22:01:23 +0000 (UTC)
Received: from krava (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 71D6817195;
        Wed, 27 Jan 2021 22:01:20 +0000 (UTC)
Date:   Wed, 27 Jan 2021 23:01:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 07/22] perf daemon: Add daemon command
Message-ID: <20210127220119.GA284633@krava>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-8-jolsa@kernel.org>
 <CAM9d7ci2VUS5oLNDF3J1PgRaGRPSJxAzsn7sd4bC-NX9_2NTfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci2VUS5oLNDF3J1PgRaGRPSJxAzsn7sd4bC-NX9_2NTfQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 04:09:18PM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Sun, Jan 3, 2021 at 7:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > +int cmd_daemon(int argc, const char **argv)
> > +{
> > +       struct option daemon_options[] = {
> > +               OPT_INCR('v', "verbose", &verbose, "be more verbose"),
> > +               OPT_STRING(0, "config", &__daemon.config,
> > +                       "config file", "config file path"),
> > +               OPT_STRING_OPTARG('x', "field-separator", &__daemon.csv_sep,
> > +                       "field separator", "print counts with custom separator", ":"),
> 
> Oh, I didn't expect it's optional and default to ":" instead of ",".

np, I can change the default to ','

jirka

> 
> Thanks,
> Namhyung
> 
> 
> > +               OPT_END()
> > +       };
> 

