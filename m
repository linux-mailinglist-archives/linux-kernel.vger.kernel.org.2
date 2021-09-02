Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F6B3FF127
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhIBQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbhIBQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:20:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A76C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:19:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w4so4550373ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iMvWLkdWUtkaR1dklSOOm8LWF6kDmId1zmm7zZNctbo=;
        b=UqYwBgxkGgrjPUjuhbRaR+xLyGBDGqNcXTGQY2dH1sazdx9URXp5fCnNYrBqs5Yf7J
         TvrKnb971ru+ib8HBTPlUc11Ft7o6IkhsByM2Jk+y8Ovf8G4HlaCr9CiPAmTrIPQfYbb
         q5nIzlUcLfmsFEKimVxis1ZpI3WSJxF/9jqfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iMvWLkdWUtkaR1dklSOOm8LWF6kDmId1zmm7zZNctbo=;
        b=nsQRIt4hf5NtKkcUinHx5+ZDYpJhzE9aHFGTx8al9nTxaLBh/aOtIRAb3bc1nADBqc
         SbBn0+frXraQot/My8yiII/7Cs1D1+LjwatLJ+HRbpl73hhMoCBzBc7VKjq64J5Fv90F
         GwZ620dyhGJ/y30uNS06FbRGRz/58Xwr3/vFlE1DfGx7cY/NFINpDv8gpG25Xi77Q7Q5
         hwHkIhxZW90SDpeNnS3Tosz8PDMr7GYfDnlhkTwOgugRLw4lczi3Y6/B8j54xIV6PZYy
         I2FW23EY3NBzD+pKyx/qYNfBWwum9XChIAVR/C1R87f5HRDH4c2nTtiBXlQjs+9KL7Ra
         cWuQ==
X-Gm-Message-State: AOAM531AmOjxgCUA2gmJcnwJxXJ3YjSyClr237CXwWtdu70IZuZezMAM
        iFPWmYx7iI5MKnWzmMP7EnFKsJgtD/+3Fi3t
X-Google-Smtp-Source: ABdhPJyVQCo2oS9uEPsvXk7GQwg/IrWQpuiBumnu17KfPGJfqMMLmnfkPCk4cCDH4bDwe6/y1kuheg==
X-Received: by 2002:a2e:bb8f:: with SMTP id y15mr3288073lje.148.1630599556400;
        Thu, 02 Sep 2021 09:19:16 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id f17sm272456ljn.44.2021.09.02.09.19.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 09:19:15 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x27so5509094lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:19:15 -0700 (PDT)
X-Received: by 2002:a05:6512:681:: with SMTP id t1mr3132726lfe.487.1630599555287;
 Thu, 02 Sep 2021 09:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 09:18:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
Message-ID: <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
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

On Tue, Aug 31, 2021 at 4:00 PM Gao Xiang <xiang@kernel.org> wrote:
>
> All commits have been tested and have been in linux-next. Note that
> in order to support iomap tail-packing inline, I had to merge iomap
> core branch (I've created a merge commit with the reason) in advance
> to resolve such functional dependency, which is now merged into
> upstream. Hopefully I did the right thing...

It all looks fine to me. You have all the important parts: what you
are merging, and _why_ you are merging it.

So no complaints, and thanks for making it explicit in your pull
request too so that I'm not taken by surprise.

         Linus
