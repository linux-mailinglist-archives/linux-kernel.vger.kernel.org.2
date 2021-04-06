Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A77354C02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 07:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhDFFGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 01:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhDFFGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 01:06:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C03161399;
        Tue,  6 Apr 2021 05:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617685562;
        bh=tfEEv4u55kxoKREQCWH6STJHYcU0yO3z+F/NysrP0KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVPofBxVdygbZzo6tVfhZmnpNmBec/scn80DgoNdCQP1t/fLvpu8mH8TuwrTY164H
         bxNfZrm4TSEH75f6mqJPC0AOTDjaVEshxQxAclJutnQ/TL9RwHJi3amDUvoWjXCIA6
         88ZKLJzCyobGHHc9xZYMR5Ovxh5G+oV+l1pe2NWl+HBrFMyI40gvUf0zmJW3EO4Y7i
         kHV+p44wslh9DbqaBXU8L5kHa8qBrevdRhDJevpRaexNZSnQYGtcJKv4hM09kuz2hT
         DMRY9Q0sHfRXWwbmAU59JXDkXa7+4Y+1mmwwfYlg5CEfwrKVNvofYWKfyaEC/e1ov7
         Ho7/CICWkMHyw==
Date:   Tue, 6 Apr 2021 10:35:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Hao Fang <fanghao11@huawei.com>
Cc:     mchehab+huawei@kernel.org, xuejiancheng@huawei.com, kishon@ti.com,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com
Subject: Re: [PATCH v2] phy: hisilicon: Use the correct HiSilicon copyright
Message-ID: <YGvsNkqDZvWO0fYG@vkoul-mobl.Dlink>
References: <1617278537-26102-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617278537-26102-1-git-send-email-fanghao11@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-04-21, 20:02, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to the official website.

Applied, thanks

-- 
~Vinod
