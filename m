Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC83D0658
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 03:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhGUAfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 20:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhGUAfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 20:35:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63FC061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 18:15:53 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o4so384912pgs.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 18:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UXoV+cGKQ4myvPfURbj+4IGhllQad57NXO7QIqiHQD4=;
        b=H3ES8RUOc7jcBhXKSSld1nbtEpTXLfbidaCzKfB/7XWZnxi/oMpreSNT8W9IF2UQFL
         j53LKazE8AZ9Zwuz9I4JcCE7RID2J6gT2zRjeiHMGJSJiWsWf5QNFSWGnQJdK6/c+m6e
         281I99+7jaPLChAxNoOpxnsyI/mmQKcHRHYFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UXoV+cGKQ4myvPfURbj+4IGhllQad57NXO7QIqiHQD4=;
        b=CsqsA/uPn36X1wjyuUiwF/X1FHaoq1CIb+BrIpPBbwxRWJLPozoTsU/AT3+tQyfmVU
         AoNgKnN2pDemC+ZC28NdS4qdFyg0sAGf6Y/8/s2HbQBbVgFZ4yD1aw/wtihwKV9lX1R3
         RrjsngYBnA69Nz5tleK6OkdiRHSiaTVoaooKib3/8YyMgIrDcyUjMIzZFm2mK3e4cMUh
         oDaMHToaicHJoghAIqYXC7+3K2FowwRWlW6Q7hLsuzLfeytsnXEMV/YLiw2s2U41bq1k
         n1nakTTHawtArNNZMlD/bdSUGrj32emhgYJWVJl+Do0Ql8I+gpD3voKsZ1+PO9P4OLz6
         Kb5Q==
X-Gm-Message-State: AOAM531tXpK2PBHMNfz6GXw7bstvF1Y0YTC4XeG9MYKGVxh0P24eFPW8
        Q+ullMGWFtIbKwsyawKBNl/Ljw==
X-Google-Smtp-Source: ABdhPJxfp5hGyASzFBCflJxvg/JXYrMBHZ4gp61qQS2+oVr0x7oYazVdBxY8Q9kTjoig37pYkCKYGg==
X-Received: by 2002:a62:19c9:0:b029:32a:129f:542d with SMTP id 192-20020a6219c90000b029032a129f542dmr33857420pfz.8.1626830153493;
        Tue, 20 Jul 2021 18:15:53 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:808c:1a13:1159:8184])
        by smtp.gmail.com with ESMTPSA id x18sm23934960pfh.48.2021.07.20.18.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:15:52 -0700 (PDT)
Date:   Wed, 21 Jul 2021 10:15:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Will Deacon <will@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCHv2 4/4] arm64: add host pv-vcpu-state support
Message-ID: <YPd1Q1ppmKng67tk@google.com>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
 <20210709043713.887098-5-senozhatsky@chromium.org>
 <874kcz33g5.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kcz33g5.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/12 17:24), Marc Zyngier wrote:
> >  
> >  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> >  {
> > +	kvm_update_vcpu_preempted(vcpu, true);
> 
> This doesn't look right. With this, you are now telling the guest that
> a vcpu that is blocked on WFI is preempted. This really isn't the
> case, as it has voluntarily entered a low-power mode while waiting for
> an interrupt. Indeed, the vcpu isn't running. A physical CPU wouldn't
> be running either.

I suppose you are talking about kvm_vcpu_block(). Well, it checks
kvm_vcpu_check_block() but then it simply schedule() out the vcpu
process, which does look like "the vcpu is preempted". Once we
sched_in() that vcpu process again we mark it as non-preempted,
even though it remains in kvm wfx handler. Why isn't it right?

Another call path is iret:

<iret>
__schedule()
 context_switch()
  prepare_task_switch()
   fire_sched_in_preempt_notifiers()
    kvm_sched_out()
     kvm_arch_vcpu_put()
