Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98713B91BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 14:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhGAMp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 08:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbhGAMpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 08:45:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48452C0617AD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 05:43:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so6809975wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mo6oA/XnbDUGfk8NTnLtsX2Oxt2DjcL5ZEyjcIbXJxE=;
        b=ZoT209PloXnbOEhL1QU7auZZ8wiKaoDhkCY5o/ymMMMc54wtJgZRSBBst/6uWhboWC
         HJUkHBzw6bANDxSgtGj3yL1oQE4Q6Lxw9ITAw68rg6FgsGIcy5ANlDp5PbqojKIES3/e
         ZlmYBBAluT51L1CqtjRWPvBnwPN/vR35iWVlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mo6oA/XnbDUGfk8NTnLtsX2Oxt2DjcL5ZEyjcIbXJxE=;
        b=e4Ml8ud/DGg9fPC+5VhzmuFnNuirKEN/vBKNBgcmKtik207U711aUxmZvgQrIFqdBn
         wi1ZOj+PHrzz7/sqYh/S3a+hLlGwDnxOztHtUbMT7Q/6vlI6OaTSMlqKvlIKWmNYCLA/
         1Y+LgfOTEDgxf9pQ/IldL99BpDWMVE3t/Jcx1sA/Fj8SwX9tAj871oRL9Af+1G+71Nsd
         lituwonvExvQa3QdUG+Cu8okMSJDl+2mbIkMkVaLf+7XukjpXnHy1mgQbfr9mmNcRfDn
         89OjmBdeZWaW1L2ckAKw76WP8X1vd7JJrLqOHlHy9NqUfYC7fbpLn+hChb5VoZQcNwE9
         QhWg==
X-Gm-Message-State: AOAM530HFmh2tQ/NLapdfq2e63tgiXjQGdQ1A5uQYFP1EdN//0CzwQAt
        OtGV61VoUA/A+HekULqQcrXI4KwvNy1Fdg==
X-Google-Smtp-Source: ABdhPJzTAwPPPR6L6P6uS3+LRZi3ZK1wPBHWPVvFvkqIsj03BGz5+yt7Zwi0kIGdB+vlNRETEs5OjQ==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr42940651wmb.167.1625143402298;
        Thu, 01 Jul 2021 05:43:22 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a683:959f:4ccb:54d6? ([2001:8b0:aba:5f3c:a683:959f:4ccb:54d6])
        by smtp.gmail.com with ESMTPSA id f6sm8278917wrs.13.2021.07.01.05.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:43:21 -0700 (PDT)
Message-ID: <8f20f2edd60fbff426b086599ae943ff09195b9c.camel@linuxfoundation.org>
Subject: Re: [PATCH] cgroup1: fix leaked context root causing sporadic NULL
 deref in LTP
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, stable@vger.kernel.org
Date:   Thu, 01 Jul 2021 13:43:19 +0100
In-Reply-To: <20210701121133.GA4641@sirena.org.uk>
References: <20210616125157.438837-1-paul.gortmaker@windriver.com>
         <YMoXdljfOFjoVO93@slm.duckdns.org> <20210630161036.GA43693@sirena.org.uk>
         <696dc58209707ce364616430673998d0124a9a31.camel@linuxfoundation.org>
         <20210701121133.GA4641@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-01 at 13:11 +0100, Mark Brown wrote:
> On Wed, Jun 30, 2021 at 11:31:06PM +0100, Richard Purdie wrote:
> 
> > Out of interest are you also seeing the proc01 test hang on a non-blocking
> > read of /proc/kmsg periodically?
> 
> > https://bugzilla.yoctoproject.org/show_bug.cgi?id=14460
> 
> > I've not figured out a way to reproduce it at will yet and it seems strace
> 
> I've been talking to Ross, he mentioned it but no, rings no bells.
> 
> > was enough to unblock it. It seems arm specific.
> 
> If it's 32 bit I'm not really doing anything that looks at it.

Its aarch64 in qemu running on aarch64 hardware with KVM.

If you do happen to see anything let us know!

Cheers,

Richard


