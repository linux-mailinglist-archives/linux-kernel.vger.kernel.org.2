Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219B23F286F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhHTIcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhHTIcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:32:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DE2F61075;
        Fri, 20 Aug 2021 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629448296;
        bh=Xm4VK8gc0LS1XxhzHAqTJlbzlRQpgW95Qm06l3aauvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LcAZW9mi5E2m/cmQXXBn8u2y5r7lSJXrrz5wumwkW4I6wF5DiAqa1IzyVx3KPMX56
         bt8CCk4o5TM+c9v9bK7D9u2lkEP6ImyymfQ6mJfCjDjYQNv1i5xDSEE3cv4vlJjFO3
         afM4l2/4uyNayAdTttNT2fA0xXD0ExHvMhvfhFArtXNJNVOqzpbaCaNYSZywQXkjLm
         cC7aL1y7ngc60KfS67l4MsbOCQPif58qijiGSJFU9UaWdEfCYuzsDIasznVWp8hCqI
         JR2zkTQoTyw+HSjkKU464+yHsciWxzTgivMUEp40buMFjrUqSxLYapZ8F9s+7mDoIz
         Y3IhTV9DshplA==
Date:   Fri, 20 Aug 2021 09:31:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop page-def.h
Message-ID: <20210820083131.GB16784@willie-the-truck>
References: <1629441331-19530-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629441331-19530-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 12:05:31PM +0530, Anshuman Khandual wrote:
> PAGE_SHIFT (PAGE_SIZE and PAGE_MASK) which is derived from ARM64_PAGE_SHIFT
> should be moved into pgtable-hwdef.h instead, and subsequently page-def.h
> can be just dropped off completely.

According to who?

Every other architecture defines PAGE_SHIFT in page.h, so if you're moving
things around then that sounds like a better choice.

Will
