Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADD35EB91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 05:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbhDNDxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 23:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhDNDw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:52:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABABC061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:52:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so2342477pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WuM+BaGUNuiUixC5dEfTXZqVl+1vqYpTV8zTf1r96dc=;
        b=DrPgtQvrjPfgRjo21QhMAAagaQr1LUefazxADfNJEjZ+aJPvKfA8z2Q+O6imzvFAMe
         H7op5V15/i8W52VTLu1gxjhW67jaf9nOmsmISIpo2JNoHF4CaIKEtS4p/hiq6J/nDHSL
         DoMxIiv5G549XWQ5N7XDN6AvciWoiB46NnijP+HJMJubofcjK13AaY6g6v7Squ3LXqtk
         9Nr5mxY2B7bMmGzYCFQp0ZRc/2qKczW3BYD1Kn8o+YSz+TPAA1EXmXMYpAYQzkxLsHlv
         9CdKtl9TaQMN6btSmWetPnr9lQjMm9PKgKT5r4GjTwwxb6Irc0csWR3OflbdyqyfLzYF
         J8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WuM+BaGUNuiUixC5dEfTXZqVl+1vqYpTV8zTf1r96dc=;
        b=eW6s3nMbL/vjrVNN4O6xyOLPpPpMBlSiRlucpUnj76KBhiXf2ZesHF6FELNW72po5F
         P+ix4LRg8TVY9GLz5+GlthFQkuk/G95r5NEVi9hXMgGlmhfuBs4/UYTXQ9DA2BgE+BcM
         859iRHDRbhdckIzFhahkNSADtJ2SH035ME53sHJJmq2q5SYQNeFFus6VNrRTPEPtE40i
         UfFxfnQFbDkN1lw6y7gOLq3J56F2YNmFuVuUsbD1+AjWGaTwcoYjXRXjfVIhlcI96xe9
         m7sAMkUTWalG/XIKVrvmGuEs5lS0bvTDRuz31iDe4Qz+28YWOKjhXEaNjpNTsP8416XJ
         l4uw==
X-Gm-Message-State: AOAM532O89T/OWhRoZfsw9nThLhpSZowMJlAGK0rfvir9NRmBnI/IEXR
        1uKgYzoPUjOHtMdwhUDOloB8cQ==
X-Google-Smtp-Source: ABdhPJywZ4E18fDVCmXhLJVB51NirppKni0+fNhFPzV/YR/qlI7pVw+352j61hTBsZbhQ81AtdzbbA==
X-Received: by 2002:a17:902:ed87:b029:eb:a96:7892 with SMTP id e7-20020a170902ed87b02900eb0a967892mr11365626plj.47.1618372354979;
        Tue, 13 Apr 2021 20:52:34 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id l25sm16769568pgu.72.2021.04.13.20.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 20:52:34 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:22:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     wsa@kernel.org, wsa@the-dreams.de, mst@redhat.com,
        linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, jasowang@redhat.com,
        wsa+renesas@sang-engineering.com,
        andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
        arnd@arndb.de, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
        rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
        u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
        yu1.wang@intel.com, shuo.a.liu@intel.com, stefanha@redhat.com
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210414035229.7uqfdcd6dy2ryg3s@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <e93836c3-d444-0b8c-c9df-559de0d5f27e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93836c3-d444-0b8c-c9df-559de0d5f27e@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-04-21, 10:07, Jie Deng wrote:
> Hi maintainers,
> 
> What's the status of this patch based on the review comments you got ?

I was expecting a new version to be honest..

> Is i2c/for-next the right tree to merge it
> ?

It should be.

-- 
viresh
