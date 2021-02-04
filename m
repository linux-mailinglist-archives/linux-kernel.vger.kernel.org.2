Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A3230F6E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbhBDPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:55:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237642AbhBDPyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:54:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47C0864DA5;
        Thu,  4 Feb 2021 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612454007;
        bh=khs2i3o7OyLpByS4iRQitlaOIeP18Lqtszz7MVd7WSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCloZaO1gq9wEGgNOGoPV0d87TreZLfRu/7f/MA26tyjU+Ru6yMj8HTvUKCtqwpcB
         gJYP+dBHnNpx5QLBd+YZP1KhLVoLcZXgluQoewwozQsn565g4vIkH/nF8HYlt9bSJm
         /6K6Lg3RKKon6YUux3/YZCd2Zmfl3rm4eW2dNlOe5XdDsqTq+EIewXbyPr9wxBoyD1
         X0XfE6f2ptOHJxzzfkkfdAjICiuDOCfTKXijzCDMRS0+s+SGlm/KPhzsbakn+x6/5b
         5/5TU0WdJ/OBkqCnd/nZnsDrUmD713Pg3Mh2l2uzXFksuvJtb1nNwCKBKGUnZoviA1
         SAM0go1xxT0jw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F5C140513; Thu,  4 Feb 2021 12:53:24 -0300 (-03)
Date:   Thu, 4 Feb 2021 12:53:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
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
Subject: Re: [PATCH 04/24] perf daemon: Add server socket support
Message-ID: <20210204155324.GC910119@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-5-jolsa@kernel.org>
 <20210203210423.GQ854763@kernel.org>
 <YBwJgC4QX5re1VNw@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBwJgC4QX5re1VNw@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 04, 2021 at 03:49:36PM +0100, Jiri Olsa escreveu:
> On Wed, Feb 03, 2021 at 06:04:23PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Jan 31, 2021 at 12:48:36AM +0100, Jiri Olsa escreveu:
> > > +static int setup_server_socket(struct daemon *daemon)
> > > +{
> > > +	struct sockaddr_un addr;
> > > +	char path[100];
> > > +	int fd;
> > > +
> > > +	fd = socket(AF_UNIX, SOCK_STREAM, 0);
> > 
> > Minor, combine decl with use, since line isn't long and its one after
> > the other, i.e.:
> > 
> > 	int fd = socket(AF_UNIX, SOCK_STREAM, 0);
> 
> hum, sure, but I'm missing the point.. I think it's less readable

one line instead of three :-)
 
> > 
> > > +	if (fd < 0) {
> > > +		fprintf(stderr, "socket: %s\n", strerror(errno));
> > > +		return -1;

- Arnaldo
