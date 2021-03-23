Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4863346500
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhCWQYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbhCWQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:23:37 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923A4C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:23:37 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id c17so18670029ilj.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rWh3AKi5SFPZYfzTilgKq/RJwaJMU4SjT7+h6/AuhnI=;
        b=WGtYCALbmPj3DX9JRJyoxXSZACk/il6nthYFGpEHryoq58Ih91nCA5mA4oViGDLmP6
         5cr3PyMALQT4sZKcYkJtInrtdDEY0vUOS9b6Pqk2KUUov47fzc2aA05wYWPektI1STWM
         KJLgJEtmNrFJu/BOzAKT0yPfKVhkt3tj7oE1uG4xYinbkUko0yeweeVobEkuW8blVEWS
         eTuZ04ThCZCe2puzBxMTGDz3FFw2cFZca6IKEoq8YycSoZrHDy6sOaSYd63aaLe9tEVq
         pcTD0p24+UkvCJQPdohsXJMh+nVSVzHsAGkyDs5NrAHe5x/9z/k42Qw5l0cmBqBwPwjl
         xfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rWh3AKi5SFPZYfzTilgKq/RJwaJMU4SjT7+h6/AuhnI=;
        b=FD+vhon+J+SgU885YIVp2KFZ1wMBu96h4DNAdL/kJ5OTJtmPpzKpplupuFYvzF5I9/
         HmEnbKj86ztE89/tAj1gdR+Eol0kF7o5UWcltln5VxGy8p2SdxHEeYi/bzjB1o3/s5TZ
         fW9f95spT7Z0M986hj50woknFdHod25Xh7AGtWxcbpNtM2wAJMCD3IHF7aFX2SPHu/tI
         Oi3zyJ5Ni31Bcd2aowbpeueXTfBpc3xSyf29pDKnbqr3xJBdJehkKmD5KgnDaGtDMyov
         YJynYIG3g+eTqv/gAdGFr4VMJQsZlGVu39vhWuMp7XKfhJFWvUrJZ/zPV4rjYEkmXtEl
         Fd/A==
X-Gm-Message-State: AOAM533fd9DrchPjitvW42l8RzZ7mycnmbPc1p11uorCcx5Vffqej6f2
        tve2MgVDeipPYWeWx/C7Dsjv6mC56dKpkQ==
X-Google-Smtp-Source: ABdhPJwouPug3WEYGZOba12nsSNtkNanniEIp80Dp4dSxD6i3FNNVXc6j63VH4CZUlecYnMGaTAC9A==
X-Received: by 2002:a92:7d0d:: with SMTP id y13mr5652853ilc.269.1616516617058;
        Tue, 23 Mar 2021 09:23:37 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h15sm9729695ils.73.2021.03.23.09.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 09:23:36 -0700 (PDT)
Subject: Re: [PATCH] xsysace: Remove SYSACE driver
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, devicetree@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <ee1fe969905f641f5f97d812ee0cac44c12fe0f6.1604919578.git.michal.simek@xilinx.com>
 <20210323000436.qm5rkiplwt5x5ttk@offworld>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6948510c-dc7e-d74a-62e3-e42be14cff16@kernel.dk>
Date:   Tue, 23 Mar 2021 10:23:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323000436.qm5rkiplwt5x5ttk@offworld>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 6:04 PM, Davidlohr Bueso wrote:
> Hi,
> 
> On Mon, 09 Nov 2020, Michal Simek wrote:
> 
>> Sysace IP is no longer used on Xilinx PowerPC 405/440 and Microblaze
>> systems. The driver is not regularly tested and very likely not working for
>> quite a long time that's why remove it.
> 
> Is there a reason this patch was never merged? can the driver be
> removed? I ran into this as a potential tasklet user that can be
> replaced/removed.

I'd be happy to merge it for 5.13.

-- 
Jens Axboe

