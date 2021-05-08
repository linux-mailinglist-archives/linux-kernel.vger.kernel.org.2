Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4C3770B5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhEHIny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 04:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHInx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 04:43:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A7196145E;
        Sat,  8 May 2021 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620463372;
        bh=4lnbNm6T7LTAU3lecNJDrlojB4pPrpCx3+nZdHSTRNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMRFR10uSvQLsc39yduvNf9mJM6OS4bVrCgXOIaztfSujy8oyTGI3Wjzlfcy1HzaH
         aSlZZh2gkO9xtx9EY6LbESYSg/EivM6Je8UkzE6fRmejRH6cg+UNVsyUI9SfkaE+Km
         qUm7JAaw79wsPMKpGJpank6XfLaNUB2U2OYi7P5Q=
Date:   Sat, 8 May 2021 10:42:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.13-rc2
Message-ID: <YJZPCMnB7/sktOF1@kroah.com>
References: <20210508083931.GA21544@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508083931.GA21544@CORE.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 11:39:31AM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This pull request contains a number of important fixes for 5.13-rc2.
> Mainly fixes to support our new F/W with enhanced security features,
> but also additional bugs.
> See details in the tag message below.

Does this include the stuff in your previous pull request?  Should I
drop that one from my queue or do both?

I will be waiting until after 5.13-rc1 before I can take any of these...

thanks,

greg k-h
