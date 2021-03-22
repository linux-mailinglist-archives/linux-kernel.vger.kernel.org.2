Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B46344BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhCVQhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231955AbhCVQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616431036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cstLSlg64cVRGYycloccCUIALExFv74RGkKqVQbwqU8=;
        b=F2EFDZH9sBeXQyVi/px55cCKMeKuCM4c09y1yYY0oJQDM/bzaoc4JHfwG9J8+5UmjPXyTS
        Awc/N9FkmVaBbtopoN3JPMkM8945wZmsTRQFmHgQSnIT4eH93CqVlBleQDRkV0lbGzrIlg
        pJS5eyWiuCe8y/Pma4wdGEC3g29sSEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-GEowI-v_PEGGjh93T-c8qQ-1; Mon, 22 Mar 2021 12:37:12 -0400
X-MC-Unique: GEowI-v_PEGGjh93T-c8qQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83BBF1085937;
        Mon, 22 Mar 2021 16:37:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3FB9E5C1A3;
        Mon, 22 Mar 2021 16:37:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Mar 2021 17:37:09 +0100 (CET)
Date:   Mon, 22 Mar 2021 17:37:05 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     qianli zhao <zhaoqianligood@gmail.com>
Cc:     christian@brauner.io, axboe@kernel.dk,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
Message-ID: <20210322163705.GD20390@redhat.com>
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com>
 <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com>
 <CAPx_LQENxx0y5mFJjwRT2qMSLt7pbAmF30=eE-QduEwRVJEJ0Q@mail.gmail.com>
 <20210319163225.GB19971@redhat.com>
 <CAPx_LQGLYx8gKJSkCx9hTyPPbCbU=GJL31TPb3s6zxro522U0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPx_LQGLYx8gKJSkCx9hTyPPbCbU=GJL31TPb3s6zxro522U0Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that we don't understand each other.

If we move atomic_dec_and_test(signal->live) and do

	if (group_dead && is_global_init)
		panic(...);


before setting PF_EXITING like your patch does, then zap_pid_ns_processes()
simply won't be called.

Because:

On 03/21, qianli zhao wrote:
>
> Hi,Oleg
>
> > How? Perhaps I missed something again, but I don't think this is possible.
>
> > zap_pid_ns_processes() simply won't be called, find_child_reaper() will
> > see the !PF_EXITING thread which calls panic().
>
> > So I think this should be documented somehow, at least in the changelog.
>
> This problem occurs when both two init threads enter the do_exit,
> One of the init thread is syscall sys_exit_group,and set SIGNAL_GROUP_EXIT
> The other init thread perform ret_to_user()->get_signal() and found
> SIGNAL_GROUP_EXIT is set,then do_group_exit()->do_exit(),since there
> are no alive init threads it finally goes to
> zap_pid_ns_processes()

No, there is at least one alive init thread. If they all have exited, we have
the thread which calls panic() above.

> and BUG().

so we don't need the SIGNAL_GROUP_EXIT check to avoid this BUG().

What have I missed?

Oleg.

