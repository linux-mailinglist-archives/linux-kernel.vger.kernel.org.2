Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E99358BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhDHSA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhDHSAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:00:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65224610C8;
        Thu,  8 Apr 2021 18:00:12 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Add __init section marker to some functions
Date:   Thu,  8 Apr 2021 19:00:10 +0100
Message-Id: <161790479237.12189.15625395810024773914.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210330135449.4dcffd7f@xhacker.debian>
References: <20210330135449.4dcffd7f@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 13:54:49 +0800, Jisheng Zhang wrote:
> They are not needed after booting, so mark them as __init to move them
> to the .init section.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Add __init section marker to some functions
      https://git.kernel.org/arm64/c/a7dcf58ae5d2

-- 
Catalin

