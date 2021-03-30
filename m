Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD534EB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhC3PIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhC3PIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:08:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D61E9619CA;
        Tue, 30 Mar 2021 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617116898;
        bh=2y57qse0hlc7nRtLBBY8dgkFobyrvUeQUtu3XdIbcdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lY38yZkb9r5DYQysiyVASARgm/pt8kPD7V/m0B9ZzMRsjQA4RtJT6CpWT7OMCWHZV
         o9F4aTaWTKN47bUXNuJ4rTkof5ARK2QTEQCTbMHtXLqUXbL4G1vtYy4xgXHHtuV1oG
         DeQgRVf7vqATtfQo/7qozRR1gG63RBcxGoETJG3cAq5jL3szp0BgNHpsPCCSGp7lbQ
         GYnQPI/M5ibpwhuczIlxPQtWHtkusPgRtOMQMx5e0OXivenaY8zXCFrOg2g3hO36Sy
         22vjvKkArMuBYl2VWpZzc+tSWeqVNLZ1eHKG0H3wDi2NaUwKz9TvK4pQmcU3+/HAv6
         DBzzKWNExcyLQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFyx-0002Vi-Gz; Tue, 30 Mar 2021 17:08:39 +0200
Date:   Tue, 30 Mar 2021 17:08:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 6/7] USB: serial: xr: add support for XR2280X devices
Message-ID: <YGM+9zmjJpnUeHMf@hovoldconsulting.com>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
 <385b5ba7739fd1d67b9b2b8fd70187ab19e8d00e.1616571453.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385b5ba7739fd1d67b9b2b8fd70187ab19e8d00e.1616571453.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:41:10AM +0100, Mauro Carvalho Chehab wrote:
> There's nothing special on those devices either. They just
> use a different set of registers.

This device also use 16-bit addresses and doesn't support CS5 and CS6.

Johan
