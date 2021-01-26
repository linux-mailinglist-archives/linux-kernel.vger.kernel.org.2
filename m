Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4292C30527C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhA0DQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732329AbhAZUWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611692465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2wtmwF4X10LmhwL3ATZVxyCDOsFENiA8D2edcsLCzNk=;
        b=QfEzm3TONzaMZaZpZ5R+TnElhTV/QVOg6wXobwZ4GvKdxP29lKYMRWuYWbDAaY9O2ed0mT
        X5GsGjsWh3eumeBzpw+h2EUTi7qHsFinLF4jHMyO6eWuFVuJfk/dyaUeMIm55zAHb2NPdO
        WiRAt3HRuxE+Vs9182aXwx8BTjnF6wU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-p-Idqt-ZM2euvKbcImnDxQ-1; Tue, 26 Jan 2021 15:21:03 -0500
X-MC-Unique: p-Idqt-ZM2euvKbcImnDxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B3811005513;
        Tue, 26 Jan 2021 20:21:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 22DC05F9A6;
        Tue, 26 Jan 2021 20:20:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Jan 2021 21:21:02 +0100 (CET)
Date:   Tue, 26 Jan 2021 21:20:59 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jianlin Lv <Jianlin.Lv@arm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
Message-ID: <20210126202058.GC12469@redhat.com>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
 <20210125181926.GA10248@redhat.com>
 <20210125133840.511b1496@gandalf.local.home>
 <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26, Masami Hiramatsu wrote:
>
> > >
> > > IOW, the "offset != 0" check removed by this patch is obviously wrong, right?
> > >
>
> No, not wrong. Even offset != 0, if the symbol exists in the kernel,
> kprobe_on_func_entry() will check it.

Yes, but unless I am totally confused... if kprobe_on_func_entry() returns false,
then trace_kprobe_create() should fail with BAD_RETPROBE even if offset == 0 ?

Oleg.

