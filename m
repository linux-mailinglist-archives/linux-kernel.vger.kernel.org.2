Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C823F6DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 05:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhHYDvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 23:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbhHYDue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 23:50:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECAAC0617AD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:49:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so3806668pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9sHfdiClg+ir79cDPtKTL0W793DnT07IRwQSqAPFHp4=;
        b=SNHYHGi1ywjzqrjN4Vr5b6iNJuFzuwLqCq5u/T+Vfl6bT/nVDfak3HIZ/5zzUaXBLx
         qHXc5HMhjunz5Tcci8T3BtPjccUPo9lQag2yq3MXOA8dzmHpPURkp4Phyb+NMOiA8uHu
         mAk3iNIjgmeySpy814cH9pbwf2U7WobmCunvxbey2Y5JK954SHN6j+FOB7BhcUUV6fy6
         b2YKJhK2R6UhdDgyj6KV0/AwH80guc1lwrwNI99/pqR9LOlSlx+tvHE2KYpVFMgq+70x
         D/65PWFVp2fnw4Ly+nACy81jTlmetYbczposURZHXwCv83wJ8N9j9QIOFTbcm721nckF
         YnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9sHfdiClg+ir79cDPtKTL0W793DnT07IRwQSqAPFHp4=;
        b=fTm1btZB4zFnlnQ/sQfT/reeGy6XsDCWmiUrf/t462+lS5uaZszkkoXw317KNw+qOZ
         K0fJhczHGWgXmV1goex682b3UT1BMYKu8i9oQdDZqRZ/hmSmKfRd+2VEDYV59ZFqwoKD
         fvMGHNrUBEM2TPOywJRDoqqOIjjCoFuogaeScpmgLKT781VdmFq+rhFjts6FSgMr2gci
         kcGA+uIbqw9ln36X4JbvHq9SVs6m75kH01iDPCnItL2743CnPjou1pPVvx3pNknc5zRj
         XvJ2E3uWCXVCgLVAJ6EjZgLn9aQDnJepo5CqRybZ4YxJpvtJd0tBbmkSUDTg+xd/MP90
         60pw==
X-Gm-Message-State: AOAM531JCRuk07NdSpBQgBacr6kYKjE5ir0ZoP1wYBIRVFQ3RpSjk08P
        4sGnjFdmh5rgK8u1K9zJKKNjIw==
X-Google-Smtp-Source: ABdhPJxItrgE+EVFUgM4xk5y1cyovfSflBdGl/ZTQWYSibONNZyb8WQmjv4eJYMsWeIsNWXL/FrN5w==
X-Received: by 2002:a17:902:9008:b0:12d:8258:e07c with SMTP id a8-20020a170902900800b0012d8258e07cmr36851163plp.42.1629863379987;
        Tue, 24 Aug 2021 20:49:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x26sm20744756pfm.77.2021.08.24.20.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 20:49:39 -0700 (PDT)
Date:   Tue, 24 Aug 2021 20:49:39 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Aug 2021 20:43:54 PDT (-0700)
Subject:     Re: [PATCH] arch: vdso: remove if-conditionals of $(c-gettimeofday-y)
In-Reply-To: <20210731055733.12332-1-masahiroy@kernel.org>
CC:     luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        will@kernel.org, tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        catalin.marinas@arm.com, benh@kernel.crashing.org,
        linux-mips@vger.kernel.org, paulus@samba.org,
        linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        linuxppc-dev@lists.ozlabs.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     masahiroy@kernel.org
Message-ID: <mhng-2a609a54-0d13-4fb3-9966-086357936773@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 22:57:33 PDT (-0700), masahiroy@kernel.org wrote:
> arm, arm64, mips, powerpc always select GENERIC_GETTIMEOFDAY, hence
> $(gettimeofday-y) never becomes empty.
>
> riscv conditionally selects GENERIC_GETTIMEOFDAY when MMU=y && 64BIT=y,
> but arch/riscv/kernel/vdso/vgettimeofday.o is built only under that
> condition. So, you can always define CFLAGS_vgettimeofday.o
>
> Remove all the meaningless conditionals.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/kernel/vdso/Makefile     |  5 +----

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
