Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B263DCE9B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 04:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhHBCDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 22:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhHBCDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 22:03:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60297C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 19:03:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso22521727pjf.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 19:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=qRAGhi37lhF1sunuSfrr1C0LvoIqLv4kahSQWWZ31Ss=;
        b=lax88g34cj6deV6YZblYxmwfptSOzpkqmyB+B4Vn1fweUniem1asTRHasAOxZ55XZJ
         zqsiJgmLq/+cRjJh0nO5k2UN7G0HlE2kugBTza3Og3GUw7rG2N+SwGBi9+uA1T1Er2yA
         6Qe1ETEHjQvyXkez1SmHzAkGP3+ymXApiEOpV1FzAMyW6KGMKhL0TpJK/qLv87h87dWh
         0pq5ri7OReltA40mhbAKM7zvrUxaTPAeuVXsDc1yJrWOdJcIdfTM/vcBcPyM1RuXikNs
         1llU3wtFXO0lSeXGbvldh/bTWKHqwYxzmauFRFoxe05GNbONOLErhKlh9idTSR22x3fR
         HSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=qRAGhi37lhF1sunuSfrr1C0LvoIqLv4kahSQWWZ31Ss=;
        b=U3oYvXh3EEsfwkFmhlls/IvmqAqIDuSyMth9zpc/23DRVMdecSgTskHnxZ5wbLZRxq
         WMrKxHpRKUM5wm8yaSOj9YOESYeHl6oY5aRArSEzoGrTIC5UMoCG3toRBOEPNLiTfaJu
         4zv5fa9BMfN98SFq6I8xK30SPqakSKaXNIQxv8/03mUaoj1mpWUqUZzicSboaNxHJzd1
         rswX+p3r0/ezMh/yG78VfpTVwcXa2bYqNH8gbUmfJdf9rWmqkoduvguiNrMXxU31+SBH
         rVmOegtKVeQEhuH5e8ayYsQ/XsboEvbh3WHfr3eca9LbR2LKt29Mi4tMRi8Ct/JJesbc
         S4/A==
X-Gm-Message-State: AOAM533tYX+BJTBfQozKTlakG7VqjWl3UCqSnS3jaCJyDU2NJmfnVu1X
        2Wv4lwN2dHkezsGuCNjXJ4e9mtBOXDI=
X-Google-Smtp-Source: ABdhPJzV7KdTwX/eRoeMqY3JPzEDww/yit821nvXnqkx9bMQbO1GpBQJFlJezLK900wCL/Z+zR4LDg==
X-Received: by 2002:a17:90a:de16:: with SMTP id m22mr14997962pjv.38.1627869804836;
        Sun, 01 Aug 2021 19:03:24 -0700 (PDT)
Received: from localhost (60-242-181-102.static.tpgi.com.au. [60.242.181.102])
        by smtp.gmail.com with ESMTPSA id j10sm10189936pfd.200.2021.08.01.19.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 19:03:24 -0700 (PDT)
Date:   Mon, 02 Aug 2021 12:03:19 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/svm: Don't issue ultracalls if
 !mem_encrypt_active()
To:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Chancellor <nathan@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Claire Chang <tientzu@chromium.org>
References: <20210730114231.23445-1-will@kernel.org>
In-Reply-To: <20210730114231.23445-1-will@kernel.org>
MIME-Version: 1.0
Message-Id: <1627869720.jrkx2xunfl.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Will Deacon's message of July 30, 2021 9:42 pm:
> Commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> introduced a set_memory_encrypted() call to swiotlb_exit() so that the
> buffer pages are returned to an encrypted state prior to being freed.
>=20
> Sachin reports that this leads to the following crash on a Power server:
>=20
> [    0.010799] software IO TLB: tearing down default memory pool
> [    0.010805] ------------[ cut here ]------------
> [    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
>=20
> Nick spotted that this is because set_memory_encrypted() is issuing an
> ultracall which doesn't exist for the processor, and should therefore
> be gated by mem_encrypt_active() to mirror the x86 implementation.
>=20
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Fixes: ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/r/1905CD70-7656-42AE-99E2-A31FC3812EAC@linu=
x.vnet.ibm.com/
> Signed-off-by: Will Deacon <will@kernel.org>
> ---

Thanks for writing it.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>  arch/powerpc/platforms/pseries/svm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platform=
s/pseries/svm.c
> index 1d829e257996..87f001b4c4e4 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -63,6 +63,9 @@ void __init svm_swiotlb_init(void)
> =20
>  int set_memory_encrypted(unsigned long addr, int numpages)
>  {
> +	if (!mem_encrypt_active())
> +		return 0;
> +
>  	if (!PAGE_ALIGNED(addr))
>  		return -EINVAL;
> =20
> @@ -73,6 +76,9 @@ int set_memory_encrypted(unsigned long addr, int numpag=
es)
> =20
>  int set_memory_decrypted(unsigned long addr, int numpages)
>  {
> +	if (!mem_encrypt_active())
> +		return 0;
> +
>  	if (!PAGE_ALIGNED(addr))
>  		return -EINVAL;
> =20
> --=20
> 2.32.0.554.ge1b32706d8-goog
>=20
>=20
