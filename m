Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1829739B95D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFDNCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhFDNCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:02:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55CEB61090;
        Fri,  4 Jun 2021 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622811649;
        bh=h0ayXPoihFOB74i0EIUfMrnc9F6zUA6UbIaHM/3VONU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRbowShmJHqWBzdPuyk0xeFL8lBi4JkkufTnlV83/a4vNc1BrZiWV0btIYpQF+Rip
         cs34FutM971wbHVk6M1DB8y6cPj0w91lfFy+YtPFwy13QnkC6ENca4mX5/enbf35It
         qRETqzj+lA/b8aboREWsIV0iXu0IWwpUDkEvrdmI=
Date:   Fri, 4 Jun 2021 15:00:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2] driver core: Make cycle dev_info() message dev_dbg()
Message-ID: <YLoj/2XmCo9OWjTS@kroah.com>
References: <20210603202116.1841261-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603202116.1841261-1-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 01:21:16PM -0700, Stephen Boyd wrote:
> This seems to mostly print debug information about device link stuff at
> boot. It doesn't seem very useful outside of debugging so move it to
> dev_dbg().

What messages at boot time are you seeing with this that should not be
there?  Shouldn't we fix the root cause here and not paper over it by
just lowering the logging level?

What drivers are having problems to trigger this?

thanks,

greg k-h
