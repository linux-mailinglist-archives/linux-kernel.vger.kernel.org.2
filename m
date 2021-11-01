Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AB1442229
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhKAVB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhKAVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:01:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346C3C061714;
        Mon,  1 Nov 2021 13:58:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r12so68846111edt.6;
        Mon, 01 Nov 2021 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGrnx62pvPj+VVQAfPPd1GnNOPN1pj0iHtDg0nowNo8=;
        b=q3GESUarDqCYNc90NbDWg2y3hKsM5xAcvaH0+c/nTpxXi9xX+vtNSAq5QXtOW9vINj
         k8QeuJm365Op4btcuXlNR710bSaEFrxcG2vc3hzH0XZarwPYaJ4it1MoqWZf7PbxMkQk
         Rmb0UQbtexTZKK+qQ+uKn7ThW7Adnw7NwrCVHf7VyL2riX9QA701emD586D9DYQ087hC
         dbSyI55CSWvmr60sEzVHTKNixvrvxtl7vExMUYMytF3X3mjkefnYbpmgwO2pY8ZJ6kDJ
         X1uhVsYnfNc8JfFMDbESC1HvedCHBReLuKM/OFhMsnN5NAhjEFd0ISNGugMifGXS/tKE
         PL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGrnx62pvPj+VVQAfPPd1GnNOPN1pj0iHtDg0nowNo8=;
        b=bjsT4Tei9vHo2m86UZaGN8RiMNJrP/Y50U0X4Hz9eooM93PWuvcASruMqzwedxpOjo
         ZaOfU36ZYNogYPBM22Vg5D2h/69Ubrrz/CLPqutb2/JMC+SMHvkWiO5Yyu5zHy+uFSOw
         45ibmGyqiHcd0gIGKL6KZfLGZq05Saome5n1Yd3lEwwx806LJ62gFpRGCVzOtLNZbzEm
         mn65fHu1CHH4h4G5oqW/Rpf6QoqwGq1LitAe4ay3vhoULsSCjY7ZjZKYNSZP3X7XOz9j
         yEJflMY2spHbSjB9eXympFXUPIfkO2DHOv1tqkHbFQDX+nmJTZHdoGa0zfQNvPCd82zw
         ckWw==
X-Gm-Message-State: AOAM533mF2M+6NVNDz+PZFFrZ6Rm8NL4wvISWD9KI4v7Qth5sOiMyJbf
        RgZzc6faMyDUYXkSF+Ngz4zXqUQJ6i1T76edWuo=
X-Google-Smtp-Source: ABdhPJwwoLB13ORBh1xxEUOZTPzBdJGO+FhxArWjC/UixC1ei6acQGnNpe+SrjyIb2lUB86fM1ikB5zdayO5Nt/NP3A=
X-Received: by 2002:a05:6402:2815:: with SMTP id h21mr45121875ede.45.1635800329724;
 Mon, 01 Nov 2021 13:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <163425193558.1688384.15520943968787313145@swboyd.mtv.corp.google.com>
 <20211015120559.3515645-1-martin.blumenstingl@googlemail.com> <04a58d50-634b-fa20-95b4-eb6831f77e85@collabora.com>
In-Reply-To: <04a58d50-634b-fa20-95b4-eb6831f77e85@collabora.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 Nov 2021 21:58:38 +0100
Message-ID: <CAFBinCAEt9_EfLYWZEzTBK6iN97+Wacho7pNd2LYDPX3+goMzg@mail.gmail.com>
Subject: Re: [PATCH] clk: composite: Also consider .determine_rate for rate +
 mux composites
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     sboyd@kernel.org, heiko@sntech.de, knaerzche@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        Collabora Kernel ML <kernel@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Mon, Nov 1, 2021 at 9:19 PM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Hi Martin,
>
> Please see the bisection report below about a boot failure on
> rk3328-rock64.
>
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
>
> Some more details can be found here:
>
>   https://linux.kernelci.org/test/case/id/617f11f5c157b666fb3358e6/
>
> Here's what appears to be the cause of the problem:
>
> [    0.033465] CPU: CPUs started in inconsistent modes
> [    0.033557] Unexpected kernel BRK exception at EL1
> [    0.034432] Internal error: BRK handler: f2000800 [#1] PREEMPT SMP
>
> There doesn't appear to be any other platform in KernelCI showing
> the same issue.
That's a strange error for the changes from my patch.
At first glance I don't see any relation to clk-composite code:
- the call trace doesn't have any references to CCF or rockchip clock drivers
- clk-rk3328.c uses drivers/clk/rockchip/clk-cpu.c to register the CPU
clock which does not use clk-composite

Chen-Yu has tested this patch (plus [0]) on RK3399 and didn't observe
any problems.
So maybe this is a RK3328 specific issue?
Anyways, I am interested in fixing this issue because reverting is
becoming more and more complex (since I think we're at eight commits
which would need to be reverted in total).

> Please let us know if you need help debugging the issue or if you
> have a fix to try.
Could you please try [0] which is the second patch in the series which
finally made it upstream.
This second patch is not in 5.15 because I believed that it's only
something to make the code in clk-composite.c more future-proof. It's
not a condition that I am aware of.

I don't have any Rockchip boards myself.
So I am thankful for any help I can get.


Best regards,
Martin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=6594988fd625ff0d9a8f90f1788e16185358a3e6
