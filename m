Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ECA34801C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbhCXSM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237397AbhCXSMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616609537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KFO6lxfSXo+H+A/7Sv08tqh+O1ib64xN6C+hvg30WuM=;
        b=FTGaPvIZFutlXIy96umX4Q/5qT5ewTp5zSZFUJcCiOR7rmLeTSdn6eX3OvI7+MB93m3B8k
        bq9FCV2Kew6IJ//h12z2GwSkiqgAOcWcPDcdyzciZvNdTRqH2aDVmZFsBiJMsBiFa0yckn
        UslaKWJ+LWHTQMg9srT1bYPvKGDq4H0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-0hJATpJuPfeudphdNHlWWQ-1; Wed, 24 Mar 2021 14:12:15 -0400
X-MC-Unique: 0hJATpJuPfeudphdNHlWWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00DD61853024;
        Wed, 24 Mar 2021 18:12:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.218])
        by smtp.corp.redhat.com (Postfix) with SMTP id DF96E10023AF;
        Wed, 24 Mar 2021 18:12:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Mar 2021 19:12:13 +0100 (CET)
Date:   Wed, 24 Mar 2021 19:12:10 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     qianli zhao <zhaoqianligood@gmail.com>
Cc:     christian@brauner.io, axboe@kernel.dk,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
Message-ID: <20210324181209.GB13021@redhat.com>
References: <20210317143805.GA5610@redhat.com>
 <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com>
 <CAPx_LQENxx0y5mFJjwRT2qMSLt7pbAmF30=eE-QduEwRVJEJ0Q@mail.gmail.com>
 <20210319163225.GB19971@redhat.com>
 <CAPx_LQGLYx8gKJSkCx9hTyPPbCbU=GJL31TPb3s6zxro522U0Q@mail.gmail.com>
 <20210322163705.GD20390@redhat.com>
 <CAPx_LQG_5ushJkyymSsYq8FafRj7XOA217JwCyHASEqq0wyMOQ@mail.gmail.com>
 <20210323090035.GA25159@redhat.com>
 <CAPx_LQH0Qx7R9vNb3FHgO7V8uJ9AAh0j_TZV-VnyBF7Ys_7FTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPx_LQH0Qx7R9vNb3FHgO7V8uJ9AAh0j_TZV-VnyBF7Ys_7FTQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/23, qianli zhao wrote:
>
> Hi,Oleg
>
> > You certainly don't understand me :/
>
> > Please read my email you quoted below. I didn't mean the current logic.
> > I meant the logic after your patch which moves atomic_dec_and_test() and
> > panic() before exit_signals().
>
> Sorry, I think I see what you mean now.
>
> You mean that after apply my patch,SIGNAL_GROUP_EXIT no longer needs
> to be tested or avoid zap_pid_ns_processes()->BUG().
> Yes,your consideration is correct.

OK, great

> But,my patch has another purpose,protect some key variables(such
> as:task->mm,task->nsproxy,etc) to recover init coredump from
> fulldump,if sub-threads finish do_exit(),

Yes I know.

But the purpose of this SIGNAL_GROUP_EXIT check is not clear and not
documented. That is why I said it should be documented at least in the
changelog.

Oleg.

