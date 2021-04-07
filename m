Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE92356CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352501AbhDGMyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352492AbhDGMyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:54:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4C4C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 05:54:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f6so11779777wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5pJucaSbsBrG/CWUYa4KAar5H4gKZ5F7mB0A0QhuVg8=;
        b=d2V91WvHx9LYuvRp67K+b4meIOoebm8Wze3K2hps8Z4p1NG0Npv4GLEd3VOyt6R73n
         ntVBvoUxVKZ8ei0NJ7XCuepOESwJ2+ga12A0D7VBIXnD8TNEGrVRdIGQ8ZsYAeo3XyTs
         sQK36KVXCCDhUQI8tfUTtgx7AHZBiH5h2j2ujQpEU8lo5uWA27s/olHs/gTv9u74XhP/
         ude9/0cBBXCLuwNtTN/q89o8fJehaYAJz8HRLNfu0E8O68Zt9lWgYcqTbN9ZdSA9Z4Hy
         3fd60TCI5lOlsUvGfbRLMeD7wix2u9WIVsA5f6CFFBDYynVaKXQs23nsluGMZJJ+0YLW
         gEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5pJucaSbsBrG/CWUYa4KAar5H4gKZ5F7mB0A0QhuVg8=;
        b=aZBvHDz3GlCPUgfnMFOrb6UCgYKNfcFAE4ss74XyuPBh3nPCAmzMmlgsH5HsSxG1eT
         fTSyY3zBKhnMhL24+OoaaNR6oCeJ3aBThsGu8Rvm269yge4gwHrVnKlL4dYZFE5mIVUR
         A9bfe+/oF9CtuLd2kjZC1hNTPiJ5ofDRpipixgaacr4aor7WpjMI9+SRcpalUyiJYpK7
         0SMTA3scQi8N9IQo+C8q6Zr1BfUH8T47ZiIoymCogj91xAhkp0oKJSkHqZKW5GNkGrlT
         Cq6dz2WAV8tQXOt8lSjiiBGicW2EszP8Jg3Hk6XnSQbVfLgxVs5HuAYx68/Ps/szjw08
         vixA==
X-Gm-Message-State: AOAM531jfOZCXATihGlSx3/AGm5LGQtiEvbWYRjTs4CUtmOgMT6jeWSk
        wDM7/DEmX+cwevDGzsj17vc=
X-Google-Smtp-Source: ABdhPJyeCuj7I9k2tqVXowyjGr6fnhGiTMtvu86730HYRIIDYqLHsIw4A0xe43av8c355Tei87QCUw==
X-Received: by 2002:adf:f0cd:: with SMTP id x13mr4264272wro.370.1617800065321;
        Wed, 07 Apr 2021 05:54:25 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id n17sm15063930wrs.84.2021.04.07.05.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 05:54:24 -0700 (PDT)
Date:   Wed, 7 Apr 2021 14:54:23 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: crashkernel reservation failed - No suitable area found on a
 cortina/gemini SoC
Message-ID: <YG2rfzRvHIZKXkf/@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I try to do kexec on a cortina/gemini SoC.
On a "normal" boot, kexec fail to find memory so I added crashkernel=8M to cmdline. (kernel size is ~6M).
But now, kernel fail to reserve memory:
Load Kern image from 0x30020000 to 0x800000 size 7340032                                            
Booting Linux on physical CPU 0x0                                                                   
Linux version 5.12.0-rc5-next-20210401+ (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 9.3.0-r2 p4) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #98 PREEMPT Wed Apr 7 14:14:08 CEST 2021
CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f                                               
CPU: VIVT data cache, VIVT instruction cache                                                        
OF: fdt: Machine model: Edimax NS-2502                                                              
Memory policy: Data cache writeback                                                                 
Zone ranges:                                                                                        
  Normal   [mem 0x0000000000000000-0x0000000007ffffff]                                              
  HighMem  empty                                                                                    
Movable zone start for each node                                                                    
Early memory node ranges                                                                            
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]                                             
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]                                    
crashkernel reservation failed - No suitable area found.                                            
Built 1 zonelists, mobility grouping on.  Total pages: 32512                                        
Kernel command line: console=ttyS0,19200n8 ip=dhcp crashkernel=8M                                   
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)                              
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)                                
mem auto-init: stack:off, heap alloc:off, heap free:off                                             
Memory: 119476K/131072K available (5034K kernel code, 579K rwdata, 1372K rodata, 3020K init, 210K bss, 11596K reserved, 0K cma-reserved, 0K highmem)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1                                          

What can I do ?

Thanks
Regards
