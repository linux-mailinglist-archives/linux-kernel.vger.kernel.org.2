Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFB2308157
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhA1WqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:46:07 -0500
Received: from ms.lwn.net ([45.79.88.28]:48302 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231645AbhA1Wo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:44:26 -0500
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 087F16178;
        Thu, 28 Jan 2021 22:43:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 087F16178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611873822; bh=67GimENfGGoxfIG5suESaGX/DNyL4yUs9MPaPa/XKCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=myWxMyg+YGMABkeWjiIeDvspCBLwnuOiEJfjNdr4ZOV5CSOM4DT0QKn/Ac0uaX/BH
         /swK4x7SXrhvVd+qFySvX9DTR6P+R2opO9csBrtqL/jQV5jD9vp9NpnKtucfQbloZ/
         LwRjzvR4HVv/Kmc4fgf90kWu7enozS7/D3YsiD3vAmVGwuWv3IDoGAVOfwkptvgrsO
         sZHnkcpewN3wDQSBqdM3Abrg/Dv6eNH7GkkygufFk2dqvnM2Cdhgrxm6l6fa/QJtIw
         vUwY1gs6vQmLEEYNKNZnK5fv6Pi3N0UFiwsVAEH7UxceR/5u5VPN1qYKUtClUweUOT
         XoPe9xTc9RK5w==
Date:   Thu, 28 Jan 2021 15:43:40 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Milan Lakhani <milan.lakhani@codethink.co.uk>
Cc:     lukas.bulwahn@gmail.com, sudip.mukherjee@codethink.co.uk,
        linux-safety@lists.elisa.tech, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, harryxiyou@gmail.com,
        alex.shi@linux.alibaba.com, robh@kernel.org
Subject: Re: [PATCH] docs: Update DTB format references
Message-ID: <20210128154340.2b10a06f@lwn.net>
In-Reply-To: <1611149511-4990-1-git-send-email-milan.lakhani@codethink.co.uk>
References: <1611149511-4990-1-git-send-email-milan.lakhani@codethink.co.uk>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 13:31:51 +0000
Milan Lakhani <milan.lakhani@codethink.co.uk> wrote:

> There were two references to devicetree/booting-without-of.rst (which has
> been removed) for DTB format information, and
> devicetree/usage-model.rst pointed to
> https://elinux.org/Device_Tree_Usage. Change all three of these references to
> https://www.devicetree.org/specifications/.
> 
> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
> ---
>  Documentation/arm/booting.rst                | 2 +-
>  Documentation/devicetree/usage-model.rst     | 2 +-
>  Documentation/translations/zh_CN/arm/Booting | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon
