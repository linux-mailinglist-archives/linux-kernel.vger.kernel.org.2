Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F3E3E8E70
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhHKKVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbhHKKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:21:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C879C0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 03:12:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m36-20020a05600c3b24b02902e67543e17aso3489351wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p5hWIHd43oZmZdmAe/Tgt2mQU61JUn32MeibY7PUSWQ=;
        b=E1WNTy4ZBaOXroPhEU16oAmoIb7TxHWc5vaO1clqHr5vgR4jZVhcU1nElSRfIMPsDQ
         /UNOosQE4tYr7JXG8D4EA2OmU8SOMOQrNCnAt/Fx6jWiTS1HPx41awL3B63/DdxaulvK
         pBj+l5XS/40ASUIdZ1z6PMtZuL0oH3Omu8WJwUou1ygTjkWHk/T3NESdtkuxBjHPL/+W
         AE6icFv17yVdjd4ED/b/bFgmOu6PEZfSTfE4At7H0YPs9lT47OGMCBH5MDq+58w7Yl0T
         tGTnUYD+DKPtEOCog6ax5XbBjg8gc/Dq7gZ+3PxTeyD9UGnnul7NgA2wP2jpLi/Vnn1b
         N4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p5hWIHd43oZmZdmAe/Tgt2mQU61JUn32MeibY7PUSWQ=;
        b=C+JZ1YOgeAKL90Htfl+LcAVWDjVriEmX7zH+xo3YD/3rrIuzME3MdVWErY6yaLYtk9
         fHRYAz9NcdVnf1/pzHCYmlrKHGHmMyf4np1CGbU0yL5xA1ne0ih2CFpcVo5X/vCjvAXA
         dz1UIW2jUuCljmOJnTazdwlXGc+e5mpqmrZCe1OKufJBDAZUPmHEOhFkV7hLPU2OkQFu
         5vxkJEsKtYHTYjIrq9yB2sCbSPQ2TcMGEXSYAWgQbjie+UOCgJg0esPHooKnWqOPWbJS
         9dnRPZHg1gRznnxD8ePIYZRsIn5O75cMwVRdTrB56nZVuKIg81W22MAjiJ4lOdX482fZ
         nA1A==
X-Gm-Message-State: AOAM533R1RrzwfIXGPjdVZOBlyDemIY8XjqUHYqJgKHEIubXdNu855lk
        732IMh61qt4LnQ8Ca8HAU0VTmw==
X-Google-Smtp-Source: ABdhPJxx/8GKFZfYfxHB5UKxM22ERPUJVsGXmqlPMwwmbrYcLQCJo+fx5ibR5G/YN51tKO70Jg3Ugw==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr26867549wmc.26.1628676773827;
        Wed, 11 Aug 2021 03:12:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:43fd:e634:73d9:e10e])
        by smtp.gmail.com with ESMTPSA id n10sm8172810wmq.3.2021.08.11.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 03:12:53 -0700 (PDT)
Date:   Wed, 11 Aug 2021 11:12:47 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Message-ID: <YROin5WudmmEPard@google.com>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <YRJym+Vn4bbwQzzs@google.com>
 <20210811051859.ihjzhvrnuct2knvy@vireshk-i7>
 <20210811053406.jqwextgtnxhgsjd2@vireshk-i7>
 <YROc95YKA1Y/TfYI@google.com>
 <20210811095311.e6wnma2ubkqdtuic@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811095311.e6wnma2ubkqdtuic@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 Aug 2021 at 15:23:11 (+0530), Viresh Kumar wrote:
> On 11-08-21, 10:48, Quentin Perret wrote:
> > I think this should work, but perhaps will be a bit tricky for cpufreq
> > driver developers as they need to have a pretty good understanding of
> > the stack to know that they should do the registration from here and not
> > ->init() for instance. Suggested alternative: we introduce a ->register_em()
> > callback to cpufreq_driver, and turn dev_pm_opp_of_register_em() into a
> > valid handler for this callback. This should 'document' things a bit
> > better, avoid some of the problems your other series tried to achieve, and
> > allow us to call the EM registration in exactly the right place from
> > cpufreq core. On the plus side, we could easily make this work for e.g.
> > the SCMI driver which would only need to provide its own version of
> > ->register_em().
> > 
> > Thoughts?
> 
> I had exactly the same thing in mind, but was thinking of two
> callbacks, to register and unregister. But yeah, we aren't going to
> register for now at least :)

Ack, we probably want both once we unregister things.

> I wasn't sure if that should be done or not, since we also have
> ready() callback. So was reluctant to suggest it earlier. But that can
> work well as well.

I think using the ready() callback can work just fine as long as we
document clearly it is important to register the EM from there and not
anywhere else. The dedicated em_register() callback makes that a bit
clearer and should avoid a bit of boilerplate in the driver, but it's
not a big deal really, so I'm happy either way ;)
