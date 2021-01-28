Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF34306C12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhA1EO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhA1EO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:14:29 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2574AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 20:13:49 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w18so3155168pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 20:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LisdbD4Ba76pA5egW3L7/zal0NtfLwHPGPSR7nUteJ4=;
        b=NhelqO3FSllB1ZGzD+4mgqb8hcO6n5QTZY1Hk2lDuTPIrpYhPHo+ungQGEoL5TPSHA
         ASkjgCpClFpzzWVCHtxcUVaG3HLft9FzTCZzoFYrkVnXcVgViREoauYDVoX3oiGmktv7
         2XA6RmGgkxFoaRkYNfskT/1y6mNo3AsqfeUmj4huE/Sxam9tRA4AJt/xQsUd8Y2EpjLG
         svG0vRzTR4HNwXyMlIEnk6xljfNHANS/lPh6Im+UgEDziR3L8hQ1IT6Kazawy3/8KOY0
         GVcpBYm5KX9DI2E+7AlRID4scasSxyGSCpvWctxwgC0EoqJwcuRe4ALlgdr3DBk91+EY
         9I+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LisdbD4Ba76pA5egW3L7/zal0NtfLwHPGPSR7nUteJ4=;
        b=A3UUswe6zI9pnjWisAUeH8PzJwIjXbvqlKoevx7ILr1znazydL3qkYDwfQHjQdgcSD
         WH9cgy5TaeR/J8yAk35fauT7WTrG71ctKBHPCDm34+Qr7k22PzJXoWynVR0J6ild7DE3
         nolvtjuMgo32FtCyOuBkh+exuIMXXXLyvCYj9jLPVy6nT4FCAWp5S4zQx4lNuFQhxe3Q
         relc0+65vrqpzvh5nPBYuvQFd0DcfIAkFLOJ2xv0TxhsA+8lJCm9f+MF7ue2KoCD1KwU
         4ExFcTIioYfW+7vszs6XgXdhNLKJ/hDA1nfaEGf6WboX0C3hbZSdLi1S57tGZw9/XrN4
         dIEQ==
X-Gm-Message-State: AOAM5303CkuxzayKqGGCr6ZOWvEueX9mNPNcK/K2ZPTfE2rZu07hNIa4
        iyAHZ77CZdgttUrT+Mvn8z0hIw==
X-Google-Smtp-Source: ABdhPJyp65IBYlRQiZdjjs4emrE5t00vqMcKFZDmZ6t5q8StvIgW2MTv6Vku3RY1sP6wUEbb7y4+pg==
X-Received: by 2002:a63:3747:: with SMTP id g7mr14432990pgn.376.1611807228569;
        Wed, 27 Jan 2021 20:13:48 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y6sm3767914pfn.123.2021.01.27.20.13.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 20:13:47 -0800 (PST)
Date:   Thu, 28 Jan 2021 09:43:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20210128041342.owkjl4voodw4dcmf@vireshk-i7>
References: <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
 <20200127061118.5bxei6nghowlmf53@vireshk-i7>
 <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org>
 <20200130042126.ahkik6ffb5vnzdim@vireshk-i7>
 <CAJMQK-gmO-tLZkRRxRdgU9eyfo95omw_RnffFVdhv2A6_9T-nQ@mail.gmail.com>
 <20210118073430.a6lr3ynkd2duv34l@vireshk-i7>
 <CAJMQK-j6EYjU1z_SUY4MFEJO6qTtOH7mQ_QWj2iUMewBKAghng@mail.gmail.com>
 <20210127115415.7zjpf6uaybwswno3@vireshk-i7>
 <CAJMQK-hgeOv9XDasmmWGguxyC62SCsSoX5_enEb46whE8_Emew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-hgeOv9XDasmmWGguxyC62SCsSoX5_enEb46whE8_Emew@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-21, 22:40, Hsin-Yi Wang wrote:
> Hi Viresh,
> 
> I tested this patch with devfreq passive governor[1] and mt8183
> cci[2]. It's also working as expected.

I hope I can add your Tested-by for the patch then, right ?

> [1] https://patchwork.kernel.org/project/linux-pm/cover/20190724014222.110767-1-saravanak@google.com/
> (patch 2,4,5)
> [2] https://patchwork.kernel.org/project/linux-mediatek/cover/1594348284-14199-1-git-send-email-andrew-sh.cheng@mediatek.com/
> 
> In my testing case, required_opp_table is not genpd case (mt8183 cci
> is not genpd), so I remove the following constraint. Does that make
> sense to you?
> 
> @@ -377,13 +377,6 @@ static void lazy_link_required_opp_table(struct
> opp_table *new_table)
>         struct dev_pm_opp *opp;
>         int i, ret;
> 
> -       /*
> -        * We only support genpd's OPPs in the "required-opps" for now,
> -        * as we don't know much about other cases.
> -        */
> -       if (!new_table->is_genpd)
> -               return;
> -
>         mutex_lock(&opp_table_lock);

We will perhaps need more changes than that, but those should be done
separately when you try to add a user for the same.

-- 
viresh
