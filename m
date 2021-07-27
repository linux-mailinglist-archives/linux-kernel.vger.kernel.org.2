Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF17C3D6B19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhGZXy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhGZXy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:54:57 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E439C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:35:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso11817357otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W5YCxty6b4oBrgJIWBXN4NRqtFbzgguEoStAt88F5gk=;
        b=eKHGwFPHZT+sJ2CvmSoXUddTNe2hQD9bzCi1aBqUR42vBMDnD0tHeQkR7AjQ7rAR57
         /wyb54GO1Ba832FTPmFYKrkmYxi2foI4uBy9Fgj13DvRLdCjUDTYuto05XSJE/lxDBHW
         zHrOnrR4GGqTKl/dc6b2c44Rb3mc0z+NTaI54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W5YCxty6b4oBrgJIWBXN4NRqtFbzgguEoStAt88F5gk=;
        b=owkG9l1jgaF1EZUapxunvcv4OS75qYnsyZ19VRc5BsOguyFlw7hHpzXWlub+PpkiEz
         pd61F3xUuZAu3EZwuoz5w4xMxraWUPwKCDahnbUvILRK1yk0pGU3wBBIiBZgxEuhZ+oP
         t2md1LiooVmUJ9ZllUPZR6QDxqrw5Lkh5xwdxocEnDZqy8cv3qzIq8SmFtzncqAWN4sO
         N+zjLz0hZu5OoMBfEHMXANo+k6voy2MmURbL465jOVYGVyuse176rP4E9J9sx3M2j77g
         3o8uXfEV+t2W7EFHiY3W0lmpcK7OJtdCJ/1ENWoFkA7dbLFPEmPcI2+7cm4XpG6jiHG3
         8c3Q==
X-Gm-Message-State: AOAM530VTUImAT0q9x8La3LOlhoiLLpLnA512iUCqKbTKDIfu2h/6VqS
        sCNZzhxahw9dpEbEi6N+rifHhA==
X-Google-Smtp-Source: ABdhPJylDa1BDMETD/M0W6U3DMVflpjhNaqVGMW/nlRlJn43IIC71UG6B2cJRZgdKz7ey8Cx7OI4/g==
X-Received: by 2002:a9d:491c:: with SMTP id e28mr13275239otf.342.1627346123949;
        Mon, 26 Jul 2021 17:35:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t137sm296932oie.20.2021.07.26.17.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 17:35:23 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/167] 5.10.54-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210726153839.371771838@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <38a4db18-4fc1-a0f4-f0d1-eea822e63330@linuxfoundation.org>
Date:   Mon, 26 Jul 2021 18:35:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210726153839.371771838@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 9:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.54 release.
> There are 167 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jul 2021 15:38:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.54-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

