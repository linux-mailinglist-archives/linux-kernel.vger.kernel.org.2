Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D92347FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbhCXSEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236787AbhCXSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616609025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=foTe1xJ94AwyuiY3jn5t5XLMRfrBh5Yrjw+oJoljw7A=;
        b=QN23ZE9vjKbMHoSUZbFbesl4764TI2eLjNFyg4v1YbZPXO8zhRv0A/7YqPaDsufUv2EQjO
        VcLZVovFPG7ESntsE2T2eePLFAbZZH2+ZVOeFioWf/ttz4lTLjmQzkw4HHfJvZdiuz81jA
        kF2WQhrWaSEMPsmy6w+uk7k0O4j36Bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-Bi7d1kwxOai1WzShSxZ5Og-1; Wed, 24 Mar 2021 14:03:41 -0400
X-MC-Unique: Bi7d1kwxOai1WzShSxZ5Og-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB759190D343;
        Wed, 24 Mar 2021 18:03:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.218])
        by smtp.corp.redhat.com (Postfix) with SMTP id 893995D723;
        Wed, 24 Mar 2021 18:03:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Mar 2021 19:03:39 +0100 (CET)
Date:   Wed, 24 Mar 2021 19:03:25 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch V5 2/2] signal: Allow tasks to cache one sigqueue struct
Message-ID: <20210324180324.GA13021@redhat.com>
References: <87o8f9r7ug.fsf@nanos.tec.linutronix.de>
 <87sg4lbmxo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg4lbmxo.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Thomas Gleixner wrote:
>
>  include/linux/sched.h  |    1 +
>  include/linux/signal.h |    1 +
>  kernel/exit.c          |    1 +
>  kernel/fork.c          |    1 +
>  kernel/signal.c        |   44 ++++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 46 insertions(+), 2 deletions(-)

both patches look good to me, feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

