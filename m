Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4733879F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349589AbhERNaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:30:19 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:35483 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349499AbhERNaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:30:17 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 112361363;
        Tue, 18 May 2021 09:28:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 18 May 2021 09:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ga/TZj/5vAgtR0dCH9rcrEvjoBQ
        +Qmj6N01DxKSJ5Hg=; b=j4U/88rHJ4axiebD9NMyOxDn7M+yhUnvt/EmDkwSyBa
        esQ4fFKuE08eF7T+C34PKg3xxwe5uSklju7N5xhg1hmTpYYQKwgtvLPnWnFIALfL
        shW44ftnfabTj9n6b/fI40tc8pRWzJEHD8s5YuZ36RuUGRIsheFKE+uO45lXKTul
        /PE1dqbnb6mRbLsaYKsPdosXL4CbuadpovqMhFefdzmxJsA1l3dxZxFG9vVUtQU6
        95A8cyvQ8KAXO3uZwSOdEb8on1m1IoDLBc0Oa8KJpB1Qdfz6dNd9DHGSHGm/Rby7
        MBhsN/DHx+hwI+z59SNHzN1BtgFNHiHlKVGxcSYRXRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ga/TZj
        /5vAgtR0dCH9rcrEvjoBQ+Qmj6N01DxKSJ5Hg=; b=jvNPXILWdiAiOeWhZ+ZG+E
        gKUTpQteePibi7OTTwubqTzpzJ69i7xoHwDXvwwxsbCHYEqDrC5WX0zvmp2FyO1+
        gkOdAawhDCb4Ukqln1c7us1YoHpLGws00fUFoEpFhdRgb28lXbfp5BVzUsDDnwCh
        28t6mvwLdpEEo6gvqrYGyIRF5sZjYofOsvsJPpZy/tAdFsZonGrFw6ls2WdkxasC
        dPtxInNry9fHE2RWnpQ9X0pExERdBh7K0pL8x49Z6Nf38OTkZJBYOIY7mfuNKzIu
        +GPOp2/Nr23cNBASQ1pOOCTMUBabxfXShV1RU9B4sF1T4d5EB5vmT7xlQIu2XIVQ
        ==
X-ME-Sender: <xms:GMGjYK0AZm8YXmKNxEpqrbkh2QgwZlf9V9W-xZRuqPsuCLJTMwQzrw>
    <xme:GMGjYNHTewBE0VFSvMvCY2TtHBGE_4ut4Q0dWbZUubEappvr3_8_ls1GIlKBaonQh
    gUcf35Ly2mzJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:GMGjYC5OE-_cJE9y5q1B4jmww8PDf4IxbW3To-fYGIrErxGCS5jfBA>
    <xmx:GMGjYL0JwV4Wgsj8YmNiWNuT6F1W5sooRFxGKy6mfsACQltEsNkTSg>
    <xmx:GMGjYNG3cONNLLc1qjIki9gtGv-KfSSS_m7ghUhS_wQlL8QDiqIz6w>
    <xmx:GcGjYBKnBlv8sjEjjIllqK7bSLavDFBR8_TGvLxxp7iX9xa416Mo_SHEW_I>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 09:28:56 -0400 (EDT)
Date:   Tue, 18 May 2021 15:28:54 +0200
From:   Greg KH <greg@kroah.com>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
Subject: Re: [PATCH v6] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <YKPBFn26BlPJZn0t@kroah.com>
References: <1621341949-26762-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621341949-26762-1-git-send-email-faiyazm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 06:15:49PM +0530, Faiyaz Mohammed wrote:
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> to "one value per file" rule.
> 
> To overcome this issues, move the alloc_calls and free_calls implemeation
> to debugfs.
> 
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
>  include/linux/slub_def.h |   8 ++
>  mm/slab_common.c         |   9 ++
>  mm/slub.c                | 359 ++++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 294 insertions(+), 82 deletions(-)

If this is v6, what happened in v1-5?  That should always be below the
--- line, right?

