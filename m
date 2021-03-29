Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF034CCED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhC2JVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhC2JV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:21:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0520D6192E;
        Mon, 29 Mar 2021 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617009686;
        bh=bzjkiO3yvGr2zMyAH/I8AOuVH+pAzD85rQTJY60oYzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZN1oK5ix8AoxJO8+oQ54kOvjnksrdvqzZ0Kt9eUIZM4l7+vhNv4uWoir4qcC99JvT
         6PwJnNV8l3iucCjM1YxvC9sclAFUHTeW+Q83vGq33VjPk94B1aqaAoo3JZ3lgg1rjK
         mxVPJex/YioAGYwPsigMUBh1ramHSm5huRM0TFKY=
Date:   Mon, 29 Mar 2021 11:21:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] usb: typec: Link all ports during connector
 registration
Message-ID: <YGGcEynXzPMQHBPo@kroah.com>
References: <20210329084426.78138-1-heikki.krogerus@linux.intel.com>
 <20210329084426.78138-7-heikki.krogerus@linux.intel.com>
 <YGGUU2z0qHsfgKrV@kroah.com>
 <YGGbQA/mIAu2JUWs@kuha.fi.intel.com>
 <YGGbqLYXXIxmTiRT@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGGbqLYXXIxmTiRT@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 12:19:36PM +0300, Heikki Krogerus wrote:
> > I could make a stub for the usb_for_each_port() function in case
> > CONFIG_USB is not enable. Would that work?
> 
> Ah, I think that's what you meant :-)

Yes, that's what I meant :)

thanks,

greg k-h
