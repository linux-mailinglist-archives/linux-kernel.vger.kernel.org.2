Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD143D1E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhGVFbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhGVFbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:31:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D00C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 23:12:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u3so3271743plf.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xYn9TThM+ZWcAUslBNCtRAoUyc+f1YV38quHS3ur+h0=;
        b=e4hyMVxoP7Mk4CxoR/e0msaMox1XC/iLjHKH2aLwkAtuyB1KBkjsGBYaqOVf9H9h6G
         iTfvQYeUsmepI1tAirhqX5+R9fzaoNiPLPO9h+z2OgtZh81Ses9TL5ud6GKwyK0NJt2r
         BgOIfa1GMG5k4ARHSbXQw1MeKMh/tDrDMhhp7flLg71hQUFKPt1CMtbnUJrlcK5gb1uV
         7QDLLUFkPyUgOiZ4SvtlIkiuzgVxR5buXCLbwgfsFIDoAnkBcA8MjlEfXJLIGZJnmk6k
         eaweuGg0DLmJnNUHPpUZYCW9NtlO/tOsfoZmbRmUPf1x101sm/tK+LLgDKUWpxd2G+JJ
         y28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xYn9TThM+ZWcAUslBNCtRAoUyc+f1YV38quHS3ur+h0=;
        b=h/5Iy2qSKhG2ip3GFcSMnQJood9ErLJkjyqseVxWWOxOPiUwuXG9pKcvSQ2TiWz1wH
         AKqCtcdaYJtegEmG7l0z39jA3CvU5XpCIKX599fXZH9u7oVzXbEmOcqeU7kuBq2L1UOu
         sow7Rwn/dBWw07P44Kl/jS0Ub2TGTpG1+xfzpr9n/VcMMoQcZlWoFVvLP3ZsUNmXLluv
         RjQ7FZUgqTxPM4bAFoKjHtxM5NOlWTtEJkB+obVOybUwCRlJkq4DDjeBq0jdd2gDLwX+
         T2yZGvOiCYJxj1EqpIU683eP3Va2c+8rYVhoauKn5nbvF/lURKymIx3pCln8vB9cyjHZ
         KqYA==
X-Gm-Message-State: AOAM5312Fv8+TqW34kri7w81haRNX3C3/spBdtXKrauutPJgSyjkIZP5
        Xo7VXtYLdYwy6IGmDxR8IgHXDg==
X-Google-Smtp-Source: ABdhPJwl5nH8LRTLVmuwt3jjEf6u6wAk+fk7F9e5/kwdFuIWmjEVCSm55fbiwlWUNcV9cfrrwSJ1wQ==
X-Received: by 2002:a63:34a:: with SMTP id 71mr4572323pgd.289.1626934340483;
        Wed, 21 Jul 2021 23:12:20 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j3sm29949764pfe.98.2021.07.21.23.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 23:12:20 -0700 (PDT)
Date:   Wed, 21 Jul 2021 23:12:20 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jul 2021 23:12:18 PDT (-0700)
Subject:     Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
In-Reply-To: <87bl6yrcmd.fsf@igel.home>
CC:     tongtiangen@huawei.com, jszhang3@mail.ustc.edu.cn,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-e14c3232-cc4d-4146-8c93-c60ec81ed272@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 00:23:06 PDT (-0700), schwab@linux-m68k.org wrote:
> On Jul 19 2021, tongtiangen wrote:
>
>> On 2021/7/17 14:55, Andreas Schwab wrote:
>>> Please use
>>> https://download.opensuse.org/repositories/home:/Andreas_Schwab:/riscv:/jeos/images/openSUSE-Tumbleweed-RISC-V-JeOS-efi.riscv64.raw.xz
>>> and run it in qemu with u-boot as kernel.
>>>
>>> Andreas.
>>>
>>
>> Hi andreas:
>> I used today's latest mainline code and .config provided by you, and I
>> can't reproduce this panic.
>
> Did you test it like I said above?
>
> Andreas.

I'm getting this on and off, with just 

CONFIG_VMAP_STACK=y

on top of defconfig, when running on QEMU.  It's not showing up right 
now: I'd thought it was an issue with that initrd patch, but it went 
away when I re-ran the tests so I'm guessing it's something 
non-deterministic.  I'll try to take a look if it comes back.
