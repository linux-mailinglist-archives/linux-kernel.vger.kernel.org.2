Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D738D45D41D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 06:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbhKYFX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 00:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhKYFVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 00:21:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B1F661028;
        Thu, 25 Nov 2021 05:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637817494;
        bh=YDz9EtJ1GxSuD4rmvrjJYpxzhE5XyXCl2MBng7O/syk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHy3ZUeKZkHU8eiLC4B+UNrfWpwPRUA7h1GxTFYSx7AwpUHz/JIKRoe4UjtSYGXiV
         HRjUPiPdc41R4sKIogcMoXcLJVFCuq91tkT1cDOwSd14nG7E/9OdnDh/f0OpML2bpx
         /b/asU6gdrj5YE2Hghy4ZDF4zaCPoU3MEzfyov86ZCN1NY5jCuG+R+6a7+QZCvvd52
         fp/8OfPe4DJaLHvmnDU3wYCqo9lMaOVzeXi0vhCMu5RkN0A95T90JgRk0EbBgNukBa
         sWfhV+zYR5ucLuXi15vhqS/Lz0+WPVL2FblGVWjiWceeL0IXwqlRpU5JAxuBLQ1YHv
         yYx1LVCn2kGVQ==
Date:   Thu, 25 Nov 2021 10:48:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     salah.triki@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ppc4xx: remove unused variable `rval'
Message-ID: <YZ8ckcRIvyLsFq81@matsya>
References: <20211114060856.239314-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114060856.239314-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-21, 14:08, Jason Wang wrote:
> The variable used for returning status in
> `ppc440spe_adma_dma2rxor_prep_src' function is never changed
> and this function just need to return 0. Thus, the `rval' can
> be removed and return 0 from `ppc440spe_adma_dma2rxor_prep_src'.

Applied, thanks

-- 
~Vinod
