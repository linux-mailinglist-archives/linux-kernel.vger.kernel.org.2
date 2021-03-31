Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69E3500BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhCaM4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235601AbhCaM4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:56:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A54E861959;
        Wed, 31 Mar 2021 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617195374;
        bh=iR7dUcqETM3DVR/eQAZ/VKZtx+OFkr2flgVh2EJMneY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=se2cttHdgk6vJofoxFcUfK1iaywv6HwSRJp5SlFPyBqhXZ4znarGX1x6QaBWjaSdS
         9GQIoQMB0Z1I0pNQ32P8TMwjjCcN1utH7Gu6RsurZhUUs9SlptK0BUr3UcR6yHDJbV
         6cYWfNBCTjxqng0MyQ07KBfKlXZWfPYGbxdUtXLjbzD9QQ24h8NF2B25/cWksZs915
         1ZI8C0uDu3M1lxhpwN8po07GVmcRbfFYMHTP2DO3zQqK+S4dRYb5yr7SNzTqvz6vn5
         V2lnSEnyBXCB2xOHYXtrmMh7GHRKeyg4tabdmNWNYAiI2PO0VDFpblEjTz6jHx/bp+
         7cLq7JElb2qRQ==
Date:   Wed, 31 Mar 2021 18:26:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     laurent.pinchart@ideasonboard.com, kishon@ti.com,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
Subject: Re: [PATCH v4] phy: zynqmp: Handle the clock enable/disable properly
Message-ID: <YGRxarYF8p28Un76@vkoul-mobl.Dlink>
References: <1616588325-95602-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616588325-95602-1-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-21, 17:48, Manish Narani wrote:
> The current driver is not handling the clock enable/disable operations
> properly. The clocks need to be handled correctly by enabling or
> disabling at appropriate places. This patch adds code to handle the
> same.

Applied, thanks

-- 
~Vinod
