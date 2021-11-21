Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C3E458670
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 22:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhKUVOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 16:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKUVOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 16:14:31 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58FC061574;
        Sun, 21 Nov 2021 13:11:25 -0800 (PST)
Received: from [2a04:4540:1403:bf00:8037:5e39:572a:8804]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1mou7H-0002CP-Tk; Sun, 21 Nov 2021 22:11:15 +0100
Message-ID: <9c169aad-3c7b-2ffb-90a2-1ca791a3f411@phrozen.org>
Date:   Sun, 21 Nov 2021 22:11:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: realtek,rtl-intc IRQ mapping broken on 5.16-rc1
Content-Language: en-GB
To:     Sander Vanheule <sander@svanheule.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bert Vermeulen <bert@biot.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
References: <bbe5506a2458b2d6049bd22a5fda77ae6175ddec.camel@svanheule.net>
 <87ilwp6zm6.wl-maz@kernel.org>
 <fdfe6615a0ec0d4a770b04a437922956e8586078.camel@svanheule.net>
 <877dd46w2b.wl-maz@kernel.org>
 <763394a6e5c83006eb4628a9d0242b7eb04b889d.camel@svanheule.net>
From:   John Crispin <john@phrozen.org>
In-Reply-To: <763394a6e5c83006eb4628a9d0242b7eb04b889d.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.11.21 21:33, Sander Vanheule wrote:
> Alternatively, a second compatible could perhaps be introduced and the current
> one would be deprecated, using (2) to prevent breaking 5.16+ kernels. I don't
> think that's really worth the effort though.
> 
> Best,

Hey,

I think that what Marc proposed as (1) is the clean solution. We want to 
describe the HW as it exists. Yes we have zero docs, and the RLT 2.6 sdk 
kernel is a pain to extract info from, yet we should move fwd with a 
clean implementation.

breaking pseudo owrt dts ABI is imho acceptable. owrt users are well 
able to reflash their units from uboot, they are at the end flying 
without wings on bleeding edge. asking for some backward compat for a 
de-facto broken dts mapping of the HW is imho a no-go.
	
	John
