Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CCD41CB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345277AbhI2RuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343623AbhI2RuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:50:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F37A86135E;
        Wed, 29 Sep 2021 17:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632937714;
        bh=482/occB/yS+/Jqx2F4SR9dzkauGgE6lzjrIHfobhGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePLitTl8YgG+Urin9jhiok61bqG+AT1DOcH3WjXAWWOipp8vL8uRFWK9BcmwjIrBx
         p2GcbVIHb2tNyMyLORy9bxIN46uoV8CVK4F15I4b15V+YJhUn3xWmtPGK88BWur24/
         VFeV1wEawtNX8ED+K0haxqwIe3HvegAIkUge0MsvKqnZakdpQ7HKXGYvoEEowmTbLX
         ncOApACSk3iF5znYKHMq9EpJJneYDd0KT4WzbAnRD/zAuFnd4Daj2x7xtyKc9l05I4
         LwNKk7TfH2ccD8mPwMuWfByITu1w/+vnZ/FlCGDSAJA1BYBuC1yj3OXHgbXwcBWN7k
         YtPZvKVReuEHg==
From:   Will Deacon <will@kernel.org>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/traps: Avoid unnecessary kernel/user pointer conversion
Date:   Wed, 29 Sep 2021 18:48:22 +0100
Message-Id: <163293026050.926465.15015359578646677100.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210917055811.22341-1-amit.kachhap@arm.com>
References: <20210917055811.22341-1-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 11:28:11 +0530, Amit Daniel Kachhap wrote:
> Annotating a pointer from kernel to __user and then back again requires
> an extra __force annotation to silent sparse warning. In call_undef_hook()
> this unnecessary complexity can be avoided by modifying the intermediate
> user pointer to unsigned long.
> 
> This way there is no inter-changeable use of user and kernel pointers
> and the code is consistent.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/traps: Avoid unnecessary kernel/user pointer conversion
      https://git.kernel.org/arm64/c/f5b650f887f3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
