Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFA543A87B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhJYX52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhJYX50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:57:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCB2C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:55:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so12925167lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aT3DJ36JdJHVIWZZjofTeLnbp7vhz92UJVeAX8pVSy0=;
        b=G40vs8yJV/u6paBEE7EhpNHsEvuPlrNfVIsKD3phU07bzJRZqUgNZo/0sLky8snNVg
         4/0jumZEmJTuXX2HXbTFxZdlKJhd130yq0rNzjvqnVnETDOjPkp/nH0zeLA9I1JTTg4i
         dOErtVJzid6/8NPURYcaeARc7gbWOnLZqo1Jjo+fEkIQ0O5iTqGzj+EHwiH6TZdE+ASk
         T3a3On9ETPMF0RaueEYF++g4MGMNpNFXDHfTAThxDmIVhvMiAwbpxAECXzljxPqboJ+r
         vFaaN6/ZWMY6BlSgYsQTdlfY/9F7NePghy3DXSOVpN2al3BJaCZuWvGjd3IZTD6TiLlr
         ljaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aT3DJ36JdJHVIWZZjofTeLnbp7vhz92UJVeAX8pVSy0=;
        b=FMlVnmtk4498O04Rmn5dINumvLzLNajJc0NovZ+DIUuE12FH9gL2IeeMnuilb/KzNd
         xDCF65ZCzh/00TZKQAbtWTnNE+rcZyBXhYB3wB1icjQaQYJL9cB0OM1/5uUVsy1XsIOW
         JvNodr3p1xKeyJrJ9B0/0c8nnAi28dNstXRqc75jvdr53GDpmFfaNRCTRfu9uSlQsGt/
         zo5CZSqDIvwoTzTJHmlGjPdeNqMt7BK+jhb4emCmVc5mQtM6F8NL8oKDAN+ULiSlF5/X
         48Y9+8lB6XNxdVX7YjqokvCtqkfS8dZiqozIzClehwgsBxrI8cz+d9JJKTpRrfPIRMM1
         wA2g==
X-Gm-Message-State: AOAM532xTcSAwU885u2+McsJLs7uQeYfXgASJFeWkmC38lbgDIb/tGb+
        AKMY7u71GcioKbGbii07oQw=
X-Google-Smtp-Source: ABdhPJyFeyXJF+fk76OPZg46jraLMHXkxk7h8aK1t6+wPg8gTB1N4ldWUfXWhhdT2N+tukeHFo3pTQ==
X-Received: by 2002:a05:6512:2292:: with SMTP id f18mr19177414lfu.619.1635206102278;
        Mon, 25 Oct 2021 16:55:02 -0700 (PDT)
Received: from [192.168.2.145] (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.googlemail.com with ESMTPSA id j12sm553517lfu.7.2021.10.25.16.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 16:55:01 -0700 (PDT)
Subject: Re: [RESEND 0/5] ARM/arm64: arm_pm_restart removal
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sstabellini@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, linux@roeck-us.net,
        treding@nvidia.com, arnd@arndb.de, xen-devel@lists.xenproject.org,
        patches@armlinux.org.uk
References: <20210604140357.2602028-1-lee.jones@linaro.org>
 <526fe66f-df08-c873-2a20-f1295e30a855@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a4fe088f-0f13-f80f-5011-4eee2d44ef63@gmail.com>
Date:   Tue, 26 Oct 2021 02:55:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <526fe66f-df08-c873-2a20-f1295e30a855@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.10.2021 02:29, Florian Fainelli пишет:
> On 6/4/21 7:03 AM, Lee Jones wrote:
>> This is a rebase/refresh of a set sent out, reviewed,
>> then forgotten about.  It's still considered useful.
>>
>> Here is an excerpt from the previous attempt:
>>
>>  "Hi Russell, ARM SoC maintainers,
>>
>>  here's the full set of patches that remove arm_pm_restart as discussed
>>  earlier. There's some background on the series in this thread:
>>
>> 	https://lore.kernel.org/linux-arm-kernel/20170130110512.6943-1-thierry.reding@gmail.com/
>>
>>  I also have a set of patches that build on top of this and try to add
>>  something slightly more formal by adding a power/reset framework that
>>  driver can register with. If we can get this series merged, I'll find
>>  some time to refresh those patches and send out for review again.
> 
> What happened to this patch series? Is there any chance we will get it
> included at some point? It is included in the Android13-5.10 tree AFAICT
> 

It's in mainline since v5.14, AFAICS.
