Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E083F83DC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhHZIkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232957AbhHZIkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:40:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2EA860EE0;
        Thu, 26 Aug 2021 08:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629967165;
        bh=mxD89ycWqrgaSNcFKl8ha7SuLOa7/8Wvffa8cCoXtCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkCdsQ5gt1ZZ3MdRlneTeFmCcX/NjTfcFLyaYgAGPxLHI7N5gGMM7uw23yYs2MUov
         hkfkbq1hmDEEjlbM0W6qItEkZeXjjXZf2RfeU3w7b5MaPbDkDxq7OX+qHCOkvIL6fx
         ORqYefJ4KiIUVvV+7eYcAxvqRfawG/UYQWV+lP8c=
Date:   Thu, 26 Aug 2021 10:39:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: Contributing to drivers/staging area
Message-ID: <YSdTOBBAMPIBVFcW@kroah.com>
References: <20210820144515.GA5479@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820144515.GA5479@titan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 04:45:15PM +0200, Len Baker wrote:
> Hi Greg,
> 
> I am a kernel newbie in the path to find an area where to contribute
> on. I have sent some patches before (simple ones) but I would like
> to find some driver to contribute on and if possible mantain in the
> future. Due to the big amount of drivers in staging, and my lack
> of experience and specific hardware:
> 
> Are there any driver in the staging area that not requires specific
> hardware? I have only access to an old laptop with 4 processors:

I think all drivers in staging relate to real hardware, so I would
recommend just buying one of the cheap devices for the drivers.  I just
purchased one of the USB wifi devices for under 20 euros, so it is
possible.

good luck!

greg k-h
