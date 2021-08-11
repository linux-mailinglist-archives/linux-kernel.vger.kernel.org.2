Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2C3E8D55
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhHKJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbhHKJgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:36:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD4C0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:36:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so3656015pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J02656YR2Fe+Hj72RiSigwAaGmAyuf7/C51n8U6jOdY=;
        b=wxXAi1TAzSCXJ4QCDlmvMQ90aBtvPmzeF2vdBsrRB91gYbhARcpyzZfqnHoV4G2xNg
         VC24e1WDKeK4nD1bFXlgcjRNkZCt2bEojXrNOOtiMgnVDLZSA489i6baRAfgRRe5oIwo
         k29UcaiaX1PjrV5lKsYOfvc8V6bWqq3Ey8mg7DOycJQ9elkfHIjitqfBM7RdeNY4X6RQ
         KqqiU13RUPRjNFXs6tG5Yh95/J38x6x5phrwCwYSFSmjuuClGEd84rHeij+/Kyszpz2B
         g4lbXalMWU282IPf6r4BarnwBCb45ZcWtA43eB2xFUwvyAlttMZbSvBTXlhirVuOsHV9
         KMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J02656YR2Fe+Hj72RiSigwAaGmAyuf7/C51n8U6jOdY=;
        b=F2TDrSwcy8WCn7x4Lut6bP+4/QVW7zoX6jhCpD0SNXCBU1ZprHjsx5Gyzz6we3oscV
         tWxWcA3Ktc4fSILEbtqZabkoiF/5UUGnpd+UdtlkM7BMfFtqXz1iVZkchU2M5oi/K/05
         ZLIl7ApwwtNnr5cUZraZEP5kQxk8p8r/vXJh4ik2hAAmPFrCDcwd4nJJDkxwT0YNdlrj
         cZ/GRJyFrlWd/QS//m0/q1AOOl8ZDofpkcNeweOXBI6bZwPbz4FUj/ezWB9q1gCIHs4L
         7dNfuKjJnWxsZ3R9D9MVtH+w/Za8JaoAbsoX+Vkcn7kxRAMsLL0WE8NTAjcFV6lXcfl+
         4eOA==
X-Gm-Message-State: AOAM531/YgMU3et0sHuEKvh1gSUbLAs87f6fDpAD51e9wTs0VpRCS30z
        iIrt6i7Kgfbkp5rUDHb11QPQgQ==
X-Google-Smtp-Source: ABdhPJys+C5eNI9Pw3BvNOuNX3w2Mr6lTrvVQYtWv/q628SqQBf/F7vEkJNqmZGhccHk0WzM588r5g==
X-Received: by 2002:a17:90a:4a88:: with SMTP id f8mr9875619pjh.226.1628674581006;
        Wed, 11 Aug 2021 02:36:21 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id 26sm32218359pgx.72.2021.08.11.02.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 02:36:20 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:06:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/8] cpufreq: Auto-register with energy model
Message-ID: <20210811093618.7ncznvblttk6hjlt@vireshk-i7>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <YRJym+Vn4bbwQzzs@google.com>
 <20210811051859.ihjzhvrnuct2knvy@vireshk-i7>
 <YROMZFHCor3pbhMr@google.com>
 <20210811091321.xtb776q4t6cwyanx@vireshk-i7>
 <YROZkbMEMAeXMt1W@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YROZkbMEMAeXMt1W@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-08-21, 10:34, Quentin Perret wrote:
> Yep, it's not immediately obvious, but see how it sets the struct
> em_data_callback to point at _get_power() where the actual energy
> calculation is done. So strictly speaking _get_power() is what uses
> these routines, but it goes in hand with dev_pm_opp_of_register_em() so
> I guess the same reasoning applies.

My bad.

-- 
viresh
