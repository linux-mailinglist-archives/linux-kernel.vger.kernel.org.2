Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9707B372C08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhEDOaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhEDOaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620138563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/C/wTNOTCb+yGfszfpaIVYIq+8oCD0tOIWtXOH684UQ=;
        b=UZ1bmByBTwT4BUjD3GBEA+6eQ60Vol5wOpIi0IsZxKLseqB86Fa1Vvgp+B9SeokIPh+ody
        I70JSHUG95AcvknojMj8B7LlawK9XhQm/x80HJkTwfHXZXjqAu8L6hRNtm0hWIbD4pjkTC
        AdmI1bxe06jXEBao2Wr9CkX6k5kgkTk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-WFDM9k2mN-CBKpl5Ua-o0g-1; Tue, 04 May 2021 10:29:22 -0400
X-MC-Unique: WFDM9k2mN-CBKpl5Ua-o0g-1
Received: by mail-ej1-f72.google.com with SMTP id h9-20020a1709063c09b0290393e97fec0fso3182322ejg.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/C/wTNOTCb+yGfszfpaIVYIq+8oCD0tOIWtXOH684UQ=;
        b=Eppbeadbp+tFIvysAcZSZjiZ0hUpGYTHNZ6EQDFgLstPUnk0lQNofOTHeKg47uene4
         KHpEUYiJCEL+ys2yA98DqGbHptyszL5ObmXXvvKHAvFG/Ywkz0O3Gaeeur2TH+67d55N
         RiN1LCx7bJohJKK9RZLv3HvMYUI2weGqdK/t5b3WUC5ZcfvKobBt6DdMY0PfKJUnHjZk
         xOnCHV5NFKSFyK8WAaKi6hKRui5y28C6azUKpvPoxoC/WJTqRtfnJTpBF0vU3algFpc5
         1ha2jAxufbUsR0gm4HlIgXMGhA6NxpAVcEM/TUu5Wz6eNe0dRGvj7kVsNCAVfuJ9df3I
         ZsOg==
X-Gm-Message-State: AOAM533Q9BOMhyLNmH+RIajVB0a6zLHedvaOCRuEn58HTCJZVqzw0YnL
        CrhIN0QIgIYD+nv3+i6WQyQBb/fquTK8eD9QGXLAijVyibFhLLmWiZuaJePmVV/vbcIxoDTZEUM
        x2c5WXoKvXLUlMdpuMLm84KGPX9OlV4zjg9sAN8We
X-Received: by 2002:a17:906:9a02:: with SMTP id ai2mr22704484ejc.279.1620138561161;
        Tue, 04 May 2021 07:29:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBQGqUZtw6piWjtshZQhonbqeKOMWr75L9XDey1rFpJCXv1AQK+Jw5/m9KuadTFtTp9gtXISJlA+uPKf1wTjE=
X-Received: by 2002:a17:906:9a02:: with SMTP id ai2mr22704467ejc.279.1620138560926;
 Tue, 04 May 2021 07:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210501021832.743094-1-jesse.brandeburg@intel.com> <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com>
In-Reply-To: <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Tue, 4 May 2021 10:29:09 -0400
Message-ID: <CAFki+L=D8aS_jub0KHAkfsnvvJ_w8_mMYbaHeZ-GkQF1s_0WDQ@mail.gmail.com>
Subject: Re: [PATCH tip:irq/core v1] genirq: remove auto-set of the mask when
 setting the hint
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, jbrandeb@kernel.org,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, abelits@marvell.com,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jinyuqi@huawei.com" <jinyuqi@huawei.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        netdev@vger.kernel.org, chris.friesen@windriver.com,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 8:15 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-05-01 03:18, Jesse Brandeburg wrote:
> > It was pointed out by Nitesh that the original work I did in 2014
> > to automatically set the interrupt affinity when requesting a
> > mask is no longer necessary. The kernel has moved on and no
> > longer has the original problem, BUT the original patch
> > introduced a subtle bug when booting a system with reserved or
> > excluded CPUs. Drivers calling this function with a mask value
> > that included a CPU that was currently or in the future
> > unavailable would generally not update the hint.
> >
> > I'm sure there are a million ways to solve this, but the simplest
> > one is to just remove a little code that tries to force the
> > affinity, as Nitesh has shown it fixes the bug and doesn't seem
> > to introduce immediate side effects.
>
> Unfortunately, I think there are quite a few other drivers now relying
> on this behaviour, since they are really using irq_set_affinity_hint()
> as a proxy for irq_set_affinity().

That's true.

> Partly since the latter isn't
> exported to modules, but also I have a vague memory of it being said
> that it's nice to update the user-visible hint to match when the
> affinity does have to be forced to something specific.

If you see the downside of it we are forcing the affinity to match the hint
mask without considering the default SMP affinity mask.

Also, we are repeating things here. First, we set certain mask for a device
IRQ via request_irq code path which does consider the default SMP mask but
then we are letting the driver over-write it.

If we want to set the IRQ mask in a certain way then it should be done at
the time of initial setup itself.

Do you know about a workload/use case that can show the benefit of
this behavior? As then we can try fixing it in the right way.

--
Thanks
Nitesh

