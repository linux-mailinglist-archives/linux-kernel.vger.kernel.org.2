Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C873F6297
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhHXQUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhHXQT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:19:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBBDC6127B;
        Tue, 24 Aug 2021 16:19:13 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: (subset) [PATCH 0/5] arm64: Survival kit for SCR_EL3.HCE==0 conditions
Date:   Tue, 24 Aug 2021 17:19:07 +0100
Message-Id: <162982183775.27939.2596397506711756472.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210812190213.2601506-1-maz@kernel.org>
References: <20210812190213.2601506-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 20:02:08 +0100, Marc Zyngier wrote:
> Anyone vaguely familiar with the ARMv8 architecture would quickly
> understand that entering the kernel at EL2 without enabling the HVC
> instruction is... living dangerously. But as it turns out [0], there
> is a whole range of (*cough*) "high quality" (*cough*) Broadcom
> systems out there configured exactly like that.
> 
> If you are speechless, I'm right with you.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[5/5] arm64: Document the requirement for SCR_EL3.HCE
      https://git.kernel.org/arm64/c/e3849765037b

-- 
Catalin

