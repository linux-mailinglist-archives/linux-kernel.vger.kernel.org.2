Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918B2441C91
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhKAO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhKAO1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:27:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A5C604DC;
        Mon,  1 Nov 2021 14:24:36 +0000 (UTC)
Date:   Mon, 1 Nov 2021 10:24:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rostedt-trace:for-next 58/100]
 samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous prototype
 for function 'my_direct_func'
Message-ID: <20211101102434.47e84754@gandalf.local.home>
In-Reply-To: <YX/thIXtDzfhljX7@krava>
References: <202111010507.F9ud1mUL-lkp@intel.com>
        <YX/thIXtDzfhljX7@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 14:37:08 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> >   
> > >> samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous prototype for function 'my_direct_func' [-Wmissing-prototypes]  
> >    void my_direct_func(unsigned long ip)
> >         ^
> >    samples/ftrace/ftrace-direct-multi.c:8:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >    void my_direct_func(unsigned long ip)  
> 
> hum, that can actually be static.. I'll check
> 

I'm not sure it can, because you call it from inline assembly, and the
symbol may not be passed to the assembler.

It may work with some options, but may not for all.

I think the best thing to do is just create a prototype to quiet the
warning (with a comment).

-- Steve
