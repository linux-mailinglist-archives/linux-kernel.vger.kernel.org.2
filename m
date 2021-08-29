Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF03FAAD3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 12:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhH2KSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 06:18:00 -0400
Received: from fallback14.mail.ru ([94.100.179.44]:56938 "EHLO
        fallback14.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhH2KR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 06:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=VZgNaS1mLdlvZJztEjsG9uU8c+U32c8iiPysRhjd9m4=;
        t=1630232225;x=1630837625; 
        b=Leq9hnTvQAvuO61wiw3nFJ19VYXAcpyznPZQpzYod6SDvVkjU9uFuO18e+3fqqaXMbeLIfQA51SHnXy3TjeoXPHOSoj82PPC6PPFfuoHfNMBQTSrV1wSAFzgJXLRO+CFaLRKRPdOWIkiCpPM40739b94fRL+wua9sZg946WH9ts=;
Received: from [10.161.64.56] (port=54290 helo=smtp48.i.mail.ru)
        by fallback14.m.smailru.net with esmtp (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1mKHs7-0004dB-W4
        for linux-kernel@vger.kernel.org; Sun, 29 Aug 2021 13:17:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=VZgNaS1mLdlvZJztEjsG9uU8c+U32c8iiPysRhjd9m4=;
        t=1630232223;x=1630837623; 
        b=OMjj1qhxTIDiibBio13CzLbzrlVAaDkDlkjTLKT8epKRRHjm7JprDCVjpbQqzbB4beS3io8WT0rEUrTGqZSA65972CQ6/C2aFVvjkZr0s0GaB/4HHFP3KLIM/HxjM/8FAvIEtF3VfF9YhgV4Kz1LbV16Z/5quvdkHweghCBwYcI91aR+UvkDOPdnwIdbvZwWTO/KPqelD8BG0pAc/+K4sFFGibHwjT1CURxwuZQPqoT332Fb/VARR7Og5jGfd6tiRKmUYEhB+VsGyi8/30we2jFP7QlykXX5RYidYDAQn9IPY+vbzZ+q2Uu2H48NvL5xaBrlE5FglXJdy5KUrKZLwg==;
Received: by smtp48.i.mail.ru with esmtpa (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1mKHs1-0002yE-1L; Sun, 29 Aug 2021 13:16:57 +0300
Date:   Sun, 29 Aug 2021 13:16:49 +0300
From:   Sergey Larin <cerg2010cerg2010@mail.ru>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: vdso: map data page before vDSO code
Message-ID: <YStekax6zSKApmRC@hp>
References: <20210829094708.169037-1-cerg2010cerg2010@mail.ru>
 <02601412-6f01-f4e5-699a-e285fc3fdf3a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02601412-6f01-f4e5-699a-e285fc3fdf3a@huawei.com>
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD92087353F0EC44DD9C4DAED859F16A63896D62C811FDE4A33182A05F5380850400EE31BA4DA85BC9891809E91445A529A4066006618D1C40D9E25B3326023DA7B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE74FC7AD0AD96C1577EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637829D9538242026C38638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8BE3992D3DA6F0F9073F11D206F93CADB6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE77A825AB47F0FC8649FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD186FD1C55BDD38FC3FD2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B5F0C88D684269EDEA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC702ADF1C0A6F83E73AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F7900637EDDE4FD3F6DF783AD81D268191BDAD3D698AB9A7B718F8C4D1B931868CE1C5781A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F783D6DB41994EC49CE5475246E174218B5C8C57E37DE458BEDA766A37F9254B7
X-B7AD71C0: AC4F5C86D027EB782CDD5689AFBDA7A213B5FB47DCBC3458834459D11680B505A58435F6B5465CCF6E8D7AE0BB36E769
X-C1DE0DAB: 0D63561A33F958A5ADA0B25F9C80F90779E9679EB5508820042D3654C38D9FF9D59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA75438CC92D4039F4E2410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34A63B03BCD35E0C0AF1593815AD0C10A101A327B40812B95BE11397FA7036B6955BEAADA9564F020D1D7E09C32AA3244C7A6454AD43A0A4B997B4CD5B2E18516E24AF4FAF06DA24FD8D5DD81C2BAB7D1D
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMpcxcuSaa4E1/55aF8zTjw==
X-Mailru-Sender: B6CA852314BECD1116C83C047D515D65CA45700ABDFD0123026E14154E9EB39DD944A9F887ED1F5C51913ECE9F5D4CE557914126969F3D9578C09B768FF42B7F4F0A872F021F9059A8B6234B51EB8B42EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4EE34287C01580B6095C43D2429CE7A3C2B8C540259D1F90968F3CF0E9FE49B6984C502FDBC3AF4E6D7ABB023218671980593E66C519BEA807954FE7AC07484BC
X-7FA49CB5: 0D63561A33F958A5DAD7999207A75F962426B3F8CA4B7215D836CD57F07BC103CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F790063740F9514592BAD022389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC862B3BD3CC35DA588F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CDBD6BAFA574C84446136E347CC761E074AD6D5ED66289B52698AB9A7B718F8C442539A7722CA490CD5E8D9A59859A8B682A37EEB73323C7B089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5DAD7999207A75F962426B3F8CA4B7215F25C09985F17A3E8D59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMpcxcuSaa4GqbnykfKRuaA==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C90057D89EA641BAE1DDB6AB638527746623CC59331E8E368B04B816609AA8FC7A761CAD91EC71FC00F3837D2A27E1A8065646C7A2150F6097340301919DCEDD5454186FA049C4F996C4B5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 05:59:04PM +0800, Kefeng Wang wrote:
> Hi Sergey
> 
> There is already one fix,
> 
> https://patchwork.kernel.org/project/linux-riscv/list/?series=534877
> 

Oh, I missed it. That one looks cleaner. Thanks anyway!

> On 2021/8/29 17:47, Sergey Larin wrote:
> > Current vDSO implementation assumes that the code size always fits in
> > single page, and the data page follows it:
> > 
> > 	PROVIDE(_vdso_data = . + PAGE_SIZE);
> > 
> > However, this was not the case with my kernel build - the
> > shared object had the size of 4800 bytes. This, obviously, is more than
> > 4096 and requires second page for the rest of the data.
> > 
> > CLOCK_REALTIME_COARSE clock became broken. It was always returning 0
> > because vDSO code was reading the second code page, not the
> > data page. Glibc uses this clock for the time() function.
> > 
> > So instead of computing the offset for the data page (it is necessary to
> > do in runtime - you can't know the size of the binary while you're
> > building it) simply move it behind the code like the ARM does:
> > 
> > 	PROVIDE(_vdso_data = . - PAGE_SIZE);
> > 
> > This commit also fixes arch_vma_name for the data page - it was
> > reporting the same '[vdso]' name for it in my case.
> > 
> > Since I don't have the real hardware, the change was debugged with KGDB
> > in RVVM and also verified in QEMU.
> > 
> > Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
> > ---
> >   arch/riscv/kernel/vdso.c          | 22 +++++++++++-----------
> >   arch/riscv/kernel/vdso/vdso.lds.S |  2 +-
> >   2 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> > index 25a3b8849599..0c49390e9be3 100644
> > --- a/arch/riscv/kernel/vdso.c
> > +++ b/arch/riscv/kernel/vdso.c
> > @@ -44,13 +44,13 @@ static int __init vdso_init(void)
> >   		return -ENOMEM;
> >   	}
> > +	vdso_pagelist[0] = virt_to_page(vdso_data);
> >   	for (i = 0; i < vdso_pages; i++) {
> >   		struct page *pg;
> >   		pg = virt_to_page(vdso_start + (i << PAGE_SHIFT));
> > -		vdso_pagelist[i] = pg;
> > +		vdso_pagelist[i + 1] = pg;
> >   	}
> > -	vdso_pagelist[i] = virt_to_page(vdso_data);
> >   	return 0;
> >   }
> > @@ -77,21 +77,21 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
> >   	 * install_special_mapping or the perf counter mmap tracking code
> >   	 * will fail to recognise it as a vDSO (since arch_vma_name fails).
> >   	 */
> > -	mm->context.vdso = (void *)vdso_base;
> > +	mm->context.vdso = (void *)vdso_base + PAGE_SIZE;
> > -	ret =
> > -	   install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
> > -		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
> > -		vdso_pagelist);
> > +	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
> > +		(VM_READ | VM_MAYREAD), &vdso_pagelist[0]);
> >   	if (unlikely(ret)) {
> >   		mm->context.vdso = NULL;
> >   		goto end;
> >   	}
> > -	vdso_base += (vdso_pages << PAGE_SHIFT);
> > -	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
> > -		(VM_READ | VM_MAYREAD), &vdso_pagelist[vdso_pages]);
> > +	vdso_base += PAGE_SIZE;
> > +	ret =
> > +	   install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
> > +		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
> > +		&vdso_pagelist[1]);
> >   	if (unlikely(ret))
> >   		mm->context.vdso = NULL;
> > @@ -105,7 +105,7 @@ const char *arch_vma_name(struct vm_area_struct *vma)
> >   	if (vma->vm_mm && (vma->vm_start == (long)vma->vm_mm->context.vdso))
> >   		return "[vdso]";
> >   	if (vma->vm_mm && (vma->vm_start ==
> > -			   (long)vma->vm_mm->context.vdso + PAGE_SIZE))
> > +			   (long)vma->vm_mm->context.vdso - PAGE_SIZE))
> >   		return "[vdso_data]";
> >   	return NULL;
> >   }
> > diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> > index e6f558bca71b..fd8a31075256 100644
> > --- a/arch/riscv/kernel/vdso/vdso.lds.S
> > +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> > @@ -8,7 +8,7 @@ OUTPUT_ARCH(riscv)
> >   SECTIONS
> >   {
> > -	PROVIDE(_vdso_data = . + PAGE_SIZE);
> > +	PROVIDE(_vdso_data = . - PAGE_SIZE);
> >   	. = SIZEOF_HEADERS;
> >   	.hash		: { *(.hash) }			:text
