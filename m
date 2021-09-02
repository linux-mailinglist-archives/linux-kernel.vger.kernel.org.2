Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD333FF3AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhIBS7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347245AbhIBS7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:59:16 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387DBC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 11:58:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g14so5445423ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nou0znqimsrLl6OB5c1aMp82GMEqusuNoyOJ20o6LFI=;
        b=Ibpdc46zjQloZ+vX8Jc+8cZvxyZgkNzdSsEJA3RXMKA4Uv115klG8TP44ku0D70EYN
         2ZdHNkPCogYuUgXzzStalGmdzhm6x4HMAJyz6jwygSEzV1uGAEnpH4rb6ZQRdRgWqyQl
         K8bZBGqrT9kuG/VjjS1yasgD0iTr8JY35ybDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nou0znqimsrLl6OB5c1aMp82GMEqusuNoyOJ20o6LFI=;
        b=ph9/MTSTCwAhFABIvv7v2xFdnWlRLh1b4I5H9cjNxR4kKS3DapL1oYDigeeZEJvAMw
         LS6yVqH628dtUYihBfEFYdihnvVEox4nPH0xKjsVwvHYwMlHpn3Bea3hqIeQb65Yk+No
         UGMIKBgqpuBMaCcUbftKJ0UJWpaHdDB4rNwaOlooZ7WIXMbA/dlEXA0oySbDtgDjEWZF
         8kE//gf0Ff4hMKgTb6axmHpwOgr0+njqzI/d9y2l0734T0+K7u3QmqK9wKNG0ePo3CtD
         s7/jYyz/rU/AL/tEevkVSB//1zRkQAgsfWPKayvABgB9ev+He6eVtuHolyM1U5jhiCIj
         JBfg==
X-Gm-Message-State: AOAM53020nD4VGyvsDRlSRoS5cTliFEQhbcqvtWehOyltjAW6BhgtoMC
        A0OyrQqx9oxeEwpweOkN2i/HhHOHRkv0wPoEb2M=
X-Google-Smtp-Source: ABdhPJyVnczfEp1cln2GfahokxtTrP9kQDcDseCHQqL0snCOmH1CQAfBt0W+3NHAIlF8epc0ONI5yw==
X-Received: by 2002:a2e:9ad9:: with SMTP id p25mr3637655ljj.439.1630609095300;
        Thu, 02 Sep 2021 11:58:15 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b17sm314780ljj.35.2021.09.02.11.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 11:58:14 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id t19so6474780lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:58:14 -0700 (PDT)
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr3465517lfu.377.1630609094065;
 Thu, 02 Sep 2021 11:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com> <20210902182053.GB26537@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20210902182053.GB26537@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 11:57:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgirqjdeuYX+PvL-09UUKtnBaRYTXQrRdjCYxGKirEpug@mail.gmail.com>
Message-ID: <CAHk-=wgirqjdeuYX+PvL-09UUKtnBaRYTXQrRdjCYxGKirEpug@mail.gmail.com>
Subject: Re: [GIT PULL] erofs updates for 5.15-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huang Jianan <huangjianan@oppo.com>,
        Yue Hu <huyue2@yulong.com>, Miao Xie <miaoxie@huawei.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 11:21 AM Gao Xiang <xiang@kernel.org> wrote:
>
> Yeah, thanks. That was my first time to merge another tree due to hard
> dependency like this. I've gained some experience from this and will be
> more confident on this if such things happen in the future. :)

Well, being nervous about cross-tree merges is probably a good thing,
and they *should* be fairly rare.

So don't get over-confident and cocky ;^)

                  Linus
