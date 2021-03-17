Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8960F33E9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCQGft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhCQGfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:35:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC54F64E86;
        Wed, 17 Mar 2021 06:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615962944;
        bh=WWS7JuEMTXd+AgVVzjeTizcx9NVGA6mCY1kYylcjsHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahXjqrs5fuztQc5g3SxOMdPIXr+j4p8Mu9hk2JbAUVgcAJHKx/nThGMCFaZ/+ABr5
         nDPPgbrCNRp3m4iBw9QED30vdREtlzwe8ekoKppq5nbuO3pHsFDfwHBjUskwdEOZYM
         ctJWcRNemsT4Rdaj/0WnLZnW6/vJR+H6MxfRj8tJZauVhFEHU4Bp7hX7T9UPL4Gghs
         4F6Y4YFKV46URVtxKpxvXufq868MCoZIwUlklydy/pyHcSUYIsGYlhocZkuDInj3Bj
         4ZyKkC1z2hb9XK7/mIgQheUaKdbijduuZHUUxLM76AvQIRtgxVoWbuXpee49278wNz
         6jZgs39kPysCw==
Date:   Wed, 17 Mar 2021 12:05:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 0/3] AM64: Add SERDES DT bindings
Message-ID: <YFGjPNonIlA4Anar@vkoul-mobl.Dlink>
References: <20210310112745.3445-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310112745.3445-1-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-03-21, 16:57, Kishon Vijay Abraham I wrote:
> Patch series adds device tree bindings to support SERDES in AM64
> platform.
> 
> This is split from [1] since this binding is also required for AM64
> USB DT patches to be merged.
> 
> Vinod,
> 
> Once the 1st patch of the series is reviewed by Rob, can you merge and
> prepare a immutable tag to be used by Nishant Menon so that he can merge
> USB3 DT patches.

Applied and tag:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/ti-serdes-for-5.13


-- 
~Vinod
