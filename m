Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE97134A965
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCZOP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCZOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:15:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03058C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dZadgslgPfxujL7/Uuk7e9L2wDYLIWlmZi+9ViCtboE=; b=oXicC6TJtHdcMVouzeu1ywLMVw
        D3xwJJiNpLWef4OGQ/jOFbhAmgSVBVj882VuYtseO/6ngdzoS1oPeNRj6RnNL2Qi0h1asLDG7SXVZ
        +IF1gSc2kv+j+nhT8s3EQzsMBlRi8Br9HXEFj04vRpDzJJX8HPU71PN7NankzVnI5+DDavtOJl1I/
        uAQi0DYkhrdAOE3CCRy8i4FDwJkQ+OTfTE1PImRso0eu8vObJ1eqXPJA6vs3eDlNpfy5JwHsqAwvl
        KuoameLl/YswRRBcKBxjvweBN0kP0V95td8/nybvXbycToD6Y/6+5RhjP1sOanl8vkYb+e/BrDBhY
        gla6m4JA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPnCV-00Evuq-Pl; Fri, 26 Mar 2021 14:13:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1F5F98103F; Fri, 26 Mar 2021 15:12:35 +0100 (CET)
Date:   Fri, 26 Mar 2021 15:12:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg KH <greg@kroah.com>, mingo@kernel.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <20210326141235.GI4746@worktop.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
 <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
 <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
 <YF3aSJ7OYiCpWsl8@kroah.com>
 <1da9e61c-6973-2e0e-d898-7bf92ac5b1c4@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da9e61c-6973-2e0e-d898-7bf92ac5b1c4@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 02:10:41PM +0100, Rasmus Villemoes wrote:
> On 26/03/2021 13.57, Greg KH wrote:
> > On Fri, Mar 26, 2021 at 01:53:59PM +0100, Rasmus Villemoes wrote:
> >> On 26/03/2021 12.38, Peter Zijlstra wrote:
> >>
> >>> Implement debugfs_create_str() to easily display names and such in
> >>> debugfs.
> >>
> >> Patches 7-9 don't seem to add any users of this. What's it for precisely?
> > 
> > It's used in patch 7, look close :)
> 
> Ah, macrology. But the write capability doesn't seem used, and I (still)
> fail to see how that could be useful.

Correct, it isn't used. But I didn't think it would be acceptible to
not implement the write side. OTOH, if Greg would be okay with it, I can
change it to:

ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
                               size_t count, loff_t *ppos)
{
        /* This is really only for read-only strings */
        return -EINVAL;
}
EXPORT_SYMBOL_GPL(debugfs_write_file_str);

That's certianly simpler.
