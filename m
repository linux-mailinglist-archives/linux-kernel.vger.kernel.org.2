Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5044D300
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhKKIQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:16:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232357AbhKKIQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:16:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E69E06109D;
        Thu, 11 Nov 2021 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636618407;
        bh=ggdWwnOFprqxn4AFwKaAIVYVP3np1MbAuiFudu/cyxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=Qsj7jK5RSS3WHkptOVVOEVyFgALovlDR8PMIiaEGS72WSJiY4f6lMxBdGnznMvMBB
         tH4EV66gmK8UDWydH0SUhQ5hrwzqMaAtPcNl1IzY1j4g0iTN9QQzPkFoOAR9B9k2eU
         3XIfnaOibjkKPcUVP3RuQon79UEq+FWTP8UrVBHMm6Zo1/Npi/ogBoYFdNtWL0Rc0l
         7ChhZmqw8V5yrOpuBGMnJRNdZ8LNEzWIjtb6Nj1qtu4gz9rluvYiWnOPgDr9PpiA0p
         Ara3nxNTxhBOTFP1d2xdzQ21p9ZyMfzz46Sa3VwGinFRWMoFZjphTcGyQ3J2UIlmkm
         PqOKdNfZkMa5w==
From:   SeongJae Park <sj@kernel.org>
To:     Yihao Han <hanyihao@vivo.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH v2] mm/damon/vaddr: remove swap_ranges() and replace it with swap()
Date:   Thu, 11 Nov 2021 08:13:24 +0000
Message-Id: <20211111081324.13174-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111064617.4729-1-hanyihao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 22:46:17 -0800 Yihao Han <hanyihao@vivo.com> wrote:

> Remove 'swap_ranges()' and replace it with the macro 'swap()'
> defined in 'include/linux/minmax.h' to simplify code and improve efficiency
> 
> Changes in v2:
> - Remove the 'swap_ranges()' function and replace it with 'swap()' 
> rather than changing the 'swap_ranges()' itself
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---

The above changes log would not supposed to be in the commit log, so putting it
here would be better.

Other than that,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
