Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79239358789
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhDHOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:53:50 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38345 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231791AbhDHOxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:53:47 -0400
Received: (qmail 1298433 invoked by uid 1000); 8 Apr 2021 10:53:32 -0400
Date:   Thu, 8 Apr 2021 10:53:32 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [PATCH v2 0/2] USB:ehci:fix the no SRBN register problem
Message-ID: <20210408145332.GA1296449@rowland.harvard.edu>
References: <1617889760-17733-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617889760-17733-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:49:18PM +0800, Longfang Liu wrote:
> (1) Add a whitelist for EHCI devices without SBRN registers.
> (2) Add Kunpeng920's EHCI device to the whitelist.
> 
> Changes in v2:
> 	- Fix some code style issues.
> 	- Update function name.
> 
> Longfang Liu (2):
>   USB:ehci:Add a whitelist for EHCI controllers
>   USB:ehci:fix Kunpeng920 ehci hardware problem
> 
>  drivers/usb/host/ehci-pci.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)

I don't think we need a whole list, along with an associated lookup 
routine, when there are only two entries.  The total amount of code will 
be smaller if you just add a check for the Kunpeng920 controller to
the existing check for the STMICRO controller.

Alan Stern
