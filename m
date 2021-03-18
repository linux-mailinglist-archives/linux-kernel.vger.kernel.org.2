Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C2340C70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhCRSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230164AbhCRSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616090703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WftQMrFPNAP4YAr6T6xNf+HYZqIB+G4C+TYDinLLNQA=;
        b=BM1KbF+EDz32kcFWmApUrXpYKNVRCuPB22sUqn5yzuaL+pSL3w3WQhPOwYgxdUQMoTdlIr
        /BubPA4Or4haI2FyQWNsCmH7f2P5IrPG8pJnBsROzaAWxAIRP72m1KNYyXvtGGNOqW1sAb
        7rs9RZfPBDs18PxQh94l426xsR9nOQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-bVL03gc7N26YbIhQwHfKxg-1; Thu, 18 Mar 2021 14:04:59 -0400
X-MC-Unique: bVL03gc7N26YbIhQwHfKxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B67581A281;
        Thu, 18 Mar 2021 18:04:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.212])
        by smtp.corp.redhat.com (Postfix) with SMTP id 473B460CDF;
        Thu, 18 Mar 2021 18:04:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 Mar 2021 19:04:54 +0100 (CET)
Date:   Thu, 18 Mar 2021 19:04:51 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     qianli zhao <zhaoqianligood@gmail.com>
Cc:     christian@brauner.io, axboe@kernel.dk,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
Message-ID: <20210318180450.GA9977@redhat.com>
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com>
 <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18, qianli zhao wrote:
>
> Hi,Oleg
>
> Thank you for your reply.
>
> >> When init sub-threads running on different CPUs exit at the same time,
> >> zap_pid_ns_processe()->BUG() may be happened.
>
> > and why do you think your patch can't prevent this?
>
> > Sorry, I must have missed something. But it seems to me that you are trying
> > to fix the wrong problem. Yes, zap_pid_ns_processes() must not be called in
> > the root namespace, and this has nothing to do with CONFIG_PID_NS.
>
> Yes, i try to fix this exception by test SIGNAL_GROUP_EXIT and call
> panic before setting PF_EXITING to prevent zap_pid_ns_processes()
> being called when init do_exit().

Ah, I didn't notice your patch does atomic_dec_and_test(signal->live)
before exit_signals() which sets PF_EXITING. Thanks for correcting me.

So yes, I was wrong, your patch can prevent this. Although I'd like to
recheck if every do-something-if-group-dead action is correct in the
case we have a non-PF_EXITING thread...

But then I don't understand the SIGNAL_GROUP_EXIT check added by your
patch. Do we really need it if we want to avoid zap_pid_ns_processes()
when the global init exits?

> In addition, the patch also protects the init process state to
> successfully get usable init coredump.

Could you spell please?

Does this connect to SIGNAL_GROUP_EXIT check? Do you mean that you want
to panic earlier, before other init's sub-threads exit?

Thanks,

Oleg.

