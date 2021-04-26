Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7483A36B7D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhDZRNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbhDZRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:12:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19D8C06134F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=mzciic0bLFIlvJTXnpZfDLwa2yVqJwmOaNREIm8p9rE=; b=LYBgMjMHb0jaj0KdW+1lsyuNjJ
        tlhjLhfp+AZos5GLxdnvx5k4uK/KPEX3SvCOkzSELtYEnyNepqXXgrxsuhpyVZ3EfkmMMFLVd77dD
        8/4RpdF4wbPwWHfzOTkVXcQt0Rfy8qnKxQUsF6xS7zgSf8b27jLECY1d8sZiH6zQtP0R5z3D9alPe
        AnmZ9nU14/tt/RhwgeGwkZBo42+XVSjt/nWQLp+uhrV3WKMIMFstSN4/qXqisf0dzGXwUKCLDW65x
        v/0suSxtmTKQWTaKh2T4vampc8ZPNx2bwJ0GG9bfwCz1zK0sVkMw2WxGWr6ljROGrtuGOT+davE2X
        XsbfWJmQ==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb4lR-005tDl-OB; Mon, 26 Apr 2021 17:11:28 +0000
Subject: Re: Build regressions/improvements in v5.12
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <20210426064151.3466465-1-geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <47632e42-3e27-d599-84b0-3ca8cb5e952c@infradead.org>
Date:   Mon, 26 Apr 2021 10:11:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210426064151.3466465-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/21 11:41 PM, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.12[1] compared to v5.11[2].
> 
> Summarized:
>   - build errors: +5/-0
>   - build warnings: +110/-10
> 
> JFYI, when comparing v5.12[1] to v5.12-rc8[3], the summaries are:
>   - build errors: +0/-0
>   - build warnings: +0/-0
> 
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
> 
> Happy fixing! ;-)
> 
> Thanks to the linux-next team for providing the build service.
> 
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9f4ad9e425a1d3b6a34617b8ea226d56a119a717/ (191 out of 193 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f40ddce88593482919761f74910f42f4b84c004b/ (all 193 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bf05bf16c76bb44ab5156223e1e58e26dfe30a88/ (192 out of 193 configs)
> 
> 
> *** ERRORS ***
> 
> 5 error regressions:
>   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
>   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emaclite.ko] undefined!:  => N/A
>   + error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource_byname" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A

https://git.kernel.org/netdev/net-next/c/46fd4471615c

These should all be fixed in net-next and linux-next.
I suppose they will be merged in the current 2-week merge window.

-- 
~Randy

