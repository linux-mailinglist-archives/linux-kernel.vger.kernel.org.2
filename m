Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E107F438AE0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 19:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhJXRRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 13:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhJXRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:17:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D407160F57;
        Sun, 24 Oct 2021 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635095703;
        bh=CsWc0SRs6ZzdaM49ktypJd25duLDuRk8S4WN/XMFu3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7C1y7V/k4CTBKc0bWu6+RPEcZV9CB6PvBC1MzSJIbrBJYTEUOdMqbMtZpkLfgjj0
         u3yD1v7qw1qu6WwIwyOgConl42GiFq3m4sKAGvoc3EX3pDYVbXN+c8ZItNcrx0Wx2Z
         td+M6eT190qDlNmqfk4B1eo/u8r4Q4kSVpqggn0tIhlYmj3j00dakwS2nvVqk/kRQP
         XxRCsErckj3cEw3vC80TpuJtFc0P2CuXeBTkF0WYrxe3eaNvYyHRr/J1LMKefIbUf7
         XoJXekBtn7laHWn2nnGH0dK9ltu0953795PJILk/J9ei1lI7Pjvv3yL5arc6biN30e
         n9SeAQtHw3WlA==
Date:   Sun, 24 Oct 2021 22:44:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] phy: hisilicon: Add of_node_put() in phy-hisi-inno-usb2
Message-ID: <YXWUk38hq/Np7EMc@matsya>
References: <20211015080154.16016-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015080154.16016-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-21, 04:01, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/phy/hisilicon/phy-hisi-inno-usb2.c:138:1-23: WARNING: Function
> for_each_child_of_node should have of_node_put() before break
> 
> Early exits from for_each_child_of_node should decrement the
> node reference counter.

Applied, thanks

-- 
~Vinod
