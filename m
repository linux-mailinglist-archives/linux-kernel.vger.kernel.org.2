Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8227832A25D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376733AbhCBHvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1836962AbhCBHWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:22:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE825600CD;
        Tue,  2 Mar 2021 07:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614669125;
        bh=8ZGZj7lA/oqjsED7NDnEXxCTiWvydjonx05aZ8XsYeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UlK6wHuZqXuDEH3q5JqFXz4keZEWKovPRX871XFQIyYTaFK7b+Q/x2TXxEE0dvkwN
         jo/Nun+8CJJMNY3Ojaz2N85eghfVBTO3Auc4ILM/l8MYQnaC1w4o5zMEYkxvSd565H
         vtDBUu21dMJZrDrD3SME1C1HPDtHDCIsfilzJRTg=
Date:   Tue, 2 Mar 2021 08:12:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: tcpm: Export partner Source Capabilities
Message-ID: <YD3lQv5PCcz7gCEp@kroah.com>
References: <20210214111730.1436506-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214111730.1436506-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 07:17:30PM +0800, Kyle Tso wrote:
> Export a function for other drivers to get the partner Source
> Capabilities.

What driver?  We need a user of new functions in the kernel, otherwise
they are ripe for removal.

thanks,

greg k-h
