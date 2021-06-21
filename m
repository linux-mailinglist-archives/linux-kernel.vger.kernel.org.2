Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1C3AE7DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFULHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFULHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:07:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 04:04:47 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id bj15so27597064qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvrUCOsjHnbRsvDmF+iBFiQ9cG1N/tBu4rO41BmsuJY=;
        b=EVDUqdE4krKQLAljHqyXPZQniLMQSkWbBzl7Z/Cs0l3Bn1PzJy6LFgNfDcMbk2D+b8
         OPkQIlKV+BmMRUmpg2y6h3SsLtxHE7gXQcRtnygho525ZpO2xoJyk+9xy6eYFAap6gnO
         YZB603T9cFPlRiqSBOQuGiwehGNbeXZn9gBGFsO8FV68HXX5MpovfK9JdKaO/i8njNI7
         tSb+TtGOpA8+A0BaB2xEVVt4m1UjK1iLH/hZN+W2fzeEWQGW4rrcO18YHEFIRuQL8Cvl
         yAjq9mwVWIaP0R+xhO5g82PpXX7Yxx+1CbVcd7jLmZaFnyTgjcGEZQbFSjiARuE0YLXM
         srgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvrUCOsjHnbRsvDmF+iBFiQ9cG1N/tBu4rO41BmsuJY=;
        b=WnjKB8YgE6ATCsoUijTKWMlH/5H7lQazOdk3U+BVOs3E0HHmQtDlfMhRNUK4JM4wbu
         llBPLP1ITWPyOgBeFXkQZDr2ZKmEXXICHkCRjeLkFTU5YhB65ql0wOUcCx4lvj3Uti4L
         qAkiawcqD1ozlJZecpHxx9wvVp30ewA2adAFIgxj4mWGC7GhVxeCx4YndIsFCoRR570O
         BuZ/Z2HksZMgSDcnKajZbKnt5C3qlfgSF5PxtmBhu4Jyg9EHtrLWM/gp727VedQJAsnC
         YBHKywvBCO4DfVCWlMm/QeJRKAo2PTv0bbOcmvR3hl0aOIFLoLmgVRoIVaDuDV5U5f2D
         KCmg==
X-Gm-Message-State: AOAM532UkA2QrTrBxGoYKytm79jm6deljBhS8DzdnoRQdQjzcNvBa/Xk
        Bf0RIgrwrCYjpYXwk2OfJ8hgb3EkJm+mwOAEpWv4FA==
X-Google-Smtp-Source: ABdhPJw+Kzdc2fnjMLQc6URmG51WkagIptLPEULYF0eySLsniubrLBVZGqwOMMepHPn92rar4m3PR/TuvxrbFZHYsPY=
X-Received: by 2002:a37:b3c5:: with SMTP id c188mr22800576qkf.242.1624273486637;
 Mon, 21 Jun 2021 04:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com>
 <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com>
 <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
 <CAFpoUr2o2PVPOx+AvatjjUvqPTyNKE3C6oXejyU3HVMmtCnzvQ@mail.gmail.com> <6D1F875D-58E9-4A55-B0C3-21D5F31EDB76@linux.vnet.ibm.com>
In-Reply-To: <6D1F875D-58E9-4A55-B0C3-21D5F31EDB76@linux.vnet.ibm.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Mon, 21 Jun 2021 13:04:07 +0200
Message-ID: <CAFpoUr0iWFTq2grtnX_EH6KnZLZQCg1o6_yv1gfDK8WdbHmUCA@mail.gmail.com>
Subject: Re: [powerpc][5.13.0-rc7] Kernel warning (kernel/sched/fair.c:401)
 while running LTP tests
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Odin Ugedal <odin@uged.al>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

man. 21. jun. 2021 kl. 12:57 skrev Sachin Sant <sachinp@linux.vnet.ibm.com>:
>
> Unfortunately this does not help. I can still recreate the failure.
>
> Have attached the o/p from test run.
>
> Thanks
> -Sachin

Yes, thanks!

I am able to reproduce it locally now, so will keep looking to see if
I find the cause. Thanks!

Odin
