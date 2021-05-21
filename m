Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A676C38C07C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhEUHOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:14:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:46274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235561AbhEUHN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:13:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621581150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jp4zlznkpFx9tdWxRUV7M5qNhT0kZeoN0+qL2xikpYg=;
        b=tUDSC0acfymWbFBzvducaP0wBVLZV872XvCF1zTWwODsy2jEiNXR0Wct16zY9MAR/cPA5E
        ZnnPP/g09GFGnQKDlw9ml/F5DzOVHFiiVXUfEv6QZ17S3+DHJ5y7Hg6zoCcUedvqbLpfSS
        HWoQiMICrUiF5LgomVsUqQ1aIOO1Mag=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 734F1AC1A;
        Fri, 21 May 2021 07:12:30 +0000 (UTC)
Date:   Fri, 21 May 2021 09:12:30 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Martin Liu <liumartin@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tejun Heo <tj@kernel.org>, minchan@google.com, www@google.com,
        davidchao@google.com, jenhaochen@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kthread: Fix kthread_mod_delayed_work vs
 kthread_cancel_delayed_work_sync race
Message-ID: <YKddXqLh6+Pj7wFW@alley>
References: <20210513065458.941403-1-liumartin@google.com>
 <20210520144845.52755f3af700a902e07e2ee7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520144845.52755f3af700a902e07e2ee7@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-05-20 14:48:45, Andrew Morton wrote:
> On Thu, 13 May 2021 14:54:57 +0800 Martin Liu <liumartin@google.com> wrote:
> 
> > We encountered a system hang issue while doing the tests. The callstack
> > is as following
> >
> > ...
> >
> > Fixes: 37be45d49dec2 ("kthread: allow to cancel kthread work")
> 
> Thanks.  I added a cc:stable to this and shall hold it in -mm for a
> couple of weeks to get exposure and testing before sending it to Linus
> for 5.13.

Sounds good to me. Thanks for taking care of it.

Best Regards,
Petr
