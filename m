Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DDC31E3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 02:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBRBbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 20:31:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229907AbhBRBbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613611793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPSb7qksCWoVa70LJkM760CHfNMFGN4fAKqgRH6BSIY=;
        b=VUqIYAhocJJKMR+FPQXJW2pGnUagOCkbzZZx6u5qGsmq9OyvxgqQh23NKmAirvARAQWL4Q
        VLpa+upReqk+OMzzu/3kcB40SAKwXFGGKgmyOR/Lx99MYIvsS5QqAadQNyyZDtfYGhnj86
        u6hSAC+r2MNuNudo0U8ipcHdpds4E5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-1eGzAYLFPuKCOtDV_U7dQg-1; Wed, 17 Feb 2021 20:29:48 -0500
X-MC-Unique: 1eGzAYLFPuKCOtDV_U7dQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A07991005501;
        Thu, 18 Feb 2021 01:29:45 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-153.pek2.redhat.com [10.72.12.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85B3B6F969;
        Thu, 18 Feb 2021 01:29:34 +0000 (UTC)
Date:   Thu, 18 Feb 2021 09:29:31 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, john.p.donnelly@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for
 vmcore creation
Message-ID: <20210218012931.GC3089@dhcp-128-65.nay.redhat.com>
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
 <77fcb8e8-c3ec-6161-14a8-c142e02a9061@oracle.com>
 <20210217142653.0fcd9ce3@gandalf.local.home>
 <20210217194211.GC31184@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217194211.GC31184@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/21 at 02:42pm, Vivek Goyal wrote:
> On Wed, Feb 17, 2021 at 02:26:53PM -0500, Steven Rostedt wrote:
> > On Wed, 17 Feb 2021 12:40:43 -0600
> > john.p.donnelly@oracle.com wrote:
> > 
> > > Hello.
> > > 
> > > Ping.
> > > 
> > > Can we get this reviewed and staged ?
> > > 
> > > Thank you.
> > 
> > Andrew,
> > 
> > Seems you are the only one pushing patches in for kexec/crash. Is this
> > maintained by anyone?
> 
> Dave Young and Baoquan He still maintain kexec/kdump stuff, AFAIK. I
> don't get time to look into this stuff now a days. 

Vivek, no problem, both Baoquan and me are on holiday leaves previously.

I'm fine with the change. 
This patch benefits distributions and those people who want to deploy a lot of
machines.  It is a good start and we can continue to improve the estimation later.

Thanks
Dave 

