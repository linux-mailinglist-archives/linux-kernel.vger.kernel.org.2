Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6607A314536
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhBIBEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBIBEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:04:09 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8B9C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:03:28 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cv23so603862pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=MfcsXfncKqwyZqj9wo90IfUK1Xuq26ciFpVmdsqb4sw=;
        b=j5O/lJoB6fWuGf5SzkH1gnTYbuONd+VGpxE2jrItYctPzNsUxG8mTGMkmrLluJHy/n
         y7VeOhTqRYO5GyfJ7ssgtNKjOo7/uBC6kOplsSlMDX+JeVtMRF/6zlpOHy9N8GBkMNad
         l3DgNqaSbgzNtR2wQm5SgpzzwlTiDAe6KXxAow5huNWk74TB07u75O61RPaef8g5mwZ3
         RuazMLkeM9ZaGiRENWKve6/j0E7UCcTiXfpOAtpfed21vZ6xQsgJ6d3aeKS9QBegcIzM
         2Tug/R8gr2E/1+Y+ObF77ZS0JXhJFIlLllsIXK7F1c6KqrGXcvKRLGUbeUbMNID9Y12z
         lwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=MfcsXfncKqwyZqj9wo90IfUK1Xuq26ciFpVmdsqb4sw=;
        b=eXlQypfZdQAnEyWOnhn8jlPDoCiSZUB4QhmiLXmXbYUQUoc1RNZkoo2RWGQGlP+ZXp
         WIOTipc8v+HiAdt1aBRStlKGpr02kjx9OaQWSJ8lUIIQe7i29GfxnfxLv1/Lhgi4aK5m
         l1Zjn19MKu2Ru1GKvrvGMGLK3R4cLnRiP3IeMIrXS+dEwDd1u8AmciMGf8a/MBRE+lon
         K+Ylgi6WBePymMQOJlPH7mz65KOL+OvZ70ff5srMwSR6bdfjgUC0kcni9hYDW9ql4lcH
         tZfMlFk2klxitK92Z1sK5l8EDohVUGzVmaJYsqoYZBq7Qi8KfzxeutV7m1t/642MR+Vi
         bhyQ==
X-Gm-Message-State: AOAM533UhnQs/0R4DkruauHtx3qcqgoNvxuOsfAyqFASXaW/iZ+a4bRw
        K3pGsjdktGvosc8hbr48ACGohtGsZQ63/A==
X-Google-Smtp-Source: ABdhPJxBFTNVbvcjXcaw2456OCXzobbFg3C8PqR3Wy1L83G9v50cVL32RYMQWVwFOK18iqh+ckrFRg==
X-Received: by 2002:a17:90a:da02:: with SMTP id e2mr1438717pjv.173.1612832608592;
        Mon, 08 Feb 2021 17:03:28 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id f18sm442920pjq.53.2021.02.08.17.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:03:27 -0800 (PST)
Date:   Tue, 09 Feb 2021 11:03:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 00/22] powerpc/32: Implement C syscall entry/exit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612832388.bbrfxby1h0.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> This series implements C syscall entry/exit for PPC32. It reuses
> the work already done for PPC64.
>=20
> This series is based on today's merge-test (b6f72fc05389e3fc694bf5a5fa1bb=
d33f61879e0)
>=20
> In terms on performance we have the following number of cycles on an
> 8xx running null_syscall benchmark:
> - mainline: 296 cycles
> - after patch 4: 283 cycles
> - after patch 16: 304 cycles
> - after patch 17: 348 cycles
> - at the end of the series: 320 cycles
>=20
> So in summary, we have a degradation of performance of 8% on null_syscall=
.
>=20
> I think it is not a big degradation, it is worth it.

I guess it's 13% from 283. But it's very nice to use the shared C code.

There might be a few more percent speedup in there we can find later.

Thanks,
Nick

