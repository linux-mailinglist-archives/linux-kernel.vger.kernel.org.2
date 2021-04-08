Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB035878C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhDHOxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhDHOxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:53:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F26460C3D;
        Thu,  8 Apr 2021 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617893620;
        bh=nW2krWtHpkH/S3XIOU+fa0NbL43wi1gA8FHgLCxc8E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rShlUtv3O87kuYTXexcR9miWFcQCYNsisI+GId/PjnJYp2QhgV0ykD2rz39e724uO
         kLFgz2CXV5xSIYi1U6CbcDxCoqKpH1BNwBygEBJAlNSjaIYq/alPDIceO8s6kNPZWo
         +xSPxMsiCmrFk9aGCwh5PH2lCLrcn9UOrr6C2ZuI=
Date:   Thu, 8 Apr 2021 16:53:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liulongfang <liulongfang@huawei.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [PATCH 1/2] USB:ehci:Add a whitelist for EHCI controllers
Message-ID: <YG8Y8viSvTpcOkJr@kroah.com>
References: <1617873073-37371-1-git-send-email-liulongfang@huawei.com>
 <1617873073-37371-2-git-send-email-liulongfang@huawei.com>
 <YG7LO2DJMThbeJ5W@kroah.com>
 <13446834-afc5-e713-d232-36c771059712@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13446834-afc5-e713-d232-36c771059712@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:04:17PM +0800, liulongfang wrote:
> On 2021/4/8 17:22, Greg KH Wrote:
> > On Thu, Apr 08, 2021 at 05:11:12PM +0800, Longfang Liu wrote:
> >> Some types of EHCI controllers do not have SBRN registers.
> >> By comparing the white list, the operation of reading the SBRN
> >> registers is skipped.
> >>
> >> Subsequent EHCI controller types without SBRN registers can be
> >> directly added to the white list.
> >>
> >> The current patch does not affect the drive function.
> >>
> >> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >> ---
> >>  drivers/usb/host/ehci-pci.c | 27 +++++++++++++++++++++++----
> >>  1 file changed, 23 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> >> index 3c3820a..6a30afa 100644
> >> --- a/drivers/usb/host/ehci-pci.c
> >> +++ b/drivers/usb/host/ehci-pci.c
> >> @@ -47,6 +47,28 @@ static inline bool is_bypassed_id(struct pci_dev *pdev)
> >>  	return !!pci_match_id(bypass_pci_id_table, pdev);
> >>  }
> >>  
> >> +static const struct usb_nosbrn_whitelist_entry {
> >> +	unsigned short vendor;
> >> +	unsigned short device;
> > 
> > u16 here please.
> > 
> >> +} usb_nosbrn_whitelist[] = {
> >> +	/* STMICRO ConneXT has no sbrn register */
> >> +	{PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_USB_HOST},
> >> +	{}
> > 
> > trailing , please.
> > 
> 
> Is it necessary to add "," at the end here?

Yes please.
