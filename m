Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C808C3697FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhDWRKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWRKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:10:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CA45613BE;
        Fri, 23 Apr 2021 17:10:14 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: remove HAVE_DEBUG_BUGVERBOSE
Date:   Fri, 23 Apr 2021 18:10:08 +0100
Message-Id: <161919777114.6013.3497530317233037222.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210418215231.563d4b72@xhacker>
References: <20210418215231.563d4b72@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Apr 2021 21:52:31 +0800, Jisheng Zhang wrote:
> After commit 9fb7410f955f ("arm64/BUG: Use BRK instruction for generic
> BUG traps"), arm64 has switched to generic BUG implementation, so
> there's no need to select HAVE_DEBUG_BUGVERBOSE.

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: remove HAVE_DEBUG_BUGVERBOSE
      https://git.kernel.org/arm64/c/4139cf940d52

-- 
Catalin

