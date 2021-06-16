Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5551C3A9E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhFPPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhFPPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:04:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4687FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I5DjI7oj7+RHnDV6cxwDeOoQ3n60YwGRMyOOSPM02Qk=; b=FdKzXZ9x5ATmodn0JioFshI/ht
        bdpS5+BCXFSEs+EM4u+wfgZ0T6OKJCP/WkbnVQi3YNxOcuedepjMeyiMX9264TX3MQJaKszqGFgbo
        4uvKVdhXRRK8u5GgHORw45pFBRkzSAzZBfyjVsW/4AOY93ztSstnsy5dU8B00kSIry2/1CcUNlp7n
        FhUhDHRYOhfr4cA/CaaLW3XuaaC1lPhNNsasz/NDn8eMulp0Njdvf2m4DR5k8Q9zVeBHqJXk9R9Na
        NR+8ZKhGQZsDOMEDmNefJ6KCJVtznwT7/l8liFHleWZrSoSFeJBPFbAC2uf/qO/hXLkZ5t0bbJLyr
        yKnVWqnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltX2W-008AIS-NX; Wed, 16 Jun 2021 15:01:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC5F8300269;
        Wed, 16 Jun 2021 17:01:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C11E42C516D3B; Wed, 16 Jun 2021 17:01:10 +0200 (CEST)
Date:   Wed, 16 Jun 2021 17:01:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     rostedt@goodmis.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, mhelsley@vmware.com,
        samitolvanen@google.com, yj.chiang@mediatek.com
Subject: Re: [PATCH v3] recordmcount: Correct st_shndx handling
Message-ID: <YMoSNnNXmKnDpJEv@hirez.programming.kicks-ass.net>
References: <20210615162313.26081-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615162313.26081-1-mark-pk.tsai@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:23:13AM +0800, Mark-PK Tsai wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> One should only use st_shndx when >SHN_UNDEF and <SHN_LORESERVE. When
> SHN_XINDEX, then use .symtab_shndx. Otherwise use 0.
> 
> This handles the case: st_shndx >= SHN_LORESERVE && st_shndx != SHN_XINDEX.
> 
> Reported-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> [handle endianness of sym->st_shndx]
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  scripts/recordmcount.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> index f9b19524da11..ef9c3425f86b 100644
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -194,13 +194,18 @@ static unsigned int get_symindex(Elf_Sym const *sym, Elf32_Word const *symtab,
>  	unsigned long offset;
>  	int index;
>  
> +	if (w2(sym->st_shndx) > SHN_UNDEF &&
> +	    w2(sym->st_shndx) < SHN_LORESERVE)
>  		return w2(sym->st_shndx);
>  
> +	if (w2(sym->st_shndx) == SHN_XINDEX) {
> +		offset = (unsigned long)sym - (unsigned long)symtab;
> +		index = offset / sizeof(*sym);
>  
> +		return w(symtab_shndx[index]);
> +	}
> +
> +	return 0;
>  }

Thanks. However that leads to atrocious codegen because w2 is an
indirect function, something like the below seems much better.

1d00:       41 0f b7 7f 0e          movzwl 0xe(%r15),%edi
1d05:       c0 eb 04                shr    $0x4,%bl
1d08:       ff 15 7a 54 00 00       callq  *0x547a(%rip)        # 7188 <w2>
1d0e:       85 c0                   test   %eax,%eax
1d10:       74 16                   je     1d28 <main+0xba8>
1d12:       41 0f b7 7f 0e          movzwl 0xe(%r15),%edi
1d17:       ff 15 6b 54 00 00       callq  *0x546b(%rip)        # 7188 <w2>
1d1d:       3d ff fe 00 00          cmp    $0xfeff,%eax
1d22:       0f 86 00 03 00 00       jbe    2028 <main+0xea8>
1d28:       41 0f b7 7f 0e          movzwl 0xe(%r15),%edi
1d2d:       ff 15 55 54 00 00       callq  *0x5455(%rip)        # 7188 <w2>

vs

1d0c:       41 0f b7 7f 0e          movzwl 0xe(%r15),%edi
1d11:       ff 15 71 54 00 00       callq  *0x5471(%rip)        # 7188 <w2>

---
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index f9b19524da11..b3e9d0563c03 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -192,15 +192,23 @@ static unsigned int get_symindex(Elf_Sym const *sym, Elf32_Word const *symtab,
 				 Elf32_Word const *symtab_shndx)
 {
 	unsigned long offset;
+	unsigned short shndx;
 	int index;
 
-	if (sym->st_shndx != SHN_XINDEX)
-		return w2(sym->st_shndx);
+	shndx = w2(sym->st_shndx);
 
-	offset = (unsigned long)sym - (unsigned long)symtab;
-	index = offset / sizeof(*sym);
+	if (shndx > SHN_UNDEF &&
+	    shndx < SHN_LORESERVE)
+		return shndx;
 
-	return w(symtab_shndx[index]);
+	if (shndx == SHN_XINDEX) {
+		offset = (unsigned long)sym - (unsigned long)symtab;
+		index = offset / sizeof(*sym);
+
+		return w(symtab_shndx[index]);
+	}
+
+	return 0;
 }
 
 static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
