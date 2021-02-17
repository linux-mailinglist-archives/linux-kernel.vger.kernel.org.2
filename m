Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5D31DFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhBQToW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233710AbhBQTnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613590943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJM1EJb2IlVcsAafjc8DDTue6Vq84muOSo4iOsYZMrA=;
        b=MP4kxDUT+AiE/YVBjbLkN3dOcOVUt9+RAvqqqCwcDUbw5bXLbdsiSRhmlfufpivkDAlilp
        ghN72T75smg+Vy444mBbtUkIraVTFRBYRnlmfm6bD69yWwgBZaPAUoZTrkj06jkM88e65o
        mxYucoPa90o7vKH+M1LSCbERt5EO5SU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224--D2yc6o0M--F1RjNWsSPDQ-1; Wed, 17 Feb 2021 14:42:19 -0500
X-MC-Unique: -D2yc6o0M--F1RjNWsSPDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AAA6107ACE3;
        Wed, 17 Feb 2021 19:42:16 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-123.rdu2.redhat.com [10.10.114.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94AD25C276;
        Wed, 17 Feb 2021 19:42:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E191E220BCF; Wed, 17 Feb 2021 14:42:11 -0500 (EST)
Date:   Wed, 17 Feb 2021 14:42:11 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     john.p.donnelly@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20210217194211.GC31184@redhat.com>
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
 <77fcb8e8-c3ec-6161-14a8-c142e02a9061@oracle.com>
 <20210217142653.0fcd9ce3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217142653.0fcd9ce3@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 02:26:53PM -0500, Steven Rostedt wrote:
> On Wed, 17 Feb 2021 12:40:43 -0600
> john.p.donnelly@oracle.com wrote:
> 
> > Hello.
> > 
> > Ping.
> > 
> > Can we get this reviewed and staged ?
> > 
> > Thank you.
> 
> Andrew,
> 
> Seems you are the only one pushing patches in for kexec/crash. Is this
> maintained by anyone?

Dave Young and Baoquan He still maintain kexec/kdump stuff, AFAIK. I
don't get time to look into this stuff now a days. 

Vivek

