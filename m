Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38F3F7EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhHYWgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhHYWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:36:10 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D10FC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:35:24 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id h133so1561581oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8umOJ4xRco1tiOVYvn1LcvlXX3cQpzvKrVzACiMJBIc=;
        b=ToCttOr5x9ajvEofZkYN+VLDKO/CsLjvdWpFG3TNveZJPFmGz0o/C37LTv7rr7B9OV
         vOvnZ2s8maSBUEhpqEUQIwROWN4RHmN2faNdL5SV8nWm3jCgIXpUBS7/9gIckZQ0UQ08
         Z0bk4frDJom7rgxxB8/IrAKE96huOp/FPV6ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8umOJ4xRco1tiOVYvn1LcvlXX3cQpzvKrVzACiMJBIc=;
        b=hLlufrZQg4aP/xDluLHpMwz/OzdCs9Kss7Px3v50X1kU4gZU3IZGD8Zl0q+m+YTHdm
         mw2g2uEcIIyidbQ0NdAP2cDzHZv7VK6wxSPm2O4Ioxhv25KYy0H9UccxawLxY9JGRVWW
         +QGrnbIwdTFXYPh3Qhhzl9fdVYdzfnn1x779jLTRxVdtbRm8imjcRP6eOcVNqPGAQDUi
         ORGUXl78PS4/dXJQwctWo5trnLRuN/A8WeBQuv33oCA8HlHAlfiD6GuVu2QS3YDEDkCX
         y9dML8XZbfN0vJQA7KscKeAdalYkJpGNVwCC6fHzNsrTBjRbOheGLB61LPih2WNMZWao
         tfmA==
X-Gm-Message-State: AOAM532npM6XDyDQNacReFNhIyQbn2H9/Tx+odG19jWHFvQDE2moP+5+
        NimUzmmcyMDaCtxflObsZnrQeg==
X-Google-Smtp-Source: ABdhPJxh5KKIbcP2t6Q/dKRaZcluVdngovwL6jB7XYvLJyWJ4gmna4PbTKOoMzBP1scnPb09+GLCoQ==
X-Received: by 2002:aca:efc2:: with SMTP id n185mr238258oih.142.1629930923733;
        Wed, 25 Aug 2021 15:35:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id bj27sm242324oib.58.2021.08.25.15.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 15:35:23 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/98] 5.10.61-rc1 review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210824165908.709932-1-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a28b2170-e267-dda2-d0cd-aaae5d806925@linuxfoundation.org>
Date:   Wed, 25 Aug 2021 16:35:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210824165908.709932-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 10:57 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.10.61 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu 26 Aug 2021 04:58:25 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.60
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


