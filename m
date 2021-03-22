Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4FE344595
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhCVNXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232989AbhCVNUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:20:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1F586192D;
        Mon, 22 Mar 2021 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616419218;
        bh=tB9BH1WfCWL6Zr4kv1jDusfYTeAiiKrkECsa+aMqwkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwblAcOCJaG11yegYF6v/yVGLYeCuvNggXP6cYwxqHrOHGMcLDVs6i/mur3l1xiZp
         3Aph3qidUnTp1L+HdY3dSdhSp8pHuoagOmzmRC5kXFp6NbTxP0yvXs3rR+Mpu7eVB4
         ii5g767V0uB3aaqnj8HZjkn1eu2bRzUH0053RggvQGZErsNuHcwy8WmOMCFTDeL2rU
         /3D9jTkWdJ6a9EzImzEw78SxHqX9Yb8jbgRSZrFm/QD2FoOjC4r/JKfvo4RBB89BPi
         gkyTlGVyicHIwslsiIpAAoYxrcTBEuJk/daaiQlZKgQ+esljQM6lB9ad2PtWc66VtL
         GvHxNkt5aCkfQ==
From:   Will Deacon <will@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Tai <thomas.tai@oracle.com>,
        Tom Saeger <tom.saeger@oracle.com>, linux-doc@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Al Stone <al.stone@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm64/acpi : clarify arm64 support of IBFT
Date:   Mon, 22 Mar 2021 13:19:59 +0000
Message-Id: <161641700110.3900554.4306809050769717911.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
References: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 12:50:41 -0600, Tom Saeger wrote:
> In commit 94bccc340710 ("iscsi_ibft: make ISCSI_IBFT dependson ACPI instead
> of ISCSI_IBFT_FIND") Kconfig was disentangled to make ISCSI_IBFT selection
> not depend on x86.
> 
> Update arm64 acpi documentation, changing IBFT support status from
> "Not Supported" to "Optional".
> Opportunistically re-flow paragraph for changed lines.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] Documentation: arm64/acpi : clarify arm64 support of IBFT
      https://git.kernel.org/arm64/c/e14a371f732b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
