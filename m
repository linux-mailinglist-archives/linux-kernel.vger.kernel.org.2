Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A707365C42
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhDTPdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232174AbhDTPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618932747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VzIaFG2wDVdYEizwLnnsRmeoa1MCm+iU4UbjuWNpwW0=;
        b=anQNL0wjSuL+tM5fUdujq03WYaqY6ZeMd0MNBcTP2U6f2d3oO5DF3aTtX/rHPNZ2pMFXfx
        kY4MnYw7F8BZHyFfJLVL1l7b0UNIZeDExyfh8mgp2y9PmuNwJEw4hRk6eEtLIpCa5zqqjU
        deAmLd2xi06YJfFlIm7uOhg+4S8HQqY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-K-n1QNEMOWOJuYcDkODSqw-1; Tue, 20 Apr 2021 11:32:26 -0400
X-MC-Unique: K-n1QNEMOWOJuYcDkODSqw-1
Received: by mail-qv1-f69.google.com with SMTP id m19-20020a0cdb930000b029019a25080c40so11619384qvk.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VzIaFG2wDVdYEizwLnnsRmeoa1MCm+iU4UbjuWNpwW0=;
        b=M358IgbDSSf31T9R23AQphNkPIM+sTV5wKPeeMHLoka43tZPgaYzU8tqngUXhLikFr
         Ho2H/6Mdx4BrsL+EDWSqSgdmD/baxfJSjL2d+SnGm1P9tYW+4+rSg+Ooc4aDVSg7fJjB
         PQRy6+iFrMW+RV6ntG3V9Ar7F5GOgpU7lGTfDBrvNjowT/StAC8A62Qlx9pk52AWF1Rh
         w1DoVDIIJVExawDIhPRZ+AOtKO2Qtand+q4SanRPUP5vonCqOrxfMeKSuYDS6lzRBVrv
         CaLsJ3Cl9DMugT2OLNtRPHZhzMtK77JPRpj/7jzqlgtFxDX0sOSqqTFFb42w8YP0hNLy
         UYjA==
X-Gm-Message-State: AOAM531T96OdG1P1FO54Z/jTdjCuUjbQwdHl0s/qHWCzwI4VBgsTNtSe
        iFHrmjJjp9Ni/i7FR5sb9ZhDy2M/f4OAJw6xmIY6GGzNtXFgpA7F0wrPgXKQ5jLGHKfFqA6JNMi
        HWH5AukCcARoU39y6lvtobkWx
X-Received: by 2002:a37:e108:: with SMTP id c8mr18492838qkm.499.1618932745574;
        Tue, 20 Apr 2021 08:32:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTKbZtJzki1RdMo4jaIwSDT4vU8zynoJCipKGsXfaSJHphwrc9cgg+bXzWrjtb96DzF1vjiQ==
X-Received: by 2002:a37:e108:: with SMTP id c8mr18492812qkm.499.1618932745353;
        Tue, 20 Apr 2021 08:32:25 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id f8sm4135429qkh.83.2021.04.20.08.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 08:32:24 -0700 (PDT)
Date:   Tue, 20 Apr 2021 11:32:23 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Always run vCPU thread with blocked
 SIG_IPI
Message-ID: <20210420153223.GB4440@xz-x1>
References: <20210420081614.684787-1-pbonzini@redhat.com>
 <20210420143739.GA4440@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210420143739.GA4440@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 10:37:39AM -0400, Peter Xu wrote:
> On Tue, Apr 20, 2021 at 04:16:14AM -0400, Paolo Bonzini wrote:
> > The main thread could start to send SIG_IPI at any time, even before signal
> > blocked on vcpu thread.  Therefore, start the vcpu thread with the signal
> > blocked.
> > 
> > Without this patch, on very busy cores the dirty_log_test could fail directly
> > on receiving a SIGUSR1 without a handler (when vcpu runs far slower than main).
> > 
> > Reported-by: Peter Xu <peterx@redhat.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Yes, indeed better! :)
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

I just remembered one thing: this will avoid program quits, but still we'll get
the signal missing.  From that pov I slightly prefer the old patch.  However
not a big deal so far as only dirty ring uses SIG_IPI, so there's always ring
full which will just delay the kick. It's just we need to remember this when we
extend IPI to non-dirty-ring tests as the kick is prone to be lost then.

Thanks,

-- 
Peter Xu

