Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7332FABB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 13:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCFMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 07:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhCFMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 07:54:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D89C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 04:54:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id r17so9347677ejy.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 04:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9hAH6iGMFoWEnEvBb1A3YoeISkLHQTxSseyp5CoaNWU=;
        b=Aa1tQyPojaD7gjcJOlbvlXqnvOOmIAVaALkBNi10VgNxNNuyF6Nsb3k45m6AQDV+sG
         RLMU8m3yJEpfvIKeGaX9/X1GZU8rBuLAb/Vns60XTjArrzsL1Xxm3KhvID9aNXeczloi
         FG0aEl/Pp4EJTFoSwNkcEjGuVMcMIdizYdhzO1x3p7lyhh5JAVHbk3piqOWwy090yB3w
         ilajvNcAPaJLkcPQan4YB1fG7C9owvC17yVhirrGa+MtjK4qvaAotNezmirzqYUp2+n4
         OmcFy2zAijzi26Nr9dyvqPSl8baklkWvCwg1eSIGM2xljtPg3CKVjyertahh8udz+rlW
         hYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9hAH6iGMFoWEnEvBb1A3YoeISkLHQTxSseyp5CoaNWU=;
        b=R5lEnJMCDkPdU7ehRr5kpL/Dbkg7IGDNpbY4w2AaBMAsM2yJn+oSvOKbbOqLGTdT3A
         yvydreRunKFW4lNwKvRS8n3b2HfK1iqdXrbyCvBWQ3cPg2n2dTWaYBBSot52mFja03Y/
         y9brMmvL8u6046RUopJ1qpkfa0SHTfO9V5uw1dTYOPF/tSZFRcFnrEbU9fdOYcuy+tyj
         hkK5UXLyAUCKbtZaFuW+vpiSgDsb17qMde8CnHXcro1L/HkCIY80AeyuapCQu0rHBKx9
         g5lhKLR6UU7EUfZOWkPQWfIHkwSumWi/D7w/2EP9H0mlq4dLsMX8C3gv+uPeeUkaj0JK
         BcHg==
X-Gm-Message-State: AOAM5313iaMS4cmkJ7CJVrX0plW5rF5AK24d5Lv8G/5P0xiAMu0kTWvE
        WjR6bSGmLo1kzb3NsAPehzU=
X-Google-Smtp-Source: ABdhPJz9JA0/7kxIj2/phM7OMcGNcV4ufBlAiEaE5CO7EiomB1CMAIKLEMXEfYIAJNw08CezmFlG0Q==
X-Received: by 2002:a17:906:1d55:: with SMTP id o21mr6774545ejh.485.1615035280481;
        Sat, 06 Mar 2021 04:54:40 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id cw14sm3624796edb.8.2021.03.06.04.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 04:54:39 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Mar 2021 13:54:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: A note on the 5.12-rc1 tag
Message-ID: <20210306125437.GA436274@gmail.com>
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
 <20210304124314.GA9979@duo.ucw.cz>
 <CAHk-=wgZjJ89jeH72TC3i6N+z9WEY=3ysp8zR9naRUcSqcAvTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZjJ89jeH72TC3i6N+z9WEY=3ysp8zR9naRUcSqcAvTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> But I also can heartily just recommend that people who already _did_
> start on rc1 to rebase their current - hopefully not extensive - work.

Thanks for the heads-up - we just rebased about 50 commits in -tip to 
avoid this bug: our normal workflow is to jump on -rc1 once it's 
released and integrate pending development work that we normally don't 
apply during the merge window. So our special pattern of pent-up 
merging did bite us a little bit - but nothing particularly serious.

> I know I've ranted about rebasing for years, and it has huge 
> downsides, but the operation does exist because sometimes you just 
> need to fix serious errors. So _mindful_ rebasing, understanding why 
> it shouldn't be a normal thing, but doing it when something 
> exceptional happens - that's not wrong.

Yeah, and in this case not sending scarce-resource testers & bisecters 
into the middle of a file corruption bug is definitely the right thing 
to do.

Maybe -next could double check that none of the maintainer trees have 
an -rc1 base? Your note here was kind of low-key. :-)

And maybe there's some bisection helper annotation or hook-script that 
can be embedded in the kernel Git tree to avoid or at least warn about 
particularly nasty bugs?

Thanks,

	Ingo
