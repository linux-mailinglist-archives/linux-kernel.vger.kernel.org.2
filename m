Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B237BF00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhELN6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:58:01 -0400
Received: from mail.efficios.com ([167.114.26.124]:49570 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhELN6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:58:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2E406331BF6;
        Wed, 12 May 2021 09:56:52 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Q5YjFhWnJ2Qt; Wed, 12 May 2021 09:56:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 240E833211B;
        Wed, 12 May 2021 09:56:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 240E833211B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1620827810;
        bh=TiLCLn2QTd4JQkZHarkDu8my0WUJj5FPPxSTRQX7FwI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=D4Nulqcb5ZQ9AxnTisIBO5qldY7Fs/CFc7iEDMVvaiNryqluY1QTFg8z43ALhqY3t
         x2x8vI45FtBF0WRuTxIkifFxV5aWqEkULNC83K4TVytpFGKcWXRIv3Kmwbu9K5QOSb
         yN3kBZisGD/UAsUFzMUnoThQM1juWcTqHPEuhj1vE63pHFxzwldKHGI+hAFgQj6nzF
         YOMq7+GFO5ir9VaWEpSZRFHfXVTqUkq8PR/O1YUOB8IhLP+FzMkYHBLQPSMxQ04vyR
         IeAij3PvzU5tYl1ixXk2JxDbhZ8hZvGnCXGFAtxYPwAsXjV+NNxTsB4qfJnzdycv6A
         xl0kkQX1/WS8w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qDwG2C_odGRc; Wed, 12 May 2021 09:56:50 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 0B6B5332111;
        Wed, 12 May 2021 09:56:50 -0400 (EDT)
Date:   Wed, 12 May 2021 09:56:49 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1879292286.40455.1620827809948.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210512133615.GA19594@redhat.com>
References: <20210511165626.GA13720@redhat.com> <CAHk-=whLqbTNc1T+rHCm-kxbVAuhK3hjo5fOgDVf5-z--x1mvQ@mail.gmail.com> <20210511175341.GA14488@redhat.com> <20210511180627.GB14488@redhat.com> <20210512133615.GA19594@redhat.com>
Subject: Re: [PATCH RESEND2] ptrace: make ptrace() fail if the tracee
 changed its pid unexpectedly
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: ptrace: make ptrace() fail if the tracee changed its pid unexpectedly
Thread-Index: SQXpGls19Im4Qivw+1Gpa/jcGJBPGg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 12, 2021, at 9:36 AM, Oleg Nesterov oleg@redhat.com wrote:

> On 05/11, Oleg Nesterov wrote:
>>
>> On 05/11, Oleg Nesterov wrote:
>> >
>> > On 05/11, Linus Torvalds wrote:
>> >
>> > > That said, why this:
>> > >
>> > > > +       rcu_read_lock();
>> > > > +       pid = task_pid_nr_ns(task, task_active_pid_ns(task->parent));
>> > > > +       rcu_read_unlock();
>> > >
>> > > I don't see why the RCU read lock would be needed? task_pid_nr_ns()
>> > > does any required locking itself, afaik.
>> > >
>> > > And even if it wasn't, this all happens with siglock held, can
>> > > anything actually change.
>> >
>> > ... and with tasklist_lock held.
>> >
>> > Hmm. Linus, I am shy to admit I can't answer immediately, I'll recheck
>> > tomorrow after sleep. But it seems you are right.
>>
>> most probably to protect task->parent, not sure, this was 6 month ago...
>> but in this case we can use "current". I'll recheck.
> 
> Of course you are right, rcu_read_lock() is not needed. Plus we can use
> task_pid_vnr() rather than task_pid_nr_ns(). I've sent v2.

Out of curiosity: what makes it OK to use either the current task or its
parent's pid namespace in this specific case ? What happens if they are
in different pid namespaces ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
