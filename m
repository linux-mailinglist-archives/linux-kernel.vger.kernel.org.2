Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677B03B7DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhF3HBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhF3HBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:01:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29418C061766
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 23:59:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s15so1654524edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IwnS1NNOOLhOi2omqPYPqrsJqmEq9LWL4DVMsAItlQU=;
        b=DAmaDKrlMjh6SgLCpuoiQ364yzoICVE3DkNiOgJFE9rQjmXU9IgzebbgvAgWJbQ255
         LFAhBvww5xdRltBWyM1XqeZGC4s+/0pgGHyGeyaqXeWwMnptgPZOzgxV+YLZIzusTTAc
         1MaUdsVYF08rhJKo9sR2KLDcSSX2XNYFsAupGLJB40+prDW2BCRzCteAg91ZTfJGdsaS
         LcdcbMMVactbR1aicj/UhBif68uIlzhX1FA5xYuOo7lSjQr9/hL4AOn9o+ZHp3k5dRv1
         WVQtKy1nAcZaCXgAbDr56iZV/6kx5BUfM0jw2qVd0/jqG9UtHrBd5g6UZlWUOvaGVQS+
         QL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IwnS1NNOOLhOi2omqPYPqrsJqmEq9LWL4DVMsAItlQU=;
        b=lnh6ZWWTWzms73RuvcgC2jNfi2dvXvwqMzfh81Cbte7or5WxjuyMTWgKO9SpuyJltc
         4+h/YjbCGquSuInmhST4FM4PmGkHMXDEg/oW8r33ZBj8Kd8GMHUGr7K7cMiUGf/cNeBS
         AXUZ2PkKettHO5wElAsFXHDjGNS5rFTWtRZRBlnl5QNWEJ7gWBYEwSLs8wliQkhwhKiv
         rum3I6r10qsbRU7YjAq/8exCbvZUDXYFt/uXAasNKLOmgvp5NiuTf+mBuM+5a5hcpJcK
         m23IKuPj1xXrUkmzgnJVHmKF1GgJstwuFNcGG+G67yfb+ZnNfGt2MZjXoGrDIOfW4Zdu
         h+gg==
X-Gm-Message-State: AOAM530bhdBpXRPCuv6svKor+8ryjAUYeNJi1yEx2QC7IpsCdWbm8Vki
        I362zA1sePPAns3O9R+lhmSGJ1XbXhR/NC5p
X-Google-Smtp-Source: ABdhPJzonuGSl/Y6sooTRS7eB+KL1/vq+D3T8l0U6/wVC+3OVKSaOiUu6zS7KBuDzlM9Vd6AIESxHA==
X-Received: by 2002:aa7:df19:: with SMTP id c25mr10095215edy.80.1625036340488;
        Tue, 29 Jun 2021 23:59:00 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::648? ([2a02:768:2307:40d6::648])
        by smtp.gmail.com with ESMTPSA id g23sm2627069edp.74.2021.06.29.23.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 23:58:59 -0700 (PDT)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e566b945-2fd0-bff0-b291-e7538bafc3fc@monstr.eu>
 <CAHk-=wieg+T4HS+7na7m3huPNT3PrGPJE6nwdeABsQueSY=38Q@mail.gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <0d32729b-3c4d-8e71-02b9-c53bd92bfa50@monstr.eu>
Date:   Wed, 30 Jun 2021 08:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wieg+T4HS+7na7m3huPNT3PrGPJE6nwdeABsQueSY=38Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 6/29/21 8:26 PM, Linus Torvalds wrote:
> On Tue, Jun 29, 2021 at 7:30 AM Michal Simek <monstr@monstr.eu> wrote:
>>
>>   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.14
> 
> I think git.monstr.eu is having some issues, I'm not getting any
> response from it..

Sorry about this. We had a quite a big storm in the whole Czech Republic
yesterday. Also some power cuts and issues around it.
As I see it is back again. Can you please pull it again?

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

