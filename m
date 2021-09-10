Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EE2407239
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhIJUBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:01:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59575 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230513AbhIJUAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:00:49 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18AJxIMe517265
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 10 Sep 2021 12:59:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18AJxIMe517265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631303967;
        bh=chquAj+ypukLNoNPJFWYjEMUvJZHTqTclDYlmUvWdp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+Go7moZYNAcJrZ3OGaA+/2RGNbqjfvGGstKaS+ypiEJWaZsFPKljh2LNeOiJhJ7d
         +7peCjQSrGQhp86PnToJfpvsUB6a0zvF2vCI0VRpCI2Hxx8rLR/OueiHTk9yMoh0bn
         6mEY0eFlwAEEXhbKN65rH5eV3rXB11fiAVqJsIVoTxqFLtjUag29Sa2JFI9FJPEYVA
         SdAKReYBUnuI+HNkmV7X02pWbst5I8lpD3mDYkpZKKT6yWTMUCaMTEp298TZ8t9SwM
         pZ2LjhZC1V7fAcawpBWhjGy4UCh2bwS1dQ5MPvauuLjzjudSn2h2ojtZuyeCmD7MB7
         Gq1Xtk2yzWQ8Q==
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86 mailing list <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH v3 0/2] x86/asm: avoid register pressure from the init case in static_cpu_has()
Date:   Fri, 10 Sep 2021 12:59:07 -0700
Message-Id: <20210910195910.2542662-1-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908171716.3340120-1-hpa@zytor.com>
References: <20210908171716.3340120-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc will sometimes manifest the address of boot_cpu_data in a register
as part of constant propagation. When multiple static_cpu_has() are
used this may foul the mainline code with a register load which will
only be used on the fallback path, which is unused after
initialization.

Explicitly force gcc to use immediate (rip-relative) addressing for
the fallback path, thus removing any possible register use from
static_cpu_has().

However, currently there is no convenient way to make gcc generate a
%rip-relative immediate reference without splitting code into i386 and
x86-64 versions, so add a new macro to <asm/asm.h> for this purpose.

Changes in v3:
--------------
* Clarify the subject line

Changes in v2:
--------------
* Add new macro to <asm/asm.h>
* *Actually* generate the %rip-relative addressing mode.

 arch/x86/include/asm/asm.h        |  5 +++++
 arch/x86/include/asm/cpufeature.h | 13 +++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)
