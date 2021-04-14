Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808FC35F17B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhDNK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbhDNK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:28:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0412AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:27:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w8so9959698pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YdDtxwykRriWWCupiB0//ekNGDTrs+ZxjP/xTLB7KZk=;
        b=jLidrOjv0ctn8uJX4dLnhYcUS5tWY1Jk/06/1aA/a0juHiVQ7uIneJDh0cKeCB/qUz
         3ygBiIHhdUmUxCrDQYzYTHCT4vnbl688CkjzJuuyMbQMs+14YY9MuvY/9+3yubO1tHY6
         zdAydx6Eb3X/fuZt63JGyTE80BoOaJx3SwcruLISRMqAWlDSgQAxO6nluPC8HV0XKnJZ
         YkeAFYEbBwu4+Rm2cYUdyJ6MsbQ8kjxdz1v7dtEOJWx2SlBkFzYaLaDdabt7sPR+ouFe
         mO7QsgFhjrLrmV4lV0dpyuSOSzyRps8fpHZjZ0yweg3FH0gPnLN8liDo5pot3otvXpX3
         Zz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YdDtxwykRriWWCupiB0//ekNGDTrs+ZxjP/xTLB7KZk=;
        b=LpISgmK47ngyxYUobJ8y8RYxxe8YefuN87KzScZnCCXyP/0xSoYeKgBsymQUi17Rd/
         tcv6lOEjHQRoB/dRfHwjmN3Q23W3s5IPLDYvccKo+jSNIjq+sG6gHxSBRT0Qkx3S/04w
         o/tovsCpzQYEzJw4Rwub1DY9k8e2iCdwA03wiTzf+KFP4zikQIqcXa0IIwMxBS/PKC8E
         9tW0J8SRaZNWnwa3VB7SrANuY7RC/V5eP+W4LokfYN5QhqwubAXPqfJqsdLo0Huqy88n
         QzP1oEbZ8LywslohgQ3O/9jGpinATADx+ULi2UfMAVeV0YZhCm4XjjW/BOZgkp45zopd
         l9+w==
X-Gm-Message-State: AOAM53179JwPq/AXPnQhCOUPY4caSE7yYTA5jQpv3Wn8V0JvLQKnz5IJ
        YcdVGVvj2uvSLVCAj3YKstcBIgMZG1XITg==
X-Google-Smtp-Source: ABdhPJxnBtm3wLL6EmGJPDTp26x+ueKb5gXI5A2qO1T/PSmlqmnJQpkJjZboGL5cvrliKjflTfNjFQ==
X-Received: by 2002:a63:8c4a:: with SMTP id q10mr25838756pgn.106.1618396060346;
        Wed, 14 Apr 2021 03:27:40 -0700 (PDT)
Received: from vostro (173-228-88-28.dsl.dynamic.fusionbroadband.com. [173.228.88.28])
        by smtp.gmail.com with ESMTPSA id z29sm1420521pga.52.2021.04.14.03.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 03:27:39 -0700 (PDT)
Sender: Nikitas Angelinas <nikitasangelinas@gmail.com>
Date:   Wed, 14 Apr 2021 03:26:21 -0700
From:   Nikitas Angelinas <nikitas.angelinas@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/mutex: initialize osq lock in
 __MUTEX_INITIALIZER()
Message-ID: <YHbDTX9XNQYZ0UZl@vostro>
References: <YGF+hDytO8r9Iv2o@vostro>
 <20210329145055.GC4203@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329145055.GC4203@willie-the-truck>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:50:56PM +0100, Will Deacon wrote:
> On Mon, Mar 29, 2021 at 12:15:16AM -0700, Nikitas Angelinas wrote:
> > Since __MUTEX_INITIALIZER() is used on memory that is initialized to 0
> > anyway this change should not have an effect, but it seems better to
> > initialize osq explicitly for completeness, as done in other macros and
> > functions that initialize mutex and rwsem.
> > 
> > Signed-off-by: Nikitas Angelinas <nikitas.angelinas@gmail.com>
> > ---
> >  include/linux/mutex.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> > index 515cff7..bff47f8 100644
> > --- a/include/linux/mutex.h
> > +++ b/include/linux/mutex.h
> > @@ -129,10 +129,18 @@ do {									\
> >  # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
> >  #endif
> >  
> > +#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
> > +# define __OSQ_MUTEX_INITIALIZER(lockname)			\
> > +		, .osq = OSQ_LOCK_UNLOCKED
> > +#else
> > +# define __OSQ_MUTEX_INITIALIZER(lockname)
> > +#endif
> > +
> >  #define __MUTEX_INITIALIZER(lockname) \
> >  		{ .owner = ATOMIC_LONG_INIT(0) \
> >  		, .wait_lock = __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
> >  		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
> > +		__OSQ_MUTEX_INITIALIZER(lockname) \
> 
> You don't need the lockname parameter for this macro.
> 
> Will

Hi,

Please excuse this late reply.

I included the unnecessary lockname parameter as the counterpart macro in
__RWSEM_INITIALIZER(), __RWSEM_OPT_INIT() and also __RWSEM_COUNT_INIT() do the
same thing, thinking that was done on purpose, e.g. so that all macros used take
a parameter in order to satisfy some dubious notion of symmetry; I realize this
is not a good reason, of course.

I'll send a v2, possibly in a series with changes to the aforementioned bits in
rwsem, fwiw.


Cheers,
Nikitas
