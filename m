Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E96394E38
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 23:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhE2VLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 17:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhE2VLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 17:11:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780C1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 14:09:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g18so5979079pfr.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 14:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8r50WTYijVxw13w+Cbl0B/a8grECRXS0efGfJBQBVbo=;
        b=PBNynF5n2iXQe/+sssTBzt+gMIs+NXmjTog4xShBRczk86R+NMYtPGbqrvT1uGgFvi
         y8xKRP38wrBGyf2e7wWlP0eeLc0rsArRKi1vFVBLa6lbKTRRKsgkx+tPBDvNbigotovP
         8PSspNUgOVnqazvOGVUXmFzu8DZ5yqhYZ54hQnm04cH/zReTEdwSoTTRz2DTjafV42Pk
         0YG2nFsdsVR1BspmBgODXxuqC2VBsm9VFx2gy6MNui+3hcaoFxsllYcxmPpAFl8Qi7zs
         PCRlCWxcLB21/9hTjxhiPGvs7yMCmrhbVpueQ/jO/+f+CV066JcJ9AGrqf553ZIq4y3g
         ZP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8r50WTYijVxw13w+Cbl0B/a8grECRXS0efGfJBQBVbo=;
        b=hrqDRIbcUN4c9bkomaZTQO5y8Fm/CI7oAfrc7jKCfdxCigI3Fhhv7+dh80fvk4/RYO
         tSqIVcVfH8bl3xKvHY4YqWaGfv/RF7Zs4C2M18Os8sLHpG03DD1Th7gFq6sUA+KlDaY9
         4fx8QC5qrOSgdI888FfXuOsYgVGzXhxIl98GyJsutVfLKLBfBPqXWxSgbb/Wt0RBKA9R
         Li5K/RM1Y56z7bz4tqmdINzpLy7jHJqP7z1eZjdGN+Kvysg7EIl8eYhKoA3g5+gaJ1qZ
         vDwGpzGqPYLJUVW6H7/SzwSA2YCT3kS0hXA4VtucXMdmlA1kPTdL+UILKN60xu/3+rag
         iyQA==
X-Gm-Message-State: AOAM532GCEk7s4dPczunFvf3MLsJYNhMUjkjGmW/rgj0AeBy91x8VRCw
        2aQBO/iWJeexhZ40cuiH7Muf6A==
X-Google-Smtp-Source: ABdhPJwPn0+uGvchgpImUmRLtYMKtuL//7Wv0+g7ZeOxfdVONPvEborW1k4FjfBCMS6GGHxB0hG5tA==
X-Received: by 2002:a63:1443:: with SMTP id 3mr15524590pgu.69.1622322565931;
        Sat, 29 May 2021 14:09:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c17sm7686313pgm.3.2021.05.29.14.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 14:09:25 -0700 (PDT)
Date:   Sat, 29 May 2021 14:09:25 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 13:56:03 PDT (-0700)
Subject:     Re: [PATCH] riscv: mm: init: Consolidate vars, functions
In-Reply-To: <20210517224001.42424097@xhacker>
CC:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-42fdf6d2-5e43-4e39-abae-971f47e6ff69@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 07:40:01 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> On Sun, 16 May 2021 21:10:48 +0200
> Alex Ghiti <alex@ghiti.fr> wrote:
>
>> Hi Jisheng,
>>
>> On 16/05/2021 15:19, Jisheng Zhang wrote:
>> > On Sun, 16 May 2021 21:15:56 +0800 Jisheng Zhang  wrote:
>> >
>> >> From: Jisheng Zhang <jszhang@kernel.org>
>> >>
>> >> Consolidate the following items in init.c
>> >>
>> >> Staticize global vars as much as possible;
>> >> Add __initdata mark if the global var isn't needed after init
>> >> Add __init mark if the func isn't needed after init
>> >> Add __ro_after_init if the global var is read only after init
>> >
>> > Hi Alexandre,
>> >
>> > I think kernel_virt_addr can be removed, users can directly use
>> > the KERNEL_LINK_ADDR MACRO. Maybe I miss the reason of intrducing
>> > it in commit 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of
>> > linear mapping"), could you please comment?
>> >
>> > Thanks in advance
>>
>> kernel_virt_addr will be used when I push my relocatable series since
>> then, the kernel virtual address will be different from
>> KERNEL_LINK_ADDR. I agree this was not needed in 2bfc6cd81bd17e43
>> ("riscv: Move kernel mapping outside of linear mapping"), I'm a bit late
>> in pushing the relocatable series.
>>
>
> Thanks for your information. I think kernel_virt_addr could be __ro_after_init
> But I will keep it unchanged until your relocatable series.

Thanks, this is on for-next.
