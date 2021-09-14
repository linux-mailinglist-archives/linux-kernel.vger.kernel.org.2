Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087A340AB70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhINKKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhINKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:10:12 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FB8C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:08:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w8so12217930pgf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8xfW5n5lGYHVjHYEbwTg272CCVO8ZvflsK9NBrpkrL8=;
        b=SnNwn7UQ8QhZcGeDD0myjSpJ7z0VOD8lcXL+A4oGbNlWV0dzX/atBgXx/r4Glvvkbs
         fYSR6NP4moNEEX24Ry62rkXiJuDpLyPiD6gOqzoNKwpCRh+piuvmZYBKc51uOLIuT1cG
         S9vPVbBmBY2XvAB2chVphNaTjYMF2pMMmgYrs9DGMHcnGOu5AnU602gPxeMmXBjMCk1H
         NdZHpRk17CLU7mQ+1Eq2AfLAYdS7wq+S8xpQ7cQgppsLpTNRLF4Mo5ZZJewjZDLvu/tA
         EbIO+i2m4o/IO9ArY6gXKXstApZ/+bcDLL34I/uavVWnYCTh67rNUCOWez8oGU4fjvPi
         hhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8xfW5n5lGYHVjHYEbwTg272CCVO8ZvflsK9NBrpkrL8=;
        b=izOlCjJ5kz8dvwuHUUdIY0ZjuHaavJvva7fzQpep/ZPWD9I3gbM/N2vih8GT5OPcdm
         iZEA2pcmbiOP7UY2nzNbt8wuzc8LaG9jDr5s+wMfoHNV3mvf3lq2mE334mQcyT9EZjeq
         tTR8pnH5uFPrT+Hte0N4Xpkjy58K94zHojsdHt+F5Z+Kf1Agz6BWxgB/etWIUogFZDtB
         gC9r8O8n0S+UPzCMmvHR4JPhqjOhW8sMLOlns36C/9EJZQp05SYcuI9WSzu2ouNi4HJQ
         OwBSZxZ4YU3Q4A7XwqyqjLKmPI2YANknnZWwhcOc6ZfojMCyDEDKjbDAPqsPHpOYiIYT
         SPJw==
X-Gm-Message-State: AOAM532urCeB1S2HGm3vZ2cW/GUkiAeTU9JtYfOHWSJAXr9Ci+lwcarT
        eQjlbuPi6aEDMPSs0CYvsaWDpw==
X-Google-Smtp-Source: ABdhPJyxxLqEAQTWjjzZxP89GKxIT19IHBKBS3aAHfouriHBRsZzMZaVmcusJD7X03+K1uKBye267g==
X-Received: by 2002:a63:7045:: with SMTP id a5mr14635597pgn.404.1631614132722;
        Tue, 14 Sep 2021 03:08:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id g9sm8012220pfh.13.2021.09.14.03.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 03:08:52 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:08:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] coresight: Update comments for removing
 cs_etm_find_snapshot()
Message-ID: <20210914100847.GD1538480@leoy-ThinkPad-X240s>
References: <20210912125748.2816606-1-leo.yan@linaro.org>
 <20210912125748.2816606-3-leo.yan@linaro.org>
 <f6700a4d-80e1-cd53-232c-0e26f7179d1b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6700a4d-80e1-cd53-232c-0e26f7179d1b@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:27:26AM +0100, Suzuki Kuruppassery Poulose wrote:

[...]

> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > index d23c7690f29a..ce14eb83925c 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > @@ -1573,9 +1573,8 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
> >   	/*
> >   	 * In snapshot mode we simply increment the head by the number of byte
> > -	 * that were written.  User space function  cs_etm_find_snapshot() will
> > -	 * figure out how many bytes to get from the AUX buffer based on the
> > -	 * position of the head.
> > +	 * that were written.  User space will figure out how many bytes to get
> > +	 * from the AUX buffer based on the position of the head.
> >   	 */
> >   	if (etr_perf->snapshot)
> >   		handle->head += size;
> > 
> 
> 
> Thanks for the revised patch, I have queued both the patches.

Cool, and thanks Suzuki!
