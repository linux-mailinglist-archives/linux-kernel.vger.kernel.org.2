Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF903331FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 00:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhCIXmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 18:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhCIXmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 18:42:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC925C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 15:42:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so6426299pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 15:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0wvDPTdhCRY4Owyf+IK6ksYfroTUCgYzibiZjp0ODqY=;
        b=r7jK6uQGSxTFfVJLaJqJiXaP6p+mNOlP9yG/+PDhRucxgePEuLoOvAxEfa1fYCGIDB
         d3VX9WbfSaS3wtY3PnODKlgekVbUM2a8zVR6patUtz43Bu3dMA99u8n5CT2KCTiNL+0B
         +Wd/4ebvJv5/chhT7ArCsgq1gD/GEbIf8VX/EO47D5DAgcLEKYuvX9mtm9KdJESK0FUK
         hFGhwTG84Fsoo0QEK9P5SA3nvVWK0VSX0opharoHrFO9TLYoF8Spxz0b1JE3wHMz2pka
         o/rPJurVUIMZ6vISquW8yRmxrG5MCxg/BeDxejn67Oo+ebfn7me3p9TLxFHDAdA45tYh
         jELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wvDPTdhCRY4Owyf+IK6ksYfroTUCgYzibiZjp0ODqY=;
        b=cIb+lSSSdk1IJqkyhsMLEBF49cjycjdWmFOrYXfdejo2dKz+cdCKa7awxHwsRwcXyQ
         RPsamvTa7HDQRcjOQbjaj/2wkLgaVQ6RV/3M/8zj6A9OFl9InZJ2Kg5KgBBzMrCfGSsj
         YSXc9DHy1kphNCya4y0C5mZfc+5BqwnCr/5+3jGZVnv9tQh15AAV5RAXSZzUYnJ01o2s
         XceS2pLJNQNKkUdArcANDs1Oattl3OhyEt4MCYAklStQ8/iy0dnISTHzsMQ43wF1bnTH
         2w5o3qba+0WO/bjQgMyQWuGloskSDl04fnxhgApRw0q6OPbpXQO9Lvhqmf4kpONnEwbO
         2sNQ==
X-Gm-Message-State: AOAM533PBvFA9Mu4W97c3EUhVOFd/4ZwGY6ToyQ41Ox0phV9RTRo7+Jk
        U4H6JkhDhcZ7FSt5AlalXtDJcvcHKa5fEQ==
X-Google-Smtp-Source: ABdhPJwXvMwK7qJH+rWBZr7Qk9TAHNVGCYBEQR+Mt9d8D0+yNsfzy7aeckKFYMnJ0j7XzEQQsXWOiQ==
X-Received: by 2002:a17:902:b7c5:b029:e6:1a9f:5f55 with SMTP id v5-20020a170902b7c5b02900e61a9f5f55mr176648plz.57.1615333342173;
        Tue, 09 Mar 2021 15:42:22 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e4dd:6c31:9463:f8da])
        by smtp.gmail.com with ESMTPSA id 68sm14247434pfd.75.2021.03.09.15.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 15:42:21 -0800 (PST)
Date:   Tue, 9 Mar 2021 15:42:15 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org,
        Haiwei Li <lihaiwei@tencent.com>
Subject: Re: [PATCH] kvm: lapic: add module parameters for
 LAPIC_TIMER_ADVANCE_ADJUST_MAX/MIN
Message-ID: <YEgH11nNwdCkF5kT@google.com>
References: <20210303020946.26083-1-lihaiwei.kernel@gmail.com>
 <03239d81-df56-a6c9-c79d-c14d22f62705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03239d81-df56-a6c9-c79d-c14d22f62705@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021, Haiwei Li wrote:
> On 21/3/3 10:09, lihaiwei.kernel@gmail.com wrote:
> > From: Haiwei Li <lihaiwei@tencent.com>
> > 
> > In my test environment, advance_expire_delta is frequently greater than
> > the fixed LAPIC_TIMER_ADVANCE_ADJUST_MAX. And this will hinder the
> > adjustment.
> 
> Supplementary details:
> 
> I have tried to backport timer related features to our production
> kernel.
> 
> After completed, i found that advance_expire_delta is frequently greater
> than the fixed value. It's necessary to trun the fixed to dynamically
> values.

Does this reproduce on an upstream kernel?  If so...

  1. How much over the 10k cycle limit is the delta?
  2. Any idea what causes the large delta?  E.g. is there something that can
     and/or should be fixed elsewhere?
  3. Is it platform/CPU specific?

Ideally, KVM would play nice with "all" environments by default without forcing
the admin to hand-tune things.
