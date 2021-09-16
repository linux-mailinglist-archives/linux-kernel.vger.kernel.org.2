Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7918240E941
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356962AbhIPRvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355821AbhIPRmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:42:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E059460FDA;
        Thu, 16 Sep 2021 17:08:27 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, Dan Li <ashimida@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC]arm64:Mark __stack_chk_guard as __ro_after_init
Date:   Thu, 16 Sep 2021 18:08:25 +0100
Message-Id: <163181210192.884883.7181525441852917097.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1631612642-102881-1-git-send-email-ashimida@linux.alibaba.com>
References: <1631612642-102881-1-git-send-email-ashimida@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 17:44:02 +0800, Dan Li wrote:
> __stack_chk_guard is setup once while init stage and never changed
> after that.
> 
> Although the modification of this variable at runtime will usually
> cause the kernel to crash (so dose the attacker), it should be marked
> as _ro_after_init, and it should not affect performance if it is
> placed in the ro_after_init section.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64:Mark __stack_chk_guard as __ro_after_init
      https://git.kernel.org/arm64/c/9fcb2e93f41c

-- 
Catalin

