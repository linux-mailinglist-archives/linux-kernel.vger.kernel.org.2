Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269973A7DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFOMJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbhFOMJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:09:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4912C61461;
        Tue, 15 Jun 2021 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623758826;
        bh=TVleJdjdTq/q5wr3S4A5i6NMJ9Z3i/Flb35DtiMWGGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IwEXUafftjf6dFuHmBelpDXBe+ahOM2PLB7L2bq2EhVtvOdCucOqsb1XqrVdpZuru
         qNyaZQUl4lNdWYvVSUb3qoezCdIzvbgKkMUs/uPiXUJHO3g51S/kgKC5kKDWaC7vYT
         tPg+AUPlnBD5vV3xhRIeSGTTLuLB2JahJi4xevqsiQDnUhtJyPsVRxVNXv+DJMPKr5
         PR2xXXB9B9DpVAdBFk7jITjy/zDGPeH3NS4puLoyESHkf6uELumUCpKrjGBcqrLy+j
         Y5F9rQsmlYWZNmtw4mDorNkoLCBicSpGSAtWJlpqoy0CA/L8HBxu+qMoqE0V9bHMtw
         QGbYf2Ogo3gTg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Gavin Shan <gshan@redhat.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, mark.rutland@arm.com
Subject: Re: [PATCH] arm64: mm: Pass origial fault address to handle_mm_fault()
Date:   Tue, 15 Jun 2021 13:06:54 +0100
Message-Id: <162375717086.3635120.2890282643627544288.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614122701.100515-1-gshan@redhat.com>
References: <20210614122701.100515-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 20:27:01 +0800, Gavin Shan wrote:
> Currently, the lower bits of fault address is cleared before it's
> passed to handle_mm_fault(). It's unnecessary since generic code
> does same thing since the commit 1a29d85eb0f19 ("mm: use vmf->address
> instead of of vmf->virtual_address").
> 
> This passes the original fault address to handle_mm_fault() in case
> the generic code needs to know the exact fault address.

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: mm: Pass origial fault address to handle_mm_fault()
      https://git.kernel.org/arm64/c/84c5e23edecd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
