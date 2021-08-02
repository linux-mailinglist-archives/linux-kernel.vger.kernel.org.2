Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31943DDEE9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhHBSHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBSHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:07:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2318860EE3;
        Mon,  2 Aug 2021 18:07:05 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Will Deacon <will@kernel.org>, maz@kernel.org,
        amit.kachhap@arm.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH] arm64: unnecessary end 'return;' in void functions
Date:   Mon,  2 Aug 2021 19:07:02 +0100
Message-Id: <162792758531.21352.13618828441310922141.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726123940.63232-1-wangborong@cdjrlc.com>
References: <20210726123940.63232-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 20:39:40 +0800, Jason Wang wrote:
> The end 'return;' in a void function is useless and verbose. It can
> be removed safely.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: unnecessary end 'return;' in void functions
      https://git.kernel.org/arm64/c/8f1fbc975b86

-- 
Catalin

