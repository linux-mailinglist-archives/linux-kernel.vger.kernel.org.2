Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79D83503B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhCaPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235863AbhCaPmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:42:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 942A960249;
        Wed, 31 Mar 2021 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617205324;
        bh=Dwu4ScXJLPyvkhqWCuKj4QrYbuGjG6upskCuMH97kBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HsSRWEdjDQeqseFojHNmRzluFhqmmu7/IioIp6qOKgNPB+HG7ONrWc9x6Qbbc5zTN
         8q6LmCWFzYnqEwJ2xKmXUWpKZow1V2UvVyQPXOvKfsgDbIL22O2MshQQxn2FBPgUJN
         4STXkbGY0hELs1Eto1ofr5BeXKorSFDpBUEmN+Iyv9TpxKoqh+5AvWl7l/znjZSIBq
         u638vAujWpdJyAWIiUghFwS/SlkIFBVUz48bNQqUzcv7UHhwKysXhtUhCDScHY3PIg
         FacZ0NoigeL7LKrhW5K7MrJka5Z7g/cdKTgU6ksS2cdMp2SQWsK+FIoZyutBP6mtbM
         JwzjIe3B0QxqQ==
Date:   Wed, 31 Mar 2021 21:11:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] phy: ti: j721e-wiz: Configure 'p_standard_mode' only for
 DP/QSGMII
Message-ID: <YGSYR0UNCYqj4jZx@vkoul-mobl.Dlink>
References: <20210331131417.15596-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331131417.15596-1-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-03-21, 18:44, Kishon Vijay Abraham I wrote:
> Configure 'p_standard_mode' only for DP/QSGMII as for other modes
> it's not used as per the programming sequence. Add "continue" in the
> else to prevent random value from being written to p_standard_mode.

Applied, thanks

-- 
~Vinod
