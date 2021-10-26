Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAB843B823
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhJZR24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbhJZR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:28:53 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C94C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:26:28 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y67so228305iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uzz6TGMcC2ZtwhQUxnj+0Mt+B8q9hN7xmHsa5ZCecN4=;
        b=IUtNubR34NmO87BL0kkEZaotfDhtXiawZRW5H4P5fyVDw7tQunFFYYP7+9evdsFfAj
         o7Ly32nAWuB+VCS2CZDcQudn1Ov6h6aFK25C0dam8y9aIWUOCTixrgzrDJGnbDLd5N9O
         ICWLyBRXhU40oTzlymbO2KjGl3JNKMYzU9sw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uzz6TGMcC2ZtwhQUxnj+0Mt+B8q9hN7xmHsa5ZCecN4=;
        b=WCll/qWJsDcAoZSGlpEYyNl3mrxgZDHynGBf2cCF1TcgIumIj5Nmv4E3Me6Kvyt3Cn
         D3KXcg3U/Q9fuDQDeXryqiO4QcHPlM0B/jqREJ2Xo7jukdsbpQCzDc8ODndIDsHd0X6o
         wPgBg0AG16OgnqkwEw71Jx/SALG/21R3juVdHu3g1z/UavAKTFhV8QH2KFuOqz8GRdfe
         AWs5Qgm9/KXztqWwRdVJJmlzKpSqD4LgO7ZtAyKa1ayIe+cLV05gzdCgNfbuE5K0ZSRV
         yS8DuRf1RYKONX09afzydmW2AId9YaSsm4nnGqjE41iZX9S9nOO8IsEWsQNDaeZHAZOk
         6QfA==
X-Gm-Message-State: AOAM530TxR+CP6ePf2aDB8HlVRMEsMX0zO4zzlraqWGr+DMOxy9Bjl4k
        6FOfxV4V8tcdEw3WtcSkPXjGTw==
X-Google-Smtp-Source: ABdhPJxQwH3bLsDCNfCxFgIlHU8WPa6W63zD/ky26alQWAYMCgZaHSOcUxNpWks/TeOMeJPYfrjeig==
X-Received: by 2002:a05:6602:2c88:: with SMTP id i8mr16286367iow.48.1635269188197;
        Tue, 26 Oct 2021 10:26:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f4sm10455877ioc.15.2021.10.26.10.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:26:27 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/58] 5.4.156-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211025190937.555108060@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <05138537-a79f-8674-8c16-ab67094d755b@linuxfoundation.org>
Date:   Tue, 26 Oct 2021 11:26:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211025190937.555108060@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 1:14 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.156 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 27 Oct 2021 19:07:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.156-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

Upgrading to Ubuntu 21.10 caused issues with the boot related to
zstd compression which is the default initramfs.conf for 21.10

If others run into this:

Change the default to lz4. I ended up enabling
CONFIG_DECOMPRESS_ZSTD=y for 5.4 since it has support for ZSTD

On another note CONFIG_ZSTD_DECOMPRESS and CONFIG_DECOMPRESS_ZSTD
naming rather confusing.

thanks,
-- Shuah
