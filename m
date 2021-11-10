Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD2044BCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhKJISJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhKJISH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:18:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C57D61076;
        Wed, 10 Nov 2021 08:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636532120;
        bh=qI7P6LTFX/PIzJyqkpmIJDTbDtNLNqaURf0IuYYimj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RBsQsjcljl/2u7hM1qx752Y1bN8cpRLugElYh5vBZEkTrFv0ALKmswT1bTPUitkTw
         0hpDPVLRxi8b6FVoXGycYNDVfEha99T/vCJGF12G4IYPD4dk1CukeeToLI6Kf1+6rV
         wsrGUncwDpm1IGkUsY1Lw9vMHfQET0Dz00TqgyyI=
Date:   Wed, 10 Nov 2021 09:15:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin.kaiser@paytec.ch>
Subject: Re: [PATCH 0/4] staging: r8188eu: clean up the calibration code
Message-ID: <YYt/lkcYBN80g4tU@kroah.com>
References: <20211107143100.9047-1-martin@kaiser.cx>
 <20211107144324.xqoab3imqxawymfz@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107144324.xqoab3imqxawymfz@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 03:43:24PM +0100, Martin Kaiser wrote:
> Hello Greg,
> 
> Thus wrote Martin Kaiser (martin@kaiser.cx):
> 
> > From: Martin Kaiser <martin.kaiser@paytec.ch>
> 
> Sorry, the cover letter uses the wrong address.
> The actual patches are ok.
> 
> Could you take the patches anyway or should I resend the series?

No worries, I took these as-is.

thanks,

greg k-h
