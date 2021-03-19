Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054843421F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCSQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhCSQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616171552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xuN/BQ3TMCd1X8UMe2lNGsX3GTMn8VHhRpzWPbejhMY=;
        b=DWVnJwInvFbVSdBDaf+/Kgvqk9Ip1CS1ca3ztbE1Q4yZgeuX/4ZiT0m3lAKcsF+phRLyMu
        d3/uESQVO6W9u/ioRzrGW3rK+/JcUv3SQNfp24GiMJRGSJDEw6xSa+iclbI2xAS4ry9SZk
        OFclnI63BMkx9dlNFvvW22uPZg8PzDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-fxBG1fW_NpCnHlafJ7rirQ-1; Fri, 19 Mar 2021 12:32:30 -0400
X-MC-Unique: fxBG1fW_NpCnHlafJ7rirQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7395B107ACCD;
        Fri, 19 Mar 2021 16:32:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.172])
        by smtp.corp.redhat.com (Postfix) with SMTP id 05AF26091B;
        Fri, 19 Mar 2021 16:32:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 19 Mar 2021 17:32:28 +0100 (CET)
Date:   Fri, 19 Mar 2021 17:32:25 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     qianli zhao <zhaoqianligood@gmail.com>
Cc:     christian@brauner.io, axboe@kernel.dk,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
Message-ID: <20210319163225.GB19971@redhat.com>
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com>
 <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com>
 <CAPx_LQENxx0y5mFJjwRT2qMSLt7pbAmF30=eE-QduEwRVJEJ0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPx_LQENxx0y5mFJjwRT2qMSLt7pbAmF30=eE-QduEwRVJEJ0Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19, qianli zhao wrote:
>
> > But then I don't understand the SIGNAL_GROUP_EXIT check added by your
> > patch. Do we really need it if we want to avoid zap_pid_ns_processes()
> > when the global init exits?
>
> I think check SIGNAL_GROUP_EXIT is necessary,or panic() will happen
> after all init sub-threads do_exit(),so the following two situations
> will happen:
> 1.According to the timing in the changelog,
> zap_pid_ns_processes()->BUG() maybe happened.

How? Perhaps I missed something again, but I don't think this is possible.

zap_pid_ns_processes() simply won't be called, find_child_reaper() will
see the !PF_EXITING thread which calls panic().

So I think this should be documented somehow, at least in the changelog.

Oleg.

