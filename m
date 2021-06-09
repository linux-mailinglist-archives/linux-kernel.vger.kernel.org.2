Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554B93A0A50
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 04:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhFIC5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 22:57:18 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37531 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbhFIC5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:57:15 -0400
Received: by mail-oi1-f174.google.com with SMTP id h9so23728666oih.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 19:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aTTLAw4NPS3JsmZfgJtfgUL+WouD7q1ngNw1o5rQTTY=;
        b=KLUDoHGLlsQCXe6JCZNeq+Od8Ro2aJ72JsjOiVVgN8M5ukJWkJ+Yc2wY75AHLOpMTr
         C68C1ZJ/2neS28j0qLNZR8OQWw3KBOe8QYY7bbNgB3hX/ttErAHeB0zRSUKYZV8pFBel
         /upvC4YllLL63E3x8dDxash8naY7dbayYFHac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aTTLAw4NPS3JsmZfgJtfgUL+WouD7q1ngNw1o5rQTTY=;
        b=kvov8ZJpkauX8+qECCu2pVa4faxlq8yx/Ej+4WdhYycqodM03pRG/SawRyz6snvF3T
         F5viF6rdmcSKFDWfjFdEIBD/p3Y1hTngiQz3rjQ1hNbF2mwMISxn28hsH1fpjDI7+Jxl
         0K+VflSG1wY/gB6nY7VBmy6f7ccrWLTiykUew9Y3O/EvrjNYVzqke4jiehMQWjvpjgau
         INWSV+ZLp3oHVgTQmmYSZ/PryZUf663J5VVM1BhO1E2mA7R93v4+cyxDtzZamyvO6KP+
         1vrk5UCLdFxz855PbjWeg6NzI8qTRCMEGmusYwdd0+9GcV6weFmnIqMWiOL7Vi/obI8z
         sE2g==
X-Gm-Message-State: AOAM531QTerLEtzWx6EtZXCa4ZMwoUe/rJc3LPQaX9gSeLACyPtzyn8U
        tiAiCYCJeDLYs07dIhVi0tO12w==
X-Google-Smtp-Source: ABdhPJwluiCzN7chYdAlx7YzSqiocQEUW3hiYncQVvsIq47C8xSDCJ8oa8Xkum2RsvGLDC31EnKFTw==
X-Received: by 2002:aca:efc1:: with SMTP id n184mr4986195oih.23.1623207245155;
        Tue, 08 Jun 2021 19:54:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c13sm2468221otr.23.2021.06.08.19.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 19:54:04 -0700 (PDT)
Subject: Re: [PATCH 5.12 000/161] 5.12.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210608175945.476074951@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2ebe5b47-42a3-39ee-e027-d29ebb2df3d0@linuxfoundation.org>
Date:   Tue, 8 Jun 2021 20:54:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608175945.476074951@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 12:25 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.10 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jun 2021 17:59:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
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
