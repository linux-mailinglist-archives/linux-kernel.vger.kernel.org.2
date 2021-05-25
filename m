Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5CD38F889
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhEYDN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhEYDN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:13:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5437C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:11:56 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f30so6666535lfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXdwPjLy8p+ZNsFuwTHjb34OCdCdZ+yc5hjsESK2BF8=;
        b=VoWuibnIL420UYl2n8AsosYrZPnisjXrlOhsUBBlw5MmzcwMF9aDtcTZA9n86EZ04A
         iKtezaGmdtqOp87nAhTYNsCFAgW07gxImBXhuL8wZaf0s8ZlRDLHhTxtNvByYYlkCKCf
         MSbtIU2pY4jJV2brIq+Xx1ARPE74uj/QT1t/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXdwPjLy8p+ZNsFuwTHjb34OCdCdZ+yc5hjsESK2BF8=;
        b=KOZFqFfLK55pn6/ZV0ihhKeuTZKamlDpikOnbatott5libRv8i81dd0OOP9e99O1pV
         fPIJ2Fqpp8Pn3qilkH9we44GZcPo3Ex/ewzKYla//sTqmVnVinHiexF4//pWhteLm8kC
         cCVqJ2Eh6F4ztUlarr4dhouhAAW3jr8Si2ojxnkXXxvA4jXqykjpPKf/lYd/RazuZ3pu
         0H2Mf5GBv1IwfChLiJkNKNBaBEXYLNP6DXTPArl1GHyp3X+EqkjnRjLGJ7leiR17bhJN
         DllaLsb2BmY/xiGG5r6apwgwHkB1NwsjjUtpvb8q1R5+IrhaxkCgJ/w0rmvFMlTB3z+H
         IpgQ==
X-Gm-Message-State: AOAM5311JIuRb6/w284HjVQMfSmzN7I7WfqJ5eNoGVXJGSvwjejc0BoI
        mAIVm2kfl+tLPbmkqv7MfwgVGTdGbIxz4xLNkVc=
X-Google-Smtp-Source: ABdhPJzcI5B7QovzAizjtzJbH+sMNMAHN0dO0tSrj/HIsFN9+nEPC09X36kXdjLvQIVk95P8r/RUJg==
X-Received: by 2002:a05:6512:40f:: with SMTP id u15mr12267871lfk.271.1621912314767;
        Mon, 24 May 2021 20:11:54 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id m28sm322489lfj.173.2021.05.24.20.11.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 20:11:53 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id q1so1268742lfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:11:53 -0700 (PDT)
X-Received: by 2002:a05:6512:36c5:: with SMTP id e5mr12425672lfs.41.1621912313387;
 Mon, 24 May 2021 20:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210525031636.GB7744@xsang-OptiPlex-9020>
In-Reply-To: <20210525031636.GB7744@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 May 2021 17:11:37 -1000
X-Gmail-Original-Message-ID: <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
Message-ID: <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
Subject: Re: [mm/gup] 57efa1fe59: will-it-scale.per_thread_ops -9.2% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 5:00 PM kernel test robot <oliver.sang@intel.com> wrote:
>
> FYI, we noticed a -9.2% regression of will-it-scale.per_thread_ops due to commit:
> commit: 57efa1fe5957694fa541c9062de0a127f0b9acb0 ("mm/gup: prevent gup_fast from racing with COW during fork")

Hmm. This looks like one of those "random fluctuations" things.

It would be good to hear if other test-cases also bisect to the same
thing, but this report already says:

> In addition to that, the commit also has significant impact on the following tests:
>
> +------------------+---------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops 3.7% improvement                    |

which does kind of reinforce that "this benchmark gives unstable numbers".

The perf data doesn't even mention any of the GUP paths, and on the
pure fork path the biggest impact would be:

 (a) maybe "struct mm_struct" changed in size or had a different cache layout

 (b) two added (nonatomic) increment operations in the fork path due
to the seqcount

and I'm not seeing what would cause that 9% change. Obviously cache
placement has done it before.

If somebody else sees something that I'm missing, please holler. But
I'll ignore this as "noise" otherwise.

            Linus
