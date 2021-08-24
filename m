Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49C3F637A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhHXQzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232594AbhHXQzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:55:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 141F861183;
        Tue, 24 Aug 2021 16:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629824109;
        bh=S3loidLLlu1xrh4xk6ck0Wtc3n7jz085PzeWqCBUG04=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=SnE/VPqSsIHaRPvZjktlP2kD2wgG+k5z1bfxXHcdHzy2xHM/ZuEsJw546F7NTebsC
         5E2WN+E4yXDFZpA1LWaevIGcmM/M7liCmBqwqbtmUkFyQvFBxqx1s39QVH7Wjv6fvN
         OHmd/6mVqjwFuwCJ2jITtTgNvhmVR7oTqORL6eAWYcl6MnKSxdssCU2j9Vc2La84m7
         v1eeTwgw5Q1nqIEFCTsIMX9OuzH8fhjtj4Hhe0iMr4NMc6sLy3XJRqpfkF+PVJu/Iw
         f8uzUz86x3DIk/cLHi7tXBL50BNHR5DtUZg9rmSjqFbMa0XZfLciFO/Xzfn4TB+3wP
         sSiTzVPo34gAA==
References: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
 <20210823184449.2796184-3-Nehal-Bakulchandra.shah@amd.com>
 <87pmu36ypp.fsf@kernel.org> <1d9ecba4-d180-2193-66a3-3812759e1916@amd.com>
 <87czq27r5w.fsf@kernel.org> <05c17f61-30db-6d10-d980-d3973dedfa5e@amd.com>
User-agent: mu4e 1.6.4; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kun.liu2@amd.com,
        alexander.deucher@amd.com
Subject: Re: [PATCH 2/2] usb: dwc3: pci add property to allow user space
 role switch
Date:   Tue, 24 Aug 2021 19:54:34 +0300
In-reply-to: <05c17f61-30db-6d10-d980-d3973dedfa5e@amd.com>
Message-ID: <878s0q7pgp.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

"Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com> writes:
> On 8/24/2021 9:47 PM, Felipe Balbi wrote:
>> "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com> writes:
>> 
>>> Hi
>>> On 8/24/2021 1:49 PM, Felipe Balbi wrote:
>>>> Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com> writes:
>>>>
>>>>> For AMD platform there is a requirement to enable user space role
>>>>> switch from host to device and device to host by means of running
>>>>> following commands.
>>>>>
>>>>> HOST:   echo host > /sys/class/usb_role/dwc3.0.auto-role-switch/role
>>>>> DEVICE: echo device > /sys/class/usb_role/dwc3.0.auto-role-switch/role
>>>> A more important question that needs to be answered: why?
>>>>
>>> Our customer platform is not completely capable of OTG i.e with type C
>>> controller it does not have PD to support role switching. Hence, they
>>> have script which triggers the role switch based on ACPI/EC interrupt.
>> sounds like some generalized version of this text should be added to
>> commit log.
>> 
> Sure i will resubmit this patch with this description should be ok?

yup, sounds good. Thank you


-- 
balbi
