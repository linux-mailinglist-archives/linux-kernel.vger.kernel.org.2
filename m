Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA933E8D96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhHKJxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbhHKJxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:53:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0C3C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:53:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso3862745pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yN5JGDsQRbqNYGictWkZk65RsQg7qzCYVO5IdGVoaBw=;
        b=jT8c08ChLL2mhNYjWrg2WH961eloGTK7WLroKUhk1+HDo/YM/IS+TatyC2cp810l+O
         0u+8hzUlKaym9ME0OwoavnqJUGcIpn88I9Idf/kYyhFAPk5xIPMh48wpBIaOaPTqX5MT
         msjuGgIKwByuZEB0CZDR5/aAcaTDR9tglGCbejFiC2kY8d111jY2EPLGmKXc4WUWKR0t
         ysxJyCokcS3h6WUhFWZ0rWGAEJhcRcycvyjSkN5g/Lmv3DabzrTvvVprW5nF4pR4KPqc
         UF9FYUExy1pzZr79hfcb9pGPg00cGCsbPNciGT1qL5RE0uAZl2NDYcH5zFa0dU2bnHxL
         nVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yN5JGDsQRbqNYGictWkZk65RsQg7qzCYVO5IdGVoaBw=;
        b=Cfn4MEgLMdW0zOZQS/3jlBUmvJsvwwS9jkiPPshFtvZ2kgpn8ctV4DN21iiGA5PXy1
         JsQrx+BJd4Oi5ZtlqO+9NOcnHBQJb79nZrg852B78YzdqNv1Vmsv9w2f97YKgVWtvRv6
         pMADXJId+lMATMDoo5lL1bHYolqrwpNuu9tOoeRvV7QCe6Z4tNyQHDVXoM3jRHqnz0p3
         3VfG7Knb0hhDcsF3bbcGyl3z0K+1TYdE9ZYgfHUaWlO+Y6evk7S16znyC7Qk4zwfI98Z
         ypbn8QD2kaDEY82Wwr6+10PAffiXVwsAfUdUeHMoolnzJwmV3ldgpLAfTfaDEN7KO7Ts
         UDNw==
X-Gm-Message-State: AOAM532nBtzArQRrfieqt07uPdnZSjnCYWpPbhMlLrmXzjoUufToxF7W
        szk8bgVUMfeB8oZBU5gBN0lSsQ==
X-Google-Smtp-Source: ABdhPJyq2OUPvDwt1HcJwEVMav+d2aFK2NfnnSvBGT0D8jiXAM3hY/HQnrCiTJv6msGhlEIvfUuJ9A==
X-Received: by 2002:a63:4710:: with SMTP id u16mr307872pga.232.1628675594245;
        Wed, 11 Aug 2021 02:53:14 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id y23sm29928446pgf.38.2021.08.11.02.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 02:53:13 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:23:11 +0530
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
Message-ID: <20210811095311.e6wnma2ubkqdtuic@vireshk-i7>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <YRJym+Vn4bbwQzzs@google.com>
 <20210811051859.ihjzhvrnuct2knvy@vireshk-i7>
 <20210811053406.jqwextgtnxhgsjd2@vireshk-i7>
 <YROc95YKA1Y/TfYI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YROc95YKA1Y/TfYI@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-08-21, 10:48, Quentin Perret wrote:
> I think this should work, but perhaps will be a bit tricky for cpufreq
> driver developers as they need to have a pretty good understanding of
> the stack to know that they should do the registration from here and not
> ->init() for instance. Suggested alternative: we introduce a ->register_em()
> callback to cpufreq_driver, and turn dev_pm_opp_of_register_em() into a
> valid handler for this callback. This should 'document' things a bit
> better, avoid some of the problems your other series tried to achieve, and
> allow us to call the EM registration in exactly the right place from
> cpufreq core. On the plus side, we could easily make this work for e.g.
> the SCMI driver which would only need to provide its own version of
> ->register_em().
> 
> Thoughts?

I had exactly the same thing in mind, but was thinking of two
callbacks, to register and unregister. But yeah, we aren't going to
register for now at least :)

I wasn't sure if that should be done or not, since we also have
ready() callback. So was reluctant to suggest it earlier. But that can
work well as well.

-- 
viresh
