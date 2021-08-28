Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5353FA3DD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 07:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhH1F0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 01:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhH1F0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 01:26:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D85C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 22:26:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fz10so6091738pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 22:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JfUpe2H37PEi8fU0OKJL2trjpNhW7D/OwMqmglIVHg=;
        b=wmdEvv2ENIhYYGUB7JTLAaIAv0cY9J3AEXqGcxs1JW+wpuG+n6GX/zaphPuMCLN3xI
         ns9idB6Sg7OOr03SuAxG8sRfuinLdHFSjEU7Jq3tp6oLpTSXdhzJPqGFq/uZ+786OV8p
         xd/s6r1r4ESyAYa+7j4DekrjGfL2n2mT9Ovr+H0dMEBLRaDX5FUtiImrzjnlHt2guhE4
         SttN5jwQ2wwEd3jfeAACvoIdQHjZHFJkMFIJcbCmI+cJx+9Z5ebldao2y6R7yv1o1Gnl
         WYYQWav3jQ0a7SPEmpucjj3+iuyqLjSHpDbeiKtEJylvNGStg8w9l95tdLZctBgLKoTg
         DR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JfUpe2H37PEi8fU0OKJL2trjpNhW7D/OwMqmglIVHg=;
        b=bPUZyudamuO21vy1WY0oiczbqcnazqyvahNtEpZ3MA1Aid8tZnUTbgipoXYHpnCfFX
         UJo2cTgGuTjjN56OclzWembwpsg00/dPOWWSxU7N9baz5jqBA4XrCpsN8d+k8gBFWTaL
         AUgTzQbin7+lc6DbzM8Q9eCyzZ7RZ7d+zxeGixklgP2Wo7USeOUc4sXK+fb4oS4gQLAn
         UjaAhwKR9Hx+C7aHfiaJ4AHXsqSNGWvg/Me7wdWK7jqwTis76ochbgrUWBEWLwC4kwf+
         hOL8e3w5cMSsOXvu2THdcTMCTMCpyw4MvLjK66PfnJrp0ClnvvRDg6gFP67lsNL/a2gl
         LoyQ==
X-Gm-Message-State: AOAM533LgmdtlPfPz+71rc3MW9QVuQbTtxKR4IVpZ8zQGCAWkrRwKJmM
        9wktscjuJgGv6OkFEoe9DKpxVnc98hQdA7161usuuA==
X-Google-Smtp-Source: ABdhPJyWIL3bp2Wtvc8QNlN/2pOeczW9cA7a6NJ+Yc79O9glgqWDdhp+1YDeYsbIyXrjH7fSFmW+RMAB1LNFKreobxU=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr14659897pjh.229.1630128363484;
 Fri, 27 Aug 2021 22:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210828042306.42886-1-zhengqi.arch@bytedance.com> <20210828042306.42886-2-zhengqi.arch@bytedance.com>
In-Reply-To: <20210828042306.42886-2-zhengqi.arch@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 28 Aug 2021 13:25:27 +0800
Message-ID: <CAMZfGtW8CVMQkkC_rwJoHXQQYsuJBAfCuWC_XjhHyKnxFdc3kw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm: introduce pmd_install() helper
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mika.penttila@nextfour.com, David Hildenbrand <david@redhat.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 12:23 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
> Currently we have three times the same few lines repeated in the
> code. Deduplicate them by newly introduced pmd_install() helper.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
