Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3503F8618
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbhHZLIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241863AbhHZLI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEF4A61026;
        Thu, 26 Aug 2021 11:07:40 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] arm64: signal32: Drop pointless call to sigdelsetmask()
Date:   Thu, 26 Aug 2021 12:07:39 +0100
Message-Id: <162997601443.30374.525425511591184271.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210825093911.24493-1-will@kernel.org>
References: <20210825093911.24493-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 10:39:11 +0100, Will Deacon wrote:
> Commit 77097ae503b1 ("most of set_current_blocked() callers want
> SIGKILL/SIGSTOP removed from set") extended set_current_blocked() to
> remove SIGKILL and SIGSTOP from the new signal set and updated all
> callers accordingly.
> 
> Unfortunately, this collided with the merge of the arm64 architecture,
> which duly removes these signals when restoring the compat sigframe, as
> this was what was previously done by arch/arm/.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: signal32: Drop pointless call to sigdelsetmask()
      https://git.kernel.org/arm64/c/24de5838db70

-- 
Catalin

