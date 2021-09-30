Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8A41D5C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348943AbhI3IzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348052AbhI3IzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:55:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED8F26137A;
        Thu, 30 Sep 2021 08:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632992016;
        bh=ipv+Kb1lDn3reuFyXjezzOrNiWEsOoZgP7hBJo18ULA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdZkh/0sTVGhG4O8RK8rDOeLE6CF2bFroexLs+UMiDl8j3ZYnORz9xaCI+hWyphyh
         Vahk20qaPmTV66veFgiGFkTzfDzjQi/QY7u6H/xnmFZq8kAjtrgtfFgczQ5RVBrKLU
         iGwD97nEomfeq5FATr7mWRUog/o99d+iGRLDv0J27V1APsNQgBxMF7DhzxTFoIKS0U
         Su6xEZGRfZarPKZHiWwv5KtZcII0aARwjWsqzvPX04mWJQyLJSVASt1wExPfa+Y58s
         33Xa8Zzctik1HUBGKSKEzgSudjlDxQnLc2fgEXmUSbtA1jzvAW8TTe+crXhDnE2OL4
         YldMLDaNq9o5Q==
From:   Will Deacon <will@kernel.org>
To:     yee.lee@mediatek.com, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>, Kuan-Ying.lee@mediatek.com,
        nicholas.Tang@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, chinwen.chang@mediatek.com
Subject: Re: [PATCH v2] scs: Release kasan vmalloc poison in scs_free process
Date:   Thu, 30 Sep 2021 09:53:31 +0100
Message-Id: <163299104851.1259041.949139290018170136.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930081619.30091-1-yee.lee@mediatek.com>
References: <20210930081619.30091-1-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 16:16:13 +0800, yee.lee@mediatek.com wrote:
> From: Yee Lee <yee.lee@mediatek.com>
> 
> Since scs allocation is moved to vmalloc region, the
> shadow stack is protected by kasan_posion_vmalloc.
> However, the vfree_atomic operation needs to access
> its context for scs_free process and causes kasan error
> as the dump info below.
> 
> [...]

Applied to arm64 (for-next/scs), thanks!

[1/1] scs: Release kasan vmalloc poison in scs_free process
      https://git.kernel.org/arm64/c/528a4ab45300

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
