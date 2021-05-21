Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7838C02A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhEUHCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbhEUHCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:02:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FD2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:01:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j14so18186319wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9SIh4qezErBShzcWnadZAbcLVeN36hf+/1c5wzsF+/0=;
        b=Rw9S2OFxbSx16SAKOP2AI0H5MtAhgQB7IlSzwrxHA0pEMy7dpUZvydLUafjViaQSaA
         RX1IdERu+sPotsbcYGV4pxxCGSssrm8E25DGlxfN1VbkZdkuq64tI7HwCywFRr5Kkcg1
         I1ZrzzYrBW470vIMYt5Y+T1cf9keOo/t0m7/S7vKHrlOj7taXjLL5xi0WBmUsOdohDmw
         R2uIWUhyFxYvLxVB1Ps4mbed5yKItmI4UmBxG6rg2s1VrAXqiidvCYNzNDyXktMNqq44
         yK59EPHsuA/GmNf1C6axK062vY09ncWzE0kBxn0SapOkaC0aiNu9CjdR9zpEFuKX2kZs
         GVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9SIh4qezErBShzcWnadZAbcLVeN36hf+/1c5wzsF+/0=;
        b=q6Gk53YVUxPLjvq6Z2C++DYNHgidlCJgT6ayl1XeStH3sWs2I0Gl07zYGeO7zL00uq
         yhzHwbhT6p5eINYo2WW/oqyPfse8hCpohWUjeiusiLt9wdO0i97m6VSQwJhpVJ5gng8W
         IpTOchEEBFvPrHy8WCwot8+i7yxmRtaSqasKdNLB+gaI6gISnE/k9XkCvOP6r7xwOFYr
         aud2o3ZQMBp6m5ZPv1uzbEOU3QQK0WbG/+QeOunUmrQXki87xc1fUaNOfG+9vZUBAK28
         uNDFqYvIAopiXU7+LwU+C2iD0nGZOIn098r895juyCWQPCYuOCGegoC7k1Kc6L5ysFvU
         0dVQ==
X-Gm-Message-State: AOAM531CO1aa7c+Fbfg3UMFindQ8PPqc9+cjQgaLSecdA9zJM9MoK77Y
        whqVA/l/E/4B1UwfRlbgTjMwGw==
X-Google-Smtp-Source: ABdhPJyOS8+jHk4co0JIgOdx73cazg37ZnCU71djedxm9H1qfZaJPVcK+b8IWxSBcOAGa3XxJKAT+g==
X-Received: by 2002:a5d:4946:: with SMTP id r6mr7871872wrs.123.1621580478801;
        Fri, 21 May 2021 00:01:18 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id o129sm11645507wmo.22.2021.05.21.00.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:01:18 -0700 (PDT)
Date:   Fri, 21 May 2021 08:01:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [PATCH 02/15] fs: gfs2: glock: Fix some deficient kernel-doc
 headers and demote non-conformant ones
Message-ID: <20210521070116.GQ2549456@dell>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
 <20210520120043.3462759-3-lee.jones@linaro.org>
 <CAHc6FU429=1Hzoghqo3=hqkSSmja3+ujna=mE_-Ro=KOMTPecg@mail.gmail.com>
 <20210521065822.GP2549456@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521065822.GP2549456@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021, Lee Jones wrote:

> On Fri, 21 May 2021, Andreas Gruenbacher wrote:
> 
> > On Thu, May 20, 2021 at 2:00 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > Fixes the following W=1 kernel build warning(s):
> > >
> > >  fs/gfs2/glock.c:365: warning: Function parameter or member 'gl' not described in 'do_error'
> > >  fs/gfs2/glock.c:365: warning: Function parameter or member 'ret' not described in 'do_error'
> > >  fs/gfs2/glock.c:461: warning: Function parameter or member 'new_state' not described in 'state_change'
> > >  fs/gfs2/glock.c:1277: warning: Function parameter or member 'delay' not described in 'handle_callback'
> > >  fs/gfs2/glock.c:1277: warning: Function parameter or member 'remote' not described in 'handle_callback'
> > >  fs/gfs2/glock.c:1578: warning: Function parameter or member 'p' not described in 'nq_m_sync'
> > >  fs/gfs2/glock.c:1993: warning: Excess function parameter 'wait' description in 'gfs2_gl_hash_clear'
> > 
> > What's that? Those warnings don't exist in mainline, and the two
> > warnings we have in mainline are fixed in for-next:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?h=for-next&id=75069590915f2
> 
> Thanks for the heads-up Andreas.
> 
> This is a rebased set that was authored last cycle.
> 
> It's great that someone has been through and fixed these already.
> 
> Tell me, is that just the case for this patch, or the whole set?

Oh, I see what's happened.

You squashed all of my patches across all of the different drivers
into a single commit for some reason.  Looks like Git didn't notice
and wilfully rebased the set, causing me to believe they hadn't been
accepted.

Dropped, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
