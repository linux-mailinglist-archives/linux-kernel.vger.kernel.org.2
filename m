Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2162F32A631
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbhCBOKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 09:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242796AbhCBMfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:35:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07BE764F7A;
        Tue,  2 Mar 2021 12:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614688129;
        bh=A5H4O3r7D9MypgFZD+4PBqBdA7HmqquEKOppYxkCEGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWj1pUq9VGpVf4Y4UgUVTLskdBcNVjdMJOlXR+n1OTowYT0cUtUO2JE3rqI7sBq/r
         ItRQJi5aM/l91SqdjSb+T80YJn2TFNT6VxLqoG14AtVIf0wpXfAZ5AwjmU3d3DBV9B
         KqLDJAD37E1EJqWp8VpiwlSN/pQ7A/MjVd8RLfUJG4zMNSwfOQSvHomOtf1cGywuHS
         /Z50Kr6obxVdSRQ9A4l6QNSR+K3wl5xbN7QSlt7OatwaIPHHOA2alk/S262QoniOtN
         mCPpxRPfwR5Ti6NNyy0s7Fmmnup1XWEfN3CDZaxZ0EQcqdMY/cNssIgKEWKCJyzD9c
         cSw/2xUiBvpLQ==
Date:   Tue, 2 Mar 2021 17:58:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name
Subject: Re: [PATCH] phy: ralink: phy-mt7621-pci: fix XTAL bitmask
Message-ID: <YD4vfDrvdlduVUQL@vkoul-mobl>
References: <20210302105412.16221-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302105412.16221-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-21, 11:54, Sergio Paracuellos wrote:
> When this was rewriten to get mainlined and start to
> use 'linux/bitfield.h' headers, XTAL_MASK was wrong.
> It must mask three bits but only two were used. Hence
> properly fix it to make things work.

Applied, thanks

-- 
~Vinod
