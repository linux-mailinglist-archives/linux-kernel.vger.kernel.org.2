Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA133B053
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCOKsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:48:47 -0400
Received: from smtp123.iad3a.emailsrvr.com ([173.203.187.123]:39678 "EHLO
        smtp123.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbhCOKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1615805320;
        bh=ID/APZIEOSDLvZtwNC0fyYc9o96mxOxli1drtsMViJI=;
        h=Subject:From:To:Date:From;
        b=SZe3qWNzYovz0C0jDIhxzIzjAPkslNN0MOMVeOb5vWivQ9mzGe+7ZaF9Ux34lu/OX
         A6HNhvEzPUSbdVO4t75ULGszVj1bSYvgSg8739wudP24ji9vivqd3eQLrKb/itn6Ef
         UaReDGOakxmQnctFNcvV5bAOmRnlX2oHDHz9wdqE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 512E524A8D;
        Mon, 15 Mar 2021 06:48:39 -0400 (EDT)
Subject: Re: [PATCH] staging: comedi: replace slash in name
From:   Ian Abbott <abbotti@mev.co.uk>
To:     Tong Zhang <ztong0001@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210314035757.2740146-1-ztong0001@gmail.com>
 <5d7a5e1c-35ab-58cb-ebcd-da5b280c802e@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <858341a6-c105-1440-aa4d-ea0217f2ec89@mev.co.uk>
Date:   Mon, 15 Mar 2021 10:48:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <5d7a5e1c-35ab-58cb-ebcd-da5b280c802e@mev.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 67750dd0-3b78-4775-abde-c905b639c76c-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2021 10:44, Ian Abbott wrote:
> On 14/03/2021 03:57, Tong Zhang wrote:
>> request_irq() wont accept a name which contains slash so we need to
>> repalce it with something else -- otherwise it will trigger a warning
>> and the entry in /proc/irq/ will not be created
>>
>> [    1.565966] name 'pci-das6402/16'
>> [    1.566149] WARNING: CPU: 0 PID: 184 at fs/proc/generic.c:180 __xlate_proc_name+0x93/0xb0
>> [    1.568923] RIP: 0010:__xlate_proc_name+0x93/0xb0
>> [    1.574200] Call Trace:
>> [    1.574722]  proc_mkdir+0x18/0x20
>> [    1.576629]  request_threaded_irq+0xfe/0x160
>> [    1.576859]  auto_attach+0x60a/0xc40 [cb_pcidas64]
>>
>> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
[snip]
> Userspace applications can use these strings to determine the board
> type, so changing the strings would break those applications.
> 
> I suggest passing the comedi driver name "cb_pcidas" to request_irq()
> for now.

Oops, I meant "cb_pcidas64".  But you could reach that via
dev->driver->driver_name if you want (where dev is the struct
comedi_device * parameter).

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
