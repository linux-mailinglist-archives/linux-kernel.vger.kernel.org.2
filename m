Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1008132A14D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576978AbhCBFfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243377AbhCBDqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:46:04 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2845C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:46:06 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q20so12946161pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lZ9D5nQ78UicwZ05zNOlu/xqak1dEhzdw1oZvwOpVzc=;
        b=HwjgFy0H8CYtyaCnrlXuMDGwjDjwRv9yZvu7+uHKaio+bBddEiURo41nalRCFef/2w
         4QeTMaiR7qZgYBUQoO6zoLuPAqzjMFqAbnKK+C/wXWo845P3qOLiIWHgO/VGGn2TNVfw
         kda5wS9FXhmcPNx4B0Iz5Np9A7s/XHFJ854u45gV+XrKT1G4MU6PaqTLjSJUHA/uYce3
         6KcaaW0vNEIRf5kYP+TWzCL0y59TwrNuQNlEPgeQmi5wk3cjs7oBxZOcSiuOQzQN5Gow
         dHUHe/+Ess7m7xjMGV23v+SpJVDvqZYK/Az4yI3LcvTZyAIuW2fCzWGdOtLZrjhjCiOA
         +TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lZ9D5nQ78UicwZ05zNOlu/xqak1dEhzdw1oZvwOpVzc=;
        b=HSWvvdfsIGuNGayVDEDLg6JVIN28CfH1lLGmCxCbK7nhlgfWm/2Nfs19O9JG1PpIiL
         QbljwLfAkE0loAvK2z8f4II6aDmyQ8WYvOhkLWbJN5q6Tbgmt2fpPg6bAHrXwVRh6LsM
         hKDBqcAtIsj058ItAftrr1vEwDxato3rvHsaLBOWp/FV1U5dtwzyjhE6TqVouY9TiXKc
         YYq0w1oxHzm7aTisE28KefoPpwF7NH8D4k8jwcj5B49n7J6jmU6oG4NRgZHuMjmCPVVR
         qIHcz9wbNfLVg68F9ozp0UokRZrjwoACfrtqyjMkPi83GLAA/NB8DknitQh6Q4teRX2A
         AFDA==
X-Gm-Message-State: AOAM5307lazmmIzdPg5WRCSXobNFGmg5CTjrC4fDtjScIWeEMgD+e2h4
        mr0I8Gj40aZioNiYlDJFaRDqQw==
X-Google-Smtp-Source: ABdhPJzxZSZ5SrS7qXhH7FcGzN7Bjt06r2mQWyGyqU1jpmDGCpiC22JfGV9oIF3ajzkSRvVj7FnrhA==
X-Received: by 2002:a62:b50d:0:b029:1ed:c0d:3778 with SMTP id y13-20020a62b50d0000b02901ed0c0d3778mr1631518pfe.72.1614656766299;
        Mon, 01 Mar 2021 19:46:06 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id f3sm18598942pfe.25.2021.03.01.19.46.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 19:46:05 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:16:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jie Deng <jie.deng@intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        conghui.chen@intel.com, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com,
        Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
        Mike Rapoport <rppt@kernel.org>, loic.poulain@linaro.org,
        Tali Perry <tali.perry1@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        yu1.wang@intel.com, shuo.a.liu@intel.com
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210302034603.4vt5ix5oxjtiilg7@vireshk-i7>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210301115441.a4s5xzwm6d6ohz7f@vireshk-i7>
 <YDzZdc9+6hEvIDS1@smile.fi.intel.com>
 <YDzZocYCA8UC1FCW@smile.fi.intel.com>
 <CAK8P3a1g_UXKVnDfDEfj=swqgUNb+bu+1O7mDMfCt55o0w0jxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1g_UXKVnDfDEfj=swqgUNb+bu+1O7mDMfCt55o0w0jxw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-21, 16:46, Arnd Bergmann wrote:
> But the driver does not support this at all: the sglist always has three
> members as Viresh says: outhdr, msgbuf and inhdr. It then uses a
> bounce buffer for the actual data transfer, and this always goes either
> one way or the other.

Yes and if the driver doesn't support the specification fully then it
should say so in a comment at least and also fail in case someone
tries a full duplex transfer..

-- 
viresh
