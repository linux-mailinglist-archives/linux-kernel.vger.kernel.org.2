Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D23387387
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347279AbhERHvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234891AbhERHvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621324232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NW4UL0U5sPtzfc4lmGw05bHMRbyTb+TE8EPYexCTqqU=;
        b=VSREbdcO6qM7L034L+lHNFgh6pd/PhtiE0xHMRJF3rrYN3jxz7n6woBdx4tbHGED8e8qy9
        PWY4biFoTsdikJfQbnrG2VMKppttfCK5irAP3A8Dz1G6lPhFNBD2tCIukrRSp0riSZgbNk
        rG/+pKhTI4cH5W1knPvEHo380MqLfqk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-6ddMeOR1Py26oBgc02-tAg-1; Tue, 18 May 2021 03:50:31 -0400
X-MC-Unique: 6ddMeOR1Py26oBgc02-tAg-1
Received: by mail-ej1-f69.google.com with SMTP id m18-20020a1709062352b02903d2d831f9baso2022680eja.20
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NW4UL0U5sPtzfc4lmGw05bHMRbyTb+TE8EPYexCTqqU=;
        b=suW2s9QHvvYkbvDkPf+XpEYZ7ZOGx/h9+CmIuSmP0XDeJtnEoqS3uKs6LSydrkdvjX
         BLPKP5vSAIeEWGgnPj4xaDy/2jh6gP6yWGUh4v6kdP+8kRtLFwqmYRztej8kkBJn70t1
         Z0N4hHgzUZcXFJiwsnpS++NHG0Wl62bYypdj2Imc8LOIbz7e0MVu9mQgXvSnp8WzoVnL
         pp+SOgpjglekwXc9NvvHWFusWYxpGmFvjEd0YjviDQtHhN8yfP1LBO2xi3U5DeYjQwZm
         pdcAWxNpYKRjXVn0w3NgamupA0sEAx9QDGwf3GrxcrtO2aAS5Wbq/wyl5JyXzGDeMhj4
         cRYg==
X-Gm-Message-State: AOAM5317/CoL5Al49Y2kNw62erERr7NE+Bi+0BvRuSaEuRvkFR1HZYVU
        qBWPPBRwqQqMufHew4Mqdntv7OrprlcMirXf1JPcVPwmvdPfr7rMyB2A0ciWfut1vtT4IMPrDWI
        yQ0j1vb5QY7Q5vK88/39u9m6a
X-Received: by 2002:a05:6402:2044:: with SMTP id bc4mr5610905edb.282.1621324230210;
        Tue, 18 May 2021 00:50:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFzMI5v4PnOH/SXzTHlKC/E2yBgzwUMmMGoQmrcpTZlsyGOhJk/7yGYBlnGzMGqecpBbtZew==
X-Received: by 2002:a05:6402:2044:: with SMTP id bc4mr5610896edb.282.1621324230081;
        Tue, 18 May 2021 00:50:30 -0700 (PDT)
Received: from gator.home (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id d15sm8128909eds.68.2021.05.18.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 00:50:29 -0700 (PDT)
Date:   Tue, 18 May 2021 09:50:27 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     "wangyanan (Y)" <wangyanan55@huawei.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Shannon Zhao <shannon.zhaosl@gmail.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
        yangyicong <yangyicong@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>,
        yuzenghui <yuzenghui@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [RFC PATCH v3 4/9] hw/arm/virt: Initialize the present cpu
 members
Message-ID: <20210518075027.wjpdjvoam7dlzign@gator.home>
References: <20210516102900.28036-1-wangyanan55@huawei.com>
 <20210516102900.28036-5-wangyanan55@huawei.com>
 <6c8f9c3502384f648f30c7381e87dda9@huawei.com>
 <68883a1b-5303-da13-a051-e909e1d1f71b@huawei.com>
 <6d8b9142e8a34d1390f2f0b4bfb53a00@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d8b9142e8a34d1390f2f0b4bfb53a00@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 07:04:51AM +0000, Salil Mehta wrote:
> > From: wangyanan (Y)
> > Sent: Tuesday, May 18, 2021 5:43 AM
> > 
> > Hi Salil,
> > 
> > On 2021/5/18 4:48, Salil Mehta wrote:
> > >> From: Qemu-arm
> > [mailto:qemu-arm-bounces+salil.mehta=huawei.com@nongnu.org]
> > >> On Behalf Of Yanan Wang
> > >> Sent: Sunday, May 16, 2021 11:29 AM
> > >> To: Peter Maydell <peter.maydell@linaro.org>; Andrew Jones
> > >> <drjones@redhat.com>; Michael S . Tsirkin <mst@redhat.com>; Igor Mammedov
> > >> <imammedo@redhat.com>; Shannon Zhao <shannon.zhaosl@gmail.com>; Alistair
> > >> Francis <alistair.francis@wdc.com>; David Gibson
> > >> <david@gibson.dropbear.id.au>; qemu-devel@nongnu.org; qemu-arm@nongnu.org
> > >> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; zhukeqian
> > >> <zhukeqian1@huawei.com>; yangyicong <yangyicong@huawei.com>; Zengtao (B)
> > >> <prime.zeng@hisilicon.com>; Wanghaibin (D) <wanghaibin.wang@huawei.com>;
> > >> yuzenghui <yuzenghui@huawei.com>; Paolo Bonzini <pbonzini@redhat.com>;
> > >> Philippe Mathieu-Daudé <philmd@redhat.com>
> > >> Subject: [RFC PATCH v3 4/9] hw/arm/virt: Initialize the present cpu members
> > >>
> > >> We create and initialize a cpuobj for each present cpu in
> > >> machvirt_init(). Now we also initialize the cpu member of
> > >> structure CPUArchId for each present cpu in the function.
> > > [...]
> > >
> > >>           qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> > >> +
> > >> +        /*
> > >> +         * As ARM cpu hotplug is not supported yet, we initialize
> > >> +         * the present cpu members here.
> > >> +         */
> > >> +        machine->possible_cpus->cpus[n].cpu = cpuobj;
> > >
> > > when vcpu Hotplug is not supported yet, what necessitates this change now?
> > >
> > The initialization will gives a way to determine whether a CPU is
> > present or not.
> > At least, for now it will be used when generating ACPI tables, e.g.
> > DSDT, MADT.
> > See patch 5 and 6.
> 
> yes,  but why do you require it now as part of the vcpu topology change?
> 
> As-far-as-i-can-see, PPTT table changes(part of patch 5/9) do not require
> this change. Change in Patch 5/9 has also been done in anticipation of
> some future requirement(vcpu Hotplug?).
> 
> Please correct me here if I am wrong?
>

Hi Salil,

The problem is that we've never required smp.cpus == smp.maxcpus, so
a user could have smp.cpus < smp.maxcpus. We want the topology to match
maxcpus, but only enable cpus. However, if you think we should just not
allow cpus < maxcpus until hot plug is sorted out, then we could discuss
a way of trying to enforce cpus == maxcpus, but I'm not sure how we can
without breaking existing command lines.

Thanks,
drew

