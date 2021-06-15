Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB713A8B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFOVrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhFOVrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:47:40 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C27C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:45:34 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so415691otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5z1OJyGYVNhUMVsV/L9Wls14EjTqIU84oTFQp0rkHAc=;
        b=VkKU5yMDFq4US0C9KONfXVdRCtY0+kipg42sQcFeGsqacuY1j8e8tqQGqn4cmYNQp9
         KTULjm6g+fN/d2VxBcmbViu0T/pyX040MkLWgEZ9oirG21z3MYJYje+iahPKlQDLH/+r
         C9RvziKLOSsdVhkHo2GaI4lnGLd/xPLS4+1NdkdHMMJVujKYn0UdKsJrIICxxKgY/5Nv
         7VNVYTjpa09EnJzYJI+++fW43q/DUe5oLOJN7SBIk161z/06ib2z7iE7BhPUjOh5RK0H
         u5WjuL/Ynrtf+mt1QF4+dJicVxwoG6DvjW0CttG6EPpJmRl7BVYBSqlarF9wTzZVtg3j
         3qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5z1OJyGYVNhUMVsV/L9Wls14EjTqIU84oTFQp0rkHAc=;
        b=K5FZgN9f73eKvS69sCKq6pvmrrJUwQkdN3fTCJpPqIOgbNoI3UjnPq3KDDPqI030qU
         O3Vzor7sbVnp4RnEVjwM1Dww3qKYOyRiyAV8LXfotMEX18Mj4aXPpLLt3WkOy2pRxB/F
         ITzK9JDY3s68Ey6wJIHoq+PqXedCAo2QkLF2Knrvx0+oEDEZX2EdavOf6a6sgeYQGr8G
         pOVwzuA/FruuE1fNJikF5Sp6KOXmHGHRqHGab1h+vXAhVoHwox6iTH3o3Gn52qZpbHsv
         dOQJETx0BDPW1Fm0VXwvFW8NwPEP8IwUaskslD0KhAVXVX0/MLIZVYbe6N9h6QK7HZN5
         DFSw==
X-Gm-Message-State: AOAM5303lIKswnyF9cCrJiIQVo7CYTaHzQZGVSj3yaSpXP7Jby+QXPwa
        D0ZRC3SxJSkQy7cymXg4AiwwGQ==
X-Google-Smtp-Source: ABdhPJzZ0m5J5y9ayP1ilal9XmMwFN9BTPg0P9DMT3IMVEBW+f5P6hjCIzGH8NaOsG6QxJ1NDTOmlA==
X-Received: by 2002:a9d:1e4:: with SMTP id e91mr1033309ote.211.1623793534208;
        Tue, 15 Jun 2021 14:45:34 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id t18sm43054otl.80.2021.06.15.14.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 14:45:33 -0700 (PDT)
Subject: Re: [PATCH -next] ide-cd: fix warning: variable 'stat' set but not
 used
To:     Baokun Li <libaokun1@huawei.com>, davem@davemloft.net,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     weiyongjun1@huawei.com, yuehaibing@huawei.com,
        yangjihong1@huawei.com, yukuai3@huawei.com
References: <20210529061729.2824082-1-libaokun1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bba1a668-227d-7dd4-59b3-6a90a169f4da@kernel.dk>
Date:   Tue, 15 Jun 2021 15:45:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210529061729.2824082-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/21 12:17 AM, Baokun Li wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/ide/ide-cd_ioctl.c: In function 'ide_cdrom_select_speed':
> drivers/ide/ide-cd_ioctl.c:212:6: warning:
>  variable ‘stat’ set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction.

This code is being removed shortly, so better to just leave it alone.

-- 
Jens Axboe

