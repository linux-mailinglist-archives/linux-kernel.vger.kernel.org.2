Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809293DF1CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhHCPsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237000AbhHCPsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:48:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51A4E60EFD;
        Tue,  3 Aug 2021 15:48:10 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Wang <wangborong@cdjrlc.com>, will@kernel.org
Cc:     nathan@kernel.org, linux-kernel@vger.kernel.org,
        samitolvanen@google.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: fix typo in a comment
Date:   Tue,  3 Aug 2021 16:48:08 +0100
Message-Id: <162800566375.22137.4299409500738989157.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803142020.124230-1-wangborong@cdjrlc.com>
References: <20210803142020.124230-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 22:20:20 +0800, Jason Wang wrote:
> The double 'the' after 'If' in this comment "If the the TLB range ops
> are supported..." is repeated. Consequently, one 'the' should be
> removed from the comment.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: fix typo in a comment
      https://git.kernel.org/arm64/c/312b7104f39b

-- 
Catalin

