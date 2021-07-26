Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993173D67DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhGZTYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhGZTYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:24:13 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A620FC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 13:04:40 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t128so12377607oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y8qxPhXibeauL3TNJ0rA0BM5c6Te/qTP5D2t4SuhdGk=;
        b=ShogC7f4yg6AU4ZuvXIJ6iZ2WCzGWAz7XPkIhO4mTtkCm+v3G8CM6P4Q1lXW5rn5d2
         9tcKWxpTA5Qap0eV/ivdZJYBpN4AO8YKue4OBZs8NMNpPiAHDsopFPJZ5lTrtYeyIdg+
         DDSxOIQCoxDh9oH3d8SViB29WrZNv/IBHXqOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y8qxPhXibeauL3TNJ0rA0BM5c6Te/qTP5D2t4SuhdGk=;
        b=SNxWgz5dJscCCGnf/D1nKcooBAtztOUE7hxV8VN91XrMNWkUHPbqs9esJVlUxUzYhd
         LOh/nZZqZqM38VdU3htAvxx/WqtyJl8lpOu42J8jnGtwKLKrndm0zszTJJQOV5OVSdHg
         V+gMxv8QV3Aj1/iELdAP94u8vgndR2zs84sGNQdhkDb7w3jPVDXziJIG4ZqRsMg3+XXl
         Ep2oAJmI5hybxcO/tQhnfpv3X2tBtVB/QY38soI5eifululujRtzBeVUSMtKopAH73bF
         7Zfcezsas9H9CwzTWypzrkstaCwJlftkEXPdSLlXWkASRMWIIgHv4ah7YEBM0jcznqAf
         p+Ww==
X-Gm-Message-State: AOAM531XivYnAPN/aZi2HA1fVfJ51RseUUKo9YxqQJFdAfE9ac3sSiaP
        MfjEE5Ef6YmF2NVlWadeEmhhKw==
X-Google-Smtp-Source: ABdhPJx290csJRp5Q9NvP/HUN2LMB44B/K1xiseY90PzZsY0ECUjGoEAo/6RawBwyGx0xv9yWM8BKg==
X-Received: by 2002:aca:c40a:: with SMTP id u10mr468462oif.111.1627329880111;
        Mon, 26 Jul 2021 13:04:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v7sm132569ooj.46.2021.07.26.13.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 13:04:39 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] cpupower: Fix to return negative value if no
 permisssion for read_msr
To:     =?UTF-8?B?5b6Q56aP5rW3?= <xufuhai1992@gmail.com>, shuah@kernel.org,
        Thomas Renninger <trenn@suse.com>
Cc:     xufuhai <xufuhai@kuaishou.com>, lishujin@kuaishou.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CAOkq_Bfc_u6crJtB=qJY4P76KnkLHF_7ZbFOsDsb5hhtpO5_FQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2d0dd861-b62e-5bb0-79ba-0be05f0d6028@linuxfoundation.org>
Date:   Mon, 26 Jul 2021 14:04:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAOkq_Bfc_u6crJtB=qJY4P76KnkLHF_7ZbFOsDsb5hhtpO5_FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/21 12:26 AM, 徐福海 wrote:
> From: xufuhai<xufuhai1992@gmail.com>  <mailto:xufuhai@kuaishou.com>
> 
> If the read_msr function is executed by a non-root user, the function returns
> -1, which means that there is no permission to access//dev/cpu//%d/msr, but
> cpufreq_has_boost_support should also return -1 immediately, and should not
> follow the original logic to return 0, which will cause amd The cpupower tool
> returns the boost active state as 0.
> 
> Reproduce procedure:
>          cpupower frequency-info
> 
> Reported-by:   yangrui<yangrui@kuaishou.com>  <mailto:yangrui@kuaishou.com>
> Signed-off-by: xufuhai<xufuhai1992@gmail.com>  <mailto:xufuhai@kuaishou.com>
> Signed-off-by: chenguanqiao<chenguanqiao@kuaishou.com>  <mailto:chenguanqiao@kuaishou.com>
> Signed-off-by: lishujin<lishujin@kuaishou.com>  <mailto:lishujin@kuaishou.com>

Please use your full names for the Signed-off-by - similar to the way you
would sign a legal document.

thanks,
-- Shuah
