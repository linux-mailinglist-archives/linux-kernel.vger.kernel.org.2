Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399BD4331B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhJSJDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:03:39 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:55307 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234840AbhJSJDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:03:37 -0400
Received: from [192.168.0.2] (ip5f5aef98.dynamic.kabel-deutschland.de [95.90.239.152])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E5F8961E5FE00;
        Tue, 19 Oct 2021 11:01:22 +0200 (CEST)
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
 <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
 <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
 <20210817170222.GA224912@dhcp-10-100-145-180.wdc.com>
 <f02a8989-d255-26ee-2fca-c9db2d1e158c@molgen.mpg.de>
 <20211011180058.GA635062@dhcp-10-100-145-180.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <3eafec89-0c71-5243-8545-dc0120f1678b@molgen.mpg.de>
Date:   Tue, 19 Oct 2021 11:01:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211011180058.GA635062@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Keith,


Thank you for your reply?


Am 11.10.21 um 20:00 schrieb Keith Busch:
> On Mon, Oct 11, 2021 at 03:08:15PM +0200, Paul Menzel wrote:
>> Am 17.08.21 um 19:02 schrieb Keith Busch:
>>>
>>> In the section for "Identify Controller Data Structure" (section
>>> 5.17.2.1, figure 257 in spec version 2.0), the NQN definition says:
>>>
>>>     "Support for this field is mandatory if the controller supports revision
>>>     1.2.1 or later"
>>>
>>> The driver does confirm the controller's reported revision meets this
>>> requirement before emitting the warning.
>>
>> The Dell support came back to me, and said, that Hynix refuses to publish a
>> fixed firmware unless I show them a use case, where I need that field.
>>
>> Can somebody think of a use case,
> 
> Spec compliance certification. UNH test 1.1 case 2, for example.
> 
>> and why this field was made mandatory in the specification?
> 
> A dependable way to uniquely identify a specific device is generally
> useful. The NVMe TWG determined the previous methods were inadequate.

Do you know, why the serial number, shown by `nvme list`, was deemed 
inadequate to uniquely identify a specific device?

> The linux kernel will continue to use the device without this capability
> since the low level driver doesn't need it to interact with a
> controller, but the driver will warn about the non-compliance in case
> host software is relying on this field.

Yes, I understand.


Kind regards,

Paul
