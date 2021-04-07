Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11E2357029
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353485AbhDGPZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234867AbhDGPZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:25:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53B2561007;
        Wed,  7 Apr 2021 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617809094;
        bh=3zfqWwj1fR2xBsHd0nVJuMbpqLPM1oM6n4YrBwVdJHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RR6dLQAVk6D6PRmU+oiURAC81jWbMIqJldEEiXZrGtJLkYUmh6uwvpIT7XL7CLgLO
         LENEUesRfGX5CcWd6i0akdiiYc0igz5gC7wOJxGNlHP/J1MfsOlrK1OjxiQP21JvKg
         XKOFKgLwnO5j901gFAALzMFDUqn9twGv01tqSrPE=
Date:   Wed, 7 Apr 2021 17:24:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] USB: serial: closing-wait cleanups
Message-ID: <YG3OxNDPBw8NeRBd@kroah.com>
References: <20210407104529.1110-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407104529.1110-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 12:45:25PM +0200, Johan Hovold wrote:
> Now that all USB serial drivers supports changing the closing_wait
> parameter through TIOCSSERIAL (setserial), we can remove the related
> driver-specific module parameters and settings.
> 
> These depend on the recently posted TIOCSSERIAL series.

Yes!  Getting rid of the module parameter is so good...

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
