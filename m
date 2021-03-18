Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5563433FFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhCRGhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhCRGhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:37:12 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E16C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:37:12 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id n79so1014407qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9KK3pAd1KRV0ESCKYhHZQ3UsogiNm22NnlLa5ysW8Fk=;
        b=Bml1qeMGnM436VljGcsX17E687Um5S+FY/d+TZjF0gr8yg6Keka5wOo/q3Bm7zHn9a
         z8M6dVTBrrfYp+VXF1p/E2o9KrDmidizedBRjoa04Q0OP/jszlGVdgHFowkfmWV0iAVk
         mzvzFNtvh0AY4rHqfheXdjgrERQFdRpwaTkVc8YePrUt82GK1DEVYxSlsiCH5f7N4VMQ
         sN7P/jZlp7XnCfRd1dJpRsfHcCTewusqNBzO/tq2F6l58A3HU18U/BIplhqWRtynumQf
         m0IblVT+6Omd1LRRa5lxSNAQVHe6bQv/G+UjnRjnpmXKDHGTnpsHdy5i1fqtHkazyz1R
         6Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9KK3pAd1KRV0ESCKYhHZQ3UsogiNm22NnlLa5ysW8Fk=;
        b=kMmyZI2ohwm/lSTq2+oJ44oO+rf56kskTlJa6btHyOJCRCwVBdMh1jqrHqb0h7ETcI
         LTa3ako21fFv8/ifFJYCUBraexzsY77z9TorwjvO7D9LRzDWUogDb8Hl/WeCVdnzl4mO
         niXAiYixvYTRmKELPjaEOt6KNGf+ynF5qyj+RXBcgqal1AlyvN+WQjGxw3s26xtwdvZI
         lQnJUrb/6Cba6eJhjjRLf+qh5l6y940/L6rWOz6pZZfCsPtmss5xmPFoOBIeJRY0GA16
         GZQo1ahmZkrD3bjnLKb2HQsTJOdBYMRWtb3XWcLzNzgyJq05Bii2dij6Yg6Vqu7ghiLN
         M4ig==
X-Gm-Message-State: AOAM5323TJ1UqRtOJtm4mjbP3vPBw4ifkj31kkkYKPD3JLkuBGYOE+wX
        77q5wvdLjcPoRLmHMEHAiFQ=
X-Google-Smtp-Source: ABdhPJwVjQ7EwYzte6Gsa3X6h5JwWMXPc9ghLQyC/ES0GeJvRQIJtSynbd2qUDa6dh/5XaOWwBMufA==
X-Received: by 2002:ae9:f818:: with SMTP id x24mr2896505qkh.101.1616049431145;
        Wed, 17 Mar 2021 23:37:11 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g7sm828004qti.20.2021.03.17.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 23:37:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id E6E4027C0054;
        Thu, 18 Mar 2021 02:37:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Mar 2021 02:37:09 -0400
X-ME-Sender: <xms:FPVSYKPDExYmgatVrcUd2tsoRvkoYyihVZSPmyY_cD0R7K48B2Lucg>
    <xme:FPVSYI_aaCSLyivuzbk7T_iRzpiTNKJ9svQleRpFINExF830Nau5BLHelLLa3JUz2
    1JO2ZuNqDZkL6CHxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefhedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:FPVSYBThNSo4_qLhocpxToZyNKuEi96H5fniEzO3OOU67jvZpxQYbg>
    <xmx:FPVSYKs5fHxBRU8hAtmat1xzv1Ur0Kfe7NzwYL-BTPibu2jEhls1xw>
    <xmx:FPVSYCf0m0xLWADJ4uKXB0o2Wrdw19A5k0lo7f_I71iXqi1Bd0YDfA>
    <xmx:FfVSYKRX1TMGsGIMyR7nkp160dlyLOrlebTrwlcsLxFdlGVn8NaxZuHuj2o>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E08F24005A;
        Thu, 18 Mar 2021 02:37:08 -0400 (EDT)
Date:   Thu, 18 Mar 2021 14:36:50 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 3/4] locking/ww_mutex: Treat ww_mutex_lock() like a
 trylock
Message-ID: <YFL1Ag8MrP6wCZjy@boqun-archlinux>
References: <20210316153119.13802-1-longman@redhat.com>
 <20210316153119.13802-4-longman@redhat.com>
 <YFK5yBIOTiCdFLNm@boqun-archlinux>
 <64af1d7b-6720-0ac1-4a55-bb0acb642c6f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64af1d7b-6720-0ac1-4a55-bb0acb642c6f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:54:17PM -0400, Waiman Long wrote:
> On 3/17/21 10:24 PM, Boqun Feng wrote:
> > Hi Waiman,
> > 
> > Just a question out of curiosity: how does this problem hide so long?
> > ;-) Because IIUC, both locktorture and ww_mutex_lock have been there for
> > a while, so why didn't we spot this earlier?
> > 
> > I ask just to make sure we don't introduce the problem because of some
> > subtle problems in lock(dep).
> > 
> You have to explicitly specify ww_mutex in the locktorture module parameter
> to run the test. ww_mutex is usually not the intended target of testing as
> there aren't that many places that use it. Even if someone run it, it
> probably is not on a debug kernel.
> 
> Our QA people try to run locktorture on ww_mutex and discover that.
> 

Got it. Thanks ;-)

Regards,
Boqun

> Cheers,
> Longman
> 
