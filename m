Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5132CB32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhCDEJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:09:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12682 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhCDEJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:09:36 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DrckX3KpzzlSPm;
        Thu,  4 Mar 2021 12:06:44 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 12:08:43 +0800
Subject: Re: [RFC PATCH] USB:XHCI:Modify XHCI driver for USB2.0 controller
To:     Peter Chen <peter.chen@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <yisen.zhuang@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
 <YDizmDmu6Kh264Pv@kroah.com>
 <87cc8b54-f530-cce0-3ea2-f879436ff5f7@huawei.com>
 <20210304013548.GA16596@nchen>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <cd4f7d23-0c21-5ea8-3224-cde1256a36a0@huawei.com>
Date:   Thu, 4 Mar 2021 12:08:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210304013548.GA16596@nchen>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/4 9:35, Peter Chen wrote:
> On 21-02-27 11:31:00, liulongfang wrote:
>> On 2021/2/26 16:38, Greg KH wrote:
>>> On Fri, Feb 26, 2021 at 04:21:37PM +0800, Longfang Liu wrote:
>>>> Our current XHCI hardware controller has been customized to only
>>>> support USB 2.0 ports.
>>>
>>> That sounds like a spec violation, right?  Why do you want to do this?
>>>
>>> greg k-h
>>> .
>>>
>> I hope to support a USB2.0-only mode on the XHCI controller
>> through software configuration.
>> Thanks.
> 
> If your hardware has disabled USB3 logic, when the USB3 device is plugged,
> since there are no RX signal on the bus, the device will not enable USB3
> logic, and only USB2 signals will be on the bus, there are only USB devices on
> USB2 roothub later. So, any issues you have met?
> 
I don¡¯t want to see the USB3 bus controller in the system,
but it actually exists.
Thanks.
Longfang, Liu
