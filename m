Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9210A3E8CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhHKJNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbhHKJNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:13:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A57C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:13:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k2so1795838plk.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ZkAU2QHfzdbeB6vZcR6DekWG4U8QzIxN1zOaeYHseo=;
        b=oDomj3rRcyWzJT98WWaMn3iUHVhd213N1K7Dc6cCQNOuPXxWqAQZdSD0fDwhqTUN5H
         bL4VRM/Iq7Wnsd4s6S13jK+Oga0ym2De4dTzSegfF9dfZet2+bbu2ZPOCAdoSEawJ8FA
         UXppbc0qPyrJkus/W8SGWprMiFPmMrprxll6d0dRRhVC3CslE0T9qVutq9EI9huG3Iwn
         EZLXH52csD4G2MXoVd5zYIl9SRzm3VzrvoM4OsXUpBoo/cNdomdEy5OlucKVNj2x0R2J
         /DHNb0L4ubFFusIvvIuglUm9c8BXGcewvgnZTrXsT4nQLY9mvU80q5OyqS4C+dliiQtr
         7XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ZkAU2QHfzdbeB6vZcR6DekWG4U8QzIxN1zOaeYHseo=;
        b=Sl0AlJtiYwTOsJh0hPIo3Ey/nPkKmxRZXvfUZzZV4uInBcOroMRD1aMUBWYkYtVNS5
         qcVWBcGbVBL21qJFvTaBL2U9XvWPPjgv40dSIoP2tgfWV3iCu0l1x0XxjdEmr8h4Ypzs
         IEZK40uUlIZ+KFhLN7Bct0VNmxLkS3cDArxqVTwt6rSc6ZZ2L3IMVQkgO7SPF/UHjLxQ
         PF6IoyDqV47nhIUHfSqrPit2dIwAIWAXoPxGW2X1Xcf74eB1dmTu2J+uTIjE9/v8Ciku
         zcZdVqET5yqRjlQLQ/eTWGPbLzRPF8FPSC5++phWn6xNwmhdueOE1GTBEt0x/IAfuk6I
         abfA==
X-Gm-Message-State: AOAM533GhDTmEuask5yxoLLWdqjQtY+PvdTUUnRUZMxVF7yi4NgUOsgt
        5jbM43PNKVq6MqDDilZS5+0gBQ==
X-Google-Smtp-Source: ABdhPJw6gEf2Fw6iBxua2gL1EBsBW5dHh3H63IoaqHdI9KWyzvZpYGzAm266LjhE7aZjzOuSMwvjGg==
X-Received: by 2002:a62:e914:0:b029:3dd:a1d0:be57 with SMTP id j20-20020a62e9140000b02903dda1d0be57mr2957701pfh.11.1628673204607;
        Wed, 11 Aug 2021 02:13:24 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id mr18sm24660227pjb.39.2021.08.11.02.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 02:13:24 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:43:21 +0530
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
Message-ID: <20210811091321.xtb776q4t6cwyanx@vireshk-i7>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <YRJym+Vn4bbwQzzs@google.com>
 <20210811051859.ihjzhvrnuct2knvy@vireshk-i7>
 <YROMZFHCor3pbhMr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YROMZFHCor3pbhMr@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-08-21, 09:37, Quentin Perret wrote:
> On Wednesday 11 Aug 2021 at 10:48:59 (+0530), Viresh Kumar wrote:
> > I had to use the pm-opp version, since almost everyone was using that.
> > 
> > On the other hand, there isn't a lot of OPP specific stuff in
> > dev_pm_opp_of_register_em(). It just uses dev_pm_opp_get_opp_count(),
> > that's all. This ended up in the OPP core, nothing else. Maybe we can
> > now move it back to the EM core and name it differently ?
> 
> Well it also uses dev_pm_opp_find_freq_ceil() and
> dev_pm_opp_get_voltage(), so not sure how easy it will be to move, but
> if it is possible no objection from me.

What uses these routines ? dev_pm_opp_of_register_em() ? I am not able
to see that at least :(

> Right but the EM is a description of the hardware, so it seemed fair
> to assume this wouldn't change across the lifetime of the OS, similar
> to the DT which we can't reload at run-time. Yes it can be a little odd
> if you load/unload your driver module, but note that you generally can't
> load two completely different drivers on a single system. You'll just
> load the same one again and the hardware hasn't changed in the meantime,
> so the previously loaded EM will still be correct.

Yeah, it will be the same driver but a different version of it, which
may have updated the freq table. For me the EM is attached to the
freq-table, and the freq-table is not available anymore after the
driver is gone.

Anyway, I will leave that for you guys to decide :)

> I hear your argument
> about cpufreq driver development, but the locking involved to allow
> 'just' that is pretty involved, and nobody has complained about this
> specific issue so far, so that didn't seem worth it. If we do have good
> reasons to change the EM at runtime, then yes I think we should do it,
> it just didn't seem like that was the case until now.

-- 
viresh
