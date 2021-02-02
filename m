Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A801430CDEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhBBV0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhBBVZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:25:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4223264F92;
        Tue,  2 Feb 2021 21:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612301117;
        bh=77hMMxPOprzk0Qr/q3FVg6g5wTLq0Jyb37av0hDV5GY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iny8Le7EK2XGGJBQf/2TcafRz1zhkrHGuEjNOesJ06qD1UnIY/XYnjHuwu/j9lb3w
         YOF4v03oYIj6Cn+rdz3aKa3qvYeMvdbH5+Tf+5KYmG4rumTcFDFg7FdTHj6MWnAP5Z
         fwMc+YIAc/0NSz1InHjR694KU7Y9RhlDH2y+0ls0dMDRzIPXvXVKKMMl5CWX9RXuii
         9q1ZUanv1GMBh6SfaTDKyRqbsca4WkCF01jtL37FKtRI1UyA+AS6Dffc8rxTl4G49o
         Q6hKTkELZE1HKUZz3wGfr2iJ8RFNtT6cg3ieVxW6B4b/x9zuvlnVYa3Ouvq6sx1YD5
         7pDvGHbpdZw+A==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, Qi Liu <liuqi115@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linuxarm@openeuler.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: Prevent forced unbinding of ARM_DMC620_PMU drivers
Date:   Tue,  2 Feb 2021 21:25:10 +0000
Message-Id: <161229123070.588050.6317802681670021510.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1612252686-50329-1-git-send-email-liuqi115@huawei.com>
References: <1612252686-50329-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 15:58:06 +0800, Qi Liu wrote:
> Set "suppress_bind_attrs" to true, so that bind/unbind can be
> disabled via sysfs and prevent unbinding ARM_DMC620_PMU drivers
> during perf sampling.

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: Prevent forced unbinding of ARM_DMC620_PMU drivers
      https://git.kernel.org/will/c/20116dd93f4d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
