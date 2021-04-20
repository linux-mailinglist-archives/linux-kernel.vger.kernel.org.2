Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A9C365A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhDTNf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhDTNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:35:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B6C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vdBcp9f+Y+NjuSY4plP2jnk3fMAR2GgyVGNWh1RxQLs=; b=KckIqJHZiRqF1mfSqOHIlS+E6t
        U22gXybkRvT2ebT3gRDrbCsXZ9Nh1oqmgEghWOFGhkT151Su9LSywEm5Vgtpl2GLyPjS/MLCye0fu
        LfVyfL3/mbtvQt4t1t6aDcFpei7wvdx0aDAe1gUXEz62pRQRbGvBYHfUyHB2jyrkPRvEjFp40wnTx
        etzaO0R4OEgzUmBP+FfIV94YiSGEATc3u17mHQnPcmche84gIBfiuX9JQrwolpOWUVzrqv8eEtB9E
        4rgIp4QUuaslVmh8ooTFPYePwuy3hfOSuyg/WkVeBaBwAVZL5pYPCw7G0fABDNgCLvPWRx2wVZUiI
        TTn/Zudg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYqT1-00FDAj-Hy; Tue, 20 Apr 2021 13:31:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BC4C30018E;
        Tue, 20 Apr 2021 15:31:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 241342CD0A95B; Tue, 20 Apr 2021 15:31:03 +0200 (CEST)
Date:   Tue, 20 Apr 2021 15:31:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, axboe@kernel.dk,
        paulmck@kernel.org
Subject: Re: [PATCH] smp: add a best_effort version of
 smp_call_function_many()
Message-ID: <YH7XlxfvrdM1+oCe@hirez.programming.kicks-ass.net>
References: <20210419184455.2987243-1-lrizzo@google.com>
 <20210419191712.GB26214@worktop.programming.kicks-ass.net>
 <CAMOZA0JxwQFfA=acfr255xcR85ztv-URwaQQFHR6RrLk-cPbvg@mail.gmail.com>
 <YH6bV9W4lgIl4Fry@hirez.programming.kicks-ass.net>
 <CAMOZA0J4q2XSmhxB_uc-Q2mOA=K_FcvZqy3G+8ME=QMicOF=Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMOZA0J4q2XSmhxB_uc-Q2mOA=K_FcvZqy3G+8ME=QMicOF=Lg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 12:41:08PM +0200, Luigi Rizzo wrote:
> On Tue, Apr 20, 2021 at 11:14 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > We mostly try and avoid using this stuff wherever possible. Only when
> > no other choice is left do we send IPIs.
> >
> > NOHZ_FULL already relies on this and gets massively unhappy when a new
> > user comes and starts to spray IPIs.
> 
> I am curious, why is that -- is it because the new user is stealing
> the shared csd's in cfd_data (see below), or some other reason ?

The premise of NOHZ_FULL is that it will not be interrupted. There are
users who are working on a mode where any interruption will cause a
(fatal) signal.

> > So no; mostly we send an IPI because we _HAVE_ to, not because giggles.
> >
> > That said; there's still some places left where we can avoid sending
> > IPIs, but in all those cases correctness mandates we actually handle
> > things and not randomly not do anything.
> 
> My case too requires that the request is eventually handled, but with
> this non-blocking IPI the caller has a better option than blocking:
> it can either retry the multicast IPI at a later time if conditions allow,
> or it can post a dedicated CSD (with the advantage that being my
> requests idempotent, if the CSD is locked there is no need to retry
> because it means the handler has not started yet).
> 
> In fact, if we had the option to use dedicated CSDs for multicast IPI,
> we wouldn't even need to retry because we'd know that the posted CSD
> is for our call back and not someone else's.

What are you doing that CSD contention is such a problem?
