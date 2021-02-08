Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000EC313E1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhBHSxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhBHRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:05:19 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5ECC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:04:38 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id q85so2806830qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=RtR3VeVzm31FjqEjJQiFAhC+wWT1fI7k0gpQHJ8YycE=;
        b=bX3fg0ph51YqYx4FE+whSSUFiyCDzSCt7diI5kJOcXNErP4n4W24+BMVi8aGnSjcuZ
         HhXwS/TZzg3vInPDbfv1dQH14umVYfe6NAKPxZkPCsVkScs+aRgQFCLY8iD4gITsfOdv
         BUhe/Bhkux815ODN78x/PIb9xucZz1GFFkNjNMwKRx9yPQoRz5Jgfd5kgCdH9DCwak2+
         xFt8RIZI4sGbHhAjvvUq5XIP/u/OdiXh87NmebIwATsX81Z9I+LJC4/9fbM3PsGprz8n
         D8c9JwIEdft5KRiJ3+OY5VmUYOBCETmvPdzFwM32c/nBaVXK0Z+Qa9ZMeYAa4KSkyxtz
         dVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=RtR3VeVzm31FjqEjJQiFAhC+wWT1fI7k0gpQHJ8YycE=;
        b=BNbK3ZUPyehz9JLpg0XFl1tlpYSLCcJReEtUMUNHhPZvbLI4TTH/Ww9Yv4h0zkavim
         n32dVxA2SXQvk3b6CXK0J3XNreyfrNHKYUqiuZ2C6af0V7XkfkleN9kh2DB8xmzkTQ7X
         v16kKdFOsOb7oBFNcYtWhci6Mzo1cBT7LzGExQuho09XFvgNBGgeglKMw6kb8bsbMQq4
         vep9OPfpjMOqViXzjwH4wP6RdB7nqhVTXSoUS/nv+qjBxEubDpslbYcSwTV5CujEXaJk
         VIEKchvQRwMp9D78+ab0m3gr4iCsPlwnrvFvtpzbIcgZweBizO71QlG8JiJFqQYoLy6b
         9P+A==
X-Gm-Message-State: AOAM532GdV6dRvNF7YFqYJO8Slsra68lljZVz22ZHH3dMHT0CXDY8Uvc
        Q9xKEnG4/a7XInZsOaSXt2w=
X-Google-Smtp-Source: ABdhPJzGexxIUm2oRm3b9iuRSBn/yF3LOrQDqB8FYUt/g0gL1/cDcJeZ7STsEEGZlG/DzS42RCbRQg==
X-Received: by 2002:a37:dcf:: with SMTP id 198mr767060qkn.257.1612803878118;
        Mon, 08 Feb 2021 09:04:38 -0800 (PST)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com (186-249-147-196.dynamic.desktop.com.br. [186.249.147.196])
        by smtp.gmail.com with ESMTPSA id v19sm16838485qkj.48.2021.02.08.09.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:04:06 -0800 (PST)
Message-ID: <c0b145ea557087ebbabe1fcca3b2bf69bedbaff6.camel@gmail.com>
Subject: Re: [PATCH 1/1] kernel/smp: Split call_single_queue into 3 queues
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Date:   Mon, 08 Feb 2021 14:03:47 -0300
In-Reply-To: <20210128103348.rtbtffmvt7mwjohx@linutronix.de>
References: <20210128065506.618426-1-leobras.c@gmail.com>
         <20210128103348.rtbtffmvt7mwjohx@linutronix.de>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sebastian, 
Thanks for the feedback!

On Thu, 2021-01-28 at 11:33 +0100, Sebastian Andrzej Siewior wrote:
> On 2021-01-28 03:55:06 [-0300], Leonardo Bras wrote:
> > Currently, during flush_smp_call_function_queue():
> > - All items are transversed once, for inverting.
> > - The SYNC items are transversed twice.
> > - The ASYNC & IRQ_WORK items are transversed tree times.
> > - The TTWU items are transversed four times;.
> > 
> > Also, a lot of extra work is done to keep track and remove the items
> > already processed in each step.
> > 
> > By using three queues, it's possible to avoid all this work, and
> > all items in list are transversed only twice: once for inverting,
> > and once for processing..
> > 
> > In exchange, this requires 2 extra llist_del_all() in the beginning
> > of flush_smp_call_function_queue(), and some extra logic to decide
> > the correct queue to add the desired csd.
> > 
> > This is not supposed to cause any change in the order the items are
> > processed, but will change the order of printing (cpu offlining)
> > to the order the items will be proceessed.
> > 
> > (The above transversed count ignores the cpu-offlining case, in
> > which all items would be transversed again, in both cases.)
> 
> Numbers would be good.
> 

Sure, I will try to get some time to compare performance.


>  Having three queues increases the memory foot
> print from one pointer to three but we still remain in one cache line.
> One difference your patch makes is this hunk:
> 
> > +	if (smp_add_to_queue(cpu, node))
> >  		send_call_function_single_ipi(cpu);
> 
> Previously only the first addition resulted in sending an IPI. With this
> change you could send two IPIs, one for adding to two independent queues.

Yes, you are correct. 
I need to change this to looking into all queues, which should just add
a few compares, given all llist_heads are in the same cacheline.

> 
> A quick smoke test ended up
>           <idle>-0       [005] d..h1..   146.255996: flush_smp_call_function_queue: A1 S2 I0 T0 X3
> 
> with the patch at the bottom of the mail. This shows that in my
> smoke test at least, the number of items in the individual list is low.

Yes, but depending on workload this list may get longer.

My patch also needs some other changes, so I will send a v2 with those
+ the proposed changes.

> Sebastian

Best regards,
Leonardo Bras

