Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082BE32A66E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384490AbhCBPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444874AbhCBMl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:41:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 890CF64F99;
        Tue,  2 Mar 2021 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614688830;
        bh=PpqzO9tNkVVYKDDpZV7nsnOgTPTa7AoZ4uQXZF/GyWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQpBTSg3ORFS0D3bGOR5mFf50nxn7iph0w/N9Ay5SnmcZ7831YdKdmmWADcrv4zE9
         FJtEOHXGgGidOi4HCEAc5NM6mzody+fj8gc0hvmNth5/mK0L/k8XX5V/XbXg7um69J
         spDcnzXnttAwwhhoCIt0Wid6I+3W3J/bTeZBdvhI3PYqZivvVKuky7FoeyjgQqhosE
         BwyYjLh8NvK6hqc7ECVV404om+TZt0CUExRkqZNBhPoXJdO7i7KVVhZ78DGzqSDeFY
         tEYEkQeXJwGoUy5nK686KZ9ZRX+FeIf1OrYao5qU8xEd//kvUzkckJvrmDJvhDtga+
         lGqjRREbrVqcQ==
Date:   Tue, 2 Mar 2021 18:10:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     p.zabel@pengutronix.de, kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: ti: j721e-wiz: add missing call to of_node_put()
Message-ID: <YD4yOucqwTPcKNAX@vkoul-mobl>
References: <1614244674-66556-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614244674-66556-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-21, 17:17, Yang Li wrote:
> In one of the error paths of the for_each_child_of_node() loop in
> of_property_read_u32, add missing call to of_node_put().
> 
> Fix the following coccicheck warning:
> ./drivers/phy/ti/phy-j721e-wiz.c:786:1-23: WARNING: Function
> "for_each_child_of_node" should have of_node_put() before return around
> line 795.

Applied, thanks

-- 
~Vinod
