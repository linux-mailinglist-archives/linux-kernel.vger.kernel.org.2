Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64349325C80
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 05:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhBZEWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 23:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBZEWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:22:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4BFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 20:21:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id t5so6087160pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 20:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yT5v0bJoOqV8v/vtReh7u5jHnFH2I4PrE3kiKoF6nh8=;
        b=TCo5ef0l9pGX/3+phqBt2AmFexoawm5IrMZBba930eJsMgBquLxMDCMmV2HIamMu3Z
         x4PEOyaUJRiZ6/r0XCjVF09eh+ekY7y/IB26sxxwUOb0xPRACJ9P8uEPQmrcs+fp5KGG
         uH0ehUBJSpA8sEswHgD//45ybEZapp/2ZJCkRhF2MUTpTbuukZ8xl81BhYEzMylywc1s
         g/8skPTW+I2bz+YFiFAlGygkyRFlvGxt4uMpAKCDeMPcRF7wrvl51EsoOAHF55srlO5t
         PBklESnRyCydLXsY17gQCtyPshpPYEUvfifjdlo72Igw1chJiuMub3mQOGvReQRvXBYi
         YvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yT5v0bJoOqV8v/vtReh7u5jHnFH2I4PrE3kiKoF6nh8=;
        b=FjaBwiqzz1ojd7R/SAgcrcYAawN6ppYgWSSZ3WxRZQbrli1sl0mufhNYSU7bzkSNqI
         ZEKvQd3lVyByz3w+9EIK1R1nIiKsw2Nyh7odKlhokc4OO16JSyhjJD6A+z8xTdMT2GOB
         G5eYhNqeuAH/d5c2IFH3Wn9v5AQCBbMELoc2YSaAnU7a33IShVUZGSZT/F6Gc/GuRAYt
         8K5EmktzLjgU1W0j0WohWBSAN6T8Ma3yWy8hkkNXjdhvIpS2JTMn0XwBwhyHIXO8X7MD
         ZZaWWB9xCPTO7nA+DhSA/9N18ztuDPd3z2AG5lUUqlGofsEOBe6S8LGd7ilUHaTFUahC
         C3QA==
X-Gm-Message-State: AOAM533vUaNzWKjptJFX5W3txFv1aDHEcTMeP2CnMNGOuiYDiWd/XmNf
        0Q1umIuDlp/sYtWbsajasGHJZA==
X-Google-Smtp-Source: ABdhPJy6rpH04MW45+IkH5QmDPPkYhMH7nMGGmDYCvUJMjRoL5FAIYqfO+UzNeKxaccOIDQj1SRyYg==
X-Received: by 2002:a17:90a:7bce:: with SMTP id d14mr1427400pjl.139.1614313289749;
        Thu, 25 Feb 2021 20:21:29 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id p19sm7361194pjo.7.2021.02.25.20.21.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 20:21:28 -0800 (PST)
Date:   Fri, 26 Feb 2021 09:51:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        wsa+renesas@sang-engineering.com, wsa@kernel.org,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        jdelvare@suse.de, Sergey.Semin@baikalelectronics.ru,
        krzk@kernel.org, rppt@kernel.org, loic.poulain@linaro.org,
        tali.perry1@gmail.com, bjorn.andersson@linaro.org,
        shuo.a.liu@intel.com, conghui.chen@intel.com, yu1.wang@intel.com,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v4] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210226042126.rix5gjxqrazb6sao@vireshk-i7>
References: <7c5e44c534b3fd07b855af22d8d4b78bc44cd7a4.1602465440.git.jie.deng@intel.com>
 <20210225072114.iwmtaexl3dkihlba@vireshk-i7>
 <a580de35-787e-4024-3c80-0a101b1a6d3b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a580de35-787e-4024-3c80-0a101b1a6d3b@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-02-21, 10:46, Jie Deng wrote:
> This v4 was the old version before the specification was acked by the virtio
> tc.
> 
> Following is the latest specification.
> 
> https://raw.githubusercontent.com/oasis-tcs/virtio-spec/master/virtio-i2c.tex
> 
> I will send the v5 since the host/guest ABI changes.

Okay, now it makes some sense :)

I am interested in this stuff, if possible please keep me Cc'd for following
versions, thanks.

-- 
viresh
