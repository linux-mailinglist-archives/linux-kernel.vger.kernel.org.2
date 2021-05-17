Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49647386C14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 23:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbhEQVO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 17:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235796AbhEQVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 17:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621286013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMVyazJ1DXkMnUs3j/wPGjHkILobShDj4cNdkiPTOO8=;
        b=KFWsQtZHOxaDYVZg7ozn9PfqPfwhgPu6C8LrQrdGdSQ43IjncUsgGxBFZK8TpXjf817WrA
        n4tt3JKw+vritcNPfcULBeRijhW5UrSeUF3HzyaUaXJtl87zDJdV6t/KwfVxtc1GQ3TYnK
        asd5i0cZWMlFaLFR/n5rNBGk0/FVC64=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-JykEBQboPRORNDdPHn3QwQ-1; Mon, 17 May 2021 17:13:31 -0400
X-MC-Unique: JykEBQboPRORNDdPHn3QwQ-1
Received: by mail-lj1-f197.google.com with SMTP id z14-20020a2e964e0000b02900e9ad576f5aso3629316ljh.20
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 14:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMVyazJ1DXkMnUs3j/wPGjHkILobShDj4cNdkiPTOO8=;
        b=NT1KPovRW/n8c/+E4k5uwXgcEsv5MHGwaCE1UsetAvLdLHxYHnZwt0BkQLiogVW+Os
         8TJuXRtugU5+jgHqC6M0FiOkh4rk9NpKQcnkvD+stkMghPavjUpmv9eQcd5gLf5rVFtN
         ac+7pTA+XqmVxXkaKjEi7ViM1n9Bkb67sZWh24sGlWgQUA8LKo5XJUe5x87GICWLCGFQ
         5DFL700zGSOingjnifnEufsL96m1nfNO2kkVyGcEqeUmtGBkEpH+Jm3wH4Wrh8J2ttX6
         3rI/mCAN0TYvpkGKQk3ulIwLr85MmgP1xcG/tPZSld0WSYMZ/dMlPxUonJyvWL8ehO5E
         d1xw==
X-Gm-Message-State: AOAM530U4qGTHji+lJpshPPQrx/eUcH+Ljk7fpQlGFC2ZLEJG5sPUpH4
        8H25nKfOK6Z4/t5goqNEiMLIHIl0PHVuyv6YHryvr0aFttj/iW2adHKHROqqRr42Ic7SI3ZiP2t
        xTO9VNY7NOun/YcoNvEuwud5C6N7GCPwrUvYgWiZZ
X-Received: by 2002:a05:6512:3b0f:: with SMTP id f15mr1283918lfv.384.1621286010054;
        Mon, 17 May 2021 14:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqIbTFw79dJ0F4QTNj1vmQA/K7J9iPzeYKZygGXoFgqrcehoZoCiXVL8VcdElnx9bU093vnbhjyUBh7vmtE5k=
X-Received: by 2002:a05:6512:3b0f:: with SMTP id f15mr1283890lfv.384.1621286009804;
 Mon, 17 May 2021 14:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com> <20210504092340.00006c61@intel.com>
 <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com>
 <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com> <CAFki+L=LDizBJmFUieMDg9J=U6mn6XxTPPkAaWiyppTouTzaqw@mail.gmail.com>
 <87y2cddtxb.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87y2cddtxb.ffs@nanos.tec.linutronix.de>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 17 May 2021 17:13:18 -0400
Message-ID: <CAFki+L=RaSZXASAaAxBf=RJqXWju+pkSj3ftMkmoqCLPfg0v=g@mail.gmail.com>
Subject: Re: [PATCH tip:irq/core v1] genirq: remove auto-set of the mask when
 setting the hint
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, jbrandeb@kernel.org,
        Alex Belits <abelits@marvell.com>,
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

On Mon, May 17, 2021 at 3:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Nitesh,
>
> On Mon, May 17 2021 at 14:21, Nitesh Lal wrote:
> > On Mon, May 17, 2021 at 1:26 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > We can use irq_set_affinity() to set the hint mask as well, however, maybe
> > there is a specific reason behind separating those two in the
> > first place (maybe not?).
>
> Yes, because kernel side settings might overwrite the hint.
>
> > But even in this case, we have to either modify the PMU drivers' IRQs
> > affinity from the userspace or we will have to make changes in the existing
> > request_irq code path.
>
> Adjusting them from user space does not work for various reasons,
> especially CPU hotplug.
>
> > I am not sure about the latter because we already have the required controls
> > to adjust the device IRQ mask (by using default_smp_affinity or by modifying
> > them manually).
>
> default_smp_affinity does not help at all and there is nothing a module
> can modify manually.

Right, it will not help a module.

>
> I'll send out a patch series which cleans that up soon.

Ack, thanks.

>
> Thanks,
>
>         tglx
>
>


--
Nitesh

