Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEFD3F341A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhHTSv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhHTSvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:51:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B96A060FE8;
        Fri, 20 Aug 2021 18:50:44 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Changbin Du <changbin.du@gmail.com>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: replace in_irq() with in_hardirq()
Date:   Fri, 20 Aug 2021 19:50:38 +0100
Message-Id: <162948543097.15117.15949920210143809523.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210814005405.2658-1-changbin.du@gmail.com>
References: <20210814005405.2658-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2021 08:54:05 +0800, Changbin Du wrote:
> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: replace in_irq() with in_hardirq()
      https://git.kernel.org/arm64/c/090bf6f84b4d

-- 
Catalin

