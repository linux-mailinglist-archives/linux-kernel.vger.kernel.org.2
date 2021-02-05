Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9853311635
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhBEW4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232736AbhBEOld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:41:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C11AF64E50;
        Fri,  5 Feb 2021 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612534007;
        bh=ZnxhsdsVe19qzzUQely0sSrtaY4w+WieV8v108r7G7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kb/0c2QIq2bVQkxHgXzhodqoBYIhMqmjMu2nDdIBCKrEFrF4aIJWL5LyaV48wOGIy
         Ujv0/lBMJKMLpp+TUCOQc20/5kSrCq6xl6XFJoPAelrY2vHkwFZxqfWSGq8jGKikgd
         Vx/WLkdCmyFf96h3VnFuSred4YMs9ThOKXmQcgbs=
Date:   Fri, 5 Feb 2021 15:06:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Kalle Valo <kvalo@codeaurora.org>, cjhuang@codeaurora.org,
        ath11k@lists.infradead.org
Subject: Re: [GIT PULL] MHI changes for v5.12
Message-ID: <YB1Q0inTuMtZlVAb@kroah.com>
References: <20210205130141.GE3221@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205130141.GE3221@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 06:31:41PM +0530, Manivannan Sadhasivam wrote:
> Hi Greg,
> 
> Here is the MHI Pull request for the v5.12 cycle. As like last time, I needed to
> do PR this time due to the immutable branches with net-next and ath11k-next.
> 
> Patch details are in the signed tag, please consider merging!

Pulled and pushed out, thanks.

greg k-h
