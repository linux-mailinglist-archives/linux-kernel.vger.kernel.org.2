Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B823CD601
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbhGSNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240351AbhGSNFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:05:25 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F13261026;
        Mon, 19 Jul 2021 13:46:04 +0000 (UTC)
Date:   Mon, 19 Jul 2021 09:45:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] tracing: histogram fix and take 2 on the
 __string_len() marcros
Message-ID: <20210719094557.5b9f5349@oasis.local.home>
In-Reply-To: <F5824BF9-1F6F-4882-A6D9-0943DCFF55DA@oracle.com>
References: <20210715215753.4a314e97@rorschach.local.home>
        <CAHk-=wiWdG6jqKhdU62b06-DtESVxHVK8MA23iV+6fB5hnGEAw@mail.gmail.com>
        <20210716143705.56001390@oasis.local.home>
        <CAHk-=wjWosrcv2=6m-=YgXRKev=5cnCg-1EhqDpbRXT5z6eQmg@mail.gmail.com>
        <20210716171805.55aed9de@oasis.local.home>
        <26A9CF5A-0724-4D4B-BC59-09849EC33326@oracle.com>
        <20210716205510.7f565b98@oasis.local.home>
        <F5824BF9-1F6F-4882-A6D9-0943DCFF55DA@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jul 2021 16:51:58 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> Thanks. I can carry whichever version of this patch that both you
> and Linus are happy with. I will apply my changes to use __string_len()
> on top of it, and send the whole mess when v5.15 opens in a couple
> months.

The version in this email is the one that I believe is something that
myself and Linus can live with. It uses memcpy() as it replaces a
memcpy() and I added documentation about it in the
samples/trace_events/ directory.

-- Steve


> 
> 
> > Hopefully
> > it wont conflict with other work I'm doing. But if it does, we'll work
> > it out. I don't have any code that relies on it.
> > 
> > -- Steve
> > 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > Subject: [PATCH] tracing: Add trace_event helper macros __string_len() and
> > __assign_str_len()
> > 

