Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0FD414395
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhIVIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233288AbhIVIVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:21:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7606861050;
        Wed, 22 Sep 2021 08:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632298794;
        bh=bn1pn5OnXP0Nih0WPPgDEIOkHQw5gDOX7VbpktBowKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bptg+K+qV8dpxab4C+g5RbNg45jV8mSn2NGXUVxgbi11ofC0tujP82HXGdaMQ7CGr
         pAtUEUsHHY+ecSmlnIGH+gn4J+sA7HQ8HfBoPwJ88THGqEDhIYo1DPP55SDb43NeJd
         kt5uLfyb1AXbdyfuV5fK4Kf1aPXGvqfXOBnDUfDov3poFck8Ou3GtbTe/6PzyD4yqW
         3LH2cZJza0KjZYGFxJnF30RjNS+5GGNmdusMT2iP/qZhrAbwyLidwlAc2S/YlPRTUs
         FHrSLpF2jhQhBkFZtoBN0LSSB+qFxdqm1PtRZcY7XgweUGX3Oq2GzRWNPIGGway0tW
         w6voOY4GseJUQ==
Date:   Wed, 22 Sep 2021 16:19:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Reorder flexspi clock-names entry
Message-ID: <20210922081948.GH13480@dragon>
References: <20210908065126.1273140-1-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908065126.1273140-1-kuldeep.singh@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 12:21:26PM +0530, Kuldeep Singh wrote:
> Reorder flexspi clock-names entry to make it compliant with bindings.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>

Applied, thanks!
