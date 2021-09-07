Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D823402F63
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbhIGUHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhIGUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:07:48 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8535CC061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:06:41 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id a20so9640ilq.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gk7sw5Z2cUyG4Jy93qJQP2ZmL94RuzZS4lGEc0ni2lU=;
        b=XI8sg94HdOFl6qDaf2FQ3ZAByy2Mzq/BBHJHujdGhYTtW+M2uZUow72xaZm/LNcprx
         mCyphBV+J6WyM3+lOe9KsLi00VuOQD1HgSUTMSKNvkaQNoLaQFGNWRH+A/eVHbVwDhPq
         TvtJc2ye6e4ewtzcpr6PXSozJi63CDUXsLziU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gk7sw5Z2cUyG4Jy93qJQP2ZmL94RuzZS4lGEc0ni2lU=;
        b=uTslpSpXgyRWBc6PgxukDhr31oz7EhGNyztG87XyP5llet1+rqo0L8C8cNU5DUYx+c
         hkDFDJ1+jy5+W1c0F5JyB2sP8KqsL4CH2XAC1bJDjcLtzF8UFHQQWICVDWLxPb3/xq/z
         chYcMpyiXOvOYkQnk7a90uAHsPC4hr/2gHrOw4bFBDihYedNd5mDbjYCYGhXH6WN1s/S
         vkIRNbghUiBKyD0aXoPY4S04CG2/cAx8hey1ZJND7IOtndoV6qHN/oUpeffroLEV9bEB
         RDHovlEqdZ8EoXqBGsBosdOP0DLioekMyGAxiKkTzi+1+7Mv04TomhFQNiLoFxpA3qq0
         gEUQ==
X-Gm-Message-State: AOAM531mID7gsQRQiO7qp+nqr0B/leTDcbxjZ2plafOY9vQgEj9zx9cU
        QKhtzY305QGZLvNOncSxCZICKA==
X-Google-Smtp-Source: ABdhPJyEN5xIadzgfJ1N4XmtIIV0nhaW3MUsYMMgT/ZL0Bzna7mZRxyBeG6m5llKhH6Ko4hDQK6FAg==
X-Received: by 2002:a92:d64e:: with SMTP id x14mr5193ilp.206.1631045200961;
        Tue, 07 Sep 2021 13:06:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g14sm65392ila.28.2021.09.07.13.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:06:40 -0700 (PDT)
Subject: Re: [PATCH 5.14 00/14] 5.14.2-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210906125448.160263393@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <243d8e79-cd2c-eb37-d0b9-57cb51554171@linuxfoundation.org>
Date:   Tue, 7 Sep 2021 14:06:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210906125448.160263393@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 6:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.2 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Sep 2021 12:54:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
