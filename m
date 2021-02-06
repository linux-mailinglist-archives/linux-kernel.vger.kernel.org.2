Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17375311FE9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 21:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBFU05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 15:26:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhBFU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 15:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612643129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9dYlMV9MA1srgVqoiRfZeY5YUMO5hZpl3iN1t2OsNs=;
        b=gKqZa2uGjqYjsHyok2LX4UsrWXam2xwld/7nm99sArvRMBSivVIQXePL+sAoj76MkCEhiZ
        Fj5LyPD4jsCpbOo1UX+ZhOwdlDXO7Z1NuRlfyLwRJRxP+PZVUZTOEJt24WN9TeLxK6fL/w
        KWe26LbDSrj/tRzaX+aMtSbX7cnbAsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-alxCFLZzNDSTko8WI_5Npg-1; Sat, 06 Feb 2021 15:25:27 -0500
X-MC-Unique: alxCFLZzNDSTko8WI_5Npg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B35427C3;
        Sat,  6 Feb 2021 20:25:25 +0000 (UTC)
Received: from krava (unknown [10.40.192.19])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3E70360C64;
        Sat,  6 Feb 2021 20:25:22 +0000 (UTC)
Date:   Sat, 6 Feb 2021 21:25:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 06/24] perf daemon: Add config file support
Message-ID: <YB77MWKXW9lNmyR2@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org>
 <20210203211211.GS854763@kernel.org>
 <YBwOAvk0v2o2w5j9@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBwOAvk0v2o2w5j9@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 04:08:50PM +0100, Jiri Olsa wrote:

SNIP

> > > +
> > > +static void session__free(struct session *session)
> > > +{
> > > +	free(session->base);
> > > +	free(session->name);
> > > +	free(session->run);
> > 
> > zfree() so that if there is some dangling pointer to session, we'll get
> > NULL derefs
> 
> and won't be notified by crash about the error ;-) ok

oops, actualy it makes no sense to do it here, because we're
freeing session just in the next line

> 
> > 
> > > +	free(session);
> > > +}
> > > +
> > > +static void session__remove(struct session *session)
> > > +{
> > > +	list_del(&session->list);
> > 
> > list_del_init

same here

> > 
> > > +	session__free(session);
> > > +}
> > > +
> > > +static void daemon__kill(struct daemon *daemon)
> > > +{
> > > +	daemon__signal(daemon, SIGTERM);
> > > +}
> > > +
> > >  static void daemon__free(struct daemon *daemon)
> > >  {
> > > +	struct session *session, *h;
> > > +
> > > +	list_for_each_entry_safe(session, h, &daemon->sessions, list)
> > > +		session__remove(session);
> > 
> > Wouldn't be better to have:
> > 
> > 	 list_for_each_entry_safe(session, h, &daemon->sessions, list) {
> > 	 	list_del_init(&session->list);
> > 		session__free(session);
> > 	 }
> > 
> > Because naming that function "session__remove()" one thinks it is being
> > removed from some data structure, but not that it is being as well
> > deleted.

session__remove is being called also from daemon__reconfig,
so it's there not to repeat the code, I'm ok to rename it

thanks,
jirka

