Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABFF31FF4F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBSTRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhBSTRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:17:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A23D364E77;
        Fri, 19 Feb 2021 19:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613762222;
        bh=s+IRAB3GQwo7lZlVCb/XaeH898GzTcEhTJHn7OJaBr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwSlpIH7vp1o/frV5As/tVieLojSSvoJccvnqXmEiJF9THnR9GHji3wXrsGcOUIbM
         3eQmy0lK9Pzq8uqZgTQpab+UZPGBWXiPU0VB81Q5LlEn7MaQhIhBCShHmJEkvaBqah
         Ej8cpH2SUhdCPyihXdTjpCH+VC8C0z41LM8uqYmwISoNiIbBgPZ6eV6aeJ+WhMDvVX
         Jsuo/pgbFAiA5XbwUb58ltB3DyWJcrELzwl79P/qMBjLLH+k+iV6yuBmvZcU5RWPi6
         +VFoRtPycKVDcPTlQIufMUDNLVQyCRiNIRbAiSXBTs6uuT2qZ5D/lQtbKh3i5753WS
         hYUqvpKgLh/9Q==
From:   Will Deacon <will@kernel.org>
To:     akpm@linux-foundation.org, qiuguorui1 <qiuguorui1@huawei.com>,
        l.stelmach@samsung.com, bgwin@google.com, james.morse@arm.com,
        catalin.marinas@arm.com, tao.li@vivo.com, gustavoars@kernel.org,
        takahiro.akashi@linaro.org, rppt@kernel.org, lkml@SDF.ORG
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, liuwenliang@huawei.com,
        zengweilin@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kexec_file: fix memory leakage in create_dtb() when fdt_open_into() fails
Date:   Fri, 19 Feb 2021 19:16:54 +0000
Message-Id: <161375746170.289317.5573837161250054897.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210218125900.6810-1-qiuguorui1@huawei.com>
References: <20210218125900.6810-1-qiuguorui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021 20:59:00 +0800, qiuguorui1 wrote:
> in function create_dtb(), if fdt_open_into() fails, we need to vfree
> buf before return.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: kexec_file: fix memory leakage in create_dtb() when fdt_open_into() fails
      https://git.kernel.org/arm64/c/656d1d58d8e0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
