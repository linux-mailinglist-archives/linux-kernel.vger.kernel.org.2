Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A22356B2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbhDGL14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:27:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36649 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234334AbhDGL1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:27:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FFhvf0Fmvz9sWY;
        Wed,  7 Apr 2021 21:27:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1617794864;
        bh=Cj3f8ngloiA9HcJv0SBAooX4hLm02FHFDJHGT11hot4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ODAla7ndUsbsO31oqNPjrBU8zkC7Fp+vECJBoGGzU4J2dhiOl2L8LmJfhtgbZWVzt
         Y3mI9rf0jAiGHgr7KCr0OLNDnDSTl30UsMWXxcjChJT8goqJgYeInQdX3DlhWqMhvw
         MRxLqA34JMfG+VoniqJjTnhuOGueMiyk/BQWhKbmZadcseizWT316Fk6BEZf0yjffQ
         5MbKTdD9VaJ1B6XsrxNJ0xPIfwW/TenRQpQ9eOKUF78y+AuJ3+UxI69Ufz46OX/k3/
         dUpboJ8nF3C/9dcFuyW6j+19SI4BsnlQ65lBGF/dDbVuBIj+m4J1sNNMLxxokK214e
         e/SIus9w4F7Yg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Youlin Song <syl.loop@gmail.com>, robh+dt@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Youlin Song <syl.loop@gmail.com>
Subject: Re: [PATCH] powerpc/dts: fix not include DTC_FLAGS
In-Reply-To: <20210403020423.85278-1-syl.loop@gmail.com>
References: <20210403020423.85278-1-syl.loop@gmail.com>
Date:   Wed, 07 Apr 2021 21:27:22 +1000
Message-ID: <87y2due3mt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Youlin Song <syl.loop@gmail.com> writes:
> I wanted to build the fsl dts in my machine and found that
> the dtb have not extra space,so uboot will cause about
> FDT_ERR_NOSPACE issue.
>
> Signed-off-by: Youlin Song <syl.loop@gmail.com>
> ---
>  arch/powerpc/boot/dts/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
> index fb335d05aae8..c21165c0cd76 100644
> --- a/arch/powerpc/boot/dts/Makefile
> +++ b/arch/powerpc/boot/dts/Makefile
> @@ -2,5 +2,6 @@
>  
>  subdir-y += fsl
>  
> +DTC_FLAGS   ?= -p 1024
>  dtstree		:= $(srctree)/$(src)
>  dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))

I guess that was missed in 1acf1cf8638a ("powerpc: build .dtb files in dts directory").

Which I think means the assignment to DTC_FLAGS in
arch/powerpc/boot/Makefile is not needed anymore.

Can you send a v2 removing that assignment and explaining that's what
happened?

cheers
