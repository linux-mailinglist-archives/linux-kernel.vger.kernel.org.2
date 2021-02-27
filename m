Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AA5326B6E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 04:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhB0DjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 22:39:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13094 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhB0DjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 22:39:00 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DnXJ62KfGz16C83;
        Sat, 27 Feb 2021 11:36:38 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Feb 2021 11:38:08 +0800
Subject: Re: [RFC PATCH] USB:XHCI:Modify XHCI driver for USB2.0 controller
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <yisen.zhuang@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
 <20210226163004.GB1392547@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <acfdf816-e295-df1d-4039-784fb0d417c4@huawei.com>
Date:   Sat, 27 Feb 2021 11:38:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210226163004.GB1392547@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/27 0:30, Alan Stern wrote:
> On Fri, Feb 26, 2021 at 04:21:37PM +0800, Longfang Liu wrote:
>> Our current XHCI hardware controller has been customized to only
>> support USB 2.0 ports. When using the current xhci driver, an xhci
>> controller device and an ehci controller device will be created
>> automatically.
> 
> That sentence makes no sense at all.  An EHCI controller device is a 
> piece of hardware.  How can an xHCI driver, which is a piece of 
> software, create a piece of hardware?
> 
> Alan Stern
> .
> 
The hardware device is a complete USB3.0 controller,
but I hope to support a USB2.0-only mode through software configuration.
Thanks.
Longfang Liu
