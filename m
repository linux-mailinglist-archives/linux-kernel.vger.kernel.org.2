Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564B93979F3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhFASXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234622AbhFASXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:23:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 334EC613D5;
        Tue,  1 Jun 2021 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622571688;
        bh=2LkiZTd7WmnTPbe1jx3qQ01dv/8NESevXvihBHnGz2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQ4hUhTV9yk7DpHXZZxe22oEyovRk43hL5EoCX/gf1kObhlDNTgJXPuCet0n+WpV3
         i9Jk15r+opGUH/cD/5eYb6GqGljQz3PEk950ZDKoljiBThLMqBJwNWjZvfhF6j3K54
         QhR9h4Y/XrhzD6X2hS4QWU4djF0u1P6NzTAF1klZ8u82+lnXP3KdFNDKssahHqQ+yQ
         5Vnlm+WtG7KIl9mWq6N3Ag+VdsjqH3jNiI/F1P1MUtFi+i0g/2PoqAI8o08SVJMOjC
         DFqX3xasRXO5ygZhsW3MIPHrjUWS9KP9ijUcEm/NhAyI12IGiwkPJ/rxwI8LJaqceU
         +kzthHYM3qjZA==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org, acme@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        mingo@redhat.com, jolsa@redhat.com,
        Yang Jihong <yangjihong1@huawei.com>, linux@armlinux.org.uk,
        julien.thierry.kdev@gmail.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm_pmu: Fix write counter incorrect in ARMv7 big-endian mode
Date:   Tue,  1 Jun 2021 19:21:05 +0100
Message-Id: <162255342222.565985.6841867867771052763.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430012659.232110-1-yangjihong1@huawei.com>
References: <20210430012659.232110-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 09:26:59 +0800, Yang Jihong wrote:
> Commit 3a95200d3f89a ("arm_pmu: Change API to support 64bit counter values")
> changes the input "value" type from 32-bit to 64-bit,
> which introduces the following problem:
> ARMv7 PMU counters is 32-bit width, in big-endian mode, write counter uses
> high 32-bit, which writes an incorrect value.
> 
> Before:
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] arm_pmu: Fix write counter incorrect in ARMv7 big-endian mode
      https://git.kernel.org/will/c/fdbef8c4e68a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
