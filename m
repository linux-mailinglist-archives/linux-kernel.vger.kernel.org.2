Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5060D3597F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhDIIfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhDIIe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:34:59 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C842C061760;
        Fri,  9 Apr 2021 01:34:46 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id l19so201168ilk.13;
        Fri, 09 Apr 2021 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCwJI5ffEAzMKRWH7+S+TuRytYmua5VwVLYnvYOAOL8=;
        b=U0Q9jEHKICx2Sug1O6lx9JD4azkZzxDi0jJwfbBegQO/515gYCJZ26NIh7ka8qKuqY
         K/XPPFAMPMn6vm9Y4dB8CtVLpAncreQLESMRlKjajFTrcDaAEWl42wO/8NQaRWBzO9u+
         HtxC74LzWdcWeE1IsRYFWY8tzK6ge+ELzCx9fSu6vwqktM4OrnkznkmOohU2hDSjeMQ8
         jApYiteBXa28UetICZLEs1QacK6MN24OH8ujDBmKDThzRUp5oTLvKmpDZPKGvQ8T117M
         gu9xl9SDpG5skzkrX/unJP6GCjO8ZLO64vHPke5hxjlOlwkSHXJBKOsdtsGzRuIh5Zar
         1Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCwJI5ffEAzMKRWH7+S+TuRytYmua5VwVLYnvYOAOL8=;
        b=nrnQhLuqQFiQfy7OMaHUv43Gn83eQbaMMv5znaEYTSpFHLokE8CJtU1mS6jYDWPf1b
         zGJKs0Vx6sbBU4mM2xOK5fCIPtrRLzITvQjQV4X1mVkcxRQxXGs2SwM896Sr0VX2RquE
         D2qVs8wNAsVFvjDeUEoNkO/wMsZadFkqhZ+MXA8aMV3frJ7wAtlqp3vyvST/zSXHfC0S
         xP+kcAt9LzWkLDjgynarFmfvbLyExOqOU5719nmJ4GkqjEFrfQj2bROMcZcG8daSgepH
         9K85JPqBLumDlGECgpQiwfNZAUA+m+jb9Zpc9cYS2wxGuRhyR4bVlEOEuqjR5hFLM50R
         hMAQ==
X-Gm-Message-State: AOAM532+twGrQx733aQjvnEV8DYsrKxcCO5iZQGBBTC68ApXS8XAsFmv
        CsHRGljazUtIFdavSAz6tVdSCBCsoSaancQPQhSQAhzcyUM=
X-Google-Smtp-Source: ABdhPJy8Go9eGKnxjqs+H5oCYvcs+FPgMqWv4m1tQrwU/f3ose04FlweQI1nD/xWG1T8+OZ7INEY9e3s45xNKoTSP9s=
X-Received: by 2002:a92:dd12:: with SMTP id n18mr10698284ilm.109.1617957285922;
 Fri, 09 Apr 2021 01:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210409082957.2909213-1-weiyongjun1@huawei.com>
In-Reply-To: <20210409082957.2909213-1-weiyongjun1@huawei.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 9 Apr 2021 10:34:34 +0200
Message-ID: <CAHpGcMJdBD9XDJvzy2_9EuKaduSewd0p+39B1przV7UW3rtouA@mail.gmail.com>
Subject: Re: [PATCH -next] gfs2: use kmem_cache_free() instead of kfree()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Fr., 9. Apr. 2021 um 10:20 Uhr schrieb Wei Yongjun <weiyongjun1@huawei.com>:
> memory allocated by kmem_cache_alloc() should be freed using
> kmem_cache_free(), not kfree().

thanks for the patch, that's true. This patch has turned out to have
other problems as well, so we've pulled it and Bob is currently
investigating.

Andreas
