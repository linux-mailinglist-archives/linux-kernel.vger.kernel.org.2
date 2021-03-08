Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D2D330637
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 04:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhCHDB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 22:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232549AbhCHDBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615172477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+f97h3r5kgP8oOoYOWrOrmtPiqRhgTUDjoTBiNYsJB4=;
        b=T+SlHWVRrbEUzufnhGoPa/bXDDmvdZRob5bEN2ZBtYzCzzNis3VUQt00WDnCqptKozaapZ
        DbSe4qrSOtfLgCWT7QO9AWa1z5tUcPCvm78Pi2DxtktZ+FXunwT65I3HLyDTqzPk+DOPnf
        C3pRJxosvBTyaixp2OgOYpUBARnIuLk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-utep3L__NxamO-mBPzv7YA-1; Sun, 07 Mar 2021 22:01:15 -0500
X-MC-Unique: utep3L__NxamO-mBPzv7YA-1
Received: by mail-pf1-f199.google.com with SMTP id u68so405008pfb.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 19:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+f97h3r5kgP8oOoYOWrOrmtPiqRhgTUDjoTBiNYsJB4=;
        b=cVez2w41TmcsfLfvQfoUVxSX+Hw27lg1DKM/SVaHAIWjTm8/YJ5ilzcEoHBTwCw6eo
         fAdDrRYGuNIrKoIhPqYBgtXmOPrCThZ3/S9ZhA6mJHdfgWYnJ298JF/IZ99Wc9jPTrGM
         DoEPIhcKVAKvOPBPTbscJFJdA41QZESOOFnLcQkzBWGjjNJ6dEECO4Bdw8LqTCvljJWa
         KZli3GLDbf2haA/NQUrEipnncS1Hn5kI5aMEVagYhm/uNQHanFuePEtqIbizp3EYonH2
         8SIvDhYr6f6M1UK3cSivMaIpWsnatS7JTfib/+sU64NDjLm83MOMjGIrtft0q9QgNvIU
         ISpQ==
X-Gm-Message-State: AOAM530Dd6cF6v9Tukyidx5vBYXTjfR/FwdGtRczI4Ibc/FaVZdzkLEe
        TZLQ6eGdOjA+Z5sRrkjBSb8aattVFSPRFezidvGDaLCwbECcqUfkpt1xJTcyZguh99HmTB/ChLY
        r3JPLPhBa+I1e1w7r/vsBEWxu
X-Received: by 2002:a63:205c:: with SMTP id r28mr19264918pgm.183.1615172474080;
        Sun, 07 Mar 2021 19:01:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAaiHHxTjy153gHbNVOfTRCbVDaW1O2b4ItT4xkhJj/ka2w84dyg/Wp5VsMoYm+fNoQXKHTQ==
X-Received: by 2002:a63:205c:: with SMTP id r28mr19264903pgm.183.1615172473806;
        Sun, 07 Mar 2021 19:01:13 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b10sm8264561pgm.76.2021.03.07.19.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 19:01:13 -0800 (PST)
Date:   Mon, 8 Mar 2021 11:01:01 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        Martin DEVERA <devik@eaxlabs.cz>
Subject: Re: [PATCH v2] erofs: fix bio->bi_max_vecs behavior change
Message-ID: <20210308030101.GB3537842@xiangao.remote.csb>
References: <20210306033109.28466-1-hsiangkao@aol.com>
 <20210306040438.8084-1-hsiangkao@aol.com>
 <6525c63c-a6e2-8c39-6c9a-1ca9b54632d8@huawei.com>
 <20210308023650.GA3537842@xiangao.remote.csb>
 <7a96c4f3-128b-6248-b25c-a838ef16a4e5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a96c4f3-128b-6248-b25c-a838ef16a4e5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 10:52:19AM +0800, Chao Yu wrote:
> On 2021/3/8 10:36, Gao Xiang wrote:
> > Hi Chao,
> > 
> > On Mon, Mar 08, 2021 at 09:29:30AM +0800, Chao Yu wrote:
> > > On 2021/3/6 12:04, Gao Xiang wrote:
> > > > From: Gao Xiang <hsiangkao@redhat.com>
> > > > 
> > > > Martin reported an issue that directory read could be hung on the
> > > > latest -rc kernel with some certain image. The root cause is that
> > > > commit baa2c7c97153 ("block: set .bi_max_vecs as actual allocated
> > > > vector number") changes .bi_max_vecs behavior. bio->bi_max_vecs
> > > > is set as actual allocated vector number rather than the requested
> > > > number now.
> > > > 
> > > > Let's avoid using .bi_max_vecs completely instead.
> > > > 
> > > > Reported-by: Martin DEVERA <devik@eaxlabs.cz>
> > > > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > > 
> > > Looks good to me, btw, it needs to Cc stable mailing list?
> > > 
> > > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > > 
> > 
> > Thanks for your review. <= 5.11 kernels are not impacted.
> > For now, this only impacts 5.12-rc due to a bio behavior
> > change (see commit baa2c7c97153). So personally I think
> > just leave as it is is fine.
> 
> Okay, so that's fine if you send pull request before 5.12 formal release. ;)

Yeah, it's an urgent commit and have very negative impact.
I pushed out -fixes branch just now. After leaving in linux-next
for days, will upstream it then asap... :-(

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > Thanks,
> > > 
> > 
> > .
> > 
> 

