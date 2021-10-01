Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC841E902
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352707AbhJAIWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231516AbhJAIWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:22:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD4D661A57;
        Fri,  1 Oct 2021 08:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633076450;
        bh=4ydmC4212QSweCoXZhk6S6Cz/uTkZU+5vdq8RbNTT0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IqPt39dAyb8Tt0U+QgnqZ0lZLM7gRKduYvqKlzunVjN8iqe+IoWhbUk7yGaCBwZfh
         I66VT2zsuae1LmjL+pvNvnwGzzBo1mwUngP4EIzOgbecfKAl/W1j7hRuKirfYsg7GA
         2o7xBma0dOxi9Ro4CsTbs1aUpEGJmsvQp++QSby5lJ0QzOqfig0LhhR7f9G1EH7eG7
         DvpdDnQzokayruhBHtsiiYXrLnkki4veE1RUls051eP/cmMaVRJWNfGojFB4A/SPMN
         edoCwQgoPs3JEnrhXch2n9abOV9qSJIcspzXhnkwNCLXV2z2EbqSYRlSHTmZH9ztNa
         lLmXKERICNZ3w==
Date:   Fri, 1 Oct 2021 13:50:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: broadcom: Kconfig: Add configuration menu for
 Broadcom phy drivers
Message-ID: <YVbE3mJ4iD/PI+xe@matsya>
References: <20210923025013.189-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923025013.189-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-09-21, 10:50, Cai Huoqing wrote:
> Adding a configuration menu to hold many Broadcom phy drivers
> helps to make the menu display more concise.

Applied, thanks

-- 
~Vinod
