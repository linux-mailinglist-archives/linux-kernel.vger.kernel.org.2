Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7DF37072A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 14:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhEAMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 08:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231960AbhEAMYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 08:24:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83BB361409;
        Sat,  1 May 2021 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619871795;
        bh=IsCKUsoaFkNF0OuX9NN16ruS+Rs+wIjJ1sC465dv+ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VrUvaZIIpBrfM8muwRro4KSxyB0Mzsqk01yyP6fxljWk+3gydENOCBECUqia5mQ5z
         PeImyO+f4Kw4I8A8+ye3FWfwyC+x00NkBXCFj/8kzuQx1UHYtriIwDtR0SVy32So4h
         bnRXLZi8T4FRwUZQqCbOOZnZO4iu3f7vsGkt4/Go=
Date:   Sat, 1 May 2021 14:23:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ashish Kalra <eashishkalra@gmail.com>
Cc:     Ivan Safonov <insafonov@gmail.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Pritthijit Nath <pritthijit.nath@icloud.com>,
        Allen Pais <apais@linux.microsoft.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wlan-ng: silence incorrect type in argument
 1 (different address spaces)
Message-ID: <YI1IMG8tCvvRMq3i@kroah.com>
References: <YI098DQNtK3i2Fge@ashish-NUC8i5BEH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI098DQNtK3i2Fge@ashish-NUC8i5BEH>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 05:09:28PM +0530, Ashish Kalra wrote:
> Currently p80211knetdev_do_ioctl use type casting to req->data to prevent sparse warning while calling memdup_user, instead of type casting it here, its better to change data type for data inside p80211ioctl_req to include __user.

Please properly line-wrap your changelog comments.

Can you fix it up and resend it as v3?

thanks,

greg k-h
