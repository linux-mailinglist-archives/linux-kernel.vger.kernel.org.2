Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4307342C26
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhCTL2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhCTL2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:28:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2414761978;
        Sat, 20 Mar 2021 09:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616231253;
        bh=6VAVAR5i6qrEizhLfVsId2rG69qGPlpUE5EC8IW9Oaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V11S2IsfG2Qutx8qrWX090WK1T4VGvz/EoZJP/BciJOybprxR4hZ4MaCSoPFKXmCM
         xI2n6/x/cJ/RJQB1JLBHmjrNafcoWn4z5TWvtV/krSaokagOvr+DeLzV80OQvFj1LO
         Q5q0Pluj8iEEhN1DXvXUwps4sY1QKjK24N+Bsp+JkjGqo2rnOJSUpLy0YFpM5FG2OP
         Z9g1cLsBm1qzggxKeg3xyaxN45UYLm2K/MacW+nYZ2J/PlseOY5Bfz4xbMStprTeFc
         wsDTjEnLQofwLI8N4KCJDh5n1CSNzsL0v0mzmllZ0yPU6BACjkEF5vCE7BthOeQupM
         FEvZ1jbP4b9Jw==
Date:   Sat, 20 Mar 2021 17:07:26 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sanket Parmar <sparmar@cadence.com>, pawell@cadence.com,
        a-govindraju@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        gregkh@linuxfoundation.org, kishon@ti.com
Subject: Re: [PATCH v2] usb: cdns3: Optimize DMA request buffer allocation
Message-ID: <20210320090726.GA28364@b29397-desktop>
References: <1616008439-15494-1-git-send-email-sparmar@cadence.com>
 <20210318073245.GA645121@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318073245.GA645121@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-18 07:32:45, Christoph Hellwig wrote:
> On Wed, Mar 17, 2021 at 08:13:59PM +0100, Sanket Parmar wrote:
> > dma_alloc_coherent() might fail on the platform with a small
> > DMA region.
> > 
> > To avoid such failure in cdns3_prepare_aligned_request_buf(),
> > dma_alloc_coherent() is replaced with dma_alloc_noncoherent()
> > to allocate aligned request buffer of dynamic length.
> > 
> > Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> > Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> 
> Looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Hi Christoph,

I would like to confirm the dma_alloc_noncoherent allocates the memory
less than PAGE_SIZE if buffer size it would like to allocate is small
(eg, 64 bytes)? 

-- 

Thanks,
Peter Chen

