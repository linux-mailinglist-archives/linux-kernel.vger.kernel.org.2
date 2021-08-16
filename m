Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD263EDA37
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhHPPxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237021AbhHPPux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629129021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9V47nu1tdB3HihFEHa605ngQMwEj5TNSAxNMSmRQs8=;
        b=YMhwCDMNNsCMc4wPLeW2KCj2rNQUa9hS5ABC/V8xZe4A6y9+Ng0Qx48lSdsfUYRqNCkg3n
        83BcRK3SHZJzm/gqgq6CaulvqEnilaE0QSBJHP8UVJXayfwY3JKduJGAI5LkuAxMPOP/dR
        BjzgHLIex+RdV+L6BjBlbTwUbaxUe5E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-02rO9YbaMbixuMVC0GfWRw-1; Mon, 16 Aug 2021 11:50:19 -0400
X-MC-Unique: 02rO9YbaMbixuMVC0GfWRw-1
Received: by mail-lf1-f70.google.com with SMTP id d16-20020ac25ed00000b02903c66605a591so4460204lfq.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9V47nu1tdB3HihFEHa605ngQMwEj5TNSAxNMSmRQs8=;
        b=HR4qRDcNoWvYRhN6+93CapdXgIh76Sa1Ev1wCMn99h6X5PndObQdeW7R1jRRxasjt+
         3+51f4wdI/nvmdK20U1LtisRF7XI2cEfDRPv7M7maJcgJ3+F2JmatVQZkrCyJLMu6R+q
         aESwUfGJXN2XMkT003u4dlvijWE0sr0HViTTpszL0wHAeFh/W5tCS9QV7jf7xKWdQIb8
         zIWxNsq26m8cJEjMsIymkbISDHxrp+foAWRPNEjAX4nRqcD1P8H6YVswNP3r/0pEM4Fq
         O/JQcKUeGglajHSzmWOrJXD8Y4AlwOfZxYSw6dEOylzwdDg6pOhgTNRFPSvsEvEMnqV/
         ogmw==
X-Gm-Message-State: AOAM532vszeUEpYRJsoZptLtRhEyW3anTu3fprZV17JPWW9jd181bkb8
        M0IWdi2GoNuatGGJIng/HrXyu0p1KXGMCRvXEj0wMcZdSJMrJaXpAQE89SUHRVe79QfFduaXsx2
        WQ34KZgoeYNW2WYMWKCZIKtB1RleRFtG9NVI7lvrp
X-Received: by 2002:a05:6512:456:: with SMTP id y22mr5533257lfk.647.1629129018299;
        Mon, 16 Aug 2021 08:50:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYKp8N35ngSFV1JQgPEtrP2LghXpp0ovI3XuTPw6uhwPl2Oh6I/VaDu17nmxri46bGsTbAB55Bxd3XRif017c=
X-Received: by 2002:a05:6512:456:: with SMTP id y22mr5533214lfk.647.1629129018115;
 Mon, 16 Aug 2021 08:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210720232624.1493424-1-nitesh@redhat.com> <CAFki+LkNzk0ajUeuBnJZ6mp1kxB0+zZf60tw1Vfq+nPy-bvftQ@mail.gmail.com>
In-Reply-To: <CAFki+LkNzk0ajUeuBnJZ6mp1kxB0+zZf60tw1Vfq+nPy-bvftQ@mail.gmail.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 16 Aug 2021 11:50:06 -0400
Message-ID: <CAFki+LkyTNeorQ5e_6_Ud==X7dt27G38ZjhEewuhqGLfanjw_A@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] genirq: Cleanup the abuse of irq_set_affinity_hint()
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, benve@cisco.com, _govind@gmx.com,
        jassisinghbrar@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com
Cc:     linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, jbrandeb@kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>, rostedt@goodmis.org,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linuxfoundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        chris.friesen@windriver.com, Marc Zyngier <maz@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, pjwaskiewicz@gmail.com,
        Stefan Assmann <sassmann@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>, james.smart@broadcom.com,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Ken Cox <jkc@redhat.com>, faisal.latif@intel.com,
        shiraz.saleem@intel.com, tariqt@nvidia.com,
        Alaa Hleihel <ahleihel@redhat.com>,
        Kamal Heib <kheib@redhat.com>, borisp@nvidia.com,
        saeedm@nvidia.com, Nitesh Lal <nilal@redhat.com>,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Al Stone <ahs3@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
        bjorn.andersson@linaro.org, chunkuang.hu@kernel.org,
        yongqiang.niu@mediatek.com, baolin.wang7@gmail.com,
        Petr Oros <poros@redhat.com>, Ming Lei <minlei@redhat.com>,
        Ewan Milne <emilne@redhat.com>, jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        kabel@kernel.org, Jakub Kicinski <kuba@kernel.org>,
        kashyap.desai@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        suganath-prabu.subramani@broadcom.com,
        Thomas Gleixner <tglx@linutronix.de>, ley.foon.tan@intel.com,
        huangguangbin2@huawei.com, jbrunet@baylibre.com,
        johannes@sipsolutions.net, snelson@pensando.io,
        lewis.hanly@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 11:26 AM Nitesh Lal <nilal@redhat.com> wrote:
>
> On Tue, Jul 20, 2021 at 7:26 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> >
> > The drivers currently rely on irq_set_affinity_hint() to either set the
> > affinity_hint that is consumed by the userspace and/or to enforce a custom
> > affinity.
> >

[...]

>
> Gentle ping.
> Any comments on the following patches:
>
>   genirq: Provide new interfaces for affinity hints
>   scsi: megaraid_sas: Use irq_set_affinity_and_hint
>   scsi: mpt3sas: Use irq_set_affinity_and_hint
>   enic: Use irq_update_affinity_hint
>   be2net: Use irq_update_affinity_hint
>   mailbox: Use irq_update_affinity_hint
>   hinic: Use irq_set_affinity_and_hint
>
> or any other patches?
>

Any comments on the following patches:

  enic: Use irq_update_affinity_hint
  be2net: Use irq_update_affinity_hint
  mailbox: Use irq_update_affinity_hint
  hinic: Use irq_set_affinity_and_hint

or any other patches?
Any help in testing will also be very useful.

-- 
Thanks
Nitesh

