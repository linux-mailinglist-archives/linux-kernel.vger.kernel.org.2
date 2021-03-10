Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37D2334210
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhCJPu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:50:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233170AbhCJPuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:50:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2201364E86;
        Wed, 10 Mar 2021 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615391410;
        bh=T8BK0uKn3twU1W4L8XWiUMlGUZc9NtGsxvTX83v5KgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xYrharKGpSNDU9rcqcFlAlqrd4po/151ntHoW9GAi28hH3X0qdsw3xTL0WzbAWjAy
         3UTsKFw1uMxSsBLioGjNaEB3lMwT8525kks8Y+EHoJHrho0JR1RVW/Ft14RMSINVrF
         XXOQsTLWao8rqqb8jNdTS+r8EXH8OEhy5q2rddqY=
Date:   Wed, 10 Mar 2021 16:50:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH] virt: acrn: Fix document of acrn_msi_inject()
Message-ID: <YEjqsEtXGr3rspkc@kroah.com>
References: <20210310153751.17516-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310153751.17516-1-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:37:51PM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> This fixes below sparse warning.
> 
> ../drivers/virt/acrn/vm.c:105: warning: expecting prototype for
> acrn_inject_msi(). Prototype was for acrn_msi_inject() instead

That is not a warning from sparse :(

