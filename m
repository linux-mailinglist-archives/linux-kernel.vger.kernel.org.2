Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607373F6293
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhHXQS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhHXQSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:18:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43756610A3;
        Tue, 24 Aug 2021 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629821887;
        bh=BDlMQu45ZqDbJNs8wpBo7h9vi71+LyNyrpawT/E6PIY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Xf2/5TI3Njr4zvViw5ydr4E55iYT1FHPGYtCCAPxYhjAws82Cr8Sf4YDd/s+NY/Bh
         tKHi2V4+QO5VZiDkIi47l3gJT1WyDX0OHknJqc/S+pOqECz/udMdNUJNgJz3UZGCAW
         lvFVPPw21rFotw/dUG3Zs3ym18o75DHIpwSw+sxhJATBUnlJtfCLjWWFFQU7iLG9WB
         8vPm3bIIohODS3Fw9kPK+Tv8hYDpAfzuzhIjn8ltUOoU5AD+jppSxGNweJROjHdXG/
         BhtfNbJu9rMu77LvT2ss12hJK60Tqe1IZ3br+ib6MGsC9/xuYxh4tdwfViXtTW3ceN
         UGJRZe0H2hqdQ==
References: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
 <20210823184449.2796184-3-Nehal-Bakulchandra.shah@amd.com>
 <87pmu36ypp.fsf@kernel.org> <1d9ecba4-d180-2193-66a3-3812759e1916@amd.com>
User-agent: mu4e 1.6.4; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kun.liu2@amd.com,
        alexander.deucher@amd.com
Subject: Re: [PATCH 2/2] usb: dwc3: pci add property to allow user space
 role switch
Date:   Tue, 24 Aug 2021 19:17:46 +0300
In-reply-to: <1d9ecba4-d180-2193-66a3-3812759e1916@amd.com>
Message-ID: <87czq27r5w.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com> writes:

> Hi
> On 8/24/2021 1:49 PM, Felipe Balbi wrote:
>> Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com> writes:
>> 
>>> For AMD platform there is a requirement to enable user space role
>>> switch from host to device and device to host by means of running
>>> following commands.
>>>
>>> HOST:   echo host > /sys/class/usb_role/dwc3.0.auto-role-switch/role
>>> DEVICE: echo device > /sys/class/usb_role/dwc3.0.auto-role-switch/role
>> A more important question that needs to be answered: why?
>> 
> Our customer platform is not completely capable of OTG i.e with type C
> controller it does not have PD to support role switching. Hence, they 
> have script which triggers the role switch based on ACPI/EC interrupt.

sounds like some generalized version of this text should be added to
commit log.

-- 
balbi
