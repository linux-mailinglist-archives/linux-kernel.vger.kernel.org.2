Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E14045D795
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354223AbhKYJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:52:46 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:57289 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348365AbhKYJup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:50:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J0Cj106q3z4xd8;
        Thu, 25 Nov 2021 20:47:32 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, masahiroy@kernel.org, adobriyan@gmail.com,
        andriy.shevchenko@linux.intel.com, Peiwei Hu <jlu.hpw@foxmail.com>,
        mpe@ellerman.id.au, aneesh.kumar@linux.ibm.com,
        rafael.j.wysocki@intel.com, benh@kernel.crashing.org,
        paulus@samba.org, ardb@kernel.org, clg@kaod.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
In-Reply-To: <tencent_BA28CC6897B7C95A92EB8C580B5D18589105@qq.com>
References: <tencent_BA28CC6897B7C95A92EB8C580B5D18589105@qq.com>
Subject: Re: [PATCH] powerpc/prom_init: fix the improper check of prom_getprop
Message-Id: <163783299816.1228879.14308105440652175596.b4-ty@ellerman.id.au>
Date:   Thu, 25 Nov 2021 20:36:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 17:12:18 +0800, Peiwei Hu wrote:
> prom_getprop() can return PROM_ERROR. Binary operator can not identify it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/prom_init: fix the improper check of prom_getprop
      https://git.kernel.org/powerpc/c/869fb7e5aecbc163003f93f36dcc26d0554319f6

cheers
