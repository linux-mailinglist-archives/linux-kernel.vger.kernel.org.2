Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030664293E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhJKP5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239142AbhJKP5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:57:48 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C0AA60E98;
        Mon, 11 Oct 2021 15:55:48 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mZxeU-00G454-1s; Mon, 11 Oct 2021 16:55:46 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, corbet@lwn.net,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: admin-guide: Document side effects when pKVM is enabled
Date:   Mon, 11 Oct 2021 16:55:42 +0100
Message-Id: <163396773657.855753.9209725646924595792.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011153835.291147-1-alexandru.elisei@arm.com>
References: <20211011153835.291147-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.morse@arm.com, linux-arm-kernel@lists.infradead.org, will@kernel.org, corbet@lwn.net, alexandru.elisei@arm.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 16:38:35 +0100, Alexandru Elisei wrote:
> Recent changes to KVM for arm64 has made it impossible for the host to
> hibernate or use kexec when protected mode is enabled via the kernel
> command line.
> 
> There are people who rely on kexec (for example, developers who use kexec
> as a quick way to test a new kernel), let's document this change in
> behaviour, so it doesn't catch them by surprise and we have a place to
> point people to if it does.

Applied to next, thanks!

[1/1] Documentation: admin-guide: Document side effects when pKVM is enabled
      commit: 53e8ce137f7b34bd7a54429d18e0d0e5f56f54e8

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


