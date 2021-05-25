Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3AD38F6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhEYAVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhEYAVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:21:13 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DD8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:19:43 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id a8so21557765ioa.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hp+HnQb7Q74sAjE+diysQ2+gcoFeCUYhJLrkwE+rihA=;
        b=PK9kCgKlpubPco56e82z5L1dLtvrEZOLp9Y0LApblPrl5l3lDeptvA1ISpwFfJf8tz
         oky6O2EdBZpHMYybzntnNA6omhlIadMYd2pnmCPcl6yzFiAhOWFEeBibdXSeAy/oUtrW
         a/tPZrWiLwnhy2iYKTU/L+JgG/Ztg0E/vxbMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hp+HnQb7Q74sAjE+diysQ2+gcoFeCUYhJLrkwE+rihA=;
        b=slnsL5nLmtZM8UQm0K74Fn1V3I+XsPavhoE4yZkEx/YaE9XX40v/VgS2QlO3xRZ0LD
         JKLhu0fk7DoD1xES4oP+jJVl8OuaSlubE843fqaGoycUKKYqNpdJNmuVAlcgA7YORAdK
         XMpT8zDjAT32LksdXa+yE7VmeOpiferwGuQf675mtjUJjFgA8DT4+G1423BFTQDe3nSn
         FX7k2rJPWXe0w2finjQc395PG1bc39gk7DLUErIe5Eov25l+V7SuNy2qFwMoZkhVuaMi
         aU0odMIGd+K7EFr7Aj4ByIDseNvW8K5fd0vF7VT/L7NOvC+xTfKz6UYRY+EUwUmnqF1S
         LmNA==
X-Gm-Message-State: AOAM531NL2rX5TvDvhh6uo2jUyaAmPj9BCjiUfEqMsYrPBxnk8Uk6rBD
        v2TY0A7UmogasndD0yun9Co8pw==
X-Google-Smtp-Source: ABdhPJyjwGklNq6Jo/geRu++WIOpcN9tTtpGLasXTX3iJ1eA5dVpaXaAmViXx6X9wBXO2gd/wT6uNQ==
X-Received: by 2002:a5e:8a08:: with SMTP id d8mr18028968iok.192.1621901983068;
        Mon, 24 May 2021 17:19:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z21sm4198697ioj.15.2021.05.24.17.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 17:19:42 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/36] 4.9.270-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210524152324.158146731@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bbb5546f-55da-1985-81af-2e7a1c8d16b2@linuxfoundation.org>
Date:   Mon, 24 May 2021 18:19:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524152324.158146731@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 9:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.270 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 May 2021 15:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.270-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
