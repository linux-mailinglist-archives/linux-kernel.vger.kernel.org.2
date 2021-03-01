Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3732A017
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575280AbhCBDy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:54:59 -0500
Received: from ms.lwn.net ([45.79.88.28]:44576 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240332AbhCAWUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:20:14 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 36A142C4;
        Mon,  1 Mar 2021 22:19:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 36A142C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614637167; bh=yk5dLYEDSZ0+FebCJm2RFjHCAGMhe2RLIW1IZ5ZFlA4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IbC7ZCPfglaeMNzv8ma7xX+0QjoQgqeubxgu/jNWq3AvoS9s+81x5TR2zEPmQluhr
         p2QOY+Hgwhtz3nERQWqYXrUNOxdLPz51geZMrZux2afewRTFM29tNgZrO3oy1Mgw3d
         J5HYagzIpPV3Wk5AM32D+uCxbiSIrJXrIhkiGptLSonH84QBKPbkLcjgwaa7FIYuxU
         A9DMougUbOgESdYyY3A1s2GUUnqXr1lRfWgBCbyHANgmKxS0Fj3MthyqiRlTBisL01
         9o/vgQN7wGlTbxoPCLcpZyRrOn2vcK7LLXzGTcLFTmAqKyYCEeuwC2H3zXrVSEcmBu
         8W3t55ayleQLg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Documentation: Replace more lkml.org links with lore
In-Reply-To: <20210210234005.2236201-1-keescook@chromium.org>
References: <20210210234005.2236201-1-keescook@chromium.org>
Date:   Mon, 01 Mar 2021 15:19:26 -0700
Message-ID: <87r1ky1pqp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> links with lore"), replace a few more scattered lkml.org links with
> lore to better use a single source that's more likely to stay available
> long-term.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  CREDITS                        | 2 +-
>  tools/scripts/Makefile.include | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

I've (rather belatedly) applied this, thanks.

jon
