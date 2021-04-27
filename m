Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F9936BF3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhD0G1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhD0G1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619504794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QG3y0jYLDkAsU+1nlifcQueSWIRESCsy0kOXhKZLKCM=;
        b=OdO/wZPEbn8s6EbjZOpjZ4e+xOMKDzoQMJlR4I8M3utqYXiV47I6zmH7nzEpQX1aI8a69K
        Ib2zR9PdVYghlhy9q+Ms09Wi+SB1t+IDT0UE7MKfHKbO/q2zhBGUZhoqXLOBzrKN20RZMr
        ExrVo/cwiBBQMYY9Gmt3m+D+x9w16PI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-59nRRFvIONSOWekGc_4Rzw-1; Tue, 27 Apr 2021 02:26:32 -0400
X-MC-Unique: 59nRRFvIONSOWekGc_4Rzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CF7A107ACE6;
        Tue, 27 Apr 2021 06:26:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.96])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9B446E16F;
        Tue, 27 Apr 2021 06:26:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 27 Apr 2021 08:26:30 +0200 (CEST)
Date:   Tue, 27 Apr 2021 08:26:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] ptrace: make ptrace() fail if the tracee changed
 its pid unexpectedly
Message-ID: <20210427062619.GB10986@redhat.com>
References: <20210426154539.GA5166@redhat.com>
 <626936290.15030.1619471040515.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626936290.15030.1619471040515.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 04/26, Mathieu Desnoyers wrote:
>
> > The patch doesn't add the new PTRACE_ option to not complicate the API,
> > and I _hope_ this won't cause any noticeable regression:
> >
> >	- If debugger uses PTRACE_O_TRACEEXEC and the thread did an exec
> >	  and the tracer does a ptrace request without having consumed
> >	  the exec event, it's 100% sure that the thread the ptracer
> >	  thinks it is targeting does not exist anymore, or isn't the
> >	  same as the one it thinks it is targeting.
> >
> >	- To some degree this patch adds nothing new. In the scenario
> >	  above ptrace(L) can fail with -ESRCH if it is called after the
> >	  execing sub-thread wakes the leader up and before it "steals"
> >	  the leader's pid.
>
> Hi Oleg,
>
> Is this something that should also target stable kernels ? AFAIU this change
> won't break debuggers more that they are already in this scenario. Or maybe
> it makes them fail in more obvious ways ?

Well, I am not sure this is stable material...

To me the problem is minor, and the patch adds the user-visible change.
I think it would be safer to not add stable tag.

Oleg.

