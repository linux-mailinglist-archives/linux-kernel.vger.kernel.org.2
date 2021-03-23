Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25105345CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhCWLSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCWLR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:17:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05ACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:17:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jy13so26409629ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PfV8LHwQUUtCkTHaGti9YI0tg87ktfBk/4EeAnA8jh8=;
        b=FnpaFGlJvfPbFXMxWKh02y+Bp1IUez2X2R4tcMdxC0WY3p0wa4wkILd4GjRYmWbUL2
         ghrO4T4Iab3fagomsILjrFQj4V1Ib91+lIpAxXHh3WtPmbQRm31Smj4Oywu1jJ49O9ik
         s/HS5paBH0S/DEfLOkWMPCjgygcIIr9E7cJCrZUwjpezGp0cXcLo2dXouucrETxm96bZ
         uIVJpeaWq/t4n3QvOXQ+umVBr2oiqlpYZDEXUcAZlNOEjxkqnAlg/0Zblrp5ANyjPZPr
         fOqX9QorHjsHuqvLKnNIwf2Bf6beSnV9B1R7gLO3x6mTZN99endUPVPW/bBvli7685YW
         a9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PfV8LHwQUUtCkTHaGti9YI0tg87ktfBk/4EeAnA8jh8=;
        b=jhMxJSyApZgFokcrTbxpuwgyDrM2ZImSLLCV6WfBw3NpEELDQYyLk51v3fOgHbhaHX
         9u4pJy6ZLi/lJiGKv9EwIG7XhnnuqI1x/atxD9Com0oRUfvfxFR7pTGFT+dbfRVR0+ag
         8KhLPNifkZG454s/R7quimUCaJBwRojkzfZ3udSb0OuP6NC12uiqP6YuMTQQZmwC1fA3
         g1M62ghoPqvdZWkGF8W4C+sZvxZEuOoHkTy8Yo5sFGwd3ZrPdRDUmYk8x6jBxR6y8mI2
         v0ONXiWr6sGYs83L/Il3e6yEgg3viqL9JkeGBzPh6AHTkYVgroKd4FyzrnPCZSsH+NpL
         eqFg==
X-Gm-Message-State: AOAM530C8PPYk2OSI19D04jP5NOntsFO4FqhbN1O1xl9T8XeakkskjYB
        mrLFcd7KcCwxaQgBw9iasgo=
X-Google-Smtp-Source: ABdhPJzV8/8pyx3lXLgB1E4UvStkp4Gt0YU+zHCXCwFfErtoSlkjiD2UJ8AqH08blAAWr84FUxFP9Q==
X-Received: by 2002:a17:907:216d:: with SMTP id rl13mr4329799ejb.362.1616498275698;
        Tue, 23 Mar 2021 04:17:55 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id gb4sm10773595ejc.122.2021.03.23.04.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 04:17:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 23 Mar 2021 12:17:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] rcu: Fix various typos in comments
Message-ID: <20210323111753.GB3939639@gmail.com>
References: <20210322230258.GA1983587@gmail.com>
 <YFlYzkY7h+OD0WCb@ArchLinux>
 <20210323053618.GU2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323053618.GU2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> > >  * there are no read-side primitives analogous to rcu_read_lock() and
> > >  * rcu_read_unlock() because this primitive is intended to determine
> > >  * that all tasks have passed through a safe state, not so much for
> > > - * data-strcuture synchronization.
> > > + * data-structure synchronization.
> > >  *
> > 
> > The "hyphen" in the middle of the word "data structure" is required or keeping by
> > convention or has some significance?
> 
> Yes, this is one of many peculiarities of English, and an optional one
> at that.  English is not a block-structured language, so grouping can
> be ambiguous.  Is is "(data structure) synchronization" or is it instead
> "data (structure synchronization)"?  The default is the latter, and
> the hyphen indicates the former.  In this case, the former is intended,
> hence the hyphen.

The other point is that there are a *lot* of hyphen variations in the 
kernel, and unless the primary author or maintainer is iterating the 
text would be insane to categorize them as 'typos' and create churn to 
'fix' them...

'data-structure' or 'datastructure' are both perfectly readable, just 
like 'fast-path' or 'fastpath', 'cache-miss' or 'cachemiss' and a 
million other examples.

Thanks,

	Ingo
