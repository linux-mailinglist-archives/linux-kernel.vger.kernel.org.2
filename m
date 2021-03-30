Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBCC34E640
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhC3LSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhC3LSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:18:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42EE861957;
        Tue, 30 Mar 2021 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617103094;
        bh=5C0F6DjYvsWIwLfvRJDFSS1kTVZJVk1lwcorkrWrvfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxHe22KkL7a53xEsAoNrKiXIHbIbV1hG/0xzrEFv4PGatxVoj8HY/LOePaGtxZKNv
         70SvFEAn3PMcuxxeX6TeVrhzo2Of7bII0YwjhMAqJxZbDr129Hgenc8MLbUhdcaAfH
         heHjOG8mie7uTggHuN6Slslqey11FRhWRiSvoKugzRz5x9IJjmz5xTU/wIZv2qHVCu
         qi53IKP4VpvNJ2VLMktCaK+/XqBuW8wDIpBNrVvJVCcCIg13hq7UHYA3IcHx9gGDIf
         9F8ZovD8fuQpE5bI4qWO3vTOcoOAlUu1z+Icpk+i1emSO1wzDR/GaHJ6fRBiKmLJ0D
         8lXw5Y3BTPYcA==
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>, mark.rutland@arm.com,
        john.garry@huawei.com, zhangshaokun@hisilicon.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] docs: perf: Address some html build warnings
Date:   Tue, 30 Mar 2021 12:18:08 +0100
Message-Id: <161710074994.2795133.6260145799361305664.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617021121-31450-1-git-send-email-liuqi115@huawei.com>
References: <1617021121-31450-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 20:32:01 +0800, Qi Liu wrote:
> Fix following html build warnings:
> Documentation/admin-guide/perf/hisi-pmu.rst:61: WARNING: Unexpected indentation.
> Documentation/admin-guide/perf/hisi-pmu.rst:62: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/admin-guide/perf/hisi-pmu.rst:69: WARNING: Unexpected indentation.
> Documentation/admin-guide/perf/hisi-pmu.rst:70: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/admin-guide/perf/hisi-pmu.rst:83: WARNING: Unexpected indentation.

Applied to will (for-next/perf), thanks!

[1/1] docs: perf: Address some html build warnings
      https://git.kernel.org/will/c/b88f5e9792cc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
