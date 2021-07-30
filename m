Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8907A3DC116
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhG3WbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:31:00 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:41216 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhG3Wa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:30:59 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 18:30:58 EDT
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 758C7227D0C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 22:23:05 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.166])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 30A552A0064
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 22:23:04 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 05C4B900026
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 22:23:03 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 5F75C13C2B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:23:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5F75C13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627683783;
        bh=pRBhLHGtPtvHLvpf59xbGmGBd1CtA0sjUl4NNDMctBg=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=l39zOg/64DoODvHBImNzLFQ0Uw+p+IhyxumyKbSFn/SLk1ebXCbsc6pIPccRWgZRQ
         3OSasTxzpTxGr8NhGviniP5J5rRuS2B6nAoO9OrhtmIf7BfNqoXvkPvVGVch0n+iBs
         AiGee+S42MyRmIuNISGmvlCIIDWLJF+Ilz15UlWI=
Subject: Re: kasan warning related to hwmon/acpi, 5.13.5+
From:   Ben Greear <greearb@candelatech.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <84eb3a9d-5f94-1136-f94e-c04ff6b0d1b9@candelatech.com>
Organization: Candela Technologies
Message-ID: <1f667b64-0360-ecef-0de0-79810a2f096c@candelatech.com>
Date:   Fri, 30 Jul 2021 15:23:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <84eb3a9d-5f94-1136-f94e-c04ff6b0d1b9@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1627683784-LxibXajwSqqz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 12:29 PM, Ben Greear wrote:
> Hello,
> 
> I'm seeing this warning often right after/during boot, but not always.
> I am pretty sure this is not some regression I've added to my tree, but
> of course that is possible.
> 
> If someone has already got a fix for this or debugged it, please let me know.

Root cause of this was mt7915 driver, a fix has been posted...

Thanks,
Ben

