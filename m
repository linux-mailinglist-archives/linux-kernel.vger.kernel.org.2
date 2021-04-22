Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380B1368497
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbhDVQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbhDVQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:14:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E59C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BzVvT0QmKCVhDm3bYV2s7DScZpHC1hhwTyETz4Vqarg=; b=p0qYT3nN65UN9+wW5YKzyD7zmc
        SPjAHKmA4q31mNeb+L85qA7ko+gaOPyOuIPKyYewHzCv2PhD+YoZmCFrNG/eTv5flYwff7VBSiy2n
        t8vC2AdAM1lufZea85sBxDiRkBhMvqRPbFUvWgt33kCrTbw1942t122v2nzvl6x8PsQ46VDSK3q5a
        dLylkfoHHE5Sc0eJiZrTq8Eyq8mZubNFI/X/ef7Rfpqx1BGyZW2+IqILPeNu8er5jVDs3jWLXVXIs
        1OSZ7j0yZrMA/SF4/KBI/BBvev71oW4l15HBUmcHgp51lmG2FY4r/mfZ6ApYxdLGrNPW+GunA9Xzs
        i0GTnXFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZbxN-00H22s-Kc; Thu, 22 Apr 2021 16:13:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2525B300103;
        Thu, 22 Apr 2021 18:13:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F8122CBE5ED9; Thu, 22 Apr 2021 18:13:32 +0200 (CEST)
Date:   Thu, 22 Apr 2021 18:13:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_call: Fix unused variable warning
Message-ID: <YIGgrMeudHobfDYQ@hirez.programming.kicks-ass.net>
References: <20210422003334.139452-1-linux@roeck-us.net>
 <20210421204139.669f5c22@oasis.local.home>
 <YIEjrb7uO1KLgf3y@hirez.programming.kicks-ass.net>
 <552a3a35-43c6-348e-ad46-1abb298cbfbc@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552a3a35-43c6-348e-ad46-1abb298cbfbc@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:01:47AM -0700, Guenter Roeck wrote:
> On 4/22/21 12:20 AM, Peter Zijlstra wrote:
> > On Wed, Apr 21, 2021 at 08:41:39PM -0400, Steven Rostedt wrote:
> >>
> >> Second patch with the exact same update. Perhaps we should take one
> >> before we get more of them ;-)
> >>
> > 
> > I thought we already fixed that...
> 
> Not in v5.12-rc8-6-g4bdafe832681, which is ToT right now.
> 
> Ah, I do see it in -next, but that doesn't help me in mainline,
> nor in stable branches where the patch introducing the problem
> has been backported to.

Given it's a silly warning I didn't figure it was urgent material. I
suppose we can backport it if someone (you apperntly) cares.
