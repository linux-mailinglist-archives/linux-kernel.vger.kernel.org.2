Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A92352C1F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhDBPHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBPH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:07:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EA2761103;
        Fri,  2 Apr 2021 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617376046;
        bh=gYmF2FZi4rLr2NP0zXXU+K8L7CMPYgLcBdksf70cB6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdrL33DWTrU8wijGjWbo+4VHUlSsOUXZi4osWEN97YcnWYg+aETJzq2kNQY53zWFh
         pK+zRj7jn6wOgaNlCcCuMJXETRRxNxFW8os+cnXSuhvyfTmXvAAQd0BfbZo3OGmfGf
         k/s8CYfBx5qVmMmrPJgpGCnsdyOqLmTQTa9BvkZQ=
Date:   Fri, 2 Apr 2021 17:07:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] of: property: fw_devlink: Add support for
 remote-endpoint
Message-ID: <YGczLJ38pTgGam0g@kroah.com>
References: <20210330185056.1022008-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330185056.1022008-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 11:50:55AM -0700, Saravana Kannan wrote:
> remote-endpoint property seems to always come in pairs where two devices
> point to each other. So, we can't really tell from DT if there is a
> functional probe order dependency between these two devices.
> 
> However, there can be other dependencies between two devices that point
> to each other with remote-endpoint. This non-remote-endpoint dependency
> combined with one of the remote-endpoint dependency can lead to a cyclic
> dependency[1].
> 
> To avoid this cyclic dependency from incorrectly blocking probes,
> fw_devlink needs to be made aware of remote-endpoint dependencies even
> though remote-endpoint dependencies by themselves won't affect probe
> ordering (because fw_devlink will see the cyclic dependency between
> remote-endpoint devices and ignore the dependencies that cause the
> cycle).
> 
> Also, if a device ever needs to know if a non-probe-blocking
> remote-endpoint has finished probing, it can now use the sync_state() to
> figure it out.
> 
> [1] - https://lore.kernel.org/lkml/CAGETcx9Snf23wrXqjDhJiTok9M3GcoVYDSyNYSMj9QnSRrA=cA@mail.gmail.com/#t
> Fixes: ea718c699055 ("Revert "Revert "driver core: Set fw_devlink=on by default""")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Rob/Greg,
> 
> This needs to go into driver-core due to the Fixes.

Now picked up, thanks.

greg k-h
