Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D8D4549B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhKQPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232713AbhKQPSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:18:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCD4D61BD2;
        Wed, 17 Nov 2021 15:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637162109;
        bh=gQT7dv1Gg1B9yvkq9cn7MUikPYktAXU3aM8r+iI3LmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HkOEWQnO4+MyqF9W4m13qp4ROubRRFT3SnEAElgVPBMq3m8N05wjlyZYsJiCbTdRc
         R9WOlKkgpyovPmvamdxvqOpWmMoQfuLCSwAeAxs1WLvCw3d58QOZ5CW4BXXkVHbjB3
         LgH5qNsbhJjNWtyc4X8NIbQRYoWH+T7NTcx0Il5k=
Date:   Wed, 17 Nov 2021 16:15:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, ardb@kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [RFC PATCH 1/5] firmware: Create firmware upload framework
Message-ID: <YZUceupQe67KYJyf@kroah.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
 <20211111011345.25049-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111011345.25049-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 05:13:41PM -0800, Russ Weight wrote:
> The Firmware Upload class driver provides a common API for uploading
> firmware files to devices.

That is exactly what the existing firmware api in the kernel is supposed
to be accomplishing.

If it is not doing what you need it to do, then you need to document the
heck out of why it is not, and why you need a different api for this.  I
do not see that here in this changelog at all :(

thanks,

greg k-h
