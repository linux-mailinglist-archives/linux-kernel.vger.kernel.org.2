Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CC93143FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhBHXiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhBHXiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:38:06 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F20C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 15:37:26 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id y17so14433590ili.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 15:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nY+hAFuWBJsnXzQEIqifUogLLPLxvPaMSeX6QEiCxNQ=;
        b=bMpydch2jple90JAnLDPt4e9xcDElyuVsoWRBub4Wb2KyoLaN0cbknEe8vstquKYwZ
         tll3quu+GiWCme6ATQzz6pX5+euSATje1jv/2PNMR6MyhNhXadIUcxlaIohUEICQ+Hl6
         zgJU/rLWWWf56M8ElfVpG2o5xgSy1FuGDhZNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nY+hAFuWBJsnXzQEIqifUogLLPLxvPaMSeX6QEiCxNQ=;
        b=CZ5WxVuVCgVTNXL53zf04ozssnB0gK5BPOuv6sgA7pmpu39yK3d+d/riwofDEiLDyG
         vMkE4HS/0ao/66J13z6Ff6414ttcdjXn5IisNtzkUkWxhwYzRZ42gJZrSgJQnbeubynb
         SUvlOmeGpkFYYZ87l0i3S7xnEQwnp+8lZnqbOLQyYQqML6cCx8+c0cgbJLByRHQ0hGAD
         4UQ7p4DqLv0tQfTvCtTEvQih/55c9h56eUTWuBtK4aLO/la6oBbt77OJVq7oZuMyGuPu
         3jciml5NIXjrg+kE1IWi+Np+QUysVxK1w4l2PRVbooOSxhLM9yrayA1DILcBMoEAdyAi
         jHFg==
X-Gm-Message-State: AOAM5318CNjSd6jmBxFoJrMAu5Rctmdmvai+Q24UTkVxtUBTseMWMH/V
        e2AQ7gP+wdnHffRT821MJPYsAw==
X-Google-Smtp-Source: ABdhPJypuK6nOerAerFaG6xS1+h27p9Sfrfd7PMiC0RbKIjb7r9OIEZSFaDZ0oGvSS2Tmrv6063gvg==
X-Received: by 2002:a92:d44b:: with SMTP id r11mr17918502ilm.159.1612827445835;
        Mon, 08 Feb 2021 15:37:25 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d135sm9686897iog.35.2021.02.08.15.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 15:37:25 -0800 (PST)
Subject: Re: [PATCH] selftests/vDSO: fix ABI selftest on riscv
To:     Tobias Klauser <tklauser@distanz.ch>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     shuah@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, vincenzo.frascino@arm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210204145042.7345-1-tklauser@distanz.ch>
 <mhng-1ed0f9e8-84ec-4f2e-ac42-5a608726e2fe@palmerdabbelt-glaptop>
 <20210205075745.jlf3vsjkp3n3rwss@distanz.ch>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5a8923b2-0c5e-ab6c-52fd-f00bc1361a3f@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 16:37:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210205075745.jlf3vsjkp3n3rwss@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 12:57 AM, Tobias Klauser wrote:
> On 2021-02-05 at 08:06:37 +0100, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> On Thu, 04 Feb 2021 06:50:42 PST (-0800), tklauser@distanz.ch wrote:
> 
> [...]
> 
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> Thank you!
> 
>> Not sure if you want this through the RISC-V tree, so I'm leaving it out for
>> now and assuming it'll go through a kselftest tree.
> 
> Either way is fine for me.
> 

Thank you. Applied to linux-kselftest next for 5.12-rc1

thanks,
-- Shuah
