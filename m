Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE633F5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhCQQnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232329AbhCQQnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:43:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C98E64F69;
        Wed, 17 Mar 2021 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615999380;
        bh=b/sKPjo0wFZrFiKOLaiPqCFikoPHrO+gmqfvGBCiGOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqfkJb0H1nV6mOU22soCC08o+VhUCcpVppNrK14ZA60FpOYXfEvARyq4LrcF+/Uv6
         IBQN4PNY9Bf/9vSBbuypDwTx/tbB/XvBLeF8qFCbBX1c38OBWVgEyoUbwD+LScGZzx
         GRXlEBYMsIXuaosyOBOgRjwiWns5on3/glaj4BSU=
Date:   Wed, 17 Mar 2021 17:42:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpci: Added few missing TCPCI register
 definitions
Message-ID: <YFIxkh8XLDiszci7@kroah.com>
References: <20210316221304.391206-1-badhri@google.com>
 <4f077e6c-4e95-ab54-c549-e953bf3c00f3@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f077e6c-4e95-ab54-c549-e953bf3c00f3@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 03:52:58PM -0700, Guenter Roeck wrote:
> On 3/16/21 3:13 PM, Badhri Jagan Sridharan wrote:
> > This change adds some of the register bit definitions from the TCPCI spec:
> > https://www.usb.org/sites/default/files/documents/
> > usb-port_controller_specification_rev2.0_v1.0_0.pdf
> > 
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> 
> Are those going to be used ?

For values and #defines that are in public specs, does it matter?  It's
good to have full definitions in the .h files for whenever possible for
stuff like this to make it easy for people to write code to use them :)

thanks,

greg k-h
