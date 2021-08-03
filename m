Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6FA3DF1CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbhHCPsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237020AbhHCPsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B32AE6104F;
        Tue,  3 Aug 2021 15:47:56 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: move the (z)install rules to arch/arm64/Makefile
Date:   Tue,  3 Aug 2021 16:47:49 +0100
Message-Id: <162800566375.22137.6946161452098258110.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729140527.443116-1-masahiroy@kernel.org>
References: <20210729140527.443116-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021 23:05:27 +0900, Masahiro Yamada wrote:
> Currently, the (z)install targets in arch/arm64/Makefile descend into
> arch/arm64/boot/Makefile to invoke the shell script, but there is no
> good reason to do so.
> 
> arch/arm64/Makefile can run the shell script directly.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: move the (z)install rules to arch/arm64/Makefile
      https://git.kernel.org/arm64/c/70a4039bd4d7

-- 
Catalin

