Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2CE424B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhJGAUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhJGAUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:20:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366F4C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 17:18:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k23so3503682pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 17:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1VIDmUVCsm3FI2UWTpaCYBzLMBMmt6DXQc+N5EprEQ=;
        b=D1h+K65xmVjdXm7ZsbkWDoQwWJpMc0l56WpKxDhVYgpYV4SC+nZXVW3z92V0dQ3Yem
         srdTmMSqoqaOgdMlWG4S7yntDZzC1lzWQUgpiz2Jr+zdM4Id3J3xu3MRqNzCMm2glqL2
         MkfMKiNmxX3hpJJaWyJ5ILpvDMAjEjOSzc02k7srTM7gcPt41Ku2rD/mpfPtkI2slvBd
         JojDaIcLSrXlkNew5OgRIPkHamW+fkVDbOul03UCwJo1Y3Ylh5kRblPm8hKKKAvLPrLd
         TKAoPR810qnRrUaThMS4AhZhrWB2HrnLG06vHLQ/nEF2lO9ohGm/P4oxw2ggzIB3qPUZ
         nm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1VIDmUVCsm3FI2UWTpaCYBzLMBMmt6DXQc+N5EprEQ=;
        b=Jyh2X0w384S7qBfGL/0zw0vFERr6X5b44qD3H1HmfI9Hgnr6v9kJMZ/FQt9EVRpliq
         dhxeGEPQ1kcMmBtFbvSNXMOoH8P9D8XsbDVzHTqGGMfD9IRgQrt6cGsDQbXVpFh/0Vos
         ZwAvFZpIMefshYab9idet+HEOVq53tfsSvX/qamLNg2lzWnGurSwcqQeyEQ2ScBysHQJ
         VOqUa6yZm4Ps6UAksKqJojZixsaJ2Zx1R1ERPGuunIEB6qqO4z0PAVoNilhtl8ZFiNwJ
         X/aSWVoSrDXC8bfds/mJcC8YtqhbHBdza+TX1yGkQl+62ak2JXP2dsZIqIxGEh8R7enM
         aVkg==
X-Gm-Message-State: AOAM5304Q2uJbIsHEs6upWp2cjnlmlb933mAhHwkGVQr8TfQ0LF5Rv6V
        +gV2xHQUNfuT/okyuzeWSFyCC90CjF9AzdhtLo5/QCLZ1VQ=
X-Google-Smtp-Source: ABdhPJz0Alva/qCwnunHbVnAsbCht0BDfqmUNcdpswgzpdgajsCKuTYURWmPvnE/x8a+m7gXLsGcRDJW9rpzAD9vgMs=
X-Received: by 2002:a17:903:22cc:b0:13e:fa73:6fef with SMTP id
 y12-20020a17090322cc00b0013efa736fefmr884359plg.25.1633565925509; Wed, 06 Oct
 2021 17:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211006194515.423539-1-almasrymina@google.com> <202110070817.swU7Hx0C-lkp@intel.com>
In-Reply-To: <202110070817.swU7Hx0C-lkp@intel.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 6 Oct 2021 17:18:34 -0700
Message-ID: <CAHS8izNhx+rOTsg5GozAqW-FbyDAhniVW_P0obJqS-QcKZ6O6w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 5:15 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Mina,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on hnaz-mm/master]
>

My apologies. I'll look into this and submit a v5 with a fix.
