Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98D2343D14
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhCVJkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:40:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCVJkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:40:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616406001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZ8GWgs/1lxqtFMN+XRCtK9Qsu5F8/EJ2Sq1Md1mAlo=;
        b=e4p7eTqXjbZgImDvyx1cDy591ZG/isT9UwUuRqW+mq1H3fwyGZ4DOKHp+0tlhu5skL8nkp
        BgCLWamcosgOU0Ichvs0wjx1kBDw8MvITXNNO65XOVTPULpT/LXv9y1tekHjGP7UGva9Lj
        q/rCPCY3Fds0o2J4BKACJUWTyaEQ/fg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80B20ADAA;
        Mon, 22 Mar 2021 09:40:01 +0000 (UTC)
Message-ID: <49f76785806f20a2d61d793d066f8416f3d8164c.camel@suse.com>
Subject: Re: [PATCH 3/7] USB: cdc-acm: drop redundant driver-data assignment
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Mar 2021 10:39:57 +0100
In-Reply-To: <20210318155202.22230-4-johan@kernel.org>
References: <20210318155202.22230-1-johan@kernel.org>
         <20210318155202.22230-4-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 18.03.2021, 16:51 +0100 schrieb Johan Hovold:
> The interface driver data has already been set by
> usb_driver_claim_interface() so drop the redundant subsequent
> assignment.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>

