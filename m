Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2930F552
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbhBDOqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236850AbhBDOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612449747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U5navyVWT5YFg45KWa2CIkT9kOGnIED6spMOn2A7NrE=;
        b=evLK18h/YCxYs0AHdt1lF3o1sGk0CcugGKp6Ng4+s9ItZd73qMdsx023jgvpThD7P8vxw/
        Sjc4Q0eqvnKzURl4SHZihV7kGNEK23v4JyPyS8/gixJuNcAbLSmtfyaydiA2Ktql9A/nIj
        yVG613qoog/5j+aAkolJ0cFiCCYXZ5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-MWVeY-6bP-eapNjSphZGpg-1; Thu, 04 Feb 2021 09:42:23 -0500
X-MC-Unique: MWVeY-6bP-eapNjSphZGpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12BC0100C663;
        Thu,  4 Feb 2021 14:42:21 +0000 (UTC)
Received: from krava (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id E438060CFA;
        Thu,  4 Feb 2021 14:42:17 +0000 (UTC)
Date:   Thu, 4 Feb 2021 15:42:16 +0100
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
Subject: Re: [PATCH 02/24] perf daemon: Add config option
Message-ID: <YBwHyIs6Q9Q2jbBk@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-3-jolsa@kernel.org>
 <20210203205702.GO854763@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203205702.GO854763@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 05:57:02PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jan 31, 2021 at 12:48:34AM +0100, Jiri Olsa escreveu:
> > Adding config option and base functionality that takes the option
> > argument (if specified) and other system config locations and
> > produces 'acting' config file path.
> > 
> > The actual config file processing is coming in following patches.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-daemon.c | 49 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> 
> Missing update to tools/perf/Documentation/perf-daemon.txt for  --config

it's all added in the separate patch with man page

jirka

