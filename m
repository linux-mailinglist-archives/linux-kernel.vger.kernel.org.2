Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808DF3DEB96
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhHCLOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhHCLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:14:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A71C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 04:13:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e5so23264412pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 04:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Gr5ftWgiJSvDbRnCS2TnO6KMHVq0WjNOvJJwrjZOEM=;
        b=lqQi1yG6Vr4L7esOiXxd+NMKstSaPTYUs+NWc2DDUO/qh0Nynt3+4fi6xMyBDyK9Iv
         anVQU0Ije/Z6IUjGsBE0THWIV/95xDUcVKB+GYRAi4UtzYe91lhpHr+NODVBBE5W7T2K
         RtBzb5P7eRk7QGwUnPsENJBhDwr9ZkFpnjk/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Gr5ftWgiJSvDbRnCS2TnO6KMHVq0WjNOvJJwrjZOEM=;
        b=qOFj/ZF8mkdz+i/qMvkLmSXCHs/xyn11KDWAYje9P6ozpU+ggyXoYbUasdDQ+AIHqP
         sGQ5cXZBIL2QGy3Chy+X2053RFiFMKxn5H0zPgMW0hX2kfp/pz6skAB8hcIAHMfF7Jwh
         p/LU79B/lRxsKUxe9lyWwQBFm5kDTvI3P9lxPQ5qdmK9+nLh8tzISmyPGm0KnCaz0i50
         zQU+JvI+WvW/lE/q6b2LqpDVYYU+6Jd9NeK+KmBb97v+AV6NeNoqHTeDlMksj7679qnL
         QHCUQHNXPZBtwCg1RojOQ9FvLleE6p1YKnSG6jY27wjWG//owAXEbX+xlmjO7aJyRniV
         tzeg==
X-Gm-Message-State: AOAM533u+SRXIMWLpPAsvHu5OffK1YqDhxDGzw76CCVEPqO3t1zrfIBa
        DTGRCZ/BKh1vFRuiKXrOhLGnbA==
X-Google-Smtp-Source: ABdhPJwAWLXABmqiaVIE3+NQJJCX+CvS8zFkgVKT89mB7cwEtiXiEW4AxxmAvoF7UzZsnlkjzeb/+Q==
X-Received: by 2002:a17:90a:1f8a:: with SMTP id x10mr21949725pja.167.1627989235469;
        Tue, 03 Aug 2021 04:13:55 -0700 (PDT)
Received: from a4d683274626 (194-193-55-226.tpgi.com.au. [194.193.55.226])
        by smtp.gmail.com with ESMTPSA id y62sm1947476pfy.183.2021.08.03.04.13.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Aug 2021 04:13:55 -0700 (PDT)
Date:   Tue, 3 Aug 2021 21:13:48 +1000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.10 00/67] 5.10.56-rc1 review
Message-ID: <20210803111344.GA914752@a4d683274626>
References: <20210802134339.023067817@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802134339.023067817@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 03:44:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.56 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Run tested ok on:
- Tiger Lake x86_64
- Radxa ROCK Pi N10 (rk3399pro)

In addition build tested on:
- Allwinner H3
- Allwinner H6
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
-- 
Rudi
