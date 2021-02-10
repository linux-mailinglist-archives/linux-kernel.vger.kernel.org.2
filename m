Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9B316804
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBJN3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:29:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhBJN3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612963669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I3FIjt8SdbutmfidhQDSOSXBUCw322LqvVNCWhXQOZw=;
        b=jN0QdM1RmLF9dDG9YZpeci6c8Vq4GnAy/wuiU6/7Z8KhVX48Dy+Pln+t1FjNc0cI+gWD8g
        +0qp69JFlj9sqFmCfY+bc5GP6AKwHq63tUc2tHgneMyGTJfNaUduKVfz+fEI0iWqPyBjO9
        V42xK/mQmruXEewYv1Np18cMx6WHVjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-Qmvwp_CQP6eBLI-s-Yuqfg-1; Wed, 10 Feb 2021 08:27:47 -0500
X-MC-Unique: Qmvwp_CQP6eBLI-s-Yuqfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D8E6107ACE3;
        Wed, 10 Feb 2021 13:27:45 +0000 (UTC)
Received: from krava (unknown [10.40.195.206])
        by smtp.corp.redhat.com (Postfix) with SMTP id 41F3D5C8A8;
        Wed, 10 Feb 2021 13:27:40 +0000 (UTC)
Date:   Wed, 10 Feb 2021 14:27:39 +0100
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
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 15/24] perf daemon: Add ping command
Message-ID: <YCPfS91fbj3XyH/v@krava>
References: <20210208200908.1019149-1-jolsa@kernel.org>
 <20210208200908.1019149-16-jolsa@kernel.org>
 <20210210125146.GD1018564@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210125146.GD1018564@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:51:46AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 08, 2021 at 09:08:59PM +0100, Jiri Olsa escreveu:
> > +
> > +	if (!pollfd.revents & POLLIN) {
> > +		pr_err("failed: did not received an ack\n");
> > +		goto out;
> > +	}
> > +
> 
> Fixed up this, pointed out by clang on many build containers, including
> fedora:34:
> 
> Committer notes:
> 
> Fixed up bug pointed by clang:
> 
> Buggy:
> 
>   if (!pollfd.revents & POLLIN)
> 
> Correct code:
> 
>   if (!(pollfd.revents & POLLIN))
> 
> clang warning:
> 
>   builtin-daemon.c:560:6: error: logical not is only applied to the left hand side of this bitwise operator [-Werror,-Wlogical-not-parentheses]
>           if (!pollfd.revents & POLLIN) {
>               ^               ~
>   builtin-daemon.c:560:6: note: add parentheses after the '!' to evaluate the bitwise operator first

oops, thanks

jirka

