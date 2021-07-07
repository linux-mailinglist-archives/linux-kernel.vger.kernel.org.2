Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105253BEA72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhGGPNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232133AbhGGPNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:13:45 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF8E61C2F;
        Wed,  7 Jul 2021 15:11:03 +0000 (UTC)
Date:   Wed, 7 Jul 2021 11:11:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Daniel Bristot de Oliveira Subject: [PATCH] tracing:" 
        <bristot@redhat.com>
Subject: Re: [PATCH v2] tracing: Add linear buckets to histogram logic
Message-ID: <20210707111102.749d1fbc@oasis.local.home>
In-Reply-To: <CAM9d7chF1Qnch5PmhfAWbTPcN5ocgVEvNKqFYsLxWOiaZPdYgQ@mail.gmail.com>
References: <20210706154315.3567166e@gandalf.local.home>
        <CAM9d7chmHmm3tjJik5EQDOJOdn7G0D3W9EJUogf_POnyTe6tcA@mail.gmail.com>
        <20210706205039.64182493@rorschach.local.home>
        <CAM9d7chF1Qnch5PmhfAWbTPcN5ocgVEvNKqFYsLxWOiaZPdYgQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 07:00:32 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> > I feel is farther from log2 than my version. Stating that "~" means
> > approximation, what does "0 ~ 99" really mean?  
> 
> To me, it means "range".  The original intention was to
> express [FROM, TO) and I thought we can omit the FROM
> since it's same as TO of the previous line.  But we can use
> inclusive ranges with FROM and TO for clarity.
> 
> But it's up to you.  I don't object to your change.

Thanks, I'd like to keep it as is. Unless Tom has any issues with it.

Tom?

-- Steve
