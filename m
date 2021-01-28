Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD3307E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhA1Scs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232025AbhA1SaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:30:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D94EE64E21;
        Thu, 28 Jan 2021 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611858570;
        bh=M/9iib7EUl+teJJ5Nt79x4C6G+veFLWaJLvCXe++AXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R37q87TVpHIwC9hpzw6MBZTDhaEPoQx971k8hQBJeYsGCYdf3xMzFOZ2M8StJbSWx
         dcBrv3S6xDTZ2cUXMhknaHfuOc4+Sa085qHc6OX1R+PNVzJE9DeGg+3d2ERJxcbGd1
         f0lPldpdl5ReNnSjINAVEkWJr5U8v66Tu9UumDDnrdHaOHK4YHPFyIFYWdPPQ0Eqiq
         Zu4NhozMhTuTMzIasq0IKSxnm93GFX33CvN+HE+P9/ufiZZFmEpdo+/cI1nkYmLTnO
         yHpuh8mzxBzcrbhbewTzBAA2mpKSJFarZwepY1xtCssYHsAbMNYt/DcSOIIP5xErRr
         3K9WK6WTYlZzg==
From:   Will Deacon <will@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/nommu: Fix return type of filemap_map_pages()
Date:   Thu, 28 Jan 2021 18:29:24 +0000
Message-Id: <161184303238.1971604.11069435708421042062.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210128100626.2257638-1-geert@linux-m68k.org>
References: <20210128100626.2257638-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 11:06:26 +0100, Geert Uytterhoeven wrote:
> If CONFIG_MMU is not set (e.g. m68k/m5272c3_defconfig):
> 
>     mm/nommu.c:1671:6: error: conflicting types for ‘filemap_map_pages’
>      1671 | void filemap_map_pages(struct vm_fault *vmf,
> 	  |      ^~~~~~~~~~~~~~~~~
>     In file included from mm/nommu.c:20:
>     ./include/linux/mm.h:2578:19: note: previous declaration of ‘filemap_map_pages’ was here
>      2578 | extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> 	  |                   ^~~~~~~~~~~~~~~~~
> 
> [...]

Applied to arm64 (for-next/faultaround), thanks!

[1/1] mm/nommu: Fix return type of filemap_map_pages()
      https://git.kernel.org/arm64/c/3f98a28cc372

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
