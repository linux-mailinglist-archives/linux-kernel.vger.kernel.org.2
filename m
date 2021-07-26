Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC903D5226
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhGZDYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 23:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhGZDYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:24:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB800C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:05:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gs8so923296ejc.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIvcSyU1E65bR7w1DDg8slGET/s8Q+m7sc5AZf8NFiE=;
        b=hMUCP2c9a3KgKSQMGqbSls3L6icE6DQGge9ygXLIKD6TRuRMyExvyHjwxw0zKcC9T8
         nIRCN687oSlbROKVwvlrRTnF5QE4Zqpr3ZHO7ugRFTWJW6BlSRMOnpyLdS61LYBkYHnM
         N2/1CvH+wigM0xKkoQBTL0QsgmHN+4GbsEGNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIvcSyU1E65bR7w1DDg8slGET/s8Q+m7sc5AZf8NFiE=;
        b=GRN2GIxolEho1g2uVXR0fEktgfpe+W2LWL2Hul++lw2UDdkxGMLGs+VsD5DyPSQa7H
         v147298W5cB7AtQVsjeZbqgfFaR5LL2Owghrm97Zro+ubCLgfvE8V0Uofb7lwx2rGmF/
         vewKnon/4o6PCic589wIOarkArsgb8JYHhdlVqBETVhm+4EMmFXgaKtekwqhDmGMFhtw
         ZgXojyzCD4BP5BS1suK6rFk056ORRvs+OGWYD0pzw1q4bZWgYt5Mo2c2wanhP65cdrnU
         mViFF3e/Wdu4wV6XJ037FUpmGznVekKobqjb0rVxzHg4RjFMwwuNfwf2PodS7skZKBxr
         moIA==
X-Gm-Message-State: AOAM530NrY78XXWh5IAzaErOGMXG4DDGZH3/FEuCQXgHUEBDVR9/yrWA
        MyC46NQaWkk7ic/L5XGVDrc34Oa4Bd07vA==
X-Google-Smtp-Source: ABdhPJwKhy81aWATaJU3lma7a8eikBadTHRna0v2W8FK6XX5vo6kr4vfW2Dm+Dbt9F9rHLWP9J/1tg==
X-Received: by 2002:a17:906:718c:: with SMTP id h12mr14994415ejk.6.1627272306303;
        Sun, 25 Jul 2021 21:05:06 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id de19sm3821348edb.6.2021.07.25.21.05.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 21:05:05 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id n12so5853380wrr.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:05:05 -0700 (PDT)
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr16953638wrs.192.1627272305067;
 Sun, 25 Jul 2021 21:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210709092027.1050834-1-senozhatsky@chromium.org>
 <20210709092027.1050834-9-senozhatsky@chromium.org> <3c80786a-7422-3736-7261-8605260eb99f@collabora.com>
 <YP4zHRh+jHJGbNHz@google.com>
In-Reply-To: <YP4zHRh+jHJGbNHz@google.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 26 Jul 2021 13:04:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D6hSoLJaBMdV-fpzn43Y6qRULR4ckejrJp_89Qpe6Xnw@mail.gmail.com>
Message-ID: <CAAFQd5D6hSoLJaBMdV-fpzn43Y6qRULR4ckejrJp_89Qpe6Xnw@mail.gmail.com>
Subject: Re: [PATCHv3 8/8] videobuf2: handle non-contiguous DMA allocations
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:59 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (21/07/22 19:26), Dafna Hirschfeld wrote:
> > Also, the 'cookie' cb returns buf->dma_addr which is not initialized for
> > the noncontiguous api. So it is not clear how drivers should use the new api.
> > Many drivers call vb2_dma_contig_plane_dma_addr which returns the cookie.
>
> Hmm, that's a good find. Is ->dma_addr the same as what we have in
> sgt.sgl->dma_address for non-contig?

Yes. As per [1]:

"The return sg_table is guaranteed to have 1 single DMA mapped segment
as indicated by sgt->nents, but it might have multiple CPU side
segments as indicated by sgt->orig_nents."

[1] https://www.kernel.org/doc/html/latest/core-api/dma-api.html#part-ii-non-coherent-dma-allocations
