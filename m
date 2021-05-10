Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7023D379903
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhEJVRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:17:18 -0400
Received: from ms.lwn.net ([45.79.88.28]:54158 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhEJVRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:17:16 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1237A2B4;
        Mon, 10 May 2021 21:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1237A2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620681371; bh=9fSJSehdcwDLUl6vB/Uilc8ih9eBrfT7IxzSt1HoGHk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mud/R0SFzJXCvc207rFOma/RK16ZZdS1G9bzF1fcBM2V95GoAmly0N8FEzZ/+AtRw
         EpEpOJBDbjwHjMSwV9C5MKGZ+E2q2CtWYCWF9EHNggdKQBVa88IDn59qhhFGkJ9Up1
         nLSKLIYfgbZDuDM931B9XWXlJ4+yUGSCao9vSPwMe86n2FVCfCJZBxvBo3Vk/kBbYL
         zXjHspFujWXCTEv2zp80b1ShVQZr3Kj0m3kTz9VwKbnod2B+Q29sW1wlRQKmWrSkwP
         0dXMOp7WwB6JTV+nrHqyyd3axErqJgbny0wJZId7UN+31cEGdZp9f82CllGOKyRas3
         A7O1/ABBdMgiQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wan Jiabing <wanjiabing@vivo.com>, Alex Shi <alexs@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: Re: [PATCH] docs/zh_CN: Remove obsolete translation file
In-Reply-To: <20210508030741.82655-1-wanjiabing@vivo.com>
References: <20210508030741.82655-1-wanjiabing@vivo.com>
Date:   Mon, 10 May 2021 15:16:10 -0600
Message-ID: <87a6p2ffxh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wan Jiabing <wanjiabing@vivo.com> writes:

> This translation file was replaced by 
>    Documentation/translations/zh_CN/admin-guide/security-bugs.rst
> which was created in commit 2d153571003b ("docs/zh_CN: Add
> zh_CN/admin-guide/security-bugs.rst").
> This is a translation left over from history. Remove it.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  Documentation/translations/zh_CN/SecurityBugs | 50 -------------------
>  1 file changed, 50 deletions(-)
>  delete mode 100644 Documentation/translations/zh_CN/SecurityBugs

Applied, thanks.

jon
