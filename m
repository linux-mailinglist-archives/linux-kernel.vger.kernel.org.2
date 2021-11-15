Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5007F450A85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 18:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhKORKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 12:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhKORKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:10:18 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E7CC061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:07:22 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bk14so36190352oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vCa2E+dJjqvGi8UXWr6zpQQV0dWLecZaeeB91TgLe64=;
        b=LFcz1qZyvl57t7vVV3/7LbJvBK3fn1w6c3gQIyMWf8rvU48SlBnIDOw8QaHPLxZ1fi
         1XVFKJKNCgK/apNa0wnuw31pNCXaUDt4EsBxjzdR9AT+aV6WjGg2IBFnNik6YmEZGRBB
         yPGWgJuTprN7Q8QnMJrGvo+AiLpIW/vBsaWW87xxg1bXTd4C+cNtK7wzNy8APYJUH2cf
         5TDfWN4xcuPvP0q0758ZQ0JAE4/LgIGHlTZUzXPpbEDN6SgFNw06z5WrxQyoAGH55jv5
         SmO9QZ1JB2qdV3ukIkTI8XuN1mOLgulJbeOIxRfwc5cjZBJRUvOzlEaq4E3uWI5lgVn/
         NwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCa2E+dJjqvGi8UXWr6zpQQV0dWLecZaeeB91TgLe64=;
        b=oUe4/2i4F+TvTYbRAFuprNXhtBN3l+PcJBPW+G3tr/0H8TfLy7ejE+4zqPQ4RXceR4
         HVDjrT0BkS2bn/uc+gUApKCTEQsGOMAVR/K9ciz042PjZf7whBs1fglgnFgBRRM7Z68x
         iJ6fpDYx+C8Fc/azlKTxMEuryC4+Nb1r6WNwNl9W9goreV3D+ZUGG4nbrias/od25fCU
         V+YJ3iaCDLjLLKLGC5ek/r2eW8CxMtZkSBIIUh+/3HWau3bn2XKfel0LDJpXQVIVAvF/
         AQpEkZvHzchT64RpqNDWQd5fZXM7uM/afx69NT1gV91i39YSf3Jh+yOpYsg+EllsfZ9O
         WzcA==
X-Gm-Message-State: AOAM532FlUYb4F6n92BA1UptaHpMf4AuhMn+Sp3izug/pn9NiUTAB1TY
        1MO+FrMBANaTFKPUOPDWRPtNBfi7O7w=
X-Google-Smtp-Source: ABdhPJxD9UthhK8b/wRlOa1bMLtcJ54h0FrCC6JCan/mYHmVjqlpgI2w+Gpg6GlxgspDFDUhtoeVng==
X-Received: by 2002:a05:6808:179d:: with SMTP id bg29mr45406430oib.138.1636996041222;
        Mon, 15 Nov 2021 09:07:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q63sm3185258oia.55.2021.11.15.09.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 09:07:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
 <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.16-rc1
Message-ID: <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
Date:   Mon, 15 Nov 2021 09:07:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/21 9:21 PM, Linus Torvalds wrote:
> On Sun, Nov 14, 2021 at 8:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> With gcc 5.4, mips:mapta_defconfig
>> mips-linux-gcc.br_real: error: unrecognized command line option ‘-Wimplicit-fallthrough=5’
> 
> This (and the gcc-6.x ones for sh4eb/sparc/xtensa) are already fixed
> in my tree. They're all "old gcc didn't support that flag" things with
> a trivial one-liner fix.
> 
> I was hoping you didn't have older gcc versions, but you clearly do ;^p
> 

Top of tree is a bit better:

Build results:
	total: 153 pass: 141 fail: 12
Failed builds:
	arm:allmodconfig
	arm64:allmodconfig
	csky:defconfig
	csky:allmodconfig
	mips:allmodconfig
	parisc:allmodconfig
	powerpc:allmodconfig
	powerpc:ppc6xx_defconfig
	riscv32:allmodconfig
	riscv:allmodconfig
	s390:allmodconfig
	sparc64:allmodconfig
Qemu test results:
	total: 482 pass: 476 fail: 6
Failed tests:
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,ne2k_pci:initrd
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,pcnet:ide:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,e1000:sdhci:mmc:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,e1000e:nvme:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,virtio-net:scsi[DC395]:rootfs

Errors:

In function 'memcmp',
     inlined from 'kasan_memcmp' at lib/test_kasan.c:897:2:
include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object

Fixed in linux-next with commit 0fa83c99044a ("lib/test_kasan.c: use underlying
string helpers")


fs/netfs/read_helper.c: In function 'netfs_rreq_unlock':
fs/netfs/read_helper.c:435:25: error: implicit declaration of function 'flush_dcache_folio'

Fixed in linux-next with commit d2f0559fc2d1 ("csky,sparc: Declare flush_dcache_folio()").

mips:allmodconfig:

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

Not fixed in -next. Caused by commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621
PCIe host controller driver")  which states "depends on (RALINK && SOC_MT7621) ||
(MIPS && COMPILE_TEST)" (I guess mips:allmodconfig wasn't tested).


parisc:allmodconfig: Lots of build failures in arch/parisc/include/asm/jump_label.h.
Not fixed in -next. The problem seens to be related to the thread_info changes,
or at least bisect points to commit 01463374c50e ("Merge tag 'cpu-to-thread_info-v5.16-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux").


powerpc:allmodconfig

fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
fs/ntfs/aops.c:1311:1: error: the frame size of 2240 bytes is larger than 2048 bytes

Bisect points to commit f22969a6604 ("powerpc/64s: Default to 64K pages for
64 bit book3s"), and reverting that commit does fix the problem.
The problem is
	ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];

I don't see the problem in next-20211115, but I don't immediately see how it was fixed there.


powerpc:ppc6xx_defconfig

arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c: In function 'mcu_remove':
arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c:189:13: error: unused variable 'ret'

Caused by commit 5d354dc35ebb ("powerpc/83xx/mpc8349emitx: Make mcu_gpiochip_remove()
return void"). Still seen in -next.


powerpc:qemu_ppc64_book3s_defconfig:

arch/powerpc/mm/slice.c: In function ‘slice_get_unmapped_area’:
arch/powerpc/mm/slice.c:639:1: error: the frame size of 1056 bytes is larger than 1024 bytes

Bisect again points to commit f22969a6604 ("powerpc/64s: Default to 64K pages
for 64 bit book3s"), and reverting that commit does fix the problem.
This is still seen in -next.

Guenter
