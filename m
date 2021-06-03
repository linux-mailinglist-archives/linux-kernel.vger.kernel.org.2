Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D839A2E6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFCOSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:18:55 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:36618 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhFCOSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:18:54 -0400
Received: by mail-il1-f173.google.com with SMTP id e7so5684577ils.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKEmsEK9QKEcJksXdElwk/YbjKL3k6kwCGWsFQD0D5g=;
        b=uOMCAlcKg22Bd/d76ANb4hI7au2j1R50ZLvLmbmKLDeVUMabRSXPJh7ZHv4htXZ/II
         4kJQynf+IaLjl8qrT0fTZjk6+RIYCsLDgZPg2LxxX9O2Z9Aw7eJXL6fzZPB+iUjQVX+k
         5vm37ChbsgZJvZXjlWcYPpBQXn8T/pLZWafjEhBgWN0muS1d4y7Umm0O3Kz5E3RvL29b
         YRjP5gAKT7n7Pu7U8rcmaX/0e/dT9Ci2yvc50PA2GSLcBXXkyUwfE/RWXH46UPevf2KW
         v3zsj3YA/AiaFp1JqwAz/TqIUB7z2d4f6Q6NkGogu6eDW6T0/Y4QF/Pai7iKhs2Ngj9N
         av3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKEmsEK9QKEcJksXdElwk/YbjKL3k6kwCGWsFQD0D5g=;
        b=noQx1s36QKCduj8NXlXI0/DUK/WyU/Hbqg0u1uteVuBcfJT/2OIxjvwd9rbkZ8Gzl/
         Sgdo9YUDDPkLcordgJY+CgLEZ2LbwT4wRCIG+QEafCQvdRcrir9NwS3oJyKwKwietJRk
         0zNnWq07LJKuPpGTHAFiwrxVX5WAzQobzAaazfmpGVo4ztADzwW3LRZdlz3eHOWExOnc
         UJsiaLNFmGwPSednPuMnJ1z0GoHIxtlbW5cMb0bmaz0w2QoF3T13mQMpxtUVTQMuPVYE
         Wtp+CDKkXGsoyeo12V+kc3Z/Fbp6gZ/K29xiFuSqLbOR0PoEPin7jzY8uVv+CqomMb2H
         Ux3A==
X-Gm-Message-State: AOAM532SoKdSmFAD64+0zvtljM9zjZ67Y7tk75Dqgfv/VylGphgS0HaV
        R0Ot2FC3qQa9m1B8VkYGOiBNnukBMnhvSpymapvkFCGaB3ziTQ==
X-Google-Smtp-Source: ABdhPJyBKCL5DJLmp8Em3ezXEYGgE0LA9WKDDAQ98hxL8KGMqUugiTswIzzEJtD3bUwkhKrvMyra1gzMk8XOIH2suuE=
X-Received: by 2002:a05:6e02:11a8:: with SMTP id 8mr122966ilj.212.1622729754900;
 Thu, 03 Jun 2021 07:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210603140700.3045298-1-yukuai3@huawei.com>
In-Reply-To: <20210603140700.3045298-1-yukuai3@huawei.com>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date:   Thu, 3 Jun 2021 17:16:32 +0300
Message-ID: <CAPAsAGziPKBpKJ7HGGHwEXuTuUXwQnscNQX_LNfCdM3ZcDrW+w@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix doc warning in init.c
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 4:57 PM Yu Kuai <yukuai3@huawei.com> wrote:
>
> Fix gcc W=1 warning:
>
> mm/kasan/init.c:228: warning: Function parameter or member 'shadow_start' not described in 'kasan_populate_early_shadow'
> mm/kasan/init.c:228: warning: Function parameter or member 'shadow_end' not described in 'kasan_populate_early_shadow'
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
