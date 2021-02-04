Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2CD30F5E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbhBDPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:12:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237180AbhBDPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612451341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPzNrEWsn+M24PwS5ETMEy5ZMgF7btgTtrcFRzwGCWc=;
        b=fbDg9tqbDWeGAjsia2AtrQNcyvjzTpqT0gN6oNsuRB7MY1UXTNEn3XoOJaNn5rLhHNWk2O
        j/Y9/AnlGnwKKTwpAqiNWh5cbPDQgno63A9FrolB53+dIUrcvtcMkX4rXoSoUAns/jy+qU
        aVRcc7uk0DFg08uYLOOZqbgbycffoy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-kLRdj8ddORKE-jrqw1rfOg-1; Thu, 04 Feb 2021 10:08:55 -0500
X-MC-Unique: kLRdj8ddORKE-jrqw1rfOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B36826D4E6;
        Thu,  4 Feb 2021 15:08:53 +0000 (UTC)
Received: from krava (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4E77019708;
        Thu,  4 Feb 2021 15:08:51 +0000 (UTC)
Date:   Thu, 4 Feb 2021 16:08:50 +0100
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
Message-ID: <YBwOAvk0v2o2w5j9@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org>
 <20210203211211.GS854763@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203211211.GS854763@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 06:12:11PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > -static struct daemon __daemon = { };
> > +static struct daemon __daemon = {
> > +	.sessions = LIST_HEAD_INIT(__daemon.sessions),
> > +};
> >  
> >  static const char * const daemon_usage[] = {
> >  	"perf daemon start [<options>]",
> > @@ -43,6 +97,128 @@ static void sig_handler(int sig __maybe_unused)
> >  	done = true;
> >  }
> >  
> > +static struct session*
> > +daemon__add_session(struct daemon *config, char *name)
> > +{
> > +	struct session *session;
> > +
> > +	session = zalloc(sizeof(*session));
> 
> 	
> 	struct session *session = zalloc(sizeof(*session));
> 
> > +	if (!session)
> > +		return NULL;
> > +
> > +	session->name = strdup(name);
> > +	if (!session->name) {
> > +		free(session);
> > +		return NULL;
> > +	}
> > +
> > +	session->pid = -1;
> > +	list_add_tail(&session->list, &config->sessions);
> > +	return session;
> > +}
> > +
> > +static struct session*
> 
> add space after type name
> 
>    static struct session *
> 
> And we could have it in the same line:
> 
>   static struct session *daemon__find_session(struct daemon *daemon, char *name)

ok

SNIP

> > +			/*
> > +			 * Either new or changed run value is defined,
> > +			 * trigger reconfig for the session.
> > +			 */
> > +			session->state = SESSION_STATE__RECONFIG;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int server_config(const char *var, const char *value, void *cb)
> > +{
> > +	struct daemon *daemon = cb;
> > +
> > +	if (strstarts(var, "session-"))
> > +		return session_config(daemon, var, value);
> > +	else if (!strcmp(var, "daemon.base") && !daemon->base_user) {
> 
> if else uses {}, if should too

ok

SNIP

> > +
> > +static void session__free(struct session *session)
> > +{
> > +	free(session->base);
> > +	free(session->name);
> > +	free(session->run);
> 
> zfree() so that if there is some dangling pointer to session, we'll get
> NULL derefs

and won't be notified by crash about the error ;-) ok

> 
> > +	free(session);
> > +}
> > +
> > +static void session__remove(struct session *session)
> > +{
> > +	list_del(&session->list);
> 
> list_del_init
> 
> > +	session__free(session);
> > +}
> > +
> > +static void daemon__kill(struct daemon *daemon)
> > +{
> > +	daemon__signal(daemon, SIGTERM);
> > +}
> > +
> >  static void daemon__free(struct daemon *daemon)
> >  {
> > +	struct session *session, *h;
> > +
> > +	list_for_each_entry_safe(session, h, &daemon->sessions, list)
> > +		session__remove(session);
> 
> Wouldn't be better to have:
> 
> 	 list_for_each_entry_safe(session, h, &daemon->sessions, list) {
> 	 	list_del_init(&session->list);
> 		session__free(session);
> 	 }
> 
> Because naming that function "session__remove()" one thinks it is being
> removed from some data structure, but not that it is being as well
> deleted.
> 
> Please rename session__free() to session__delete() to keep it consistent
> with other places.

ok

> 
> > +
> >  	free(daemon->config_real);
> >  	free(daemon->base);
> >  }
> >  
> >  static void daemon__exit(struct daemon *daemon)
> >  {
> > +	daemon__kill(daemon);
> >  	daemon__free(daemon);
> 
> Ditto for daemon__free(): please rename it to daemon__delete()

ok

thanks,
jirka

