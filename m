Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF29369808
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbhDWRMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWRMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:12:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B451613CB;
        Fri, 23 Apr 2021 17:11:49 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Show three registers per line
Date:   Fri, 23 Apr 2021 18:11:46 +0100
Message-Id: <161919777114.6013.3738864758201386208.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210420172245.3679077-1-willy@infradead.org>
References: <20210420172245.3679077-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 18:22:45 +0100, Matthew Wilcox (Oracle) wrote:
> Displaying two registers per line takes 15 lines.  That improves to just
> 10 lines if we display three registers per line, which reduces the amount
> of information lost when oopses are cut off.  It stays within 80 columns
> and matches x86-64.

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: Show three registers per line
      https://git.kernel.org/arm64/c/0bca3ec846d7

-- 
Catalin

