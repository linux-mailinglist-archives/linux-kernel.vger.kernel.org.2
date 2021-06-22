Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2A63B0CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhFVS0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhFVS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:26:03 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80EBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:23:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e33so17793353pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yXA4rHiWjIH9o9XmIG32r03SHImL59Pk8RIZgBFL7d0=;
        b=Ym2SAYocAlxz13BRcPfGv8BL5ruxEwMIEahKmrLIa951qfCVLKr9ib9qEyEluwR76s
         arIDjvRk31dZudsnPP/G0ZxPBVpkMpoJrAqqO0lds4WJufGy4ktUWggJUY+VHBaryxhi
         n+ChYlaDh99MnXKFn+3MinQfk0F5WEpJbIWzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yXA4rHiWjIH9o9XmIG32r03SHImL59Pk8RIZgBFL7d0=;
        b=PITx2P/55GMKkE7MFKGWBQZVITEiLUdv7r8IIUq5bIeH76bdwqVaKgHasjNxBXKUwU
         vDl1d/CDyE6YDfG6UjtJNYDQBOjMtddMQgr8IK9mOfsVieXdF361nJORwuqkOURNihQX
         Dz2/rtKUoJzsoTqpXrNxzJExCxDqpSfawe5ntcTHj56tLYUt5mANGiGnLWyzHNcugJUG
         9uJWDriUqam6yWVdY5GV+rh4VMireNyw9ZkVHa4hcHrZ2/QphKuwlviHqUqnXYAWmayR
         IbkiNuj5YI1jZYsH8D/EnYEv4LsV6FGbUXI0XXZ4uB1GyjQC4ZWDdstu60Cc/uZT/VaH
         3enQ==
X-Gm-Message-State: AOAM531Y3dSUAfOOSfDFMrPBt8mB4I3nPr7DAgKGRabvBKtSLQZNW+LH
        DvKRKN+IoEjrvE4Ou2oa/CPI1g==
X-Google-Smtp-Source: ABdhPJyAKRVykKU/KgvZGJQDqYy26+5sRFeqHMwGvD8r2zLxNa5qXN+gVPDw1p3/7DsMBYg0ZSOh3w==
X-Received: by 2002:a05:6a00:1acf:b029:305:d2e4:1687 with SMTP id f15-20020a056a001acfb0290305d2e41687mr2653921pfv.50.1624386226378;
        Tue, 22 Jun 2021 11:23:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:dc21:8b6f:f8cd:9070])
        by smtp.gmail.com with UTF8SMTPSA id o1sm40173pfk.152.2021.06.22.11.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:23:46 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:23:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        chanwoo@kernel.org, cwchoi00@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] PM / devfreq: Export devfreq_get_freq_ragne symbol
 within devfreq
Message-ID: <YNIqsJLqWNSg2oxM@google.com>
References: <20210617060546.26933-1-cw00.choi@samsung.com>
 <CGME20210617054647epcas1p265359058d489661e09d8d48d4937ca7b@epcas1p2.samsung.com>
 <20210617060546.26933-3-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617060546.26933-3-cw00.choi@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 03:05:44PM +0900, Chanwoo Choi wrote:

> Subject: PM / devfreq: Export devfreq_get_freq_ragne symbol within devfreq

nit: s/ragne/range/

>
> In order to get frequency range within devfreq governors,
> export devfreq_get_freq_ragne symbol within devfreq.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
