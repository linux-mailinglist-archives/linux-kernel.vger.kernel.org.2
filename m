Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A21321A55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhBVO0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhBVOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:18:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CADC061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 06:17:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d2so22091877edq.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 06:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YT5NXlZ/9d8XoE+oxxWlW382PtgEHHp3vtjYIv+Vhw=;
        b=dZyV4C2zyeZVRtuKhBcDCbng/5SdTWZWFSp7ywwWOh7TMKWX5ptAVcfFrhxajJhHD1
         +KhAP8jxH0m2iWHS9L5yOlT527PBSPNl3efL3LiDLlffhglOYcG7swCFLlQfRUS5l5Dm
         2F19aUz6afZDgEv6WBL8ZrnUY6z2okhOXxnczdfEO/nnR6LA6mxLRhJoBAqueqo9Z/UJ
         HMS3tktlAhyQ07oTvIuZN8m3PG/oqfAtn3/k9sthFJbPlRwpEFvo8anMHgPfijM28dw5
         hnN5RNpLlZy9WKGZZiDgTizdXk4BUe10lnYaqkOG8/XmuOKs6vtZWyEzU46ACoQPJWsL
         nMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YT5NXlZ/9d8XoE+oxxWlW382PtgEHHp3vtjYIv+Vhw=;
        b=ly1DTd3ZdcwyDQkNLfplzZmO2sEsCShXsfZu2slWtY2G3f5hOeD9GsVj3BoS9efoq5
         2h98Vo1G+3ReQz0gA/svqGNtuCsj5hVCKJz0Y4uXWzjXTqRcngBcW1mpYfL/vZ0qw5qG
         Mhjz+rYW7NQ9dthwqlRai13J+yHwXtSbppHT/PeI7+F1COY9RHtoEDVQlg9osUzCxTu7
         79nIyGOz0Dgy71XYqdnRQX55KKnCnFIsYr/SvUxJYYDRVDLt7seCoUjRUTNaEp0fHpv3
         KEdPS/yNnN+YiAO5aRnF8lKJ45QNAbyNTTnKo8JHNnlfe9cdk1Q4Ae0LM/fT4UybFsHN
         nmeg==
X-Gm-Message-State: AOAM531oTzWVtbwiBzYIen/ea9t0+MVtmjil9Gv9kGjaMicYsHf+4i2v
        wnmKWXbQ98C+jzPXhdjxlXwhuI2nlalt5NhxtR6GUQ==
X-Google-Smtp-Source: ABdhPJxobFS2+pnMGd/1Dl6DCWPFYR/PVdxrO2cWHSnrj9bjGDIUhtVV0KwoIjpICgcw33/iWtDNwjOanGNiShwSW9g=
X-Received: by 2002:aa7:d287:: with SMTP id w7mr1391321edq.26.1614003475052;
 Mon, 22 Feb 2021 06:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20210216150351.129018-1-pasha.tatashin@soleen.com>
 <20210216150351.129018-2-pasha.tatashin@soleen.com> <20210219191807.GB6683@willie-the-truck>
 <CA+CK2bB13G4wTm6P_hdkwi2cbu=774GnpwBV7giy77-fEHDKow@mail.gmail.com> <20210222122545.GA8847@willie-the-truck>
In-Reply-To: <20210222122545.GA8847@willie-the-truck>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 22 Feb 2021 09:17:18 -0500
Message-ID: <CA+CK2bB73ezoajLaK63+WWKjDxOBiPNPv9Akj8mtJuvBvhLOZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] arm64: mm: correct the inside linear map range
 during hotplug check
To:     Will Deacon <will@kernel.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Taking that won't help either though, because it will just explode when
> it meets 'mm' in Linus's tree.
>
> So here's what I think we need to do:
>
>   - I'll apply your v3 at -rc1
>   - You can send backports based on your -v2 for stable once the v3 has
>     been merged upstream.
>
> Sound good?

Sounds good, I will send backport once v3 lands in Linus's tree.

Thanks,
Pasha

>
> Will
