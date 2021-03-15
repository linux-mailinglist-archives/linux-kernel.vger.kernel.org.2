Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5129533B0AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCOLJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhCOLJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:09:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85D4364E10;
        Mon, 15 Mar 2021 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615806545;
        bh=cHe5RSU39hrf/ymOIT9U/8vkIFHGBNL/uZbszqSluUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/YFTwc1wf9bcD/ysmbBKbTjGcRDa75Qz0+SASn+w/v5jwJOb4lqrIgDoxz50h/mb
         knzQpqpuVNo4AGg+A84TsMd9DDQ8sYTB/tXZ+LxxgwBg+tOCvnn1RYFO9ioT/LkY3B
         1yWe+7kuQH2dKIzhX2cp79xYGvn5sYArfooJACptpgHV1o1bLB+IUwRN1yu9DRb6W6
         8m/Nk+T/F+vSZFD9lsMogakxLbR4ISdgthsRqEpJxONNxLznz+rVRk4rxEKSzYSn58
         5r0QVpN8UFo6aS8VTBqVBdC3fAtw+Cb+W4glaC2cytzyih/hikYWYyGhoDyoGSiA84
         utUk2PqyUKa7w==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, robin.murphy@arm.com,
        Alex Elder <elder@linaro.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: csum: cast to the proper type
Date:   Mon, 15 Mar 2021 11:08:59 +0000
Message-Id: <161580584158.3661646.2103216478554098018.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210315012650.1221328-1-elder@linaro.org>
References: <20210315012650.1221328-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2021 20:26:50 -0500, Alex Elder wrote:
> The last line of ip_fast_csum() calls csum_fold(), forcing the
> type of the argument passed to be u32.  But csum_fold() takes a
> __wsum argument (which is __u32 __bitwise for arm64).  As long
> as we're forcing the cast, cast it to the right type.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: csum: cast to the proper type
      https://git.kernel.org/arm64/c/0710442a88d1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
