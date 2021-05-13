Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410A337FF87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhEMU7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 16:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233203AbhEMU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 16:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620939519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2MuNgdGMtsDmykFFXFtn1HpjYrmNy84WzMn3B0LjVEQ=;
        b=Z8Dv9RarZOaWhHG862sYuJ7iPItXRGnXQTyCE2ZAZjDdOFhGXOl4cEntOGgGUWuaFPP8nl
        gWEZvzPhDiD4hscHG8Ypj7Ojeag09KwQq3qJoizGygJOwl8lVEwTcUYyLK6+drPskCgkEA
        /UrziAIbtScpppxJ3wlioe+MXC5R6tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-DmQllInpPwmZ4YKwlxloJQ-1; Thu, 13 May 2021 16:58:37 -0400
X-MC-Unique: DmQllInpPwmZ4YKwlxloJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33A09801817;
        Thu, 13 May 2021 20:58:36 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with SMTP id 125B210016F9;
        Thu, 13 May 2021 20:58:34 +0000 (UTC)
Date:   Thu, 13 May 2021 22:58:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ftrace: Handle commands when closing set_ftrace_filter
 file
Message-ID: <YJ2S+mwrreixOkcb@krava>
References: <20210505104818.24358ef7@gandalf.local.home>
 <YJ2K80OWCmoxy4n8@krava>
 <20210513164504.6214b03c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513164504.6214b03c@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 04:45:04PM -0400, Steven Rostedt wrote:
> On Thu, 13 May 2021 22:24:19 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > Fixes: eda1e32855656 ("tracing: handle broken names in ftrace filter")  
> > 
> > nice, breaking kernel since 2009.. I'll put that on t-shirt ;-)
> 
> Hmm, maybe I'll recommend that for the Linux Plumber's t-shirt ;-)
> 
>  "Breaking kernel's since 2009"!
> 
> > 
> > I saw the patch got already merged, FWIW:
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> I'm guessing you hit the bug too?

no, I did not notice before, just reproduced based on your changelog

jirka

