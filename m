Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BEF352471
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhDBAYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbhDBAYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:24:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95143C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 17:24:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so5368030ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXGKhNV99vGi9noKhiqmuk0ylgRK9SHFVWcAt0TKDv0=;
        b=oYu/gSNHNSPVlrJDb/sLcS9bh2dKPmXtbcN8WC4i81uYplHsMJe5AM1oiCiUOUyQPG
         ZBbQMAEsbW4MtfOvbTGoy3jGdseDTu0f9gF4x3XLoriFXAyXmmTkuHKo6iXY8wtksWmk
         admyyzwspqYM+fKLXfEgA8YCEon27qQDMRbb/8jVipuseQyMOjRPIeJu+YnFZ0s2iAdD
         SstyNHQ4nFv8UQjw1RHYXQnqvAS8ziWsh+NCTV21sTXJqclawZ7lp8nww8VuOGPdZ6PB
         r396aSaDdAnIM/4nCIkwOiV85e1DPoSIewr2QwEA46oAi4BO+EfgwmIgSWh/pdEcpDTb
         9fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXGKhNV99vGi9noKhiqmuk0ylgRK9SHFVWcAt0TKDv0=;
        b=uBvOdMNzmufQ3Vxx2MztTalmGAtsup2By39iid2Nhq1UflsLNEz/MRGthTdrLcieRJ
         MELOSYgFzGMkGh0PlTaxKW+EsGt4ByWjwE9UQrRoOX/JieMs7JaDZihEyxc/LOsDJ7IL
         j/Ue1r34atiqutmcw/zw19sOTxgago1ykvWB+jpxaNTUB2c/ed//BalZ/U/qmC//QfMY
         BOAoGFfU9KwQ6VuCek+H4GnRNXhNZig0NMmWF2th7E0RSjV4xRPD+22pmF6d2D21Av/K
         fLKD5jgByvVf2B8HqCkxxLAQthXIlEZjAkN08t3i5ZGHgTty+Xl+ZBCaQE10hbSlUGXm
         Ruvg==
X-Gm-Message-State: AOAM533KxaMIl0wtzK7YgapvmDJGq3Sxln+YxNa7pCqHFByxrMW/oHDH
        jDN6flSivEYE+l4htPS2E94BlXOnBwrlp780gZNiEPah++E=
X-Google-Smtp-Source: ABdhPJybhlu8jhwm0o8Rz8mIwOGsIOK/RpJVJn2DA9fkiMBr694CAbu+fx1Zi8gLXNEUWMt5S29rsMrWSr83+dveUds=
X-Received: by 2002:a17:906:3409:: with SMTP id c9mr11596318ejb.314.1617323085208;
 Thu, 01 Apr 2021 17:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210331163816.11517-1-rppt@kernel.org> <CA+CK2bB7FuPV5z+j+8HS+wHOmNXAANYPLwo64ebV71AWNCjPSw@mail.gmail.com>
 <20210401171705.9bd350411cdee0db91332c92@linux-foundation.org>
In-Reply-To: <20210401171705.9bd350411cdee0db91332c92@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 1 Apr 2021 20:24:09 -0400
Message-ID: <CA+CK2bDhLboBCYL1BwxG2VzkrSnqzPMBx5NdrE==jJ-Do=_mSw@mail.gmail.com>
Subject: Re: [PATCH] mm/hugeltb: fix renaming of PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Andrew, since "mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN" is
> > not yet in the mainline, should I send a new version of this patch so
> > we won't have bisecting problems in the future?
>
> I've already added Mike's fix, as
> mm-cma-rename-pf_memalloc_nocma-to-pf_memalloc_pin-fix.patch.  It shall
> fold it into mm-cma-rename-pf_memalloc_nocma-to-pf_memalloc_pin.patch
> prior to upstreaming, so no bisection issue.

Great, thank you!

Pasha
