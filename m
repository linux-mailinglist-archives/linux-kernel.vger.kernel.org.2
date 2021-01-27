Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E073057FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhA0KOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:14:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:44732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235679AbhA0KL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:11:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611742271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yPf2iJr5KkXD7cHfhYBFDDhckcK1meh6Ewd51gOqfVA=;
        b=TcRl87hTHXiu0LMMLmcAeZugAde+Q45wqATiGZvDorIGR26b3XcTaRPcfpe8NVFEPaL1rR
        nIiUgDsci2VWtrvWSmmxD/jdeiI4qDKr7ILOVdd/WCTK7AssE85lTPosVzPDuXqqTEU4mH
        PToAbuFhI0ni1QfcSob3Us+oaWwG6/s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79988ADA2;
        Wed, 27 Jan 2021 10:11:11 +0000 (UTC)
Date:   Wed, 27 Jan 2021 11:11:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Timur Tabi <timur@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        roman.fietze@magna.com, keescook@chromium.org,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <YBE8Pj8t8bsVroyQ@alley>
References: <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
 <09c70d6b-c989-ca23-7ee8-b404bb0490f0@suse.cz>
 <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org>
 <083dd940-60c1-4cc8-fc89-8815b253d5c5@suse.cz>
 <a9b38fe7-8a22-71b7-1e84-0ebf1e864306@kernel.org>
 <20210126123912.23a5c3a1@gandalf.local.home>
 <20210126124032.0915f408@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126124032.0915f408@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-01-26 12:40:32, Steven Rostedt wrote:
> On Tue, 26 Jan 2021 12:39:12 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 26 Jan 2021 11:30:02 -0600
> > Timur Tabi <timur@kernel.org> wrote:
> > 
> > > On 1/26/21 11:14 AM, Vlastimil Babka wrote:  
> > > > If it was a boot option, I would personally be for leaving hashing enabled by
> > > > default, with opt-in boot option to disable it.    
> > > 
> > > A boot option would solve all my problems.  I wouldn't need to recompile 
> > > the kernel, and it would apply to all variations of printk.  
> > 
> > Should it be called "make-printk-insecure"

Nit: This makes me feel that printk() might break (block) the system.
     Please, make it more clear that it is about unveiling some secret
     information, something like:

	"non-secret-printk"
	"non-confidental-printk"
	"unretricted-printk"

I do not mind about the words order or using the
"make-printk-non-secret" form.

> And even if we make this a boot time option, perhaps we should still
> include that nasty dmesg notice, which will let people know that the kernel
> has unhashed values.

+1

Best Regards,
Petr
