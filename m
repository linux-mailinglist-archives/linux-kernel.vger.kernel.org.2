Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859C5320AAB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBUNtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:49:46 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34767 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhBUNtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:49:45 -0500
Received: from [192.168.1.176] (dynamic-078-055-128-098.78.55.pool.telefonica.de [78.55.128.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 507A22064792E;
        Sun, 21 Feb 2021 14:49:03 +0100 (CET)
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Alexander Monakov <amonakov@ispras.ru>,
        Joerg Roedel <joro@8bytes.org>
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com>
 <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru>
 <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
 <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
 <b01994db-da9b-d8e6-e0c1-1af35dd62191@amd.com>
 <alpine.LNX.2.20.13.2009172052480.29869@monopod.intra.ispras.ru>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <23d42e73-91ac-8f47-af64-40edff8bc027@molgen.mpg.de>
Date:   Sun, 21 Feb 2021 14:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2009172052480.29869@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Suravee,


Am 17.09.20 um 19:55 schrieb Alexander Monakov:
> On Tue, 16 Jun 2020, Suravee Suthikulpanit wrote:
> 
>>>> Instead of blindly moving the code around to a spot that would just work,
>>>> I am trying to understand what might be required here. In this case,
>>>> the init_device_table_dma()should not be needed. I suspect it's the IOMMU
>>>> invalidate all command that's also needed here.
>>>>
>>>> I'm also checking with the HW and BIOS team. Meanwhile, could you please
>>>> give
>>>> the following change a try:
>>> Hello. Can you give any update please?

[…]

>> Sorry for late reply. I have a reproducer and working with the HW team to
>> understand the issue.
>> I should be able to provide update with solution by the end of this week.
> 
> Hello, hope you are doing well. Has this investigation found anything?

I am wondering the same. It’d be great to have this fixed in the 
upstream Linux kernel.


Kind regards,

Paul
