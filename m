Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211483A0B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhFIEb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:31:26 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35578 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhFIEbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:31:25 -0400
Received: by mail-pg1-f181.google.com with SMTP id o9so15540961pgd.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=466GkKYajJKZZ8o449pbsZdtpv8lFssIM+BWMw8ocbc=;
        b=KtkLh+yzYPo/Hy3dD5Bh0G2chrU6J9xzOFbDHK+rZvotMK0hnsssHwFb+FBZX+cuQR
         CRfnxQYW8YO3s9J7PZ/7rJZ0XFiXVl+0pBoZsHkYSfWCQhI4e897se29QTvVVlD/6j/Q
         foeKQ9AcskFmhaAZz6gyQUOI+qAXZ+UKHjZb8KZrUgTt64UcUP48RvOF79KJWxYYVxFK
         JUs0IuTulQBDBLbNTxeWd5LnKBUE/Y5tyC2JCBLGLstGvjuGTgs/YcN/Rz6yeO6fbz22
         LaH+9xAqoSoFNrHhmBEivYylm1VIF6mfE8dWp6FlqPuFmGx2YHwkHrY9A09kKv2CtOLY
         3MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=466GkKYajJKZZ8o449pbsZdtpv8lFssIM+BWMw8ocbc=;
        b=NyACVynju3ApkOumkkHLpMshQVwtWeGvQw8LhypswTFaYYnRP02Geb+l3oPqk56YNh
         tOxk0ukxcVlaT4qucMkKaWHrmRWx5RCTGoT81twBCgRXkUtMBySfxJiEkfYS4U1wK7zf
         00YVrQs+CcFPEHXer4da4WTI+lhRE82LZIH1AGKeaQIkQ6u0JVpW2jj4XoBZBLsG147z
         7ffPdus0eJ/4P597c/1szEUIvhNS2CElSa07rCJUvZMb9JcZU0IiF9MLWHNvVwkT0hu2
         AlCWOdvm3g5pMmD2XtT7OfTphl1TO4MtdLs/iLQ7OkYbkkRJ7dS1Tt2v9vFYw6YKkDuP
         x6Lw==
X-Gm-Message-State: AOAM5333o38qD2/c04sK2t0yv9hLxAqySjsF/QpXx1aCy8N/th3dU5uQ
        IMJDPJFQOhKNIrCMmAN3ONYbgoXItqmezYpeDlS5pQ==
X-Google-Smtp-Source: ABdhPJy7sycljRIcbt0LIUJlmjby8WgEapGKwnO8xUzbihnwucMVt6qQXRNQcZiFKraeUhWwUBe0yaKe2B6quIssEDY=
X-Received: by 2002:aa7:952b:0:b029:2e9:eef1:8e17 with SMTP id
 c11-20020aa7952b0000b02902e9eef18e17mr3379605pfp.70.1623212911484; Tue, 08
 Jun 2021 21:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210609135237.22bde319@canb.auug.org.au>
In-Reply-To: <20210609135237.22bde319@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 21:28:20 -0700
Message-ID: <CAPcyv4j946hkhZVrP=eOav52VpCDj5whwwSyQ7cRgBGvoSXjJw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 8:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the block tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>
> drivers/nvdimm/pmem.c: In function 'pmem_pagemap_cleanup':
> drivers/nvdimm/pmem.c:338:24: warning: unused variable 'q' [-Wunused-variable]
>   338 |  struct request_queue *q =
>       |                        ^
>

Ugh, I should have caught this... fix incoming.

> Introduced by commit
>
>   80b58f4e9f4a ("libnvdimm/pmem: Fix blk_cleanup_disk() usage")
>
> --
> Cheers,
> Stephen Rothwell
