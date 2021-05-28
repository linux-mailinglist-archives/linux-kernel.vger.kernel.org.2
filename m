Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93093394266
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhE1MQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbhE1MQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:16:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C83C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:15:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso2436912pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7A2wb+GJtAcwJVhvUxTTGI+RPfXeOHTxXrDmiJRyIfg=;
        b=bI09wOqTzyiKSNYGvKhJkhj8N97H/RJzy42xrvR/np/CCEYHvflOOHDI0IMEyTQ2Ee
         RMQstwlyHsmvu4/OEksu8xUeJqgposcWOcb+QpwLZsOM6QTgSGiXgsGkO2bxJj2AMypi
         5URoUQlX+kykRQbKyW3tRGxqQOQZgASW+O8cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7A2wb+GJtAcwJVhvUxTTGI+RPfXeOHTxXrDmiJRyIfg=;
        b=jMKxV3yA+/WGi8UgLkouD+uqFfcvsiJFeq0qkKEBpWxYv4txDUjTzWmAh5s6UyliDV
         YZS79ves4ILTSSa/3WDUcU1ykoBSikt1Uts17McjrYp+oNd15Vp4jlh+1fy2pKyDTOhu
         OXGoLyVnMqT6n5kWPvsI/pOk0ZMD2NkaSa+l7e2rbifMGuFFMZwXBcvsh+n08wtduegw
         8ZNLloTEUy+32tHpkB0W2Ift2FSfuewdiF3CWR6qqZ7Hr35Fbd8WM70pV61wn6i1Nl+o
         whzlC747HwIAukYVfYJ03jGJv8082G7CviQGQ1/37dX0ht0N7UJxG/6AZopgkTZq89tq
         s9Xw==
X-Gm-Message-State: AOAM531F9ChsgWAXyAdM2a9uzHDfJxtN//5sssNVjNjDd1EHGt0AymOy
        TxU7RoKcftE/9Kf7qQJtjVDcAg==
X-Google-Smtp-Source: ABdhPJyotZBvrP2UQ1Quch2hWrs+3Djniga8slIktR33JXVxc8MQ/Rygxugq6o0pxqh39/MqCxwlTQ==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr4209606pjj.174.1622204112187;
        Fri, 28 May 2021 05:15:12 -0700 (PDT)
Received: from c120b2e857b3 ([124.170.34.40])
        by smtp.gmail.com with ESMTPSA id x19sm4417395pfp.153.2021.05.28.05.15.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 May 2021 05:15:11 -0700 (PDT)
Date:   Fri, 28 May 2021 12:15:04 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 0/7] 5.12.8-rc1 review
Message-ID: <20210528121500.GA23@c120b2e857b3>
References: <20210527151139.241267495@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527151139.241267495@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 05:13:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.8 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 May 2021 15:11:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested ok on:
- Tiger Lake x86_64
- Radxa ROCK Pi N10 (rk3399pro)

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
-- 
Rudi
