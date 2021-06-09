Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE63A0875
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhFIAkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:40:02 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:36358 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhFIAkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:40:00 -0400
Received: by mail-pg1-f173.google.com with SMTP id 27so17973769pgy.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=UCR8T6dvOadUB7ygYan14MhvChrSqba7/u0loWi+kQ8=;
        b=iRVfqSkcbG2fNiVmqvD+pJ9CeAa1l3oBB/cL/IYxFJ8VWaIQJXzMqNUWWVqgibrK0W
         dxSLFHvScGabXvEMaGhkf050sQrRrR0B4kEfYw8i9baZUspCSx5n7YWNAAxnbCEZgjgM
         T3ZnR0/UTHe/htRqvmgPJfVKDuarbTZe5Sc/3y/nEdES8xK0r0munby4t0O+iMRxB5TB
         t1nlc4FOsBfRuWcDZsVPkAKnixjw8SYC/hzAVHfSrQzntpjlgOHA5BnkccWh3r9e1fuv
         0GAZtZw3kV9b2IDrlLWbe+Hcdep0I3bWTswLEGUhKTFpTZUj9JumDod21nSlo4/rd2Bw
         QZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=UCR8T6dvOadUB7ygYan14MhvChrSqba7/u0loWi+kQ8=;
        b=IStzvvUrt7/HWd1CUfxhzgDziz+yC5CsoqokiMIKQD2xNP88dldd6EOF3QGSBcre+X
         jhjnoYdKnlpj/fnxOujIE4yJRsAcshj3nsosevDLQDhb5iKMwxAtpVhJDNHlVYZVUMfd
         zTwIKnuAHZm7dOkoP54BPGlyk/KmuO4AgI3J1FcdYQ8olEOBGoyNfbBk8prTLy5KCIva
         jA+YhgvocPwbliEEeV4d3q4Vl9ZOaykezWYi2PqlDl//HOjgYu1XKE+rEuDaFQVH2PCq
         1crm/cH6Rly4FOvyjOfBz0l6QqWv2JQh5dNZSL2D44XJc9tvFisCgrIg17N5zrE3NNXS
         YAGw==
X-Gm-Message-State: AOAM5330z2SDlg3bXxaJZWBFF1eh9S65yVVb3INxu8gq1r3U9Jsr05Ow
        k8mT5150rcMYKTE6z+xECmVg7Kkv+b76tDFt
X-Google-Smtp-Source: ABdhPJxBzOZlknCG5sbF9Ce6xSEVRnAoFk6kdQF2DaGcBQkch5HRb86Gj6rvB/SZtiDLqon1/U8+Ug==
X-Received: by 2002:a62:79cb:0:b029:2e9:9951:eac8 with SMTP id u194-20020a6279cb0000b02902e99951eac8mr2457298pfc.59.1623199026692;
        Tue, 08 Jun 2021 17:37:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o16sm11790252pfu.75.2021.06.08.17.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:37:06 -0700 (PDT)
Date:   Tue, 08 Jun 2021 17:37:06 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Jun 2021 17:37:04 PDT (-0700)
Subject:     Re: linux-next: manual merge of the risc-v tree with the risc-v-fixes tree
In-Reply-To: <20210609102608.5582071b@canb.auug.org.au>
CC:     Paul Walmsley <paul@pwsan.com>, jszhang@kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        vitaly.wool@konsulko.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-d47c3450-5364-43a2-a02a-965e7a9aa886@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jun 2021 17:26:08 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the risc-v tree got a conflict in:
>
>   arch/riscv/mm/init.c
>
> between commit:
>
>   8700a6b6fee2 ("riscv: fix typo in init.c")
>
> from the risc-v-fixes tree and commit:
>
>   010623568222 ("riscv: mm: init: Consolidate vars, functions")
>
> from the risc-v tree.
>
> Note that 8700a6b6fee2 supposedly fixes 010623568222, but 010623568222
> is not an ancestor of 8700a6b6fee2.
>
> I fixed it up (I just used the version from 8700a6b6fee2) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Sorry about that, this one was supposed to go on for-next not fixes.  It 
was causing my mail client to crash so I was kind of focused on that 
instead of the actual code...

It's on for-nex now.
