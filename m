Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6C345E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCWM2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhCWM1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:27:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B639560200;
        Tue, 23 Mar 2021 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616502475;
        bh=yC5mkX0jRbM/U+lNf6Wg8GgczPj/ciwTwpmysPKYGZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3y70jFID9QOmY6LEq+ae3KZo2HHKORn/AqoVyEXBpio6CWyXHoDhzVLpOgQVl3NJ
         msbyttUncaYi2ep6ZtZYc7U+6mMP9lHeMJ5xJ2kL/Aqo/2e/hvSus6Xc/di0cLgrMH
         E3uGunIW6JOofemYYSd1Rd+1cOK18uHMogFoXdmo=
Date:   Tue, 23 Mar 2021 13:27:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] USB: cdc-acm: probe fixes
Message-ID: <YFnes2XnI+/o9yZX@kroah.com>
References: <20210322155318.9837-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322155318.9837-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 04:53:10PM +0100, Johan Hovold wrote:
> This series fixes a couple of bugs in the probe errors paths and does
> some clean up in preparation for adding the missing error handling when
> claiming the data interface.
> 
> The first two should probably go into 5.12-rc, while the rest could be
> held off for 5.13 if preferred.

I'll just take them all for 5.12-rc, thanks!

greg k-h
