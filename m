Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE48C30F579
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbhBDOyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:54:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236911AbhBDOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/bXhNm9KwpDexU8pLCeEwowBlnm7DpOxgyBpK3M5ji8=;
        b=SH4u6COoPv3dSo/wMMSxdRaYsiloerIxKVraJ5OxZXnqh7KaptsGsetkSGXARYUyxQqqgD
        dgI/CbKbGNPihVPdzlR9mG/XMvdEO4AMjZ0h00vY5kDXrpQ3UpAaHhSjKNJHw/c/1I5CD4
        Nt+U+JRVaqYaacpwmCoXqkIGr3F5k6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-EuZoKhJUOOKL2fX810sTFA-1; Thu, 04 Feb 2021 09:51:16 -0500
X-MC-Unique: EuZoKhJUOOKL2fX810sTFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E92691935780;
        Thu,  4 Feb 2021 14:51:14 +0000 (UTC)
Received: from krava (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 89F6F60CFA;
        Thu,  4 Feb 2021 14:51:12 +0000 (UTC)
Date:   Thu, 4 Feb 2021 15:51:11 +0100
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
Subject: Re: [PATCH 07/24] perf daemon: Add config file change check
Message-ID: <YBwJ36m11cVh5G+u@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-8-jolsa@kernel.org>
 <20210203211359.GT854763@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203211359.GT854763@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 06:13:59PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> >  #include <sys/types.h>
> >  #include <sys/socket.h>
> >  #include <sys/un.h>
> > @@ -73,6 +75,7 @@ struct session {
> >  struct daemon {
> >  	const char		*config;
> >  	char			*config_real;
> > +	char			*config_base;
> >  	const char		*base_user;
> >  	char			*base;
> >  	struct list_head	 sessions;
> > @@ -493,6 +496,7 @@ static void daemon__free(struct daemon *daemon)
> >  		session__remove(session);
> >  
> >  	free(daemon->config_real);
> > +	free(daemon->config_base);
> >  	free(daemon->base);
> 
> Please replace those with zfree()

ok

> 
> >  }
> >  
> > @@ -535,6 +539,83 @@ static int daemon__reconfig(struct daemon *daemon)
> >  	return 0;
> >  }
> >  
> > +static int setup_config_changes(struct daemon *daemon)
> > +{
> > +	char *basen = strdup(daemon->config_real);
> > +	char *dirn  = strdup(daemon->config_real);
> > +	char *base, *dir;
> > +	int fd, wd;
> > +
> > +	if (!dirn || !basen)
> > +		return -ENOMEM;
> 
> This may leak one of them

right, will fix

thanks,
jirka

