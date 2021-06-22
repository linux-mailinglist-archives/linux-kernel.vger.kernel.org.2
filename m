Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008FC3AFE50
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFVHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:50:59 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:60092 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFVHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:50:56 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 8913F20D03
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:48:39 +0900 (JST)
Received: by mail-pj1-f70.google.com with SMTP id o11-20020a17090a420bb029016eed2aa304so11155267pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K2/PCim2TgrlrpWsUBXXxC0v9+AUPcQxYb8PsC1cUMs=;
        b=D9JYU+3Uf0wodhTMlGJRiepHuXUY3G2/UsSEh7oL+GwOY/j6xzYckUTdmEPFJ//9MC
         M7w89NIFut6igTCAjnL7BY1MM1iE4hiF78e3d8KrgmxYo9B1ckN0q0oJedzBt+z2SWdR
         D4U2qo00gXiWlBjvH76qv1QwFDZfWs6R7VxkdB6sd4uwYGAA99Sc4jnv5XU/Zhi7AkoX
         x27cdutEebnKP3O2mmmcyt9Vf+A0S/6Aj/Ah1I3CkN6Bww6TXYGFCoWrQtB6+URMG9G+
         NqeVcKFWo5Iuf5y/oZ1noRP76r5FvJjYFQA+s1rt9uBEWn2z46CQSxKGME/TZOWSqYbH
         3/Eg==
X-Gm-Message-State: AOAM5327zKf2phYtyxmTqG/+XnjErligg4pV8VFSrV6yhJQ18romVG0A
        gumxcVV3X5bTcPFDxLznUJevcrVUJ8+70U08Brf2axSzRVwy67PB+Od0jsJYtck7rdKzhomU3sg
        Q3w5NI7+8+MkymXf2Z3wAl9o4pw==
X-Received: by 2002:a17:90a:4812:: with SMTP id a18mr2670004pjh.40.1624348118681;
        Tue, 22 Jun 2021 00:48:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfgoRVVp6JmSP2/8H6vwINnTVMm7MriWlKRzk6O1jIIF/9JeL5ZPHTpSyHUlltCbzyiAQDkQ==
X-Received: by 2002:a17:90a:4812:: with SMTP id a18mr2669988pjh.40.1624348118458;
        Tue, 22 Jun 2021 00:48:38 -0700 (PDT)
Received: from pc-0115 (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id n12sm7972919pfu.5.2021.06.22.00.48.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 00:48:37 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1lvb98-002Mj2-Pa; Tue, 22 Jun 2021 16:48:34 +0900
Date:   Tue, 22 Jun 2021 16:48:24 +0900
From:   'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        'Jianxiong Gao' <jxgao@google.com>,
        'Christoph Hellwig' <hch@lst.de>,
        'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Horia =?utf-8?Q?Geant=C4=83'?= <horia.geanta@nxp.com>,
        linux-kernel@vger.kernel.org, 'Lukas Hartmann' <lukas@mntmn.com>,
        'Aymen Sghaier' <aymen.sghaier@nxp.com>,
        'Herbert Xu' <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        'Marc Orr' <marcorr@google.com>,
        'Erdem Aktas' <erdemaktas@google.com>,
        'Peter Gonda' <pgonda@google.com>,
        'Bumyong Lee' <bumyong.lee@samsung.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YNGVyOyD+CAMmPos@atmark-techno.com>
References: <YMqW+/gQvM+uWUTw@fedora>
 <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de>
 <YMrfWBLsJxCRhX5U@atmark-techno.com>
 <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
 <CGME20210621020328epcas2p207e9fa2df119730ceb993543621437d8@epcas2p2.samsung.com>
 <YM/zWyZlk1bzHWgI@atmark-techno.com>
 <2038148563.21624247281621.JavaMail.epsvc@epcpadp4>
 <YNASOEGsDxhFC8qJ@atmark-techno.com>
 <YNCROxI328u7IKdQ@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNCROxI328u7IKdQ@fedora>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Rzeszutek Wilk wrote on Mon, Jun 21, 2021 at 09:16:43AM -0400:
> The beaty of 'devel' and 'linux-next' is that they can be reshuffled and
> mangled. I pushed them original patch from Bumyong there and will let
> it sit for a day and then create a stable branch and give it to Linus.

Thanks, that should be good.

Do you want me to send a follow-up patch with the two extra checks
(tlb_addr & (IO_TLB_SIZE -1)) > swiotlb_align_offset(dev, orig_addr)
tlb_offset < alloc_size

or are we certain this can't ever happen?
(I didn't see any hit in dmesg when I ran with these, but my opinion is
better safe than sorry...)


> Then I need to expand the test-regression bucket so that this does not
> happen again. Dominique, how easy would it be to purchase one of those
> devices?

My company is making such a device, but it's not on the market yet
(was planned for august, with some delay in approvisionning it'll
probably be a bit late), and would mean buying from Japan so I'm not
sure how convenient that would be...

These are originally NXP devices so I assume Horia would have better
suggestions, if you would?


> I was originally thinking to create a crypto device in QEMU to simulate
> this but that may take longer to write than just getting the real thing.
> 
> Or I could create some fake devices with weird offsets and write a driver
> for it to exercise this.. like this one I had done some time ago that
> needs some brushing off.

Just a fake device with fake offsets as a test is probably good enough,
ideally would need to exerce both failures we've seen (offset in
dma_sync_single_for_device like caam does and in the original mapping (I
assume?) like the NVMe driver does), but that sounds possible :)


Thanks again!
-- 
Dominique
