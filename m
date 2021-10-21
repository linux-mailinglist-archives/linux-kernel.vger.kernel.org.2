Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C94363D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhJUOPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhJUOPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBBDE61208;
        Thu, 21 Oct 2021 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634825566;
        bh=5XEccsfIAKur6QssRs1skdFyS9avliQQXeTAuJkdmZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zjb5Vr8E/Px2rKoUqdT9wCPg586LLspkrRYlHNZlLieSndh9y8amg2spBJBLCeZEs
         jXwrzBcL2v2wDme0R50Gh0/jxYVvh2LNcgAzqFAioXdSc4MeDPuJ1H5rBbmuGnzuip
         uTanStszxoq24wp8nSls+nAvggyLdcvRen8NQgAc=
Date:   Thu, 21 Oct 2021 16:12:43 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Abhyuday Godhasara <agodhasa@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
Message-ID: <YXF1W8a7NfvRWPTt@kroah.com>
References: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbYKQXf8g8s55kG@kroah.com>
 <YWbZoPHDzc4e5Nme@kroah.com>
 <SA1PR02MB8592E68D021E12DCA45B70A2A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbo660XPKlwDZH0@kroah.com>
 <SA1PR02MB8592EB312091543A1D564D70A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbtSiHWNOf2djee@kroah.com>
 <f63e44a0-c187-8278-6c89-935b7006b64f@xilinx.com>
 <SA1PR02MB85922CC2DCFCDC902BC37E68A1BF9@SA1PR02MB8592.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR02MB85922CC2DCFCDC902BC37E68A1BF9@SA1PR02MB8592.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 01:55:49PM +0000, Abhyuday Godhasara wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Michal Simek <michal.simek@xilinx.com>
> > Sent: Wednesday, October 13, 2021 9:00 PM
> > To: gregkh@linuxfoundation.org; Abhyuday Godhasara
> > <agodhasa@xilinx.com>
> > Cc: Rajan Vaja <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>;
> > zou_wei@huawei.com; Sai Krishna Potthuri <lakshmis@xilinx.com>; Jiaying
> > Liang <jliang@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > 
> > 
> > 
> > On 10/13/21 16:29, gregkh@linuxfoundation.org wrote:
> > > On Wed, Oct 13, 2021 at 02:21:01PM +0000, Abhyuday Godhasara wrote:
> > >> Hi Greg,
> > >>
> > >>
> > >> Thanks,
> > >> Abhyuday
> > >>
> > >>> -----Original Message-----
> > >>> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > >>> Sent: Wednesday, October 13, 2021 7:41 PM
> > >>> To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > >>> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja
> > >>> <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>;
> > >>> zou_wei@huawei.com; Sai Krishna Potthuri <lakshmis@xilinx.com>;
> > >>> Jiaying Liang <jliang@xilinx.com>; linux- kernel@vger.kernel.org;
> > >>> linux-arm-kernel@lists.infradead.org
> > >>> Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > >>>
> > >>> On Wed, Oct 13, 2021 at 01:57:59PM +0000, Abhyuday Godhasara wrote:
> > >>>> Hi Greg,
> > >>>>
> > >>>>> -----Original Message-----
> > >>>>> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > >>>>> Sent: Wednesday, October 13, 2021 6:36 PM
> > >>>>> To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > >>>>> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja
> > >>>>> <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>;
> > >>>>> zou_wei@huawei.com; Sai Krishna Potthuri <lakshmis@xilinx.com>;
> > >>>>> Jiaying Liang <jliang@xilinx.com>; linux- kernel@vger.kernel.org;
> > >>>>> linux-arm-kernel@lists.infradead.org
> > >>>>> Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > >>>>>
> > >>>>> On Wed, Oct 13, 2021 at 02:59:21PM +0200,
> > >>>>> gregkh@linuxfoundation.org
> > >>>>> wrote:
> > >>>>>> On Wed, Oct 13, 2021 at 12:27:58PM +0000, Abhyuday Godhasara
> > wrote:
> > >>>>>>> Hi Greg,
> > >>>>>>>
> > >>>>>>>> -----Original Message-----
> > >>>>>>>> From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > >>>>>>>> Sent: Wednesday, September 15, 2021 6:46 PM
> > >>>>>>>> To: gregkh@linuxfoundation.org
> > >>>>>>>> Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
> > >>>>>>>> <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Manish
> > >>>>>>>> Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > >>>>>>>> Potthuri <lakshmis@xilinx.com>; Jiaying Liang
> > >>>>>>>> <jliang@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
> > >>>>>>>> linux-kernel@vger.kernel.org;
> > >>>>>>>> linux-arm- kernel@lists.infradead.org
> > >>>>>>>> Subject: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > >>>>>>>>
> > >>>>>>>> This Linux driver provides support to subscribe error/event
> > >>>>>>>> notification and receive notification from firmware for
> > >>>>>>>> error/event and forward event notification to subscribed driver
> > >>>>>>>> via
> > >>>>> registered callback.
> > >>>>>>>>
> > >>>>>>>> All types of events like power and error will be handled from
> > >>>>>>>> single place as part of event management driver.
> > >>>>>>>>
> > >>>>>>>> Changes in v4:
> > >>>>>>>> - Rebase on latest tree
> > >>>>>>>>
> > >>>>>>>> Changes in v3:
> > >>>>>>>> - Update the commit message.
> > >>>>>>>>
> > >>>>>>>> Changes in v2:
> > >>>>>>>> - Removed updated copyright year from unchanged files.
> > >>>>>>>> - make sgi_num as module parameter for event management driver.
> > >>>>>>>> - Use same object for error detection and printing.
> > >>>>>>>>
> > >>>>>>>> Acked-by: Michal Simek <michal.simek@xilinx.com>
> > >>>>>>> [Abhyuday] Michal suggested to merge this via your tree. Please
> > >>>>>>> have a
> > >>>>> look.
> > >>>>>>> Please let me know if there is anything required from my side.
> > >>>>>>
> > >>>>>> Ok, I'll pick it up, thanks.
> > >>>>>
> > >>>>> Nope, I can not as for some reason it all did not show up on
> > lore.kernel.org.
> > >>>>>
> > >>>>> Please resend this, with Michal's ack and I will be glad to pick it up.
> > >>>> [Abhyuday] Sent v5 with Michal's ack.
> > >>>
> > >>> Sent where?  Do you have a lore.kernel.org link?  Did you cc: me?
> > >> [Abhyuday] I added linux-kernel@vger.kernel.org and linux-arm-
> > kernel@lists.infradead.org in CC. also  added you in "To" for v5.
> > >> Please let me know if require anything else also.
> > >
> > > Again, I do not see them in my inbox, nor do I see them on
> > > lore.kernel.org.
> > >
> > > Are you _sure_ you sent them?
> > 
> > I got it but I expect they are not sent out of xilinx.com domain and you are sort
> > of blocked. You should talk to IT or just simply use any email out of xilinx
> > domain to check that you got it.
> > Also I am not able to see it in lore.
> [Abhyuday] Now v5 are available in lore.kernel.org

Looks good, all now reviewed from my side.

greg k-h
