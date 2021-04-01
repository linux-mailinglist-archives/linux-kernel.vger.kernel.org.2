Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F73512ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhDAJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhDAJ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:59:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ED5C06178A;
        Thu,  1 Apr 2021 02:59:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j3so1249052edp.11;
        Thu, 01 Apr 2021 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ixwMGt+i4qBo3otDAwTk2qAaNfme5ZNpdNGswOC3A/o=;
        b=h/2V0lM8gKKQlwrhDIuyQrhrVcaNK1VEw/l3zRi4R8PglE74meqwhoaVNcA14GND3Z
         cTopICmP+VeUNff46fUntSS/O0RHpeelt8tnwuiYpmZoVoCnhDQwUH95QoWahY0nBG5R
         yKW8M8yHM1sdMlAz26EXMK5hthuaAHSLbKVahcRMKVGeEbJL+w6vnGDMBJOWpTAjqi9D
         GXUIY767Ke0JhrAE4bQxehC3xXDMxryAzWvNeuGah+BaYM6hjaUYCil0lkMJWeRsX+Q6
         /7eWcLh4TGpgduvZ6XOOCtYvetyx9hWOzU6xIY7NIWWqjvDaBrGyAnzd6B0UXc6x78E7
         kEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ixwMGt+i4qBo3otDAwTk2qAaNfme5ZNpdNGswOC3A/o=;
        b=CCi1QFPe/khUmSPV9hnN35W6O6HOHW8QCR6BJeZ64LY9kwXX5ZZNjyGxkGAFNz0c1K
         1pplAoBD3qdWMazNPGhGzMCK9KlnCh0Y0BKCrQhW4093IdzxN/G4dA+0N+Pl+Ibsb/Qy
         YCsvZ0wtNq7l6uoNScZi9C2XPZuAeo/c8e6bHiXe6KSfpkIjfTd45oV//10wj2pSz1aX
         4hQ9LyCxSOkf8WUIYQNIaqSAfQOHLckkIXhAn6o0XixKGlGEgjUQluWY3UZ/C1xICS+P
         +GOtBqaUeqDEQMpbpILScLJqNuSxno/6vaw7RK+dadcKqT9VgVipYi4xDL5U98FlJguy
         vqlA==
X-Gm-Message-State: AOAM531nruH/neuglWVYG13abti4ZbOXu/Q/p9giNRl+04NNRUMNOgp2
        ISK7vsS++an+QUKhzpbqROZFKYk9XAo=
X-Google-Smtp-Source: ABdhPJyVUjTkMOC2oqFm3Tr+/tJ1w/ISknqRyHsdLj4ydM6sAnJ9oMQ1Fb2PTJCihMud+D9YSpvLIg==
X-Received: by 2002:a05:6402:42d1:: with SMTP id i17mr8547229edc.131.1617271150902;
        Thu, 01 Apr 2021 02:59:10 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id h17sm3144993eds.26.2021.04.01.02.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:59:10 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:59:08 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm: dts: owl-s500-roseapplepi: Add ATC2603C PMIC
Message-ID: <20210401095908.GC1993499@BV030612LT>
References: <2e0a2931ae3757f016948e7c78e8e54afa325ae0.1615538629.git.cristian.ciocaltea@gmail.com>
 <20210401054300.GD14052@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401054300.GD14052@work>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:13:00AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 12, 2021 at 11:49:27AM +0200, Cristian Ciocaltea wrote:
> > Add device tree node for ATC2603C PMIC and remove the 'fixed-3.1V'
> > dummy regulator used for the uSD supply.
> > 
> > Additionally, add 'SYSPWR' fixed regulator and provide cpu0 supply.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Applied to for-next after fixing the patch subject as below:
> 
> "ARM: dts: owl-s500-roseapplepi: Add ATC2603C PMIC"

I encountered commits with both "ARM: dts:" and "arm: dts:" prefixes,
so I wasn't sure if there is a preferred format.

I have just counted the no. of occurrences in git log for both variants
and it seems the former is indeed more common, so I will make sure to
use "ARM: ..." from now on.

Thanks for noticing this,
Cristi

> Thanks,
> Mani

[...]
