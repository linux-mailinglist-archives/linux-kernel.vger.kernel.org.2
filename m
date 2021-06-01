Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C1E3979F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhFASX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234692AbhFASXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:23:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53C5A613BC;
        Tue,  1 Jun 2021 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622571696;
        bh=RkuLnYe/XfumILch0fOAa0uv13ScTbTnPD5MYc//4ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWCsDWKZAjrcNnZ5fFJh2HtV73sNGIqyLoHKDY2wc1mV2i1GaBBdY6zDk0K2B5Lwa
         nHbauOOdHdhf8WtLB8cTUri5Gi+xslYwkviu8cmqJskbcdncIjPhLexgTH3/eZVf4u
         jzs/05fzhCKtn2ZDgzI289hFev+J3nzRr4Blzo/R1IjW/+JZU+YYxKS6oPy12nc6Gh
         9vkn8ZY+YWcvM7c1i0DguxvAsiPK13CEvmFnYc6jMp7g0pr9hDThhCCRZVhjXT1w1b
         sV4abGbame5h+fvBLXo2MqkIMFkrkmpR4mB6x+AkV4+mJDc10Rdkps9rjqKx9VDtaL
         WaVH/GFP7XsuA==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, YueHaibing <yuehaibing@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 -next] perf: arm_spe: use DEVICE_ATTR_RO macro
Date:   Tue,  1 Jun 2021 19:21:09 +0100
Message-Id: <162255390948.567214.11552331173090930522.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210528061738.23392-1-yuehaibing@huawei.com>
References: <20210528061738.23392-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 14:17:38 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_spe: use DEVICE_ATTR_RO macro
      https://git.kernel.org/will/c/f9e36b388a32

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
