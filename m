Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6A45C76F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355678AbhKXOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355017AbhKXOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:35:30 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB533C0A8893
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 05:21:35 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so5051517pja.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 05:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ZZnceqICuZXQxPcm2fjZ+yNkedIH7ExOGImuK8kHxUU=;
        b=bGwnHyizE2euGF4OJfhTDD2tgzRvAWwF6PN/DkgD6CTp4z8K9eAW13Jav2pgjImfCK
         OSon47t018CdVGm9mwvb/92iEYY3llvVuiiZW7fYtR9jv7GbrAtRGtB7p9qqlaXU2Lqi
         ZGdLYeQHe9ZPJwI5yEtPPR5WbEApMhzyIgis689/J6Y/haHI6FN4DbeQoA11s9T24lyj
         W/TaflPrQrNy0nXT2rAVInzq+weBRQ+8Is7lcmA7fV5km70Xd8uF/yJQnvd983gJ0DiN
         GTFC4E0k8tzzeXwn8H4YWGoe67sR09wIqkHUQCsSB1hU0+VljxCfrne+wrRW2W19Blp7
         2Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ZZnceqICuZXQxPcm2fjZ+yNkedIH7ExOGImuK8kHxUU=;
        b=UiGOGtOixftlox4YvfE8uRNzL9+fTl/szbrJRGN0TliUYz+s5DLwI5llhXa2s/zMKq
         7a+qlH16canklJFPweNaxMbaCOor0ISMG6cATPxGwrrSCDV5yGG3h3Ywplvxg3/FP//y
         //BGeaiQbUGrjc3giynTZ3zFYBDMQUIRKyBfchqp8Cv4MUPpd6dTLdR3inJj6NVRX3Km
         7WKdhEjiKfybW95CKZN0J9xM03u0kzn+ckV2LWjRgLu52AxoO8/nC4Pspt7X3OubABC2
         cllRdIkkis6LjDK+/mirZsq5BIYUT4WLmHPjj+s4miCnXsn4Yq+afmCjgUJ5+MNczNZf
         OOHQ==
X-Gm-Message-State: AOAM5308uHBr3cvJyis7FJU8lXOt5hfra0HyM3i1l7Pu1xA3J5PxLqfw
        4+SFa3o73Uz1y3IDbx7bGq8=
X-Google-Smtp-Source: ABdhPJz1FI1FMD+raRAIrvhT0VvCzZtUkPciJvFR7lj0nGhiV/h2EIZmuWty/vs4et/iSU5mts8Dqw==
X-Received: by 2002:a17:902:c202:b0:142:2441:aa25 with SMTP id 2-20020a170902c20200b001422441aa25mr18417025pll.68.1637760095555;
        Wed, 24 Nov 2021 05:21:35 -0800 (PST)
Received: from localhost ([124.170.11.53])
        by smtp.gmail.com with ESMTPSA id j6sm17055518pfu.205.2021.11.24.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 05:21:34 -0800 (PST)
Date:   Wed, 24 Nov 2021 23:21:28 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/8] Convert powerpc to default topdown mmap layout
To:     alex@ghiti.fr, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1637570556.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1637570556.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1637759994.e3mppl4ly7.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of November 22, 2021 6:48 pm:
> This series converts powerpc to default topdown mmap layout.
>=20
> powerpc provides its own arch_get_unmapped_area() only when
> slices are needed, which is only for book3s/64. First part of
> the series moves slices into book3s/64 specific directories
> and cleans up other subarchitectures.
>=20
> Then a small modification is done to core mm to allow
> powerpc to still provide its own arch_randomize_brk()
>=20
> Last part converts to default topdown mmap layout.

A nice series but will clash badly with the CONFIG_HASH_MMU=20
series of course. One will have to be rebased if they are
both to be merged.

Thanks,
Nick
