Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1F33AE21B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 06:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhFUERT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 00:17:19 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:38854 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhFUERR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 00:17:17 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 402B720D02
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 13:15:03 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id j6-20020a170902da86b029012092e5da71so2889236plx.15
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 21:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0cNPlfrR3mHT9UabyMptbK269y7CX6VJikwsTnrJUAE=;
        b=lN1iSpOp9YHOzLnRrtu7KI2Kpe+u6LMD7KBFq61naP9+4b4FfdfoCgRSBNRZ0paX89
         UGjjCJ31quUz592ie7eTEHHDQLhyGICZGElgf14SZeLTU/n5frdJmbp75Iw0SmM3zIBR
         ozkWwS1NrF+kWuVZpWzYSQKfsvZHIyl/b6WCX++S0vEEUYDc96PcSIoBPjo6dwBMpzY/
         /xj1I4R52qUwa5BdLzObgtgXbhwLs3mh4PS6oGEbOM14KjA5zsXWW2zFPl00NPgSkCA7
         tuFjnp+w8F4M2pmUXT3ul2RqdB9HuMzRCwlT5xWrF3BXmEYg1OKFss9denvsKxTzqWiu
         gysg==
X-Gm-Message-State: AOAM5332iofQveSuRdew0sYIUY5W5YXSJBo5n/u6XWfHY+s+U0wxJkxD
        z0dafTr5IUXWyPKcPf+6vmMSUiyB+O/pBkpwmYMDu/TpqkTHwhL0vBSi9pioXV6WHfHndOEDh99
        NSYJXyXyRWe3XUt2yyVwNn30EiA==
X-Received: by 2002:a63:db43:: with SMTP id x3mr21772897pgi.383.1624248902411;
        Sun, 20 Jun 2021 21:15:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwABzUQPm9SUU6k+/MVNgSXR0PAbNKc3mtW3pmxgxtF5tFRcVYbJO4+Phv3wJkMa6wTECEmiQ==
X-Received: by 2002:a63:db43:: with SMTP id x3mr21772865pgi.383.1624248902163;
        Sun, 20 Jun 2021 21:15:02 -0700 (PDT)
Received: from pc-0115 (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id t3sm1594918pfl.44.2021.06.20.21.15.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 21:15:01 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1lvBKs-001Ecg-KK; Mon, 21 Jun 2021 13:14:58 +0900
Date:   Mon, 21 Jun 2021 13:14:48 +0900
From:   'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     'Jianxiong Gao' <jxgao@google.com>,
        'Christoph Hellwig' <hch@lst.de>,
        'Konrad Rzeszutek Wilk' <konrad@darnok.org>,
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
Message-ID: <YNASOEGsDxhFC8qJ@atmark-techno.com>
References: <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
 <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora>
 <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de>
 <YMrfWBLsJxCRhX5U@atmark-techno.com>
 <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
 <CGME20210621020328epcas2p207e9fa2df119730ceb993543621437d8@epcas2p2.samsung.com>
 <YM/zWyZlk1bzHWgI@atmark-techno.com>
 <2038148563.21624247281621.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2038148563.21624247281621.JavaMail.epsvc@epcpadp4>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chanho Park wrote on Mon, Jun 21, 2021 at 11:55:22AM +0900:
> Sure. No problem. But, the patch was already stacked on Konrad's tree
> and linux-next as well.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/commit/?h=devel/for-linus-5.14&id=33d1641f38f0c327bc3e5c21de585c77a6512bc6 

That patch is slightly different, it's a rewrite Konrad did that mixes
in Linus' suggestion[1], which breaks things for the NVMe usecase
Jianxiong Gao has.

[1] offset = (tlb_addr - mem->start) & (IO_TLB_SIZE - 1)


Konrad is aware so I think it shouldn't be submitted :)

-- 
Dominique
