Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8531F40E944
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357045AbhIPRvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355825AbhIPRmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:42:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A1F660E54;
        Thu, 16 Sep 2021 17:09:01 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     cgel.zte@gmail.com
Cc:     Will Deacon <will@kernel.org>, peterz@infradead.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, mark.rutland@arm.com,
        pcc@google.com, Zeal Robot <zealci@zte.com.cn>, maz@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/kernel: remove duplicate include in process.c
Date:   Thu, 16 Sep 2021 18:08:59 +0100
Message-Id: <163181210192.884883.11937713153007247102.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210902011126.29828-1-lv.ruyi@zte.com.cn>
References: <20210902011126.29828-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2021 18:11:26 -0700, cgel.zte@gmail.com wrote:
> Remove all but the first include of linux/sched.h from process.c

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/kernel: remove duplicate include in process.c
      https://git.kernel.org/arm64/c/861dc4f52e69

-- 
Catalin

