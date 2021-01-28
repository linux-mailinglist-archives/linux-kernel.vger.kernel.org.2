Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB693081C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 00:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhA1XWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 18:22:10 -0500
Received: from vern.gendns.com ([98.142.107.122]:59422 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhA1XWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 18:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vxlxCLEYe7Qe4lS7C6DM4d8MIH71fHWxRV8aQVea7Ys=; b=X+VBHukCOX8r+XYvSfWAR9bb+8
        JqHbWpTS3cQ07ZU36o3kbzgAG2kNkxUZF/vsZMJ3E6n2Y1CczeTLgc7e8zpdH5kecX8V01t0pp1AH
        UEpaxF9RGjJggnbaQFY6q9zzC/2xlG7kAmgRszhsnfz1dL/4qVUafF25eeSQdPMceSmH5/hejksgR
        rOusT0hb07HieVXhQ19wni1Hoy4kQx6/qbtfsDujPqUbBvmiS2jAqqPvVzIPWOw/KHq5hObXJpap+
        rtH2rPxr8w/DFAiWWwrQJdcp2ZrzRVdRaRofZAQ2naRWOEN8/AW3qiM9amRlU+IP5Aza5drcq5FPI
        2lKAACIA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:50246 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1l5GbL-00079l-AH; Thu, 28 Jan 2021 18:21:23 -0500
Subject: Re: [PATCH] remoteproc: pru: future-proof PRU ID matching
To:     Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20210104211816.420602-1-david@lechnology.com>
 <ccc1ee4b-ed73-f7c8-ca1e-f15eedeeb84b@ti.com>
 <e2a0a40d-f720-8139-29f3-39a473c69119@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <5fed434e-1569-ab9f-b1a4-475aa820ef47@lechnology.com>
Date:   Thu, 28 Jan 2021 17:21:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e2a0a40d-f720-8139-29f3-39a473c69119@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 4:55 PM, Suman Anna wrote:
> Hi David,
> 
> On 1/15/21 6:53 PM, Suman Anna wrote:
>> On 1/4/21 3:18 PM, David Lechner wrote:
>>>   static int pru_rproc_probe(struct platform_device *pdev)
>>> @@ -825,20 +808,28 @@ static int pru_rproc_remove(struct platform_device *pdev)
>>>   
>>>   static const struct pru_private_data pru_data = {
>>>   	.type = PRU_TYPE_PRU,
>>> +	.pru0_iram_offset = 0x4000,
>>> +	.pru1_iram_offset = 0x8000,
> 
> The offsets for the PRU cores are actually 0x34000 and 0x38000 respectively from
> the base of the PRUSS on non-Davinci SoCs.
> 
> If we were to use this static data approach, then we might as well continue to
> use the current address masking logic with the appropriate masks for Davinci
> (0x38000 and 0x3C000, not true offsets but as masks they would work). Davinci
> PRUSS is the only one with its differences being the first PRUSS IP, and I would
> prefer to keep the logic aligned to the IPs on all the recent SoCs on 3
> different TI SoC families (OMAP, Keystone 2 and K3).
> 
> Let me know what you think.

I'm not too picky as long as it works. :-)

If keeping the static data to a minimum is really important, I suppose we could
introduce a new type = PRU_TYPE_PRU_V1 for these PRUSSs instead. It sounds like
this information might be useful elsewhere anyway.
