Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878FF34FD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhCaJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234689AbhCaJjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:39:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C399E61954;
        Wed, 31 Mar 2021 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617183583;
        bh=f+fwWDGLY+gVOzJtajN7go3Pyscihbt/vp3GyZITTT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVw2zSj1KYLYpU1NanCuviovXBPPaQW53oxlVvKT4kv+NXQU56Os/FC0jiSRN3Xbe
         ieiKPEgtSx3/ECd4q9QdYNPjy8fltYD5QR0BqGhPg9ZF2dzk8IrafRXk1wBcHuwlGV
         W5v1vPItC6bMtnRmSybyGhPBofiUJB9nlhNMhP59aUfFzErWJB8w436TGHwdHzErrF
         BWYr40/g1YRP+LJemrmvVhAiCBqT1lbG/ZStqAVio9909B9rrZXFfvAnqt6Pg3dHvF
         T4fwnmKaEu9eqzhEj/d6m4qNEUsJLoxQ5PXX5cPgAoxkhwZETHr1j+wwR6ER424rZq
         gcHglVtHEddug==
Date:   Wed, 31 Mar 2021 12:39:36 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: assign pagewalk.h to MEMORY MANAGEMENT
Message-ID: <YGRDWLUea442tV7f@kernel.org>
References: <20210322122542.15072-1-lukas.bulwahn@gmail.com>
 <20210322122542.15072-2-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322122542.15072-2-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 01:25:41PM +0100, Lukas Bulwahn wrote:
> Commit a520110e4a15 ("mm: split out a new pagewalk.h header from mm.h")
> adds a new file in ./include/linux, but misses to update MAINTAINERS
> accordingly. Hence, ./scripts/get_maintainers.pl ./include/linux/pagewalk.h
> points only to lkml as general fallback for all files, whereas the original
> ./include/linux/mm.h clearly marks this file part of MEMORY MANAGEMENT.
> 
> Assign ./include/linux/pagewalk.h to MEMORY MANAGEMENT.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 728216e3919c..46a1eddbc3e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11622,6 +11622,7 @@ F:	include/linux/gfp.h
>  F:	include/linux/memory_hotplug.h
>  F:	include/linux/mm.h
>  F:	include/linux/mmzone.h
> +F:	include/linux/pagewalk.h

I'd say that we miss all include/linux/page* here, not only pagewalk.h

>  F:	include/linux/vmalloc.h
>  F:	mm/
>  
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
