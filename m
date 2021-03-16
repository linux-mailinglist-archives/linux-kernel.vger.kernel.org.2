Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1595433CBE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhCPDSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhCPDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:17:53 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBABC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:17:53 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so6164614oto.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1xDPeykeJpE8/53P0YWT3nntzZKV5Yu2PY4r8ou2l0w=;
        b=NrvAzJfu1kPoc+7FtqPoS3kwt9AcsTrp0EZQ1Yz1na1vRB50A5Udii0brdlenUvkMq
         TdRoXalnDlDbruitvGAzOegvv4o5hMGv5a15rU2bDeAhNugmYfJU83YKZEt4rbSi0FXT
         NkQ2LJM9AofS6TWE+oxMKaKxf9TjjcafEhuCcmmS/LKagOLcuIaPTsAuKTHGzIZzs2cR
         /24G0vhf9aD8YmsvRAa5hr/3oFBhzO7jtqpD3qd/ZRwMWo+GfUHHEI29YfKwunUtEASx
         Ol16acLj558ZjFso0+Gnyi2vEPy5mipuYTaFZRzfvN8cGtiLFV79Ob/3W9jSrfwV+wre
         jXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1xDPeykeJpE8/53P0YWT3nntzZKV5Yu2PY4r8ou2l0w=;
        b=thBWN9XHus/Y1zd03zdMXf1m87+2SF8EEKuh6AWbEZ18JlC6i5tfKi3HCPxSOi+xHn
         hzZ6rrETcIq6/4rOIgtcTB3JpbcsP7Zm9ru/cC9SdozFxGR+hozsdCa9L2R+ix+Rye9D
         B2VCpxNVu/WCRnsXSHDx/63vz6o/ZmMTPo/PZuOM9dQLTp0fHnvOWZIqTdCSw4YXnPQG
         eNleMtw6+mzwX3nEhWjKAwuAMXP0hmblXs3Tty6Yj5EeQrcs3twffLp/nT+CVXgRHXEg
         M2qCAzQ3oEG8RUy8nOxnK4a5khqxv9ibKdhGm2NgI2RI6bxiyAIgTIFA72pOPCy+5+b3
         nITA==
X-Gm-Message-State: AOAM530rixjWwBzsSMO8nAXLJKlLLP9RmDw4HohwyvfB3X2BmedljyQX
        oRMlAS9CN66BQBAdxFgYGdzlaFVw1tAnNNXCnLs=
X-Google-Smtp-Source: ABdhPJwE6z/CPX42yTFe1d1ufeTo1Kxv4eGUtNZTq7+WAI8U6L5zKma/b759NyahVXhiJ5lmgzqZRFpIy9ThpUR0cEU=
X-Received: by 2002:a9d:12a7:: with SMTP id g36mr1723395otg.304.1615864672742;
 Mon, 15 Mar 2021 20:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210310062250.74583-1-liu@jiuyang.me> <20210316015328.13516-1-liu@jiuyang.me>
In-Reply-To: <20210316015328.13516-1-liu@jiuyang.me>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Tue, 16 Mar 2021 03:15:05 +0000
Message-ID: <CALecT5iDxuzRPvPg8w=WmLT9XtWxOieDN=iRoY0nAdyhdLV+SQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bug Fix for last patch
To:     Jiuyang Liu <liu@jiuyang.me>
Cc:     Andrew Waterman <waterman@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiuyang

On Tue, Mar 16, 2021 at 1:56 AM Jiuyang Liu <liu@jiuyang.me> wrote:
>
> Sorry for the noise, Andrew gave me feedbacks, and pointed two bugs in
> last patch.
> 1. asid should be thread safe, which is not the intent.
> 2. asid extracting logic was wrong.
>
> This patch fixes these bugs.
>
> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> ---
>  arch/riscv/include/asm/tlbflush.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 4b25f51f163d..1f9b62b3670b 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -22,10 +22,14 @@ static inline void local_flush_tlb_page(unsigned long addr)
>         __asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
>  }
>
> -static unsigned long asid;
> +static inline unsigned long get_current_asid(void)
> +{
> +       return (csr_read(CSR_SATP) >> SATP_ASID_SHIFT) & SATP_ASID_MASK;
> +}
> +
>  static inline void local_flush_tlb_asid(void)
>  {
> -       asid = csr_read(CSR_SATP) | (SATP_ASID_MASK << SATP_ASID_SHIFT);
> +       unsigned long asid = get_current_asid();
>         __asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
>  }
>

This patch title is  too obscure to parse, it should clearly reflect
what's the changes doing here

my two suggestions
1) if previous patches have already been merged, then you probably
should fix title (the commit message)
 and re-send the patch? and maybe add a "Fixes" tag here
2) if previous patches still under reviewing.. then
  a) you can send an update patches series (can squash this fix)
  b) or maintainer willing to squash this fix for you?
