Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC513878E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242943AbhERMhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbhERMhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:37:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BCEC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:35:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x188so7282337pfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wr+XrZcgNvYZ/U0me03bl9jtBfK6Woy1Ij8oTw3EO0g=;
        b=ARIwUE74pUXhnhhlQOttFgP9tdpaJUCMpBNxyl5HdMep+F/30nRhwV5B6LzclXo3T2
         JS9XWJ+ajr7EzEV2gTFSu4ZfNfe0K0vUUC2ShACXHVd2FNhbQ2FDKx7Dqr59hM+hJn6o
         CfYjnaMKWNZodcZLS8xIAbW1FzZ6djxGixmzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wr+XrZcgNvYZ/U0me03bl9jtBfK6Woy1Ij8oTw3EO0g=;
        b=AEfF9K8OX2Anvz4ii1d8fQmmcfYYLmPboF2EIvmTiIQEU8e90OFCXyWMmAF6hc1UBp
         GR80jR0d91XdPJt4rdKfYRfCjwvdzdx6tslOo5hsIRGbzSoL+tWJ7AO7DSegI5TeFvy6
         pkdFohM/VdRg+EaeN4bnELN3pqwD4aIvzzBqHAt2oBE1ZESDhNUFhHLteHGAcLltV9r7
         RuLaqc6mzA/D0ya8BE/h/ybgsgRKT7kojLHy5h+TP+Wze29maI39erqbM48PJe1RDbBC
         tzPn6WKiX5aljx9AeCmoA0a+dcYvDoPKg6QznuohkddBq2f64ovqYwwZxmCZ7cFQDJcL
         gp3g==
X-Gm-Message-State: AOAM531P3l0Zsqli1hbUsVMmKHDg8Q+LY5yK1AN24SYknB45c9gQ9d+F
        UDuyBeoSafis/X1wjJzdEIdhtA==
X-Google-Smtp-Source: ABdhPJxqu3KL4ufBV19+rzKyqR+ASuEjcpx7KVwWQApeiRNkgDPs7sBo+gV8fIGdpvLvRqXCK71dEA==
X-Received: by 2002:a62:3344:0:b029:28c:6f0f:cb90 with SMTP id z65-20020a6233440000b029028c6f0fcb90mr4974112pfz.58.1621341344639;
        Tue, 18 May 2021 05:35:44 -0700 (PDT)
Received: from ec3d6f83b95b (110-175-118-133.tpgi.com.au. [110.175.118.133])
        by smtp.gmail.com with ESMTPSA id a2sm159637pfv.156.2021.05.18.05.35.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 May 2021 05:35:44 -0700 (PDT)
Date:   Tue, 18 May 2021 12:35:37 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 000/363] 5.12.5-rc1 review
Message-ID: <20210518123532.GA102@ec3d6f83b95b>
References: <20210517140302.508966430@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517140302.508966430@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 03:57:46PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.5 release.
> There are 363 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 May 2021 14:02:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On Tiger Lake x86_64 kernel:
- regression on:
  [PATCH 5.12 081/363] net: bridge: propagate error code and extack from
  br_mc_disabled_update
- remaining tests ok.

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
-- 
Rudi
