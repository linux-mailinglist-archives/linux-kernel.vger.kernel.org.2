Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80B33F8617
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbhHZLIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241863AbhHZLIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:08:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1245A61053;
        Thu, 26 Aug 2021 11:07:30 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xujun Leng <lengxujun2007@126.com>, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: fix comment typo of pud_offset_phys()
Date:   Thu, 26 Aug 2021 12:07:29 +0100
Message-Id: <162997601443.30374.4843361649013969123.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210825150526.12582-1-lengxujun2007@126.com>
References: <20210825150526.12582-1-lengxujun2007@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 23:05:26 +0800, Xujun Leng wrote:
> Fix a typo in the comment of macro pud_offset_phys().

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: mm: fix comment typo of pud_offset_phys()
      https://git.kernel.org/arm64/c/5845e703f9b5

-- 
Catalin

