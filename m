Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C539332A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhE0QJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233839AbhE0QI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:08:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75E2D6100A;
        Thu, 27 May 2021 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622131645;
        bh=HH5XZFPh3zUTWNsoRPna0CjJu9Cji3kUy+m+jh256Ag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mMpl9nRrySnqq/5B21Fw8AcV2z3LRuaw4ZijWnDlAPDRmG73aIOym0fnP2nQsupWn
         Di0VbPcZk5/Hf78w8OHqXvImHqlzOd1AHJW5zwFl5jaRsTOsxO8gNTLec2/TaFBGlE
         THjpqdRQAaLy81BX02pYfj+SSqVl12MJXdfCHIX1SnyJNJ3aOlc+w6IDUG0K1lsba3
         +O+n++R/bQnaDgujgmgxkQzVy0VynQNKr/nCj7eUCtrvW2m3AmKQ1bK/2+PlD7btyQ
         Ko+2xOLn/XRpD8zw/db0uGNwyqrAtUsqlDTIoeUeIH154g6vSERSTmhYJlgln9Eac2
         UyjdeoKnAAI+A==
Date:   Thu, 27 May 2021 09:07:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chen Li <chenli@uniontech.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] netlink: simplify NLMSG_DATA with NLMSG_HDRLEN
Message-ID: <20210527090724.44b0c040@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <878s401w1r.wl-chenli@uniontech.com>
References: <878s401w1r.wl-chenli@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 15:21:36 +0800 Chen Li wrote:
> The NLMSG_LENGTH(0) may confuse the API users,
> NLMSG_HDRLEN is much more clear.
> 
> Besides, some code style problems are also fixed.
> Signed-off-by: Chen Li <chenli@uniontech.com>

Looks fine, but you'll need to repost and CC netdev@vger.
