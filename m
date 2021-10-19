Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C621433DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhJSRuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhJSRuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:50:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E2AC06161C;
        Tue, 19 Oct 2021 10:47:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ez7-20020a17090ae14700b001a132a1679bso498656pjb.0;
        Tue, 19 Oct 2021 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TUAEa4/k2XTg8hxpFffV2Im7arkCW9oaw1zsRiqU/HM=;
        b=YEWQd42hgaM/SNOn6WGoTdoEzWfQYEoJsZZJLSO8rxwobhWrDK+pdO4T4vo2y3EP+s
         K2VS/NlgBtIy3LP7fHlEidcOgg2p45dDIxkhywIJKufDhbJpa73eZru1q6v2MUnIxLRt
         PVPDISBLiEwZr2xmlH5GMrEvZ/OIkWTmi5BqGui3oB0uKee2UIhV3Iv8xfRlRpvLPWf9
         itl4InhelBr+nZIvp35cU/y95+tAAbF+VoXSmg/RM7q3xApeuHutKOl6AU09cEpxN+fw
         kbuLrPzs+eqK42K1A8TSs5rKJ5ndrlc8sMV6vppOrY63/EPYlHwfu5tFbA0h4JcTXQGt
         wZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TUAEa4/k2XTg8hxpFffV2Im7arkCW9oaw1zsRiqU/HM=;
        b=Gl7wBFuU+uzh7uTNpG6aSYdr3ydDdJTXVclEED+soqPnpMn7Gnv8x9ewAxhKMZUB8w
         Wx4FShE5I1Z4ODM41f51pEBwdG1Kh3MUKTlkPuPbZaRNDJ8aJh3/YIQGdAd6V6QO/OvS
         oKsTrNZia2wRh1OdwEEynrnKlSoHVLmziMP+FYSDKw0RpoPGQ03CMwoRjm4Hknu5OfIT
         Q1r6h4ITctns2alzQMn3wpXd/MAj0PG0le0wP52tW3CS/dC10f/Aj+MM/igkPFIxT3Gs
         Eu6sWFFpXhumRQzdJFSJqWRo6u2k5xwyzlCv9q/IHn9efc5iZ2crAM2Y0p6T1FxpGqru
         Pytg==
X-Gm-Message-State: AOAM532QxRjmrTFJ66zrad+JTFMKMphMd6f4cFgzzXSiqoKgK28RsVrk
        U7TNdGORrvj16wGA1KUQTkO7uYfi3XRISw==
X-Google-Smtp-Source: ABdhPJwPtTOPyeENj1PlTq0kDGdbySJItkafJ6TlG/XXgrakS0KbPoprirPyA+hdibabxCPhFttlMQ==
X-Received: by 2002:a17:902:e144:b0:13f:4b7:68c0 with SMTP id d4-20020a170902e14400b0013f04b768c0mr33965064pla.77.1634665677888;
        Tue, 19 Oct 2021 10:47:57 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id oa4sm3623784pjb.13.2021.10.19.10.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:47:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Oct 2021 07:47:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] workqueue: doc: Call out the non-reentrance conditions
Message-ID: <YW8EzNmq/bde5VTa@slm.duckdns.org>
References: <20211018013117.256284-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018013117.256284-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 09:31:17AM +0800, Boqun Feng wrote:
> +Workqueue guarantees that a work item cannot be re-entrant if the following
> +conditions hold after a work item gets queued:
> +
> +        1. The work function hasn't been changed.
> +        2. No one queues the work item to another workqueue.
> +        3. The work item hasn't been reinitiated.

Maybe phrasing it so that the above are the conditions defining a work item
to be the same instance would be clearer?

Thanks.

-- 
tejun
