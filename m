Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C906B357DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhDHIAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHIAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:00:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FE5661130;
        Thu,  8 Apr 2021 08:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617868835;
        bh=La09tBMP61eg7G3Ah/my2WS/uG2b2GzYj7sKoOh7eI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cn6iX9I2/kDg5WooyL7rw5G4hutUhw+YzplY2JHgNP8fihvYqyxqtdwmyUvsIEroz
         7HuFD6P1P8/D4uULzuNZr/n1236u10UfmObPj9l0c6FI8Kyu4S3Lv2Z9+wwy2dpTnU
         KjVTH5igpaygoOa8amufxmS7FanIkXFRU480xJpA9Tqha2bcMovMpn2KN99Vq1kbR0
         V1azs1zLZoisE4BpNAThBB4q3YyM4A/T+MLdD35+bHxTBvzWaUvuyp386UtQQLxChV
         RxIYSlMlRr/h71kULhL9dDQYOpM/o0YHW314RqR8Bd/wXYr9t7U73ASqBhd0/hM2RB
         sIuqCaeitmlkQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUPaX-0002dV-CS; Thu, 08 Apr 2021 10:00:30 +0200
Date:   Thu, 8 Apr 2021 10:00:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] USB: serial: closing-wait cleanups
Message-ID: <YG64HZ5IBsAaAimw@hovoldconsulting.com>
References: <20210407104529.1110-1-johan@kernel.org>
 <YG3OxNDPBw8NeRBd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3OxNDPBw8NeRBd@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:24:52PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 07, 2021 at 12:45:25PM +0200, Johan Hovold wrote:
> > Now that all USB serial drivers supports changing the closing_wait
> > parameter through TIOCSSERIAL (setserial), we can remove the related
> > driver-specific module parameters and settings.
> > 
> > These depend on the recently posted TIOCSSERIAL series.
> 
> Yes!  Getting rid of the module parameter is so good...
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing these. All three sets now applied.

Johan
