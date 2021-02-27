Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272BC326B5C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 04:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhB0Dbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 22:31:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12957 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhB0Dbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 22:31:52 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DnX8D4n0szjRwh;
        Sat, 27 Feb 2021 11:29:48 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Feb 2021 11:31:00 +0800
Subject: Re: [RFC PATCH] USB:XHCI:Modify XHCI driver for USB2.0 controller
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <yisen.zhuang@huawei.com>, <linux-kernel@vger.kernel.org>
References: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
 <YDizmDmu6Kh264Pv@kroah.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <87cc8b54-f530-cce0-3ea2-f879436ff5f7@huawei.com>
Date:   Sat, 27 Feb 2021 11:31:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YDizmDmu6Kh264Pv@kroah.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/26 16:38, Greg KH wrote:
> On Fri, Feb 26, 2021 at 04:21:37PM +0800, Longfang Liu wrote:
>> Our current XHCI hardware controller has been customized to only
>> support USB 2.0 ports.
> 
> That sounds like a spec violation, right?  Why do you want to do this?
> 
> greg k-h
> .
> 
I hope to support a USB2.0-only mode on the XHCI controller
through software configuration.
Thanks.
Longfang Liu
