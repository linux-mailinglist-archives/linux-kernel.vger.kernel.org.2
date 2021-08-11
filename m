Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CF33E9235
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhHKNHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhHKNHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:07:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51BCE60C3E;
        Wed, 11 Aug 2021 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628687201;
        bh=fUdCaZhvGvtDwxEeWOdI/KcN6FC3y269PQqOnHZl3TY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQAisoLx/fo1hl4kc2JFXTkyx9v7c/vCodrtecfFN4CAB93vjWPyhEmwDRUt8M7Mc
         pmCeLqpZXP8x5T+uvbEs8ivM79gqkLYSQ9EOhdXFrUu0CJpJQEkvofeqsiJ1mXFFGz
         u2g4TzL5u1cJPFFggsbGEZAhJtw6/xhrwWdL0N8bNu7CP7v7QguarFud0otPoIFFS1
         rnnguFpt8Z9jXHCcswcXDTp3olUB2fjCdpgmGrjg97G8t+Arwv2u5EDl7OMB6JuDvK
         ThwCsvaOOqkz61YxXi2ibIV+FlJzlNdKKei6k/AldAGf4xSZzbX4ST4mlOhP9CH4n0
         xRvfZAuFbY+hw==
Date:   Wed, 11 Aug 2021 16:06:36 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Check memory add/cap ordering
Message-ID: <YRPLXFZxLVUjE5pr@kernel.org>
References: <aabc5bad008d49f07d542815c6c8d28ec90bb09e.1628672091.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabc5bad008d49f07d542815c6c8d28ec90bb09e.1628672091.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:55:18AM +0200, Geert Uytterhoeven wrote:
> For memblock_cap_memory_range() to work properly, it should be called
> after memory is detected and added to memblock with memblock_add() or
> memblock_add_node().  If memblock_cap_memory_range() would be called
> before memory is registered, we may silently corrupt memory later
> because the crash kernel will see all memory as available.
> 
> Print a warning and bail out if ordering is not satisfied.
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for 5.15,
Thanks!

-- 
Sincerely yours,
Mike.
