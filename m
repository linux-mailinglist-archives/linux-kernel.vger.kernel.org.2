Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0583343957C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhJYMFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhJYMFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:05:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC1C860EFE;
        Mon, 25 Oct 2021 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635163408;
        bh=c/J35cMXuvIKQ4peLSh+02vEELJbAsYmYaB7v/xWwyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5fCON+GAtn04lxlrnd74fP7BgJ8NHRib32T+sxrE8Y/tdf/J57GRAJl58MplpKhQ
         ZmTSg906gS9i734/xTsdKXWKy4MGl81OJj13B9z785YeWLrJ1YjXas5b2cs/iu1Na6
         kG/mMQ4vVI+58Ez2Skh1/um4rRvkYVG4715nMd64=
Date:   Mon, 25 Oct 2021 14:03:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhyuday Godhasara <agodhasa@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Tejas Patel <TEJASP@xilinx.com>
Subject: Re: [PATCH v6 1/6] firmware: xilinx: add register notifier in zynqmp
 firmware
Message-ID: <YXadDpOHWs2kUA6J@kroah.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
 <20211025082350.10881-2-abhyuday.godhasara@xilinx.com>
 <YXZsLJ3SfCjYr3gk@kroah.com>
 <SA1PR02MB8592145E6C1A9A1FA561FA33A1839@SA1PR02MB8592.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR02MB8592145E6C1A9A1FA561FA33A1839@SA1PR02MB8592.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:53:17AM +0000, Abhyuday Godhasara wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, October 25, 2021 2:05 PM
> > To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> > Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; Jiaying Liang
> > <jliang@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; Tejas Patel <TEJASP@xilinx.com>
> > Subject: Re: [PATCH v6 1/6] firmware: xilinx: add register notifier in zynqmp
> > firmware
> > 
> > On Mon, Oct 25, 2021 at 01:23:45AM -0700, Abhyuday Godhasara wrote:
> > > In zynqmp-firmware, register notifier is not supported, add support of
> > > register notifier in zynqmp-firmware.
> > >
> > > Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> > > Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > ---
> > > Changes in v6:
> > > - Minor fix
> > 
> > 
> > That is vague, what got "fixed" here?
> [Abhyuday] During rebase of patches on your tree couple of lines code was get mixed unintendedly in xlnx-zynqmp.h header file due to use of "git am -3".
> I corrected the below code which was wrong in previous patch v5.
> +static inline int zynqmp_pm_register_notifier(const u32 node, const u32 event,
> +					      const u32 wake, const u32 enable) {
> +	return -ENODEV;
> +}
> 
> In v5 it was like below, which is wrong
> static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
> static inline int zynqmp_pm_register_notifier(const u32 node, const u32 event,
> 					      const u32 wake, const u32 enable) {
> 	return -ENODEV;
> }
> So, the body was missing here for zynqmp_pm_load_pdi in v5.

And why did you not describe this in the changelog text?  That is what I
was asking about here.  Please be specific, as reviewers need to know
this type of thing.

thanks,

greg k-h
