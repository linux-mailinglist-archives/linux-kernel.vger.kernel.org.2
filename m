Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865073AE201
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 05:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFUDzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 23:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhFUDzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 23:55:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBEFD60725;
        Mon, 21 Jun 2021 03:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624247572;
        bh=RJf49uRgzXxA9bjN6VYQdbbDHBJXNIssYY4EJQsK6O4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nz+Xa9/ERTZcal8bRaRv9umf0lBsqYqUAybFBy7UOv5btP0iHDxX8OOsd4VRWbjIi
         AOCEnQCEvj5h2TrB4eL8VO+Q2ceb5bpCKE5YtUPhLBxsMCTY6Gp/9AL26ITmHKln6a
         w3GcvmZHU5M4VQPt/sB5ebpfo6izjsPvPDklJHWjq89vUlY6meby8IjAKlZiLFAxfu
         uYs6+blZjXHk42yr8+Y4pYjVWwGwZz4b0xJlQc5vor6TtoNwrQwGdWmcRNMEPrPJG+
         lCl9Chy7i92vfEkryVfmZH3cG4il5oUcUltfM4ginG5fE7lbgWJ8AJqAKbs6PNlyfw
         9gkaUH1u+XH+w==
Date:   Mon, 21 Jun 2021 09:22:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip: remove redundant initialization of
 pointer cfg
Message-ID: <YNANDuQgtahNHxiG@vkoul-mobl>
References: <20210609113901.185230-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609113901.185230-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-06-21, 12:39, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer cfg is being initialized with a value that is never read and
> it is being updated later with a new value. The initialization is
> redundant and can be removed.

Applied, thanks

-- 
~Vinod
