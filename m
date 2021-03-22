Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A6634459C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhCVNYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhCVNVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:21:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AF3C6198D;
        Mon, 22 Mar 2021 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616419221;
        bh=sRPo2fkNoZFZD5HrAJghuNqEYtoeifWmTP0wA1fzGyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P17LDjr1Ea9zhliCa5LIL7TtRPyybUNW1vesTFCt5pNA48dyHHtpHCizhvknyKcSM
         mcYT8ex3TIP4Yca0ie+2wzWCdchBkIur/A2zxTrAXkZgaav2ZsH7NWesT2o59nIJMZ
         bEtUQcz1Do6JzKXjHob+HMu2FUJtBMSKhOeDilGEu1uwOvQMEALq3Oo5BICj1AQOb5
         Z6L/fo43+UWskrQGiPYlB1520Wwmqa1IFlLQTGo+U8ivPT+aVwRIJ2/dg1nB89Q+oj
         GHohKTyqhcROuSvF22G5JgolHzICjZIkLf20QTaIQrwtGYwrq5gweDuNX82uy8jn+s
         sqyAsi9HB6Zcg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-arm-kernel@lists.infradead.org, vincenzo.frascino@arm.com,
        gustavoars@kernel.org, suzuki.poulose@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        rdunlap@infradead.org
Subject: Re: [PATCH] arm64: cpuinfo: Fix a typo
Date:   Mon, 22 Mar 2021 13:20:00 +0000
Message-Id: <161641711394.3900753.8128409981313133389.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210319222848.29928-1-unixbhaskar@gmail.com>
References: <20210319222848.29928-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2021 03:58:48 +0530, Bhaskar Chowdhury wrote:
> s/acurate/accurate/

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: cpuinfo: Fix a typo
      https://git.kernel.org/arm64/c/d1296f1265f7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
