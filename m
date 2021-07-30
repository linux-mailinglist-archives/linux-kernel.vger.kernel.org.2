Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774583DBE0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhG3SBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 14:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhG3SBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 14:01:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B618660F4B;
        Fri, 30 Jul 2021 18:01:01 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, amit.kachhap@arm.com,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tabba@google.com, dave.martin@arm.com, mark.rutland@arm.com
Subject: Re: [PATCH] arm64: use __func__ to get function name in pr_err
Date:   Fri, 30 Jul 2021 19:00:55 +0100
Message-Id: <162766803320.17946.14774626934912896748.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726122907.51529-1-wangborong@cdjrlc.com>
References: <20210726122907.51529-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 20:29:07 +0800, Jason Wang wrote:
> Prefer using '"%s...", __func__' to get current function's name in
> a debug message.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: use __func__ to get function name in pr_err
      https://git.kernel.org/arm64/c/2806556c5e1a

-- 
Catalin

