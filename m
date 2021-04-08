Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD5358787
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhDHOxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhDHOxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:53:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6338E60C3D;
        Thu,  8 Apr 2021 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617893591;
        bh=A+lmlSJytki0D83VoLSeoFC03SWEPdUvUSWJ5JtB45U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2TIRy1gbUSU7f3p68CkHaxNOPMpAUoJMuXbCCmiJLRk9j1JccDzKo4kn6M8svC8Zo
         seYqfzQLZvAFG+0zgH9k26cqummWkXKwgqYAoba25gyptkCKS1Wn0QTTHfh3HhduRa
         iEwyhZE8+4ZeiVJbd78icMHauOkEyuBO4WehA2Lo=
Date:   Thu, 8 Apr 2021 16:53:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [PATCH v2 1/2] USB:ehci:Add a whitelist for EHCI controllers
Message-ID: <YG8Y1HexwyN2Wk03@kroah.com>
References: <1617889760-17733-1-git-send-email-liulongfang@huawei.com>
 <1617889760-17733-2-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617889760-17733-2-git-send-email-liulongfang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:49:19PM +0800, Longfang Liu wrote:
> Some types of EHCI controllers do not have SBRN registers.
> By comparing the white list, the operation of reading the SBRN
> registers is skipped.
> 
> Subsequent EHCI controller types without SBRN registers can be
> directly added to the white list.
> 
> The current patch does not affect the drive function.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/host/ehci-pci.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 3c3820a..534e906 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -47,6 +47,29 @@ static inline bool is_bypassed_id(struct pci_dev *pdev)
>  	return !!pci_match_id(bypass_pci_id_table, pdev);
>  }
>  
> +static const struct usb_nosbrn_whitelist_entry {

Again, please do not use the term "whitelist", it is vague and you can
pick a better term for this.

How about:
	struct ehci_nosbrn;

thanks,

greg k-h
