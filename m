Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18076322D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhBWPaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233319AbhBWP3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:29:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D584464E4B;
        Tue, 23 Feb 2021 15:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614094124;
        bh=ASPTFYQJ9aYlx0jP9jf73ncK2t24KFX+ta+1VMzSgQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=joCMwd9EN+j1jUbAT42/zqoBbSjMxhmL/vxcEkNfXFNtSQ0GvIOfD0HpfKPOCRNLV
         nItF1cX2BWOEeYij1329LhFT9ZImkmUUkfxO+X2cxT/nX50U/HiMB22x538xophzvz
         LX3XnlaQ+42Dr91fhje1xsLppn9tWBquBwhNgYPiuO6mm87EP3Cml0NPf1+kzvTzJJ
         rMua10YCtj3C0YG/YEh4ZLsJmapvuuyEtrWmLLeIhcH4MqbxoE9VvvPynFteBGnD+A
         TlVDzwmdyeSW9SCI+HN0xwVeqstBuubJFM38R0WfvnOzfKYsC/vItnDFuGi3cAAK2u
         JkfCh5FuQZPUw==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/mm: Fixed some coding style issues
Date:   Tue, 23 Feb 2021 15:28:38 +0000
Message-Id: <161407685558.1401825.16372685933631923628.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1613958231-5474-1-git-send-email-daizhiyuan@phytium.com.cn>
References: <1613958231-5474-1-git-send-email-daizhiyuan@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 09:43:51 +0800, Zhiyuan Dai wrote:
> This patch move the pointer location to fix coding style issues,
> improve code reading.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: Fixed some coding style issues
      https://git.kernel.org/arm64/c/2e8acca1911b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
