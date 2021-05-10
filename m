Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE63B37968A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhEJR4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhEJR4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:56:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51FDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:55:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so10520918pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ENyXchrEwZFqrIacbznFvbJBEbNl/lZ9i1nxAnl+9g=;
        b=UYnI3HCSiBU6cvrm7dQI9tdEKSpp7CV9MxA5EuqiU1bGvJozPE8d1aTvUMwq39OvOd
         6hCzlmIZ4HAEv63tDmVIVKWs9W/onufqIfZR0FJAiNKvjvqbAGyfuN9WDmRCYeKCbSO5
         eJyWoEjCXEYhAF6SLKA5MebZNUldv1yONyhuZjb36IRxEIqV5b5WDCOkbL8OQ7vb4pRh
         IowdP6NS5bWsZGrw8dyywqqSnSDrD01UxPFtiSFzC7LaB1fWvGvTe61QibO+dQemlWPB
         jWxT35Zkc40rObpO+UVyCdQmjq+8lF8jqrR13Mp0g7PBbaExIEj5E/xbQS+K2pBE5lU4
         SNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ENyXchrEwZFqrIacbznFvbJBEbNl/lZ9i1nxAnl+9g=;
        b=fjCyi/WbJttd+nj+X4JBATtIceLLeYgCrbfzzjsO3mpnzYJtDOzUsW74YtSk+5Vvhr
         r55+9fRbJaswNx0Bup2LQduTnen9FKJ1zRq5mSC6NFXApNJuztLMDyPYYRIvfG7Iu6wb
         7XIP0tqMQ+6F/ACgwXCkQGosZPhlx1pV5CD9coJQXAKPBcL1PEJmD9IlqS4ZrIVDAohY
         4h0BP+UNA/SErpmck/3FwqJ4fc3dJCD76ttThUn8eErw6RpQ59yZeZLTQPvC3MGrPkVW
         U8lln8kojBQ84YA0QcRDAzx+gUirhzmkzNemcHSbo2v88l87yPzs3cV+RQu15n510GYY
         dcdQ==
X-Gm-Message-State: AOAM5316eEVkWDWlCQDkkv1vs6BhYcu0jaoPxYoTe45qE9UeaZ0TaVcU
        arMiyA6n0yRcsYJk6MTcjEmOu9hWHsFV+jGDRk4dog==
X-Google-Smtp-Source: ABdhPJzYS0mfwifF6JB5ZMhzPe6Yj6fIZ8OsHaCnRLd+QrUH0DbuWH4cUGjgbuEIW9GLWUClBxbn5gr61i4+/DsRBU0=
X-Received: by 2002:a17:902:f203:b029:ee:af8f:8e4b with SMTP id
 m3-20020a170902f203b02900eeaf8f8e4bmr25110542plc.23.1620669340375; Mon, 10
 May 2021 10:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com> <20210504171734.1434054-10-seanjc@google.com>
 <CAAeT=FyKjHykGNcQc=toqvhCR281SWc6UqNihsjyU+vuo3z5Yg@mail.gmail.com> <YJlixiTcwFkrnxIL@google.com>
In-Reply-To: <YJlixiTcwFkrnxIL@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Mon, 10 May 2021 10:55:24 -0700
Message-ID: <CAAeT=FxTfF2-FsKn93u3ba1Rdg8ehz6XUG9G=bBT7fx_OtXgdw@mail.gmail.com>
Subject: Re: [PATCH 09/15] KVM: VMX: Use flag to indicate "active" uret MSRs
 instead of sorting list
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Shouldn't vmx_setup_uret_msr(,MSR_TSC_AUX,) be called to update
> > the new flag load_into_hardware for MSR_TSC_AUX when CPUID
> > (X86_FEATURE_RDTSCP/X86_FEATURE_RDPID) of the vCPU is updated ?
>
> Yes.  I have a patch in the massive vCPU RESET/INIT series to do exactly that.
> I honestly can't remember if there was a dependency that "required" the fix to
> be buried in the middle of that series.  I suspect not; I'm guessing I just
> didn't think it was worth backporting to stable kernels and so didn't prioritize
> hoisting the patch out of that mess.
>
> https://lkml.kernel.org/r/20210424004645.3950558-34-seanjc@google.com

I see. I hadn't checked the patch.
Thank you for your answer !

Regards,
Reiji
