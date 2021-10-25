Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B288439D62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhJYRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhJYRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:22:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E8C061745;
        Mon, 25 Oct 2021 10:20:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k26so11381035pfi.5;
        Mon, 25 Oct 2021 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bdG6zTkPGu9c4FKs3tg7miki1n8YFj1c71kLZtHP0Yk=;
        b=HlPiDvf5Mmkmyy/HaH057fo86toFQwJNi1VAhkDPTbfw3Yurbl1vNS8KmrEtIi0jE+
         QH1MtjboqxaouRgvKDlfSN5yKTKDHwD7XipxKDKTRxBisZ9/c5VpOQQ+JJWuOB3eGBj4
         KyfOUSyLVZ4gmPNx3070+51Vg7vWwwnf2WNBXl50+3mhAP1xTxzF0imVRsGBupexejse
         5ddk5JCds5HvJFAWlHSK++n2B/YOSzDHH3l6yyrLA/fGXhiYqbFMagyXE5iSb+ss2BnF
         VY/Nh9eI7TcS/3Uee3bmLfaxZjDVv7a56tz2e6pNwQV3rLb9Cz1HSuPqMRHDxoTiV94c
         PdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bdG6zTkPGu9c4FKs3tg7miki1n8YFj1c71kLZtHP0Yk=;
        b=j8bhsiuKeSBDM1P9ukc9e/07U0uVj/RBUN1uQtOuCljQ9BYSkpir5dzI8uFsp7EtNF
         PAos/cAGhCgE19RR18JVTX7Ci7OLlHPPzd5IbOx0Bdlj/hH6dJckE0aErwzVAw937UcK
         fb5iEez/BDo0O+A/L2NifbtRm7TfPaN+BYCdD3fx4q03RFm4FqgQP4pEqg4wAt+KEVTy
         8JrJnRIueSQsWn9pSvgbZ3gxQ5r5YASsgheo/bDzp2lv8LFOU+NM6jPC1vqWmAfBD8Ki
         xaS6en5PjoGAfJ6T4zK4a2dXNS7cVatUsqzS/LAPf4dlP1BcXWVvrpChML1Jf9IApI+k
         FeLg==
X-Gm-Message-State: AOAM533W2ahu12iGt7l0kSdm9M1Nq+p1z4CpsOGYYlttUdScWZEJGyjQ
        90UV+HYxT+EtZVObNBAewngrYbRiAT6MeQ==
X-Google-Smtp-Source: ABdhPJwaBZgfZUvCNkZCvJc2kHpsZkVCvrwl6Zg6T8fHG/aLvHYURtVl6s5FiwOtMiRRD7tflFXS5Q==
X-Received: by 2002:a63:b448:: with SMTP id n8mr14831028pgu.31.1635182425732;
        Mon, 25 Oct 2021 10:20:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b8sm20813105pfv.56.2021.10.25.10.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:20:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Oct 2021 07:20:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] workqueue: doc: Call out the non-reentrance conditions
Message-ID: <YXbnV8wbrL5LEZZP@slm.duckdns.org>
References: <20211022004208.350992-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022004208.350992-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 08:42:08AM +0800, Boqun Feng wrote:
> The current doc of workqueue API suggests that work items are
> non-reentrant: any work item is guaranteed to be executed by at most one
> worker system-wide at any given time. However this is not true, the
> following case can cause a work item W executed by two workers at
> the same time:
> 
>         queue_work_on(0, WQ1, W);
>         // after a worker picks up W and clear the pending bit
>         queue_work_on(1, WQ2, W);
>         // workers on CPU0 and CPU1 will execute W in the same time.
> 
> , which means the non-reentrance of a work item is conditional, and
> Lai Jiangshan provided a nice summary[1] of the conditions, therefore
> use it to describe a work item instance and improve the doc.
> 
> [1]: https://lore.kernel.org/lkml/CAJhGHyDudet_xyNk=8xnuO2==o-u06s0E0GZVP4Q67nmQ84Ceg@mail.gmail.com/
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Applied to wq/for-5.16.

Thanks.

-- 
tejun
