Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25F739094D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhEYTA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhEYTA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D01E66138C;
        Tue, 25 May 2021 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621969137;
        bh=z0usWbxfwBGudXRXKWGwieHukoR9PbbwFFDwEcd/QBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSdyFaTbGIQO99eM9GCc8qHAbjigQVZyE+VJTHnu+mCQYS5xo7MlMs3V/Raf9oMGH
         5ZCRp7fH+GgXjWp6Cl+F9NYVPV7di4nLg1jQPJ+xWIntxXvnq5q4ROLoA47WcnWuBv
         c4NEILZ6s0gq4LKbkgxqbrM4SPl+A22a0+uSVJOI4yYaEaN4BmgoPAPGE9LhWR3iED
         nMOgi5hcR6K0DCdCPv531cMnFF4jhiqbL+KLSZla2qt1cj8w5DfaSrBpxY1JFH56qR
         y7cRJKuhMdaGKj9JWXBgoEM1wddMJD1O+8MJH6h58SocThv+8o1/SQyfuAJ2WNF3gu
         BAkRT7FlGFM5w==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/mm: Make vmemmap_free() available only with CONFIG_MEMORY_HOTPLUG
Date:   Tue, 25 May 2021 19:58:41 +0100
Message-Id: <162196703657.2318431.4855809369951976839.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1621842030-23256-1-git-send-email-anshuman.khandual@arm.com>
References: <1621842030-23256-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 13:10:30 +0530, Anshuman Khandual wrote:
> vmemmap_free() callsites (mm/sparse.c) and declaration (include/linux/mm.h)
> are protected with CONFIG_MEMORY_HOTPLUG. This function is not required if
> CONFIG_MEMORY_HOTPLUG is not enabled. Hence move the config wrapper outside
> the function definition.

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Make vmemmap_free() available only with CONFIG_MEMORY_HOTPLUG
      https://git.kernel.org/arm64/c/40221c737608

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
