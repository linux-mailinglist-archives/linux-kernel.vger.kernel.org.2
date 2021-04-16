Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01CB36190E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhDPFCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhDPFCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:02:36 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF48C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:02:12 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o5so27755260qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=WOJ0UtWuaDZ08TA8ls/cWkvs2FHJ72zjJt8I3V9qQcI=;
        b=Epc0PQhLN9gDvkdLnkSygNmEsrwxjIXV3tWae4l/zunJj1kOvldk1Vl06w3+E3Cwx5
         0DtwDpZLKFygLHT3GVZhY5Q3YVOXlt1Cm59+WwGwfopWE79C8xEJ0Hm6lRROwiwfwQvC
         KRlpSi9NA6S+7rp1VzdqfCp9mjohsrtYUkzOnWyxV9ET6533eY9Kh3ThdfJRGH1jKc7D
         JXa8uAcbDkPdqP+RIm8wcsbjiCkaPrglle/jnc9H6Hd91WNGp6A2+i1PNqE1A7jUKck7
         YKx7Bd0d63zEEqUpJD2KJa6WmUUZlc7cWRagN9rAWAPQ773nrK4DiR6luA93KUfEr8vG
         JwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=WOJ0UtWuaDZ08TA8ls/cWkvs2FHJ72zjJt8I3V9qQcI=;
        b=gBFmODBc5OzetbKbBpQIrFDdezVu8ICWtGBPMQeZg1II8j005nW9UmZQaFtZ1xsC1z
         c3B9NdSp8ngss4sgr/eFHcFQdKuPNKJh3IrG3zDC0ut9WsJvsV9Akz+FFPQkxaTp94Te
         CRp3/0lxnWBrh25UMx52u2u+X8YCUzdV6oo1StHlALLsqMoCdf/c4sNLmPGt4vXqLAg4
         J+tCbS2juhLszTq6A0w7RyK/nCN3djA/MkbWPhiiUkyo4NeEjo5VDoIXa/W6c+KzEY47
         qfl56xoSRg+ugYJKv0PHIX77TVOlzBAJo84x/HtNbSYe0hPEckxJCSnTdx3IcMiaouJQ
         JW9g==
X-Gm-Message-State: AOAM533JEgWHSnW1dcuVlRSlAJo4aM5vhb20RYgyxSvhpTPS/dbXukMi
        PZYvF3jqAi+zBbDDHT3Hd+VfArO2EKzovuc=
X-Google-Smtp-Source: ABdhPJyJFi0HO/TYr+eb0XeJONbnzKxKoxS4kYJDwd4PxmzvcKjkKz6ccicRfk5I2HHzi1dcBB8wQw==
X-Received: by 2002:a05:620a:22a5:: with SMTP id p5mr6951907qkh.480.1618549331407;
        Thu, 15 Apr 2021 22:02:11 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id s4sm3131399qtx.50.2021.04.15.22.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 22:02:10 -0700 (PDT)
Date:   Fri, 16 Apr 2021 01:02:04 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [RFC PATCH] percpu_ref: Make percpu_ref_tryget*() ACQUIRE
 operations
Message-ID: <20210416050054.ws2nl6ds7kd6i4so@zaphod.evilpiepirate.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416044256.GE4212@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 09:42:56PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 13, 2021 at 10:47:03AM +0800, Huang Ying wrote:
> > One typical use case of percpu_ref_tryget() family functions is as
> > follows,
> > 
> >   if (percpu_ref_tryget(&p->ref)) {
> > 	  /* Operate on the other fields of *p */
> >   }
> > 
> > The refcount needs to be checked before operating on the other fields
> > of the data structure (*p), otherwise, the values gotten from the
> > other fields may be invalid or inconsistent.  To guarantee the correct
> > memory ordering, percpu_ref_tryget*() needs to be the ACQUIRE
> > operations.
> 
> I am not seeing the need for this.
> 
> If __ref_is_percpu() returns true, then the overall count must be non-zero
> and there will be an RCU grace period between now and the time that this
> count becomes zero.  For the calls to __ref_is_percpu() enclosed within
> rcu_read_lock() and rcu_read_unlock(), the grace period will provide
> the needed ordering.  (See the comment header for the synchronize_rcu()
> function.)
> 
> Otherwise, when __ref_is_percpu() returns false, its caller does a
> value-returning atomic read-modify-write operation, which provides
> full ordering.
> 
> Either way, the required acquire semantics (and more) are already
> provided, and in particular, this analysis covers the percpu_ref_tryget()
> you call out above.
> 
> Or am I missing something subtle here?

I think you're right, but some details about the race we're concerned about
would be helpful. Are we concerned about seeing values from after the ref has
hit 0? In that case I agree with Paul. Or is the concern about seeing values
from before a transition from 0 to nonzero? That wasn't a concern when I wrote
the code for the patterns of use I had in mind, but Tejun's done some stuff with
the code since.

Huang, can you elaborate?
