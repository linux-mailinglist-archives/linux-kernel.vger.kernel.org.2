Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5CD34A92B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCZN7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhCZN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:59:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5E0C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 06:59:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v10so4650980pgs.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N525R0I1T5gnDP/3pYDdjFavoBHG9Qg5l7r45szAcMA=;
        b=On5nh8B2BwJPDQwCEKPxGLKDv3gYAyj5ajozYNDU4Ce24qYJ24iq/peVoXZaJP+dVc
         2pq/64hQrDfofYJKjVYhSdFgCsGriXtI8NX+u1vqXJozoIB5NZDGF15omc4P7xv0zx82
         c/mRquYRrktbKcqvmaT27SzUmkgBozvx2eZaKBGQ8uMV8lfnWQUSFEBmbFB9OLWHeDC/
         XvwYLKJNai+IrsOEPm7glz55eK8IEUUanTZpt31eYU/UoYfyq3zyvZsc438+KaLouX33
         gxSEVD5wL32jRxNgNlkuvruzM4QeAxcOwgFrftWqb35fGsIZy7OHOUnwlUgD/IDh8pmZ
         bvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N525R0I1T5gnDP/3pYDdjFavoBHG9Qg5l7r45szAcMA=;
        b=I3noF6nYeItbik9cogZSl2fuy2vL77xotiRyYEESDxheSApdNGv7Fr5erwq9lN/cgC
         pj31hpID3wpBv3SPHn8Y/PMw6L4Af0jnyp32AXvfn/FI3TYKLuabydW/x5btWUuZfZAx
         V2pNaFHUE94tTL8Gn6NuCv+yPYzaWLSg7i3i3fqbNIHh+H8qJhLhlrbWnHKl3AI2Acnr
         u3g4G0Oz/oTGGsCHzn3WpXhxY/P90JTwDi5V1KkQMZi/a2qtfCy67HSLvj8NNQdtikRL
         6Jua4j4lZjPai7ypBX/1zREObxVFL3yejhqPe4jcTKIgItFHybOqhk55ud4bUrbIjRwV
         B84Q==
X-Gm-Message-State: AOAM5324WmAtff8dsCKE9Owudi/N7DzaSOdQYgnmTijzaub8q9PONXTD
        TjAH4sP1C0c4H4zFjmynzw4ZMsTKxquelw==
X-Google-Smtp-Source: ABdhPJxy4yx7KcV09Vt/gQnCAzR92830CABL6QhI9gAQ40ZE1qQ2TJB5VYfnCuiKZjlGm330dxP55w==
X-Received: by 2002:a65:5849:: with SMTP id s9mr6142005pgr.309.1616767169276;
        Fri, 26 Mar 2021 06:59:29 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k5sm9537445pfg.215.2021.03.26.06.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 06:59:28 -0700 (PDT)
Subject: Re: [PATCH 0/6] Allow signals for IO threads
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20210326003928.978750-1-axboe@kernel.dk>
 <e6de934a-a794-f173-088d-a140d0645188@samba.org>
 <f2c93b75-a18b-fc2c-7941-9208c19869c1@kernel.dk>
 <8efd9977-003b-be65-8ae2-4b04d8dd1224@samba.org>
 <0c91d9e7-82cd-bec2-19ae-cc592ec757c6@kernel.dk>
Message-ID: <bfaae5fd-5de9-bae4-89b6-2d67bbfb86c6@kernel.dk>
Date:   Fri, 26 Mar 2021 07:59:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0c91d9e7-82cd-bec2-19ae-cc592ec757c6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 7:54 AM, Jens Axboe wrote:
>> The KILL after STOP deadlock still exists.
> 
> In which tree? Sounds like you're still on the old one with that
> incremental you sent, which wasn't complete.
> 
>> Does io_wq_manager() exits without cleaning up on SIGKILL?
> 
> No, it should kill up in all cases. I'll try your stop + kill, I just
> tested both of them separately and didn't observe anything. I also ran
> your io_uring-cp example (and found a bug in the example, fixed and
> pushed), fwiw.

I can reproduce this one! I'll take a closer look.

-- 
Jens Axboe

