Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C8C3A9F16
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhFPPb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:31:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60337 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233949AbhFPPb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:31:58 -0400
X-UUID: f2bd905068764510afb6cb637a10eb58-20210616
X-UUID: f2bd905068764510afb6cb637a10eb58-20210616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1351017316; Wed, 16 Jun 2021 23:29:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 23:29:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 23:29:46 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <peterz@infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mhelsley@vmware.com>,
        <rostedt@goodmis.org>, <samitolvanen@google.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v3] recordmcount: Correct st_shndx handling
Date:   Wed, 16 Jun 2021 23:29:46 +0800
Message-ID: <20210616152946.2709-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YMoSNnNXmKnDpJEv@hirez.programming.kicks-ass.net>
References: <YMoSNnNXmKnDpJEv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jun 16, 2021 at 12:23:13AM +0800, Mark-PK Tsai wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > One should only use st_shndx when >SHN_UNDEF and <SHN_LORESERVE. When
> > SHN_XINDEX, then use .symtab_shndx. Otherwise use 0.
> > 
> > This handles the case: st_shndx >= SHN_LORESERVE && st_shndx != SHN_XINDEX.
> > 
> > Reported-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > [handle endianness of sym->st_shndx]
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > ---
> >  scripts/recordmcount.h | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> > index f9b19524da11..ef9c3425f86b 100644
> > --- a/scripts/recordmcount.h
> > +++ b/scripts/recordmcount.h
> > @@ -194,13 +194,18 @@ static unsigned int get_symindex(Elf_Sym const *sym, Elf32_Word const *symtab,
> >  	unsigned long offset;
> >  	int index;
> >  
> > +	if (w2(sym->st_shndx) > SHN_UNDEF &&
> > +	    w2(sym->st_shndx) < SHN_LORESERVE)
> >  		return w2(sym->st_shndx);
> >  
> > +	if (w2(sym->st_shndx) == SHN_XINDEX) {
> > +		offset = (unsigned long)sym - (unsigned long)symtab;
> > +		index = offset / sizeof(*sym);
> >  
> > +		return w(symtab_shndx[index]);
> > +	}
> > +
> > +	return 0;
> >  }
> 
> Thanks. However that leads to atrocious codegen because w2 is an
> indirect function, something like the below seems much better.

Oh, I didn't notice that.
I'll update in v4.
Thanks!

> 
> 1d00:       41 0f b7 7f 0e          movzwl 0xe(%r15),%edi
> 1d05:       c0 eb 04                shr    $0x4,%bl
> 1d08:       ff 15 7a 54 00 00       callq  *0x547a(%rip)        # 7188 <w2>
> 1d0e:       85 c0                   test   %eax,%eax
> 1d10:       74 16                   je     1d28 <main+0xba8>
> 1d12:       41 0f b7 7f 0e          movzwl 0xe(%r15),%edi
> 1d17:       ff 15 6b 54 00 00       callq  *0x546b(%rip)        # 7188 <w2>
> 1d1d:       3d ff fe 00 00          cmp    $0xfeff,%eax
> 1d22:       0f 86 00 03 00 00       jbe    2028 <main+0xea8>
> 1d28:       41 0f b7 7f 0e          movzwl 0xe(%r15),%edi
> 1d2d:       ff 15 55 54 00 00       callq  *0x5455(%rip)        # 7188 <w2>
> 
> vs
> 
> 1d0c:       41 0f b7 7f 0e          movzwl 0xe(%r15),%edi
> 1d11:       ff 15 71 54 00 00       callq  *0x5471(%rip)        # 7188 <w2>
> 
> ---
> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> index f9b19524da11..b3e9d0563c03 100644
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -192,15 +192,23 @@ static unsigned int get_symindex(Elf_Sym const *sym, Elf32_Word const *symtab,
>  				 Elf32_Word const *symtab_shndx)
>  {
>  	unsigned long offset;
> +	unsigned short shndx;
>  	int index;
>  
> -	if (sym->st_shndx != SHN_XINDEX)
> -		return w2(sym->st_shndx);
> +	shndx = w2(sym->st_shndx);
>  
> -	offset = (unsigned long)sym - (unsigned long)symtab;
> -	index = offset / sizeof(*sym);
> +	if (shndx > SHN_UNDEF &&
> +	    shndx < SHN_LORESERVE)
> +		return shndx;
>  
> -	return w(symtab_shndx[index]);
> +	if (shndx == SHN_XINDEX) {
> +		offset = (unsigned long)sym - (unsigned long)symtab;
> +		index = offset / sizeof(*sym);
> +
> +		return w(symtab_shndx[index]);
> +	}
> +
> +	return 0;
>  }
>  
>  static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
