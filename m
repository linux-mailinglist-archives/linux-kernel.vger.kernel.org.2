Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26D43F80A0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbhHZCr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhHZCr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:47:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0337BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 19:46:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id x4so1803381pgh.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 19:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=/FGgI9x0SVUGWX1Ii0vytBN96Rq3UENFMj5FRaxLo1E=;
        b=KqdjzpEYWp5iAmyMfKDNfhgSlCWCM6za+gvT1BygIAkW3ToHyHhsjVy4RLZKrtkz4x
         gFuOFW4uKr45Zf5aYFWeZEWbuB9bv0KinpTQwCN1oZayGXKfzlZf11tROrXxKeeESOtd
         hkWXSAZv1fBqOczxXw6mQ2PS7+CvOfS5bD3DPDW6/Dt9jj6g/MrINTuH95KdBxZCrZJq
         Syw5GQpA3XWvDkGxhrccOPSXTIqM2QL1HJv8yW73vxCgjG/NOR1KB3u8p0atXaQHwxnI
         N/fuJDTlU0/Q1p6/j54iDVv01JhbyeTLPJFOpIVra65EjskSvsgDuzN5oDMYp0/HHkZ5
         BDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=/FGgI9x0SVUGWX1Ii0vytBN96Rq3UENFMj5FRaxLo1E=;
        b=SuTAERcXpn1obeRTdOvCz4HHCPZzlBpSmXDpTapKXBT0+5BwfKFiTUSlUMJLhJPZeJ
         rcVy1YXerUMaCz+Awoly/bUJP516qRfVly9q7xG1qkK5TWC8UhUxSY5tCw8JYcKnfF88
         IOlxNFnl2ePm+caRgqYikOHO4hm5X9ZCWOBxOOI+BwtMmh8pYSIVhHtgODcC0z5bHL4r
         tzibo0Ooze6reNT7fuwEN+1YCadajdkbDiPhpFneM+GwNhSa96ptAsoBCZC/bH+GxNvK
         NZuIx7Oi8jvFPQ10f7MSmftrduqHLT9Jfvrsvie36amxRoHT8WPgSU9LwbeE+DTSPEb2
         FhZA==
X-Gm-Message-State: AOAM531clauYcE4+8UATlkmf98nyS/G/UjnNbsZpfnW3whL/G5O+m3GW
        BwfMsu4CxipC1tEg50fUN/9rEmLb83Q=
X-Google-Smtp-Source: ABdhPJw4jeLQqriyaf8CIKRDvkXqQF6viSdmeArYY3iGmd06amZjXQQSRDX+MT3rdt3e6BmqMB6e2Q==
X-Received: by 2002:a62:4e0f:0:b0:3ee:668d:b841 with SMTP id c15-20020a624e0f000000b003ee668db841mr1517387pfb.48.1629946000520;
        Wed, 25 Aug 2021 19:46:40 -0700 (PDT)
Received: from localhost (193-116-119-33.tpgi.com.au. [193.116.119.33])
        by smtp.gmail.com with ESMTPSA id a25sm923809pfo.200.2021.08.25.19.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 19:46:40 -0700 (PDT)
Date:   Thu, 26 Aug 2021 12:46:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] mm: don't allow executable ioremap mappings
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20210824091259.1324527-1-hch@lst.de>
        <20210824091259.1324527-3-hch@lst.de>
In-Reply-To: <20210824091259.1324527-3-hch@lst.de>
MIME-Version: 1.0
Message-Id: <1629945413.hwbzjjtfbl.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christoph Hellwig's message of August 24, 2021 7:12 pm:
> There is no need to execute from iomem (and most platforms it is
> impossible anyway), so add the pgprot_nx() call similar to vmap.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e44983fb2d15..3055f04b486b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -316,7 +316,7 @@ int ioremap_page_range(unsigned long addr, unsigned l=
ong end,
>  {
>  	int err;
> =20
> -	err =3D vmap_range_noflush(addr, end, phys_addr, prot,
> +	err =3D vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
>  				 ioremap_max_page_shift);

I can't see why this is a problem. powerpcs can but it seems like a bad=20
idea anyway.

Any point to a WARN_ON or return -EINVAL? Hmm, maybe that doesn't work=20
for archs that don't support NX. We could add a check for ones that do=20
support it though... But that's for another patch.

Thanks,
Nick
