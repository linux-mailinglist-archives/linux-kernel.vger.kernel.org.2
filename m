Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281273437D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCVERP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 00:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCVEQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 00:16:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0825C061574;
        Sun, 21 Mar 2021 21:16:49 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id q9so8049002qvm.6;
        Sun, 21 Mar 2021 21:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mqht8zfwIeNE6HjVuAaYTNSXTwuv6qIhvRvFRLciTdo=;
        b=WvFWAMUXUkmp8JUrDcdVH22ls7yHZqmEHjYznXOykZ85M2sFuwoeOmutLw03cTVIXI
         3U29Dgx+wSAqhfFa3HlIu70Hk5pcb1a/D21DStOU7ZeLBMmW25/Y00bX8BYkkppnf9UQ
         7tKjf3fn54vN583xxYiLL6mfeBT3iC5sSf4BIhif+M+vDjO6nbKJama/OII8EoR8AxuS
         X5a++PuLgy/rHpaDRqzI6F1mWFIeoW5Su/zhuKgWJua4MTmngWr1fjy6kmaXGO69ZKh2
         wkP/Ki/MNWEHDtHLTRjkghCTRIpCIGe3lsVbwCCc0hHCVP8lv9wgXygaLr2AOFxlJ6UC
         wCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Mqht8zfwIeNE6HjVuAaYTNSXTwuv6qIhvRvFRLciTdo=;
        b=oSHYjcuofOv8s8qb1aMTQDEnDQzzbe9OWSe+o8ehNYOKNCPJH9GxROSNFKAPBUpr4e
         i9YN0JDUXzTx5Nlya8zxiyKp2shzCkUKgjHrFecvUc2RB0OqXW4d7trUBuH2P3rQ75cu
         8/+hxNjg2v6uReghOf19YVBsSFxmhFmfRX3iANbokEOjwADANbz0GCOnCz6KMEzha4lh
         ubOMXlPVhdzSGB2RvPH/3xUVgsiNm5xSBj7W1E75lzYxyygaPotpZl11hSbZ7N4IcmHb
         gMi59jKQCSsOAOJJQWf2mZoQ5a1A0FNCOW8lPixnvyO8hvgu2mO4U2NFI8pV6dDzHh8C
         wgKg==
X-Gm-Message-State: AOAM533c+HffkKQY9bX1s28MDsXevYeVbwGE6qGt4DBUqOpJMW/e4go0
        h/qBZ1wRtPoaPNxbWrTfPRc=
X-Google-Smtp-Source: ABdhPJzrf9mOYGAGXu1F2pVN51nObBBqB1Omsvj8++pYy+lDqyYyf/ymAD3sBoPM9bcNH3/dKDXSPg==
X-Received: by 2002:a05:6214:a62:: with SMTP id ef2mr19594079qvb.44.1616386608698;
        Sun, 21 Mar 2021 21:16:48 -0700 (PDT)
Received: from ArchLinux ([156.146.54.190])
        by smtp.gmail.com with ESMTPSA id m3sm9951370qkk.15.2021.03.21.21.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 21:16:47 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:46:36 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, sir@cmpwn.com, gregkh@linuxfoundation.org,
        lee.jones@linaro.org, bp@alien8.de, huawei@kernel.org,
        krzk@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] docs: submitting-patches Fix a typo
Message-ID: <YFgaJJUIX24QNCpK@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, corbet@lwn.net, sir@cmpwn.com,
        gregkh@linuxfoundation.org, lee.jones@linaro.org, bp@alien8.de,
        huawei@kernel.org, krzk@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210322033000.2523887-1-unixbhaskar@gmail.com>
 <20210322034459.GE1719932@casper.infradead.org>
 <YFgTkhA+IOvNVxEn@ArchLinux>
 <20210322040214.GG1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="flmwgVbWvhpOynZh"
Content-Disposition: inline
In-Reply-To: <20210322040214.GG1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--flmwgVbWvhpOynZh
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 04:02 Mon 22 Mar 2021, Matthew Wilcox wrote:
>On Mon, Mar 22, 2021 at 09:18:34AM +0530, Bhaskar Chowdhury wrote:
>> On 03:44 Mon 22 Mar 2021, Matthew Wilcox wrote:
>> > On Mon, Mar 22, 2021 at 09:00:00AM +0530, Bhaskar Chowdhury wrote:
>> > >
>> > > s/mesages/messages/
>> >
>> > did you test the build afterwards?  you forgot to do something.
>> >
>> What are you talking about??? It is going over my head...why the build
>> reqired?? A spello needs a rebuild???? Wondering....
>
>don't argue with me.  just type 'make htmldocs' and find out.

Well, some other time ..I have the habit of arguing with people ..can't help ...
>

--flmwgVbWvhpOynZh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBYGh4ACgkQsjqdtxFL
KRWSWwf/eRNUqsB43exjIlNdW3/Wsm0cETdVZHcu6rrj1e3/nQqD7dMZ6y1yVGab
RBNOng0+BrO2TqhqJ84M5NV6yRJPTUuPsnW+Ex2vVPF5RVO2aDOILbHOgZCfCkMM
3PDBf6xCSTGDW+1cIL8e4CqHGypRSx0ggPiPUQc9QHjBSAFIMJ9D9vvfKuq9q92b
FOFx1Y8XxZkuuGoa/JpCzRZZNuA376/fkgjetnY5JB8pa2OYL4mA8ZdQIfRcgDDI
BOPJ87JAqypelCtVWVpXUpgIFQPemwGSyWQnOd/fgSxrZbBDsswmuyNc8AfXo/Ua
GaQUBDGlPPZ8GcKvqi71ZjDR/oWGRw==
=t7t2
-----END PGP SIGNATURE-----

--flmwgVbWvhpOynZh--
