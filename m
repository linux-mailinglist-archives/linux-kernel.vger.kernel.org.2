Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B3F34A65F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCZLTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCZLTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:19:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B66C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nbfdoB56OSJA++wkCwG7Y5R4eFfXpQtmTwFSIJHLz/c=; b=G8FismzwdvL19CPX/qdZjbZHtY
        E/9TiTrhEgksF9ea/z3GayckiadJIzULXnkoHdCgpCO+qh2eGH6+1ToX461+RF14w7xEjGs6FRqmF
        P/wTRoR+wqLYkjL4sEKUbcjPqXuFJsmsP4sjI5QgqpO2PV9dly8mpGKdOAUBhwHvOa7kDMKqsDVR5
        wjl873BjVs/Ti8DUf2QyjayHybZvq+/gtlN+RRGw261ZwusU2EH/z81zkMUcCBS8eSfzxjlsYFqNj
        caTxbZ3ZZ3lwYedsk47yyZvMEI/MaA0NzT5SA2GIDxvnVT4LFfzOJrXmFfk5VojNyOliReKIgnq4t
        LiTAQgmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPkUK-003QTl-15; Fri, 26 Mar 2021 11:18:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A95343003E1;
        Fri, 26 Mar 2021 12:18:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7020A2BCA7ED2; Fri, 26 Mar 2021 12:18:47 +0100 (CET)
Date:   Fri, 26 Mar 2021 12:18:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <greg@kroah.com>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <YF2/41K4xs3ZOQdV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF2/41K4xs3ZOQdV@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 12:05:07PM +0100, Greg KH wrote:
> On Fri, Mar 26, 2021 at 11:33:58AM +0100, Peter Zijlstra wrote:
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> No changelog text?  :(

Yeah, didn't really know what to say that the Subject didn't already do.

> > +/**
> > + * debugfs_create_str - create a debugfs file that is used to read and write a string value
> > + * @name: a pointer to a string containing the name of the file to create.
> > + * @mode: the permission that the file should have
> > + * @parent: a pointer to the parent dentry for this file.  This should be a
> > + *          directory dentry if set.  If this parameter is %NULL, then the
> > + *          file will be created in the root of the debugfs filesystem.
> > + * @value: a pointer to the variable that the file should read to and write
> > + *         from.
> > + *
> > + * This function creates a file in debugfs with the given name that
> > + * contains the value of the variable @value.  If the @mode variable is so
> > + * set, it can be read from, and written to.
> > + *
> > + * This function will return a pointer to a dentry if it succeeds.  This
> > + * pointer must be passed to the debugfs_remove() function when the file is
> > + * to be removed (no automatic cleanup happens if your module is unloaded,
> > + * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
> > + * returned.
> > + *
> > + * NOTE: when writing is enabled it will replace the string, string lifetime is
> > + * assumed to be RCU managed.
> > + *
> > + * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
> > + * be returned.
> > + */
> > +struct dentry *debugfs_create_str(const char *name, umode_t mode,
> > +				   struct dentry *parent, char **value)
> 
> Please have this return void, no need for me to have to clean up
> afterward later on :)

That would make it inconsistent with debugfs_create_{bool,blob}() from
which I copiously 'borrowed'.

Also, the return dentry might be useful with debugfs_create_symlink(),
but you're right in that most other create_file wrappers return void.
