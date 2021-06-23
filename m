Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABB23B117E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 03:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFWCBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 22:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFWCBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 22:01:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE541C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 18:58:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso375345pjp.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 18:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P5PtrKC9BdXykLLTnlC43FIWRW0aAh6zQskb0Bi37+o=;
        b=MwiYZPgOvt//Exx/SzMRAT93UC6GNbfsWOIwmy2iSYuOdjFaQTl1MUo5O6tXWLVa5W
         C35lr5mEZHzWkGDyQLC4PWJzmldEC1uC5yzR09jZMxzAJh6AyKaR/pk2+C1fKSzgiUdL
         QzFEm1gMtOj3DPTjbxAS4gb0TRtypIgZavZl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P5PtrKC9BdXykLLTnlC43FIWRW0aAh6zQskb0Bi37+o=;
        b=hulR1NK6CsTtSJwp+PYwnWjdn/IZT3eHpqlMyITqJm2H272DkqGmgOSmDat29MiAE8
         5asH46mQ7NExDLuQEl8+fN90Er+skhlCgCsDlL5eorofZuTEbFPh0e0UdlAf8itCzk1C
         o6ArCVpNM7C++iESjMJBqdmsEZ5W9G6uFt/ybyvcP1qwguR7Y8tSCXs/rt5zLrQiLjL5
         rGfH1HJe8UbXIh7sbp9C90VMEx31C+krW43mIASp9Mi3Z+7h5G5uFPmZGpO2M5I4hqLm
         Q1kfjm2ROcdUCPJj01+FqY1uZ5kKMA1DGUfVecblsul3QiP5wYD9OYdxgKZW9svl0NaV
         ylEA==
X-Gm-Message-State: AOAM532nGKRAmBrrGQQOKQ6WD5nZo7I6nJdP2+wPMDm3HpT9mfybG6wt
        oC3pmVjja2BOhwm4dqmJ7IiRGQ==
X-Google-Smtp-Source: ABdhPJxlmlfbS0hvcRkA20u7GDWoT7mCvv2+/4iOghHL/y8nzewuL6/UlJShiqjH2AyxX8SaihTx5A==
X-Received: by 2002:a17:902:b095:b029:118:cfad:c536 with SMTP id p21-20020a170902b095b0290118cfadc536mr25304861plr.79.1624413538355;
        Tue, 22 Jun 2021 18:58:58 -0700 (PDT)
Received: from c8bead504505 ([124.170.38.181])
        by smtp.gmail.com with ESMTPSA id h24sm3429379pjv.27.2021.06.22.18.58.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jun 2021 18:58:57 -0700 (PDT)
Date:   Wed, 23 Jun 2021 01:58:51 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 000/178] 5.12.13-rc1 review
Message-ID: <20210623015847.GA757183@c8bead504505>
References: <20210621154921.212599475@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621154921.212599475@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 06:13:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.13 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Jun 2021 15:48:46 +0000.
> Anything received after that time might be too late.

Tested ok on:
- Intel NUC11 x86_64 (Tiger Lake - TGL)
- Radxa ROCK Pi N10 arm64 (rk3399pro)

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
