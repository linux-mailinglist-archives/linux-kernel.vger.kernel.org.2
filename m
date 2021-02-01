Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D2430AD88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhBAROO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:14:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhBAROL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:14:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F34A661481;
        Mon,  1 Feb 2021 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612199611;
        bh=dUiip7qLKy2LGuyjmp5XpIMJXqdoPfl8ZbQdZ7XrFZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJBFEJ2WwDMkPDBqnEdXz/wN4fvaLlGg5GudCf3AXYxGhGdBd2Dbm2s36egxJkMzm
         Cr6QvGhJGcR3AKSms90UJk8ULmqozKHKZBUULEe26tiwxi6wN8oOKcWXoGYcuo5shA
         tMS+vWc9FQo7H64Hzg4/CD+dsl2rZvUFmfIYoMAkiBG05MLS2CWKghNXS+T9Nv5YXd
         cPrjyUKZzaIOdSre1kl/K5BEwjcbBx+W8tFMozInlpaQ1dgGntyeG/RmmkP9TzCeKe
         MT7WdnnW/qRIxS8RGnV2OVpij8Ew481iQ1oL0zudn+3QQKJpQD9rkyF4h+LNeWSHXj
         6Nt0qG3q7eK8g==
From:   Will Deacon <will@kernel.org>
To:     vladimir.murzin@arm.com, matthias.bgg@gmail.com, maz@kernel.org,
        james.morse@arm.com, corbet@lwn.net, selindag@gmail.com,
        sashal@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        tyhicks@linux.microsoft.com, rfontana@redhat.com,
        jmorris@namei.org, steve.capper@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/1] arm64/hibernate: sparse warnings fix
Date:   Mon,  1 Feb 2021 17:13:24 +0000
Message-Id: <161219505105.3603742.9530959766797999831.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210201150306.54099-1-pasha.tatashin@soleen.com>
References: <20210201150306.54099-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 10:03:05 -0500, Pavel Tatashin wrote:
> This is against for-next/kexec, fix for sparse warning that was reported by
> kernel test robot [1].
> 
> [1] https://lore.kernel.org/linux-arm-kernel/202101292143.C6TcKvvX-lkp@intel.com
> 
> Pavel Tatashin (1):
>   arm64: hibernate: add __force attribute to gfp_t casting
> 
> [...]

Applied to arm64 (for-next/kexec), thanks!

[1/1] arm64: hibernate: add __force attribute to gfp_t casting
      https://git.kernel.org/arm64/c/d1bbc35fcab2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
