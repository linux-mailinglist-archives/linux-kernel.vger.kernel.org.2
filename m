Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0C03F99ED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbhH0NX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245275AbhH0NXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:45 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBC4C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:22:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0l14C20z9tk8;
        Fri, 27 Aug 2021 23:22:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, sxwjean@me.com
Cc:     mpe@ellerman.id.au, paulus@samba.org, efremov@linux.com,
        oleg@redhat.com, benh@kernel.crashing.org,
        ravi.bangoria@linux.ibm.com, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        Xiongwei Song <sxwjean@gmail.com>, npiggin@gmail.com
In-Reply-To: <20210807010239.416055-1-sxwjean@me.com>
References: <20210807010239.416055-1-sxwjean@me.com>
Subject: Re: [PATCH v2 0/4] Some improvements on regs usage
Message-Id: <163007017202.52768.7618867123198912679.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:16:12 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2021 09:02:35 +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> When CONFIG_4xx=y or CONFIG_BOOKE=y, currently in code we reference dsisr
> to get interrupt reasons and reference dar to get excepiton address.
> However, in reference manuals, esr is used for interrupt reasons and dear
> is used for excepiton address, so the patchset changes dsisr -> esr,
> dar -> dear for CONFIG_4xx=y or CONFIG_BOOKE=y.
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc: Optimize register usage for esr register
      https://git.kernel.org/powerpc/c/4f8e78c0757e3c5a65d9d8ac76e2434c71a78f5a
[2/4] powerpc/64e: Get esr offset with _ESR macro
      https://git.kernel.org/powerpc/c/cfa47772ca8d53d7a6c9b331a7f6e7c4c9827214
[3/4] powerpc: Optimize register usage for dear register
      https://git.kernel.org/powerpc/c/4872cbd0ca35ca5b20d52e2539e7e1950f126e7b
[4/4] powerpc/64e: Get dear offset with _DEAR macro
      https://git.kernel.org/powerpc/c/d9db6e420268b2d561731468a31f0b15e2e9a145

cheers
