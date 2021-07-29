Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4F33DAF99
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhG2WxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhG2WxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:53:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F739C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:53:14 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 21so10534732oin.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bd7dVxWZYNuT3I9ZZ3/NGYWtgMpKZTXAbbWXptJCJmg=;
        b=DSI6jW3CyvI5xTydK7NrBm+CN2vi2xwISQZBrWq6ujFfWzOeAzfifgIVNBA4Dw+Mzi
         BoTOgJFTsKH15XERmt0bWVl+yi3qJ+DhcYNaGl/VYC0AMszvoojuqDlonOUSc7c7jHYh
         Rn+RqcKMloy9z/fz0H3iIwrXDohKlY+6tLhq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bd7dVxWZYNuT3I9ZZ3/NGYWtgMpKZTXAbbWXptJCJmg=;
        b=XMxVFk02v410MwbK5HXR+apCiAyg+NPcjpq0xeNloB7MhGoK0B/5w91sZUWjC4P5un
         ccrAew/m9vtb8Vf/72S4mm0vJHmu8CrPP3lZVKL9NBuHSZbx0uBCNT3uGbLjvibnFO+0
         /d210IRm0kezZnsySdR7OqdLeOLIF5WM2K1tmqRecT1SLCCEZCVzbOC4HZ1L/h5oakHI
         jv5BlLucmP96GLLUb2Omm0VMvx1cOn21wdKKSAMgdI2I9tVu1OsQ0WyntF5YhLXQtsKY
         6k0O/TDPog58LmdZkTsLu8yMpVu2dKB9DUEQnHyzgc5V8si9LJMpzmF197r0l41//OXf
         UVlA==
X-Gm-Message-State: AOAM533la1m+t7wQbxu+aFKTa8516TMQFZiPG57l4gTUQG5a/4XbcEwp
        /kEjT9srVfkwLWOKd4aOoXBwEQ==
X-Google-Smtp-Source: ABdhPJz/cDoA5ROTORgia6Wg/A24q4jVe7a/TPTO597+Mug16syhXzbW4bBuj9eobtJB9SYEJ0rT4Q==
X-Received: by 2002:aca:c346:: with SMTP id t67mr11591228oif.124.1627599193630;
        Thu, 29 Jul 2021 15:53:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r20sm857513oic.47.2021.07.29.15.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 15:53:13 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/24] 5.10.55-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210729135137.267680390@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <126ef248-a490-24d9-2bf0-feefe5c64007@linuxfoundation.org>
Date:   Thu, 29 Jul 2021 16:53:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210729135137.267680390@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 7:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.55 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 31 Jul 2021 13:51:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.55-rc1.gz

Couldn't find this patch. Will checkout the rc instead.

thanks,
-- Shuah
