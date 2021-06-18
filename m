Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544B13AC969
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhFRLG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233606AbhFRLGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:06:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DD196128C;
        Fri, 18 Jun 2021 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624014283;
        bh=XDjioh1/EllDaNzB8OJYHn6BohHUeO4QCzLNotVCEug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZe7BvoOKisf179jzIwekgMGFUZ3Ub6pRims4VV83ccFutc371cvvD83sSMcsCpFu
         F9c4rTXj07XnBQyDdkXbPB/WSJe3059CCTYUuFgzG2kh985skJOOBsJZ76NKq7MN+K
         fkfbWO40dq2eoRI81eLiu+//hUhr8ftu9mB2PwN8=
Date:   Fri, 18 Jun 2021 13:04:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5YiY5rW36b6ZKER1Y2tCdUJlZSk=?= <liuhailong@oppo.com>
Cc:     "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "maco@android.com" <maco@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "hridya@google.com" <hridya@google.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= staging:
 android: ashmem: add size field in procfs fdinfo
Message-ID: <YMx9vICXV7liMMoL@kroah.com>
References: <20210618095035.32410-1-liuhailong@oppo.com>
 <YMx0GIRQmpRC7pdQ@kroah.com>
 <HK0PR02MB31546ACD1FE5BA96CB49B54BAF0D9@HK0PR02MB3154.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK0PR02MB31546ACD1FE5BA96CB49B54BAF0D9@HK0PR02MB3154.apcprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 10:40:28AM +0000, 刘海龙(DuckBuBee) wrote:
> Hi 
> No user tools use this proc file as I know, I added this line can help user locate shmem leak issue.

Ok, thanks, I'll go queue it up.

greg k-h
