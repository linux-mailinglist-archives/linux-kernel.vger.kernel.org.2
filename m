Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23F3364F11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 02:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhDTAKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 20:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhDTAJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 20:09:48 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 17:09:17 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p8so15333299iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 17:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NbaDxFLUsEuvQOAjKk+XEBwgvpjR6/LYpusKOWl3cMU=;
        b=RGr/R2K3vSww+QQbhhS3OgEXMvH0b47J336zktH5TQg1JSE5O1RZ6bB+mWyAjA6aPe
         yK5QgGpAYKqQ/a6VyH2T/U7jTFXMWxfHPTWvQOdPA2rGdb5kWOtp0yqN9qTVvoDC3Ign
         6nhBe3qA6oGcHj/yjP16KnuY34RAHENkOSKyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NbaDxFLUsEuvQOAjKk+XEBwgvpjR6/LYpusKOWl3cMU=;
        b=lSRUs2IWIm6RvRqCWbSNtL3ZcbLGEfEtKv5NU5FUwwNCqxWkvPtPgC8pVgY8/q2TQ0
         /c6ovSSQvFZW/Gs6q6hpCHd7lTsm/6VNoMjW/czgUCIDeC6AUllEZD1cjlKY49W7XlMv
         qRYKOgaeC3UocpinuYr4ZQePKW77sfHepvkKGTohFANSgOYGIer+CXKqHCoUdxiIJ9bo
         gJVEDhuY8lGNuzJ8L7QDBvHxSv22YIGHhUg4P7kSzqvGW5q4WMNOTJ4jUnEfV2D9p6/8
         SNyKYV6n7a1wpl9dGQrj71CjhxhNX3tSZugS82QMNkukXY9Kgzs4quCKQVWOJjvjDxSU
         yAQg==
X-Gm-Message-State: AOAM531NCISAXBBt/QiXjoL7WHDbH2FkwmZ6vcMs0flHfSZZUqgMX/8/
        hmG64PPTDCIkUoLWodgEpAYPnA==
X-Google-Smtp-Source: ABdhPJzv5IwZBJdosZhayWklQDUWdpz9mjrdTAv7BVVCLk0/bonbB/QdKs4Nenk2MqarEfem/JEoeQ==
X-Received: by 2002:a6b:e814:: with SMTP id f20mr16698326ioh.206.1618877356933;
        Mon, 19 Apr 2021 17:09:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s6sm7688329iob.45.2021.04.19.17.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 17:09:16 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/73] 5.4.114-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210419130523.802169214@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <54b16e4c-5279-32ea-564a-7f864ce1da43@linuxfoundation.org>
Date:   Mon, 19 Apr 2021 18:09:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210419130523.802169214@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 7:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.114 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Apr 2021 13:05:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.114-rc1.gz
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

thanks,
-- Shuah

