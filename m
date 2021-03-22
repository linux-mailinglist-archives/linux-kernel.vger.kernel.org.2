Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE543344856
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCVO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhCVO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:57:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D48C061762
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:57:19 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lOLzY-001lCy-0n; Mon, 22 Mar 2021 15:57:16 +0100
Message-ID: <69743b4e0fe1364f1d933a883bd580e7b76129f0.camel@sipsolutions.net>
Subject: Re: Build regressions/improvements in v5.12-rc4
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Gary Guo <gary@garyguo.net>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-um <linux-um@lists.infradead.org>
Date:   Mon, 22 Mar 2021 15:57:14 +0100
In-Reply-To: <CAMuHMdVvCGa6SaumOOA-hM=WDEb7WHgXTNRsTrU=BnCXGqcr2g@mail.gmail.com>
References: <20210322141417.1062111-1-geert@linux-m68k.org>
         <CAMuHMdVvCGa6SaumOOA-hM=WDEb7WHgXTNRsTrU=BnCXGqcr2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-22 at 15:43 +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 22, 2021 at 3:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v5.12-rc4[1] to v5.12-rc3[3], the summaries are:
> >   - build errors: +6/-2
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b/ (all 192 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1e28eed17697bcf343c6743f0028cc3b5dd88bf0/ (all 192 configs)
> 
> > 6 error regressions:
> >   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
> >   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emaclite.ko] undefined!:  => N/A
> >   + error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
> >   + error: modpost: "devm_platform_ioremap_resource" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
> >   + error: modpost: "devm_platform_ioremap_resource_byname" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
> 
> x86_64/um-allmodconfig

I'd guess that's a missing 'depends on HAS_IOMEM'.

johannes

