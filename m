Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D29321A69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhBVOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhBVO3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:29:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CCD364DB1;
        Mon, 22 Feb 2021 14:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614004147;
        bh=6mB4JMT/+w6QdGUYB9iQQJkOQmscj/qwkonxGwBuPr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjT00xuPkd/Ig9AfT0fIf4wxtrbvMJnX3T08ojj7ay3fGg3OQ9HtAeRR5Ml3g6e5L
         2vSLhpRf8gf/1bIvQ6ulZ3cWTlXNJnvAQmxNVlVWP5kvhIXu6nx+qMWYoisK6wDOgo
         gjoH3jf1ckWJktGoSuvGtv8hFKkxfxQWyfW0kgbSBoyk/MJBd2XqWNcpscnB8yuS0d
         3KelwhTQAhlbYI3N/x0SkxR2+gQT3lSutnIBlrMhBBV1P9Rsr6Be0rF1ki/+nwDxkm
         FRK+zIB7yoeIS2Tszz/bo0xbq5gqecZgo+rRetPEuhpBwOEfih69HfqSfRuIFqxlzE
         jOGeqiiN7MecA==
From:   Will Deacon <will@kernel.org>
To:     james.morse@arm.com, jmorris@namei.org,
        tyhicks@linux.microsoft.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, ebiederm@xmission.com,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] kexec: move machine_kexec_post_load() to public interface
Date:   Mon, 22 Feb 2021 14:29:01 +0000
Message-Id: <161399720788.2051103.17455817952511939013.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210219195142.13571-1-pasha.tatashin@soleen.com>
References: <20210219195142.13571-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Feb 2021 14:51:42 -0500, Pavel Tatashin wrote:
> machine_kexec_post_load() is called after kexec load is finished. It must
> declared in public header not in kexec_internal.h
> 
> Fixes the following compiler warning:
> 
> arch/arm64/kernel/machine_kexec.c:62:5: warning: no previous prototype for
> function 'machine_kexec_post_load' [-Wmissing-prototypes]
>    int machine_kexec_post_load(struct kimage *kimage)

Applied to arm64 (for-next/fixes), thanks!

[1/1] kexec: move machine_kexec_post_load() to public interface
      https://git.kernel.org/arm64/c/2596b6ae412b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
