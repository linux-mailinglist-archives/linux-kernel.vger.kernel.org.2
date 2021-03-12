Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF6B3385F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhCLGeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhCLGds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:33:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A9D964F7E;
        Fri, 12 Mar 2021 06:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615530828;
        bh=D1OggX/GjwNY+qirvOQ3O1G12a9MpViR45YYkavvKP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUcWsMTI+Fa6IpjDfuthVTbJFj2ZV0BgNd114NHF+VjcahsFMH+gm3Ml5ieMWCJFq
         wecc66H+CsdYStAIS2ZZAEnUgBwGvdDFd6YJI23VI4O0ktSfb8WLFMC1BX4MOZdchf
         Wi0KcqSmT8Zo7YdyKY/o6C74sfO6Xt1ctNSNYkVM=
Date:   Fri, 12 Mar 2021 07:33:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2 1/2] usb: typec: tcpci: Add tcpc chip level callbacks
Message-ID: <YEsLSevhzYja0fwk@kroah.com>
References: <20210312052443.3797674-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312052443.3797674-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 09:24:42PM -0800, Badhri Jagan Sridharan wrote:
> This change adds chip callbacks for the following operations:
> 1. Notifying port role
> 2. Notifying orientation

This should be 2 different patches, one per callback, right?

And where is the code using these callbacks?  We can't add any hooks
without in-tree users, as you know.

thanks,

greg k-h
