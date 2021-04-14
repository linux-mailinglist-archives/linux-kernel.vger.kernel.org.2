Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759CF35F143
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhDNKJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhDNKJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:09:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1D936128E;
        Wed, 14 Apr 2021 10:07:58 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@vivo.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64/kernel/probes: Use BUG_ON instead of if condition followed by BUG.
Date:   Wed, 14 Apr 2021 11:07:54 +0100
Message-Id: <161839480316.21512.13167172134622153882.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617105472-6081-1-git-send-email-zhouchuangao@vivo.com>
References: <1617105472-6081-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 04:57:50 -0700, zhouchuangao wrote:
> It can be optimized at compile time.

Applied to arm64 (for-next/misc), it saves one line ;). Thanks!

[1/1] arm64/kernel/probes: Use BUG_ON instead of if condition followed by BUG.
      https://git.kernel.org/arm64/c/839157876f97

-- 
Catalin

