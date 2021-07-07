Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E683BF11A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhGGU5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhGGU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:57:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB82EC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:54:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v14so7754405lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 13:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/kA3SD9saboQz8UvpjlwI7yeO7q8qZF3XCWfCyb1yI=;
        b=eLE4MbwO2HgXGT8xqVoMOkh5dGvG0jeKB8XEZ2bhl0bnZdEB/0Q0qc0EpfRElV5zZL
         QNHGKphh+Cs783oNn7iOkqrwqzROHwgZo+pt0RUdaSmjUvsiI3XYR60axeHk0xJJbWr4
         LkFoqO8bJs9AudkKwHCRyJ9pA5khR+IVXVWs4pXkZUC8x2egqqFENY26RyfHkWV6kC2v
         NXrDIhvObFvxrqaVqU6w1z9mPt/hZQSBjP5H2NIlDwPD60Ca8eGQWCrIfIyirdFSkadJ
         vVvuzlYT+I1Od2SPKG9FESJVhtA+aw7+HceuZ2lTR1pz+dzcOWwXR5TX++9CDN8sUGCo
         y1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/kA3SD9saboQz8UvpjlwI7yeO7q8qZF3XCWfCyb1yI=;
        b=d0FiPnu0Y86hxvV31UV5mC4Z/NuM38GYG6T2W5gx5zHGuYiaaAgpUQcdZ0k93POxju
         3+tpwAQ5qmfEvEwBg9di591MjoSd4ZbRMZr4NagS1H4cec62vDicH9r+nBukIGOMC6nN
         qGQpfJ89MytGfIApbTT31QrtULNfyoSIWX762MQZ7/FdAK0N72M/ua1CGRatM3oN+iVr
         JAToUoWRxddCEgNYGG3PJAtPgP/5433ryU18EJtLoXTRehjnImVxGZNaLK1Y0zo/RpkX
         COe5qazL1blghkcwgZO1oCsKR6I4H12/CEkDjnFANzPFsLu19P/LgVo62Mw8+JAAZIf4
         9t3g==
X-Gm-Message-State: AOAM530kDGWIu90w9Kn4x08oWk78gNkVrSdTprE199xV7OKLKWW7BgXF
        S2cgQo9nTLm5PEgbyT3REjrJd0Kn5zfTWREFpoxnnA==
X-Google-Smtp-Source: ABdhPJz5xj35JumH1kEcELdwoB5hFtDmYMLlMrm0Tb0UawhOMwPwqmdX0dRgvIilBmJaMPCqJsoKpvPPJ4mKbEtVlCM=
X-Received: by 2002:a19:7418:: with SMTP id v24mr20805735lfe.117.1625691257942;
 Wed, 07 Jul 2021 13:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com> <1241d356-8ec9-f47b-a5ec-9b2bf66d242@google.com>
In-Reply-To: <1241d356-8ec9-f47b-a5ec-9b2bf66d242@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 7 Jul 2021 13:54:07 -0700
Message-ID: <CALvZod4+=Nyg+=BT1E3Uc85ubcCzBgt7_sY-ZuAxvtih31PbOQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/rmap: try_to_migrate() skip zone_device !device_private
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 1:13 PM Hugh Dickins <hughd@google.com> wrote:
>
> I know nothing about zone_device pages and !device_private pages; but
> if try_to_migrate_one() will do nothing for them, then it's better that
> try_to_migrate() filter them first, than trawl through all their vmas.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
