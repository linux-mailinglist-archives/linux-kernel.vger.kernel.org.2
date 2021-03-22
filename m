Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D396343D22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCVJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:42:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:42358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhCVJlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:41:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616406108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ET9tVnh7U7AfNWjmR9qfyQd1mYs0mmzEoyVOIiFE5FI=;
        b=unHr1He0BPFNL+FpcGjhTz2ADOSJvebz/np30Jrm8MHzvwsaZ6AFi0xDG6BShaHi8Z2o4h
        /hrTTMTKWpJ+vEwv1o2p2IGE+zk/zhlCD3WyyB8XeBOZtN/JnfEJgfK2+xSDYcZJ4qrTO2
        o8OYpJieBr2MjOLXdn2eU6tVgQZ4sSg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4728AD79;
        Mon, 22 Mar 2021 09:41:48 +0000 (UTC)
Message-ID: <00dec0f52239f6c98a405474648e6cdcd41d48e5.camel@suse.com>
Subject: Re: [PATCH 6/7] USB: cdc-acm: use negation for NULL checks
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Mar 2021 10:41:45 +0100
In-Reply-To: <20210318155202.22230-7-johan@kernel.org>
References: <20210318155202.22230-1-johan@kernel.org>
         <20210318155202.22230-7-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 18.03.2021, 16:52 +0100 schrieb Johan Hovold:
> Use negation consistently throughout the driver for NULL checks.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>

