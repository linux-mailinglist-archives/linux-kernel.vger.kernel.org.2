Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FDF37980C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 21:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhEJT55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 15:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhEJT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 15:57:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 12:56:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620676608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnsCi4tsfX2EqkxQUyb5I4F/v2kHeUeGstf11LeuD24=;
        b=h4WDucZYAjALME2VAr4sUcDFtrwd+qDWQJUSNZ2QtDyfAZvGeKFxNJs4M/nvq+Ij/i1TPq
        m0u4HNhXDlodulnGSiA1lz4L5WpCUvtXn9aEOUHS4hHsEsC7e+krK/+cQ4mhmVzWWRYbob
        3SHjf0Cgaqd4cxhkkMbgJ5rBiXatg4ligh0cdQQ54z6hNXqA1qWTVf21rRTF9oAgH0ABzU
        ++X1aHmFw5hnQqTsG085zuf5TbkgZQgCq5goHn4qtneGmiQmE+CB7BJejbcQJzGAye61+u
        6GZySM/dR11ZQNLYUZOe4ueBafLA3kk37ErNDXrxeHf1dJeZCdLyhOJNbg1f4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620676608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnsCi4tsfX2EqkxQUyb5I4F/v2kHeUeGstf11LeuD24=;
        b=wYYj63iKrfnU2kzRsq94miAfEYRP4OHGf+WJ6KHq55/aU5EmGwZkJr5Z2xS/8n6OON87EX
        tT77+OdaPha9xzCQ==
To:     xuyihang <xuyihang@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, minlei@redhat.com,
        liaochang1@huawei.com
Subject: Re: Virtio-scsi multiqueue irq affinity
In-Reply-To: <963e38b0-a7d6-0b13-af89-81b03028d1ae@huawei.com>
References: <20190318062150.GC6654@xz-x1> <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de> <20190325050213.GH9149@xz-x1> <20190325070616.GA9642@ming.t460p> <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de> <20190325095011.GA23225@ming.t460p> <0f6c8a5f-ad33-1199-f313-53fe9187a672@huawei.com> <87zgx5l8ck.ffs@nanos.tec.linutronix.de> <963e38b0-a7d6-0b13-af89-81b03028d1ae@huawei.com>
Date:   Mon, 10 May 2021 21:56:48 +0200
Message-ID: <87wns6gy67.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yihang,

On Mon, May 10 2021 at 16:48, xuyihang wrote:
> =E5=9C=A8 2021/5/8 20:26, Thomas Gleixner =E5=86=99=E9=81=93:
>> Can you please provide a more detailed description of your system?

>>      - Kernel version
> This experiment run on linux-4.19

Again. Please provide reports against the most recent mainline version
and not against some randomly picked kernel variant.

> If we make some change on this experiment:
>
> 1.=C2=A0 Make this RT application use less CPU time instead of 100%, the =
problem
> disappear.
>
> 2, If we change rq_affinity to 2, in order to avoid handle softirq on=20
> the same core of RT thread, the problem also disappear. However, this app=
roach
> result in about 10%-30% random write proformance deduction comparing
> to rq_affinity =3D 1, since it may has better cache utilization.
> echo 2 > /sys/block/sda/queue/rq_affinity
>
> Therefore, I want to exclude some CPU from managed irq on boot
> parameter,

Why has this realtime thread to run on CPU0 and cannot move to some
other CPU?

> which has simliar approach to 11ea68f553e2 ("genirq, sched/isolation:=20
> Isolate from handling managed interrupts").

Why can't you use the existing isolation mechanisms?

Thanks,

        tglx
