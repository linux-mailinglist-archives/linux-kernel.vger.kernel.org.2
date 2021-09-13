Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76553409E00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243201AbhIMUPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242914AbhIMUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:15:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70292C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:14:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f2so19458260ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFTu7i7tglTtOKjDBcC9nmGq/Wxog3yPftPLyMBlrng=;
        b=KWNwuwaNQr+7SRzLqx1Ow/Hdp9oPj6ocOQ2nsmKYN9cZLRkBI/Hv4/znREvl77lHn0
         m08q9e3Zbe5EyWd7pYglZjLKjTUmhZVypq8EZy6Pqeze6LfuxRelwE4v4447DcsFa1h5
         DMQUdpK8zA1H3rB2ZnZay55j3BNkWQmNQ9IrloYumykcFjHTRiZyP6XxCz5X8HxGhWgv
         MVv6cvaaaVbD4tY/HwzWhvQ47vYTNPbutha5oh5TtNU1pBtY7z0Zo2bUUhx4ltptgUEn
         8Qj4b7Gogx2ExFy4CaojIzA8WbQ0TsU+PaUy2vjVNpvnz5pVbxrxySVpi99XOyedjYEp
         sUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFTu7i7tglTtOKjDBcC9nmGq/Wxog3yPftPLyMBlrng=;
        b=c0wXDn95wVMERyI5QqSD98rzTNEvi8txEhW141zmA5kFDk38saf6PmIUw5S5yA1Fye
         hzfrYTWjiQMikC2IMTmzwBdhuks76r98hCvhJ9GZkN47yo9t8Wxkh5Jz2UxRwZOSSTlF
         DfR+AoJLhwpNRxhE21TtQDN4rK6LrbszzHEnFf5AwoUta/qmZLGhEumrNrkSzkg26Y1w
         nCVqhDbyoiDsBdSq4a0Z2db63c2OGwuNqxcWLrATEjljk8zQRfGY/lb4Hsptr+63Xxj5
         ygvMBnM+IDJcT54Rvrfd9wDQJ6A/l+B0ebWjYi6l1aeENobdT2MddO/SAtd9H8ynlkzL
         nhQw==
X-Gm-Message-State: AOAM530yRuLfm0T18RgdojdBXUzYGZ4eZGZjkPrnpqIUxbJmpA0yzkM+
        ulZ9UzqbC0mTe09Ha+qCiGZeQCfEc+aCDkmE3qE2cg==
X-Google-Smtp-Source: ABdhPJynmxXZYWW7JPUI3h584TVaD1TqBxmocx5ejgb70V1LLe1DVNrZcKCPnyNoPmkyAcNQHtpQf8sM3W2XoyW8GGQ=
X-Received: by 2002:a2e:964b:: with SMTP id z11mr11833962ljh.91.1631564048561;
 Mon, 13 Sep 2021 13:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210905124439.GA15026@xsang-OptiPlex-9020> <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
 <20210907033000.GA88160@shbuild999.sh.intel.com> <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
 <20210912111756.4158-1-hdanton@sina.com> <20210912132914.GA56674@shbuild999.sh.intel.com>
 <CALvZod4VbdSux5RaQuhqbC7ENm39UbdkJF8LhYedbFwHKyJgfw@mail.gmail.com>
 <CALvZod7Oa7q=P0gzfA3F26bHPrNz+F-d6G9qKpSiHy9g=msM_w@mail.gmail.com>
 <YT+ptg1Lf1kGLyUX@slm.duckdns.org> <CALvZod7mBLbkqZJzZz=XNGTDB4mxCd6dwM40aCv6t8fWbdUJdw@mail.gmail.com>
 <YT+wKFZg0OS0YFrF@slm.duckdns.org>
In-Reply-To: <YT+wKFZg0OS0YFrF@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 13 Sep 2021 13:13:57 -0700
Message-ID: <CALvZod7BFZ1M4KWYWEhRHdZCeLV8Km=NqpkCZ=k67mBNSgX0cQ@mail.gmail.com>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
To:     Tejun Heo <tj@kernel.org>
Cc:     Feng Tang <feng.tang@intel.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 1:10 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Sep 13, 2021 at 01:09:11PM -0700, Shakeel Butt wrote:
> > Thanks a lot for the explanation. Are there any concerns to call
> > cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup) in system_wq?
> > This will be called every 2 seconds, so, we can assume the updated
> > tree would be small most of the time.
>
> I can't think of a reason why this would be problematic.
>

Thanks again.

Feng, is it possible to re-run these benchmarks with
queue_work(system_wq) instead of queue_work(system_unbound_wq)?
