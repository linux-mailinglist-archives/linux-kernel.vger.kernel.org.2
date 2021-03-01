Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7323275F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 02:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhCAB7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 20:59:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13023 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhCAB7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 20:59:35 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dpjzt5SxTzMSfq;
        Mon,  1 Mar 2021 09:56:42 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 09:58:42 +0800
Subject: Re: [RFC PATCH] USB:XHCI:Modify XHCI driver for USB2.0 controller
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <yisen.zhuang@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
 <20210226163004.GB1392547@rowland.harvard.edu>
 <acfdf816-e295-df1d-4039-784fb0d417c4@huawei.com>
 <20210227162703.GA1429200@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <770f03f2-0df2-1821-0f7e-9f27145c8c6b@huawei.com>
Date:   Mon, 1 Mar 2021 09:58:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210227162703.GA1429200@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/28 0:27, Alan Stern Wrote:
> On Sat, Feb 27, 2021 at 11:38:08AM +0800, liulongfang wrote:
>> On 2021/2/27 0:30, Alan Stern wrote:
>>> On Fri, Feb 26, 2021 at 04:21:37PM +0800, Longfang Liu wrote:
>>>> Our current XHCI hardware controller has been customized to only
>>>> support USB 2.0 ports. When using the current xhci driver, an xhci
>>>> controller device and an ehci controller device will be created
>>>> automatically.
>>>
>>> That sentence makes no sense at all.  An EHCI controller device is a 
>>> piece of hardware.  How can an xHCI driver, which is a piece of 
>>> software, create a piece of hardware?
>>>
>>> Alan Stern
>>> .
>>>
>> The hardware device is a complete USB3.0 controller,
>> but I hope to support a USB2.0-only mode through software configuration.
> 
> Even if it only supports USB-2.0 connections, an xHCI controller is 
> still an xHCI controller.  It doesn't magically transform into an EHCI 
> controller.
> 
> You are not creating an EHCI controller device.  Rather, you are trying 
> to restrict an xHCI controller device to make it handle only USB-2.0 
> connections.  If you run lsusb on a system that has an xHCI controller, 
> you'll see that the controller is bound to two USB buses: a USB-2 bus 
> and a USB-3 bus.  But for both buses, the controller is xHCI -- not 
> EHCI.
> 
> Your patch description is inaccurate.
> 
> Alan Stern
> .
> 
Yes, you are right.
when I run lsusb on a system that has this xHCI hardware,
the system displays two USB buses: a USB-2 bus and a USB-3 bus.
Both of these are xHCI host controllers, but USB-3 bus's roothub is zero.
Thanks.
Longfang Liu.
