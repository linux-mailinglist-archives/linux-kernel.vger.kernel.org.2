Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02483327F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhCANOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235482AbhCANNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:13:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADC7664E07;
        Mon,  1 Mar 2021 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614604367;
        bh=aW2NdYnLG+40ramsrXHgw8fcFipvnhX3ru1eNXPPhMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQIrpLEuJOltx+8fuc1pZa1svxl8TIqc4RFZncW5OBURubDzcET21DplqMbHmwL4e
         jPRrVkcICl/G6kt814pcPG8s0VO1zKAFl65xUO7/p6J3PW1ljQDatHCQHc70roPPb+
         BMnfYGQmDYE+4G/x5kuKlgtCQYkhR1veXPqVABR7tdrvu7E5/V5iu5GADheFNx+Kas
         IqM818PXZsrOUCQsYYfcxl1MsuC4yTQOLcwdm3ooJTU3UXz+tEQLAhSVo+hes01uG6
         EbxRzF8b9MIZFEGpd6gJXUueVCi5KJ1mr2Gah4IjoxqARdjRBGnxVgWS72njRQNVy0
         nu5dhjG7iSJ0g==
Date:   Mon, 1 Mar 2021 14:12:44 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <20210301131244.otn7vzhgstufjts2@hendrix>
References: <cover.1614430467.git.wilken.gottwalt@posteo.net>
 <98f75101bbd7d6637aa596a9f43d0ea6372e57c8.1614430467.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f75101bbd7d6637aa596a9f43d0ea6372e57c8.1614430467.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 02:03:28PM +0100, Wilken Gottwalt wrote:
> Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> compatible series SoCs.
>
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
> Changes in v6:
>   - fixed formating and name issues in dt documentation
>
> Changes in v5:
>   - changed binding to earliest known supported SoC sun6i-a31
>   - dropped unnecessary entries
>
> Changes in v4:
>   - changed binding to sun8i-a33-hwpinlock
>   - added changes suggested by Maxime Ripard
>
> Changes in v3:
>   - changed symbols from sunxi to sun8i
>
> Changes in v2:
>   - fixed memory ranges
> ---
>  .../hwlock/allwinner,sun6i-hwspinlock.yaml    | 45 +++++++++++++++++++

The name of the file doesn't match the compatible, once fixed:
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime
