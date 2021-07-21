Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A746B3D0CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbhGUKF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbhGUJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:59:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF9C061762
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:38:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y17so1436625pgf.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EIbOGymDYcRaNQxjueCe6a1zJ8aY0naaP0fQUkEZuv8=;
        b=Ov5r12ynseBnyTNRKsKx9w8I9twMbxcSJ1f73zH2iop1yQASsh3BfriyZofnrwgGPb
         JWsBYE6ZU5a3lBHKbfhG01blBS2BP/AHgilqkL+QG/cbbprBm/Aw4GR7gpJVVtkbNURP
         IGrlGE+9rwKA79Of6P2jRijrEqbvnRi+5RyzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EIbOGymDYcRaNQxjueCe6a1zJ8aY0naaP0fQUkEZuv8=;
        b=hu0A9Dw6ODdTdQgDOJyfBNxERKXCSlCU9C03C+7Zi8x0RTu3t/MQ49t2m6rn/lrvS0
         924cDeEFXEWm9S5GTGuhMTup04OuTnpO9mNcWr+3FIGENt9XPlHiCxErjRU6I6AhZmnD
         IPv0NMRh7+XJGkn1bNIjafDJ5u40QQlFXT2N0hsOCXvqcWIcMtZGmQrWYdNDXeUU7fPa
         2fkF0pWgZ2bH3JAj3EzhiO7ewOQxrymo42lsoMiffk+itia1kmePNuSjHDX89YErNHr4
         VACNYFTspwstHx6ikY3zyyB5GbpVYmco4HT5pelklqD7VPNxUUhFjAoisuxP6VayrGq+
         YukA==
X-Gm-Message-State: AOAM531fB2QBaUuV5k1FnCrsTJm02jBXtdXOAthnsrJccHK34JYSouqa
        CBr7p/bLv+atNquRicD+MF13Pg==
X-Google-Smtp-Source: ABdhPJwG3zXjqu/tpj5VxqRx6FmJchnrD4hFB2OoBNGmAOcVyTAxWZv9VdpXTlSzk5yhFw1PCfmBEw==
X-Received: by 2002:aa7:81c5:0:b029:2f7:d4e3:78e9 with SMTP id c5-20020aa781c50000b02902f7d4e378e9mr36527927pfn.31.1626863925613;
        Wed, 21 Jul 2021 03:38:45 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:f1b2:269f:996b:b71a])
        by smtp.gmail.com with ESMTPSA id z16sm5586915pgu.21.2021.07.21.03.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:38:45 -0700 (PDT)
Date:   Wed, 21 Jul 2021 19:38:40 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Will Deacon <will@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCHv2 4/4] arm64: add host pv-vcpu-state support
Message-ID: <YPf5MFV99zPdTu/U@google.com>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
 <20210709043713.887098-5-senozhatsky@chromium.org>
 <874kcz33g5.wl-maz@kernel.org>
 <CAJWu+oqCyj3H0=1KNo3c+crdcktYinFoTQJ5jHgU8gjeF4d2yA@mail.gmail.com>
 <87h7go2h69.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7go2h69.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/21 09:40), Marc Zyngier wrote:
> > 
> > Can that be cured by just checking vcpu->preempted before calling
> > kvm_update_vcpu_preempted() ?
> 
> It isn't obvious to me that this is the right thing to do.
> vcpu->preempted is always updated on sched-out from the preempt
> notifier if the vcpu was on the run-queue, so my guess is that it will
> always be set when switching to another task.
> 
> What you probably want is to check whether the vcpu is blocked by
> introspecting the wait-queue with:
> 
> 	scuwait_active(kvm_arch_vcpu_get_wait(vcpu)
> 
> which will tell you whether you are blocking or not. We are already
> using a similar construct for arming a background timer in this case.

Can we examine if vcpu->run->exit_reason == WFE/WFI and avoid setting
preempted state if so?
