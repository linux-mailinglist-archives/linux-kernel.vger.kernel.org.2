Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA3361AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbhDPHhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhDPHhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:37:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 345E861153;
        Fri, 16 Apr 2021 07:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618558607;
        bh=l0GFKWQuALae0ij/Od9yu2a+hXe0aaMnMEBbL7OCjBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kjc45SxEKUo3RUwa6SL07UUCLyPhLTHSPMwNMIIQnutA7pKG1PXO35Wlscqee5mGQ
         nZAkd/DBlD8IvhLBokkkscnbgfXNOSDI5F7n6Yo35U9XIbEtcKaeLECQnWnuj2+mvn
         NdYVwV9IUjavGY6bb2egJBuQUc7IdrliIX9i93hc=
Date:   Fri, 16 Apr 2021 09:36:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     mike.leach@linaro.org, leo.yan@linaro.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] coresight: Fix for v5.12-rc7
Message-ID: <YHk+jRT/164eCnWa@kroah.com>
References: <20210415202404.945368-1-mathieu.poirier@linaro.org>
 <YHk0iDnfujBR3mTB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHk0iDnfujBR3mTB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 08:54:00AM +0200, Greg KH wrote:
> On Thu, Apr 15, 2021 at 02:24:03PM -0600, Mathieu Poirier wrote:
> > Hi Greg,
> > 
> > Please consider this patch as a fix for v5.12-rc7.  Applies cleanly
> > to your char-misc-linus branch (e49d033bddf5).
> 
> It's too late for 5.12-final, and really my tree should be closed for
> 5.13-rc1 now.  I can sneak this in for the merge window, is that ok?

I've just taken it for my 5.13-rc1 set of patches and added a cc: stable
to get it backported to 5.12.1.

thanks,

greg k-h
