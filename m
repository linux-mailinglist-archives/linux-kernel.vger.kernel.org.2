Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F34F41ABA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbhI1JVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:21:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58766 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239839AbhI1JVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:21:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB472222BC;
        Tue, 28 Sep 2021 09:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632820765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvEEH+NUSydT0GBp81GypO9UbLO4ySo4r83uSsiOMDc=;
        b=1vZj8QMW6bv+ZomgzmMCzl8xqbXsy44m+jI0HIBykRf/oYDbKJXtiAyMeKS7w/FALv0xha
        M9Tb2VKlBdtQxBvQ+AtC+mZHkRvtVlsqLiK/PTblGRv5eXIKBchyd+zd3kwh1sPgVPNxzS
        SYKKbrNyVCRxkXH5wb/ggbvBtmkBHBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632820765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvEEH+NUSydT0GBp81GypO9UbLO4ySo4r83uSsiOMDc=;
        b=18FQWf+s15NFLK0gF+B0KsDQN3NkOeBlAYzCRYWosDoWiRswpoe+FwJBIZqLLK+1gLbmtx
        EHW3GfZxNfdkJECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D908A13A4A;
        Tue, 28 Sep 2021 09:19:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o2lMNB3eUmEeHwAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 28 Sep 2021 09:19:25 +0000
Date:   Tue, 28 Sep 2021 11:19:17 +0200
From:   Borislav Petkov <bp@suse.de>
To:     unknown <weidonghui@allwinnertech.com>
Cc:     akpm@linux-foundation.org, maz@misterjones.org, will@kernel.org,
        rabin@rab.in, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scripts/decodecode: fix faulting instruction no print
 when opps.file is DOS format
Message-ID: <YVLeFbrAMF7s1F0e@zn.tnic>
References: <20210928062316.3481-1-weidonghui@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210928062316.3481-1-weidonghui@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You forgot to CC a mailing list, lemme do that for you.

On Tue, Sep 28, 2021 at 02:23:16PM +0800, unknown wrote:
> From: weidonghui <weidonghui@allwinnertech.com>
> 
> If opps.file is in DOS format, faulting instruction cannot be printed:
> / # ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> / # ./scripts/decodecode < oops.file
> [ 0.734345] Code: d0002881 912f9c21 94067e68 d2800001 (b900003f)
> aarch64-linux-gnu-strip: '/tmp/tmp.5Y9eybnnSi.o': No such file
> aarch64-linux-gnu-objdump: '/tmp/tmp.5Y9eybnnSi.o': No such file
> All code
> ========
>    0:   d0002881        adrp    x1, 0x512000
>    4:   912f9c21        add     x1, x1, #0xbe7
>    8:   94067e68        bl      0x19f9a8
>    c:   d2800001        mov     x1, #0x0                        // #0
>   10:   b900003f        str     wzr, [x1]
> 
> Code starting with the faulting instruction
> ===========================================
> 
> Background: The compilation environment is Ubuntu,
> and the test environment is Windows.
> Most logs are generated in the Windows environment.
> In this way, CR (carriage return) will inevitably appear,
> which will affect the use of decodecode in the Ubuntu environment.
> The repaired effect is as follows:
> / # ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> / # ./scripts/decodecode < oops.file
> [ 0.734345] Code: d0002881 912f9c21 94067e68 d2800001 (b900003f)
> All code
> ========
>    0:   d0002881        adrp    x1, 0x512000
>    4:   912f9c21        add     x1, x1, #0xbe7
>    8:   94067e68        bl      0x19f9a8
>    c:   d2800001        mov     x1, #0x0                        // #0
>   10:*  b900003f        str     wzr, [x1]               <-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   b900003f        str     wzr, [x1]
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Marc Zyngier <maz@misterjones.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: weidonghui <weidonghui@allwinnertech.com>
> ---
>  scripts/decodecode | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/decodecode b/scripts/decodecode
> index 31d884e35f2f..8738f721a06c 100755
> --- a/scripts/decodecode
> +++ b/scripts/decodecode
> @@ -126,7 +126,7 @@ if [ $marker -ne 0 ]; then
>  fi
>  echo Code starting with the faulting instruction  > $T.aa
>  echo =========================================== >> $T.aa
> -code=`echo $code | sed -e 's/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
> +code=`echo $code | tr -d "\\015" | sed -e 's/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
		      ^^^^^^^^^^^^^

Let me google this for you:

https://stackoverflow.com/questions/12167178/replace-windows-newlines-in-a-lot-of-files-using-sed-but-it-doesnt

>  echo -n "	.$type 0x" > $T.s
>  echo $code >> $T.s
>  disas $T 0
> -- 
> 2.22.0.windows.1

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
