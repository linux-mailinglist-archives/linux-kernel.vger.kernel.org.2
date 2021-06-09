Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE7A3A0BAB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhFIEtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230401AbhFIEtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:49:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20EDB61351;
        Wed,  9 Jun 2021 04:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623214045;
        bh=/bvJ4VTCfVrClXydbE5TyXaRfwzZ02GngWXdY4kSr6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xf3ZofrYrcKOvidZ0sNsCNsnuUGiPzhbFmLmC09ryTj6vvHRwMBlKDtiqi+Ja5yLn
         pVyo/rIaycCRU/RiwdJxUEtHDP2FfockfbdkYr/QIQD5HhVBhBQ+Ht4mopqWjBDvpC
         vmnbpOPLwZ215shdbErJAz2+cmJIKDHt2LGewGMo=
Date:   Wed, 9 Jun 2021 06:47:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        kbuild-all@lists.01.org, Michal Simek <monstr@monstr.eu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/5] USB: misc: Add onboard_usb_hub driver
Message-ID: <YMBH2SUor2kNeMWL@kroah.com>
References: <20210604144027.v11.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <202106050751.uNo0uAEm-lkp@intel.com>
 <YL5cvT4NvMLIuH+C@google.com>
 <YL5kL38o8JLDp8LK@kroah.com>
 <YL5mP4lGoiHNjAYN@google.com>
 <YL8wqCQZvim7iB02@kroah.com>
 <YL/ZHyvnRlS4AC5N@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL/ZHyvnRlS4AC5N@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 01:54:55PM -0700, Matthias Kaehlcke wrote:
> Also please let me know if you have other comments besides the prototype
> question, I'd prefer to avoid version churn if possible, this series
> already had a bit of that primarily due to the prototype issue.

When the kernel test robot finds issues, I drop the patches from my
review queue as I don't have time to review stuff with obvious issues,
so I do not even have the changes around to review at the moment.  I
have plenty of patches that do not have build problems to review :)

Fix them up and resend, there's nothing wrong with sending lots of
versions if you have to resolve problems.

thanks,

greg k-h
