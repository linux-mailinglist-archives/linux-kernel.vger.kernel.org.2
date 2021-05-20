Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631E538B92A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhETVs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhETVst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:48:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB242C06138A
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:47:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 29so1682351pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lOx27d/uQrYPhm7QiQJwj4x5kxMnupMSsRgPCNPISSc=;
        b=K+wnXlxkKExIB+dsJciBk1qJ+zoKVSslpY+BkPFt6lW3vte33+HcRhxVC1kW8xAMVl
         RCcQxK09DLGlKEq+E98YUTNeiwFNkEj3WXKk4oBu2ysVdrB4S7uE/lDylTGwMvxszuSR
         Uy6lcVAlNOgUNZEbemM42L9r6v0fjnsMsa0C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lOx27d/uQrYPhm7QiQJwj4x5kxMnupMSsRgPCNPISSc=;
        b=HqmRxaRMk04r/vwKFdNjWNtLL7826HEAAdcT+CDLEwNfwMyrHQXPzNMNQakv6IWF13
         fzDC1TDzOqjoIgzUtc40TxVntQq9zZFXtTCFTTpRH8iqlTqFKt1vasoL7+btUdT4QUkx
         rruGOp8RV+PYIg2QL5hDEoJSbC85o6PGTWesxkocq0WHJAdDHvtBZe9fEFzyT5trZ9HH
         CDJ+3bNdtNjoBRrRNGttods6hMtGzjEnaLN+x/xEI6vbgYOUQd98fISEIWx2RgtqIyur
         pXLh+qMGeBnjROQkYlA+x54K2GBsGdatFh6llvKxB4Sv7jWx7N8cvBj/1EvCIoxz+AV+
         7syw==
X-Gm-Message-State: AOAM530D+2k+BL0hxqUZ+bPBcbsgM7s9T2ZfFenRmO/kz3VCbzofGXc9
        O3zrMYe2kTckIQOy6hKhuLoAeA==
X-Google-Smtp-Source: ABdhPJwbDEieZ89f2F0RJsteaqfH5xrpppw981BvgNItfnpYzEQccXS0HeqYmTqb93wP0w0N1Sc3pw==
X-Received: by 2002:a05:6a00:882:b029:24b:afda:acfa with SMTP id q2-20020a056a000882b029024bafdaacfamr6845969pfj.72.1621547245437;
        Thu, 20 May 2021 14:47:25 -0700 (PDT)
Received: from 8b61f9077464 (110-175-118-133.tpgi.com.au. [110.175.118.133])
        by smtp.gmail.com with ESMTPSA id a10sm2754586pfg.173.2021.05.20.14.47.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 May 2021 14:47:25 -0700 (PDT)
Date:   Thu, 20 May 2021 21:47:17 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 00/45] 5.12.6-rc1 review
Message-ID: <20210520214713.GA21@8b61f9077464>
References: <20210520092053.516042993@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520092053.516042993@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:21:48AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 May 2021 09:20:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On Tiger Lake x86_64 kernel:
- tested ok.

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
-- 
Rudi
