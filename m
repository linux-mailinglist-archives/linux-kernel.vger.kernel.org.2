Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3543DF972
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 03:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhHDBzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 21:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhHDBzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 21:55:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D30DC061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 18:54:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g21so1505227edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 18:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwYC/1Gaei+t62tNQY4YFdCc3ENCGWe2M7gmqksCaew=;
        b=KHb4cAohmBF1wfyoLs/rl9cOV9WjJt9nG6P38g00AdqrxqLV5mua3SEFz/TSWaLCqs
         oH4d8ZTRnjv+7LOQHJ2pBW+uZuSvZRByXOwXRnPc39/EERKz9KXuz/K174nu9vFg+ZQK
         TL4g2fX+oge1hfeOB9BCHoi7Dvgl96FMp4AA8b4V4JkQBwmGssIOwB+yjnSeH+vR/6gn
         Damiwu22iVbNL+LuUSuyUQC30j3SUFER1qnBQwYcVsALj8ngBP3vTKh06LJnT+y+3Z3H
         eSnmKh09Cm7+6J2sRBuYoIyG4hnKb9KMoVUQ+7zdC2w7KL4BPXZAxUHb++++iemZVIJm
         MIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwYC/1Gaei+t62tNQY4YFdCc3ENCGWe2M7gmqksCaew=;
        b=II5KIpPNG7Dc/pBlqd5SgoNgd1itDivhhLoHRTwR1Vm1eAuoQnm1Or17QmLRALL1C5
         krX0xZlwtvxXHFCyCd/KiVaY87SiNx18YEF+Iicv/CIW0Rp8KNeTiahDgaK0AFcemQWr
         sJxf2AKg6Iqd5ZQduoD1tW1xqQ3Yx+LMzK69tnF95xfWfT3Fq7FtzN4jFhW4w1UeN/iB
         ZT62f4sb6vU7rBCbg8WSeFzne5RDdIhcFc+Wd+xkjIR7Gp/UWeZyaaIOX/05TMoiVKq6
         Ko17ls9gLXAVo4yzWnW1AMWagpwUp1ouRLFLGwC2BZPefpZuhdpS4cYL0tatQl7c6x25
         JopA==
X-Gm-Message-State: AOAM530fHfDvsSZpVMnpxCPxXO9LPxY1H1p7MTXEa17i8yEOkUIz0lg+
        BHvujXC0oW3jGym4nQ5Mlf7rtXNIi9+mP6SRB4WIAw==
X-Google-Smtp-Source: ABdhPJyDcdBun5ArBBclPVQ3zL16nLtGBhsP9+jwmxqLDtzBCI+VKFyx/007H8oKIjwZRLdTTG+gAaRt9+6z8JS0H20=
X-Received: by 2002:a05:6402:2043:: with SMTP id bc3mr29167190edb.62.1628042089213;
 Tue, 03 Aug 2021 18:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626252248.git.zhansayabagdaulet@gmail.com> <90287685c13300972ea84de93d1f3f900373f9fe.1626252248.git.zhansayabagdaulet@gmail.com>
In-Reply-To: <90287685c13300972ea84de93d1f3f900373f9fe.1626252248.git.zhansayabagdaulet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 3 Aug 2021 21:54:13 -0400
Message-ID: <CA+CK2bAGr1SB3Y0ZPBkuPvEKEMd1LkecpPoXNhwPN=1vd3KqBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] selftests: vm: add KSM merge test
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     shuah@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 4:56 AM Zhansaya Bagdauletkyzy
<zhansayabagdaulet@gmail.com> wrote:
>
> Add check_ksm_merge() function to check the basic merging feature of
> KSM. First, some number of identical pages are allocated and the
> MADV_MERGEABLE advice is given to merge these pages. Then, pages_shared
> and pages_sharing values are compared with the expected numbers using
> assert_ksm_pages_count() function. The number of pages can be changed
> using -p option.
>
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>

No comments, because I have already reviewed this series for Zhansaya
as part of the Outreachy internship, so:

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
