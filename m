Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4E3BB95E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhGEIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhGEIex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:34:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F6D261374;
        Mon,  5 Jul 2021 08:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625473936;
        bh=/AgnkzuMvDPW3umEWUlJz3KteQYiDoT9pBzOhGC/svI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpVOFaFot8/5u9vTh+tHSj4iDhPO8PR4GJaRYLEdSrEBlBHUkrnxhDjNXnuHcn0VH
         owbQkiyq8lD/ZjS1857Ar3ZLSMuMXtQrrOp0lbFtEEiFsRqhJFQFNZcaScJ5HwdHuh
         N61IgSpxiMcx3/Twv0crQuqt0ufjB48fYqfauNno=
Date:   Mon, 5 Jul 2021 10:32:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] USB: serial: cp210x: fixes and CP2105/CP2108 fw
 version
Message-ID: <YOLDjgUFoIbWjilh@kroah.com>
References: <20210705082015.18286-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705082015.18286-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 10:20:09AM +0200, Johan Hovold wrote:
> Here are couple of minor fixes and some cleanups related to the recent
> regression which broke RTS control on some CP2102N devices with buggy
> firmware.
> 
> In case we run into another one of these, let's log the firmware
> version also for CP2105 and CP2108 for which it can be retrieved.
> 
> Johan
> 
> 
> Changes in v2
>  - keep the special-chars error message to make it more obvious that
>    continuing on errors is intentional (1/6) (Greg)

Thanks for the change, looks good to me!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
