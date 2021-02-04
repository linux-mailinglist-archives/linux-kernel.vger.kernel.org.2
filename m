Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98F030EF21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhBDJAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbhBDJAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:00:38 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92B9C061573;
        Thu,  4 Feb 2021 00:59:56 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EE8181F45E0A;
        Thu,  4 Feb 2021 08:59:54 +0000 (GMT)
Date:   Thu, 4 Feb 2021 09:59:45 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH] mtd: rawnand: Do not check for bad block if bbt is
 unavailable
Message-ID: <20210204095945.51ef0c33@collabora.com>
In-Reply-To: <20210204085221.GB8235@thinkpad>
References: <20210202041614.GA840@work>
        <20210202091459.0c41a769@xps13>
        <AFD0F5A6-7876-447B-A089-85091225BE11@linaro.org>
        <20210203110522.12f2b326@xps13>
        <EBDAB319-549F-4CB1-8CE3-9DFA99DBFBC0@linaro.org>
        <20210203111914.1c2f68f6@collabora.com>
        <8A2468D5-B435-4923-BA4F-7BF7CC0FF207@linaro.org>
        <20210203122422.6963b0ed@collabora.com>
        <F55F9D7B-0542-448E-A711-D1035E467ACA@linaro.org>
        <20210204091336.1406ca3b@xps13>
        <20210204085221.GB8235@thinkpad>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 14:22:21 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> On Thu, Feb 04, 2021 at 09:13:36AM +0100, Miquel Raynal wrote:
> > Hi Manivannan,
> > 
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote on Wed,
> > 03 Feb 2021 17:11:31 +0530:
> >   
> > > On 3 February 2021 4:54:22 PM IST, Boris Brezillon <boris.brezillon@collabora.com> wrote:  
> > > >On Wed, 03 Feb 2021 16:22:42 +0530
> > > >Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > > >    
> > > >> On 3 February 2021 3:49:14 PM IST, Boris Brezillon    
> > > ><boris.brezillon@collabora.com> wrote:    
> > > >> >On Wed, 03 Feb 2021 15:42:02 +0530
> > > >> >Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > > >> >      
> > > >> >> >> 
> > > >> >> >> I got more information from the vendor, Telit. The access to    
> > > >the      
> > > >> >3rd        
> > > >> >> >partition is protected by Trustzone and any access in non    
> > > >privileged    
> > > >> >> >mode (where Linux kernel runs) causes kernel panic and the device
> > > >> >> >reboots.       
> > > >> >
> > > >> >Out of curiosity, is it a per-CS-line thing or is this section
> > > >> >protected on all CS?
> > > >> >      
> > > >> 
> > > >> Sorry, I didn't get your question.     
> > > >
> > > >The qcom controller can handle several chips, each connected through a
> > > >different CS (chip-select) line, right? I'm wondering if the firmware
> > > >running in secure mode has the ability to block access for a specific
> > > >CS line or if all CS lines have the same constraint. That will impact
> > > >the way you describe it in your DT (in one case the secure-region
> > > >property should be under the controller node, in the other case it
> > > >should be under the NAND chip node).    
> > > 
> > > Right. I believe the implementation is common to all NAND chips so the property should be in the controller node.   
> > 
> > Looks weird: do you mean that each of the chips will have a secure area?  
> 
> I way I said is, the "secure-region" property will be present in the controller
> node and not in the NAND chip node since this is not related to the device
> functionality.
> 
> But for referencing the NAND device, the property can have the phandle as below:
> 
> secure-region = <&nand0 0xffff>;

My question was really what happens from a functional PoV. If you have
per-chip protection at the FW level, this property should be under the
NAND node. OTH, if the FW doesn't look at the selected chip before
blocking the access, it should be at the controller level. So, you
really have to understand what the secure FW does.
