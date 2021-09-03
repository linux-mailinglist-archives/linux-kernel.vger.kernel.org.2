Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290523FFAA6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347394AbhICGvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347003AbhICGvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:51:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0107C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 23:50:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i24so709465pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0BQ9u2y+lw4VEtzEXjzN4NZ3IpjygaobSG94tsEQOB0=;
        b=K/qIFLcWBPxAbl2ywxgXJE7YZyHmsP6nhL7IpT7DAAX6NFt6nPHyvf0YrSBgQfiylr
         7dl2n5nhxJmv0oH+QIgd9rBVOpqcoFBfHG7tPeB5StXo6jj+Dn/V/zMVaEBVt8sNarj6
         dzfcBJrm0i2gf7wSE3vYt5mIOIDVpUgHnh0s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0BQ9u2y+lw4VEtzEXjzN4NZ3IpjygaobSG94tsEQOB0=;
        b=jmIRIe4mC6S3JQJ3uj6VrT3nW0rJ/YtDyeGjcv7Jk5lFGccSjSIJoL7La+SGkuEcln
         LSZszVUe+tYWuudRPWW5ofsBlOOWYMMoFAD/Em6sea8hZP89VqOP9rdhq94bHZK5pOsp
         EDrsWAGrtRUCfysQN5u2Lgy4LPdRDty2OadBHCXtp76ap69podzR+io9Gkw2tQ5TCBIm
         Xy0iHd2GkUQvYaFlopCxChzmHtKILJa3qSzUFY3ZvNOe3K+yySyKL5kFtemwEvBy9bW+
         TUqwBda6QdAiVAsPO7IO4mKuoWAm6pEW6tDWBNkfp+HRPsky9N3IrZ4aOaHjtEznLZRV
         Nevw==
X-Gm-Message-State: AOAM532VGXdHHy+1QWs0xwEM7/qs95IfEe0jYCcQqjFVYrLSVQbsj/JA
        n7ancBbTPZ1AG4rrbgynBbsXAdFwg9Z0pA==
X-Google-Smtp-Source: ABdhPJyp7NknuFpIcPAgK+njiE3tqC94g8/kN/2XtEpH0MA3stL+2JFabeSEdyw88uMsuVCmN0FLRA==
X-Received: by 2002:a63:e64a:: with SMTP id p10mr2274483pgj.263.1630651836290;
        Thu, 02 Sep 2021 23:50:36 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:ddd7:1b3:9327:fcf5])
        by smtp.gmail.com with ESMTPSA id y3sm5045324pge.44.2021.09.02.23.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 23:50:35 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/machdep: Remove stale functions from ppc_md structure
In-Reply-To: <24d4ca0ada683c9436a5f812a7aeb0a1362afa2b.1630398606.git.christophe.leroy@csgroup.eu>
References: <24d4ca0ada683c9436a5f812a7aeb0a1362afa2b.1630398606.git.christophe.leroy@csgroup.eu>
Date:   Fri, 03 Sep 2021 16:50:32 +1000
Message-ID: <87ilzi5f0n.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> ppc_md.iommu_save() is not set anymore by any platform after
> commit c40785ad305b ("powerpc/dart: Use a cachable DART").
> So iommu_save() has become a nop and can be removed.

I wonder if it makes sense to have an iommu_restore() without an
iommu_save. Only dart_iommu.c defines an iommu_restore(), but I couldn't
figure out if it was safe to remove and it seems like it still did
something...

> ppc_md.show_percpuinfo() is not set anymore by any platform after
> commit 4350147a816b ("[PATCH] ppc64: SMU based macs cpufreq support").
>
> Last users of ppc_md.rtc_read_val() and ppc_md.rtc_write_val() were
> removed by commit 0f03a43b8f0f ("[POWERPC] Remove todc code from
> ARCH=powerpc")
>
> Last user of kgdb_map_scc() was removed by commit 17ce452f7ea3 ("kgdb,
> powerpc: arch specific powerpc kgdb support").
>
> ppc.machine_kexec_prepare() has not been used since
> commit 8ee3e0d69623 ("powerpc: Remove the main legacy iSerie platform
> code"). This allows the removal of machine_kexec_prepare() and the
> rename of default_machine_kexec_prepare() into machine_kexec_prepare()

I think you should also remove the prototype from
arch/powerpc/include/asm/kexec.h

Apart from that:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel Axtens
