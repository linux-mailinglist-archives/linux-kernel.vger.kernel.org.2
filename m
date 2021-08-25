Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F6B3F6D04
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 03:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhHYBRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 21:17:47 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:11927 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhHYBRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 21:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1629854221; x=1661390221;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Ppczo/0UhEqduN9raiNIidj5suITutz6sSUsUlr93xI=;
  b=GsFz7myoAb9tOtr6+/B2xw6w4ALRAuRqaTxtTxZcGolWDjHekOZwFQG4
   JFn4JE1PvAf8EoZ7Q4YNIyjpYYmhBa5FeNlrhOV5/6O3aqSVzsWeMsOWp
   QwGioePmm0dgj7h68KiVCI2GiYfqKTXDdu+ow6RCh+WSmMqKSjQAuECcc
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 24 Aug 2021 18:17:01 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 18:17:00 -0700
Received: from [10.226.59.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 24 Aug 2021
 18:16:59 -0700
Subject: Re: [git pull] habanalabs pull request for kernel 5.15
To:     Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Oded Gabbay <ogabbay@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210819110209.GA115485@ogabbay-vm2.habana-labs.com>
 <YR6PIvwYbYG20ZY0@kroah.com>
 <CAPM=9tyT_iouVE2v8J0SMJOLV=pr=QJOm88ud=bht4=5Ms2Y2A@mail.gmail.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
Message-ID: <5506552d-5be1-42f6-ead5-51b92a7ced82@quicinc.com>
Date:   Tue, 24 Aug 2021 19:16:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPM=9tyT_iouVE2v8J0SMJOLV=pr=QJOm88ud=bht4=5Ms2Y2A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/2021 12:48 PM, Dave Airlie wrote:
> On Fri, 20 Aug 2021 at 03:07, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Aug 19, 2021 at 02:02:09PM +0300, Oded Gabbay wrote:
>>> Hi Greg,
>>>
>>> This is habanalabs pull request for the merge window of kernel 5.15.
>>> The commits divide roughly 50/50 between adding new features, such
>>> as peer-to-peer support with DMA-BUF or signaling from within a graph,
>>> and fixing various bugs, small improvements, etc.
>>
>> Pulled and pushed out, thanks!
> 
> NAK for adding dma-buf or p2p support to this driver in the upstream
> kernel. There needs to be a hard line between
> "I-can't-believe-its-not-a-drm-driver" drivers which bypass our
> userspace requirements, and I consider this the line.
> 
> This driver was merged into misc on the grounds it wasn't really a
> drm/gpu driver and so didn't have to accept our userspace rules.
> 
> Adding dma-buf/p2p support to this driver is showing it really fits
> the gpu driver model and should be under the drivers/gpu rules since
> what are most GPUs except accelerators.

Care to elaborate?  I'm not trying to be cute, but all I see here is 
that dma-buf/p2p using drivers must be in drivers/gpu, yet many drivers 
outside of the gpu area use those features.  Surely your position can't 
be that only drivers/gpu can use dma-buf or p2p (which is part of the 
PCIe spec).

> We are opening a major can of worms (some would say merging habanalabs
> driver opened it), but this places us in the situation that if a GPU
> vendor just claims their hw is a "vector" accelerator they can use
> Greg to bypass all the work that been done to ensure we have
> maintainability long term. I don't want drivers in the tree using
> dma-buf to interact with other drivers when we don't have access to a
> userspace project to validate the kernel driver assumptions.

Umm, isn't that [1]?  The Habana device has the most open userspace I'm 
aware of.  Seems disingenuous to claim you don't have access to a 
userspace project for this driver.

[1] - https://github.com/HabanaAI/hl-thunk
