Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6123E405F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbhIIWJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 18:09:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47923 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231819AbhIIWJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:09:54 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 189M8Rx1240627
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 9 Sep 2021 15:08:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 189M8Rx1240627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631225314;
        bh=z6l5KSYd2UWZHXazF9BmrbSsVpVuYtysUQylbL6UGpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCPqxJ2Hcn1AAXkLmlRJUTLG3Gx/wwnepYIVidE9ChSF8Ye9t4DuDx64BR0fVZ+uq
         DX4cLDcx3HNUp6UX9kwvkIzO2JbjLHC7oILQ+DQ4GBGdHqumpv3etF1EyNPOeoEc58
         NEg5HIcV7GKMIL4syuyLfxZO8Yinq8h4Af1TDKKgSTZKmieGniH0mcMDTnyKGZoJuQ
         gohRYjuOBIcV3FqyOPbdRKAws5fnxodsWqYlnbZ4dZ6TZSkzn5KHJFyDpUu+EgNnjz
         5wOrqCjibI8ztqrfb8TIWkjkqtxJAS0O/kUPxOnTG6CwmOUx6D8CF14FMPc/3W8TVi
         NJmEx9BB32mLQ==
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH v2 0/2] x86/asm: avoid register pressure from static_cpu_has()
Date:   Thu,  9 Sep 2021 15:08:16 -0700
Message-Id: <20210909220818.417312-1-hpa@zytor.com>
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

Changes in v2:
--------------
* Add new macro to <asm/asm.h>
* *Actually* generate the %rip-relative addressing mode.
