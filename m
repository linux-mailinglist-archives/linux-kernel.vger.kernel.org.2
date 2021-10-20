Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66A9435000
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJTQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhJTQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:20:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F304C06161C;
        Wed, 20 Oct 2021 09:18:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q5so22965631pgr.7;
        Wed, 20 Oct 2021 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wRjN+fFhf5ZDRdsJW+ExfiLsDHvU4PP0qY8Z9DJXa+Y=;
        b=ZlK8y7JXK8JJTN6O/RcMNvlIrPlXv+chFPhqJAay1KrY3xiOISTUyXjAhxOAnlvSRz
         9+9jvS5BazdrB9s84Uq+GFrPbQSp2dgIJJ/vs4oKVWvMKnm5E9ByN9tMUNuqB/Qnm4x3
         97hf+hO0tQcLzsTT+i4gj2C446ZvE8QnChtGN39L/L83WcufKn7475cFUVFnpsqudsaX
         VlYq6dSEBCijyk/t2QOhyQED4EgxtyVes8eygyRJsEBbyzSx0K9cvSAqmSq/0ZZ/1WyO
         FMeaN7MK/6TBC3Oa5mt3DRPnrem6jWrD77yEXZ6wXBozy/9bZP1MVgxH0fbz+uxmkBq1
         TG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wRjN+fFhf5ZDRdsJW+ExfiLsDHvU4PP0qY8Z9DJXa+Y=;
        b=tq06y3vubjrg4vak6ZbGHU7GaL4WY1l8Q/XLw3/8HlEZoZa8CHYGlLmmnryDxjn0Xm
         KDEZnVfVFOAGAXpLaYDzhI+bIh9poSmbkXbpj7tRaUwsBLFJfnvD6B0dHJuDpIMxDFz0
         wXxI880bFCoxiSM+EoKkqPGXnez5308JOjOkBO6316rjK9KtymQvooT03jjJA0l5ywPH
         NbXD9hu3hAPU/KnvcE/SLgBhZ4hYL9DQLUBgCuN8mUQcmR697ZO70jrNCg5pQ2+3zzjd
         XhkmvYkJopyZ+lsjO7UeIrHC8BXOnMB7ZrT+Q3v3NBL1J0Bj7es6jJrhGwhcQX2wMQik
         IjfQ==
X-Gm-Message-State: AOAM5304u8nHwWDKMnbAhyGdPeShb5iNFXAZbRkjnFuFfd0+zgveMD23
        zI33qmu7XC1D9xj1yemcbQU=
X-Google-Smtp-Source: ABdhPJzYGYiaYqG6HBbNjSdlim7mfX7k/kJhbqPQ6/ns6u+6hM7MXCpC344AnJiLegWqFFKpxpm14A==
X-Received: by 2002:a63:7b52:: with SMTP id k18mr138686pgn.345.1634746700451;
        Wed, 20 Oct 2021 09:18:20 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j9sm2730874pgn.24.2021.10.20.09.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:18:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Oct 2021 06:18:18 -1000
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
Subject: Re: [PATCH] workqueue: doc: Call out the non-reentrance conditions
Message-ID: <YXBBSrlOmAU8+J5w@slm.duckdns.org>
References: <20211018013117.256284-1-boqun.feng@gmail.com>
 <YW8EzNmq/bde5VTa@slm.duckdns.org>
 <YW+rxfMof4QcGSrq@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW+rxfMof4QcGSrq@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 01:40:21PM +0800, Boqun Feng wrote:
> * A work item instance will not be processed by multiple workers at the
>   same time, i.e. it's non-reentrant, so requeuing the same instance of
>   a work item is safe and not racy.  Operations considered as changing
>   the work item to a different instance are: 1) change the work
>   function, 2) queue the work item to a different workqueue, or 3)
>   reinitiate the work item.  The non-reentrance guarantee doesn't hold
>   for different work item instances.

Yeah, I prefer it to be described this way but it's not a strong opinion.
Looks good to me either way.

Thanks.

-- 
tejun
