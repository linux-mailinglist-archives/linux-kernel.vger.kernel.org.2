Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5091D30C62E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhBBQkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236697AbhBBQiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:38:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18E6964F72;
        Tue,  2 Feb 2021 16:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612283858;
        bh=9mui9xktHtF4zCrmc2eyRWaxKALJ4HJXaxXeHOy1mAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qI1GeeRAKPkcTDb2WvoCRO3pjb61cGDxNDmrF1y3X3wp6HQ0RgS+Cx00ZqDvs1v6P
         0meisXUANtUPby6t/JsInrHBLlcR9XfQPtpcDUgVc5qyBmQWA4Z0VOwKnmi3950UnX
         OlFNlnjzI0bt/gvb9RLp4EEpJm6qaXTx/2hQDr2A=
Date:   Tue, 2 Feb 2021 17:37:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        pmalani@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kyletso@google.com, bleung@google.com
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Fix call to
 typec_partner_set_pd_revision
Message-ID: <YBl/0C4yc3ST9zLy@kroah.com>
References: <20210202163248.3981555-1-bleung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202163248.3981555-1-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 08:32:48AM -0800, Benson Leung wrote:
> typec_partner_set_pd_revision returns void now.
> 
> Fixes: cefc011f8daf platform/chrome: cros_ec_typec: Set Partner PD revision from status

Can you please use the documented format for the Fixes: tag (and for the
use of any git id in the kernel changelog)?

If anyone were to commit this change, you would get a nasty-gram email
from linux-next :)

thanks,

greg k-h
