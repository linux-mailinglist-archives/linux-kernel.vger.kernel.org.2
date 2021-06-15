Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF58A3A7DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFOMJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhFOMJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB7396145F;
        Tue, 15 Jun 2021 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623758823;
        bh=lOlaZf1R4UfQSki/XQKY+dn8lW/qqAaoP2FcRRgKX+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kINviSGCFVykTf1Obsp/YWrILmnCRlO/LPEwC3JLq705+/r8n/MDxDX310b9QlAZp
         SwHtxVfKwNU7j/OkiFM36BGp8E2DBIdhWKrGmr6ZfeJ7BjEvSg1rcqUJyIq+vigIWH
         tWJQ0G8CGDQAh4xf0c8Z5R+uYVNUuYxpKSuEKGjv7ZBtTdklxWMvosQoxOXdmeJ/oW
         mc0K9EAPIFOdtCb35j31w6hCmyGRYwMthPO1pcw61QcRogDTXMOVo0HQyalS6tG2xJ
         coXaVc7UqV3xJ4tTUUrCZ9/qEx0BCXRlPLhH6eUtOAAh5vTF2KWZUF6Rw/VUFCnT/S
         j8qa+mJN78nVg==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/mm: Use CONT_PMD_SHIFT for ARM64_MEMSTART_SHIFT
Date:   Tue, 15 Jun 2021 13:06:52 +0100
Message-Id: <162375530576.2680511.10357384723588273448.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623663755-8949-1-git-send-email-anshuman.khandual@arm.com>
References: <1623663755-8949-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 15:12:35 +0530, Anshuman Khandual wrote:
> ARM64_MEMSTART_SIZE needs to be aligned with CONT_PMD_SIZE on 16K page size
> config. Hence just directly use CONT_PMD_SHIFT.

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Use CONT_PMD_SHIFT for ARM64_MEMSTART_SHIFT
      https://git.kernel.org/arm64/c/ca6ece6a76a8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
