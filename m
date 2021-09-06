Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E828401D44
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbhIFOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239634AbhIFOx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:53:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CE7260F45;
        Mon,  6 Sep 2021 14:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630939940;
        bh=esriyLvHzgDbNbMTj20a96cZLW13fHn4a0ByWh6XP+g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KcYhHBs9fdRDjTk7RH9aIZVinHoR2vjZEz0e54G9S7uSfxlE/yo8dpCOjtX+xoiQu
         pHpVvRwZPSuJs3x067lbm7XucF9xaTP9R41GvjLrly2PbcINPz1RBzhw1a3Sm+dHas
         nyStzQKySPOZjsGNH6pY3FP9kMMCH2sVxe+pa+glT7XSGRJrzwXwQimJiJmHpq6oNE
         gJGVpfQC7Q2BY8iKme1D4vegJ6/ovQjBCp+J8B3RGY0qTjJh2qPNwY+17DAfEVZGVo
         jAYzDfz9VRjgGgCHlhQ5W8V/7tsSB3p+p05SX2kvSY0wYQpBkbfG3zG6hRkBi7SHeU
         6avXQ60ljRmwQ==
Message-ID: <15bb23ac8b8cefdd8b976a8b20e161715b32da19.camel@kernel.org>
Subject: Re: 5.4.143-rt63 fscache_cookie_hash initialisation
From:   Tom Zanussi <zanussi@kernel.org>
To:     Gregor Beck <gregor.beck@gmail.com>, linux-kernel@vger.kernel.org
Cc:     "williams@redhat.com" <williams@redhat.com>, bigeasy@linutronix.de
Date:   Mon, 06 Sep 2021 09:52:19 -0500
In-Reply-To: <CAEvSrY+XS2+xYTDT=up6VwLer8STS1KmNbP43PjZ4Z=qKvL4-w@mail.gmail.com>
References: <CAEvSrY+XS2+xYTDT=up6VwLer8STS1KmNbP43PjZ4Z=qKvL4-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregor,

On Mon, 2021-09-06 at 09:55 +0200, Gregor Beck wrote:
> Hi,
> 
> Patch 602660600bcdb53e56a87edee6b4dbbcc248a0cc "fscache: initialize
> cookie hash table raw spinlocks" fails to initialize the last element
> of fscache_cookie_hash.
> 
> [   79.218128] 003: BUG: spinlock bad magic on CPU#3, bash/2090 
> [   79.218132] 003:  lock:
> fscache_cookie_hash+0xfffe8/0xffffffffffff4fa0 [fscache], .magic:
> 00000000, .owner: <none>/-1
> , .owner_cpu: 0 
> [   79.218140] 003: CPU: 3 PID: 2090 Comm: bash Not tainted 5.4.143-
> rt63 #1 
> [   79.218141] 003: Hardware name: To be filled by O.E.M. To be
> filled by O.E.M./MAHOBAY, BIOS 4.6.5 11/07/2013 
> [   79.218142] 003: Call Trace: 
> [   79.218145] 003:  dump_stack+0x50/0x63 
> [   79.218149] 003:  do_raw_spin_lock+0x71/0xc0 
> [   79.218152] 003:  fscache_hash_cookie+0x3e/0x390 [fscache] 
> [   79.218156] 003:  __fscache_acquire_cookie+0x9f/0x2d0 [fscache] 
> [   79.218159] 003:  nfs_fscache_init_inode+0xbf/0xe0 [nfs] 
> [   79.218171] 003:  nfs_fhget+0x416/0x600 [nfs] 
> [   79.218177] 003:  nfs_readdir_page_filler+0x551/0x690 [nfs] 
> [   79.218183] 003:  nfs_readdir_xdr_to_array+0x2ba/0x420 [nfs] 
> [   79.218188] 003:  ? preempt_count_sub+0x9b/0xd0 
> [   79.218190] 003:  nfs_readdir_filler+0x1d/0x80 [nfs] 
> [   79.218195] 003:  do_read_cache_page+0x33c/0x780 
> [   79.218197] 003:  ? nfs_readdir_xdr_to_array+0x420/0x420 [nfs] 
> [   79.218201] 003:  ? verify_dirent_name+0x1c/0x30 
> [   79.218203] 003:  ? filldir64+0x3b/0x1c0 
> [   79.218204] 003:  nfs_readdir+0x20d/0x700 [nfs] 
> [   79.218209] 003:  ? nfs4_xdr_dec_server_caps+0xa0/0xa0 [nfsv4] 
> [   79.218222] 003:  iterate_dir+0x94/0x1a0 
> [   79.218223] 003:  ksys_getdents64+0xc1/0x170 
> [   79.218224] 003:  ? filldir+0x1c0/0x1c0 
> [   79.218226] 003:  __x64_sys_getdents64+0x16/0x20 
> [   79.218227] 003:  do_syscall_64+0x81/0x1b0 
> [   79.218229] 003:  entry_SYSCALL_64_after_hwframe+0x44/0xa9 
> [   79.218230] 003: RIP: 0033:0x7f3b7141781b
> 
> Gregor Beck
> 
> 

Thanks for the patch.  I'll apply it to the 5.4 rt stable kernel, but
it's missing your Signed-off-by:

Can you resend it after adding your Signed-off-by?

Thanks,

Tom



