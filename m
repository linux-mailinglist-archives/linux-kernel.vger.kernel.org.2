Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D21324554
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhBXUgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:36:51 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:37893 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234741AbhBXUgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:36:43 -0500
Received: from [192.168.0.5] (ip5f5aed0a.dynamic.kabel-deutschland.de [95.90.237.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6F2AB206446A2;
        Wed, 24 Feb 2021 21:35:59 +0100 (CET)
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
 <23d42e73-91ac-8f47-af64-40edff8bc027@molgen.mpg.de>
 <290635dc-723e-a55e-8447-95cef703b090@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <28294d78-3987-e47d-3609-d36dd2e993d1@molgen.mpg.de>
Date:   Wed, 24 Feb 2021 21:35:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <290635dc-723e-a55e-8447-95cef703b090@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Suravee,


Thank you for your reply.


Am 22.02.21 um 18:59 schrieb Suravee Suthikulpanit:
> This fix has been accepted in the upstream recently.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=x86/amd 

Indeed. Linux pulled also pulled this [1].

> Could you please give this a try?

Yes, I did give it a try, but, unfortunately, the problem is unfixed. I 
commented on the Linux Bugzilla bug report #201753 [1].


Kind regards,

Paul


PS: It’d be great if you didn’t top post, and used interleaved style for 
responses.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=201753
      "AMD-Vi: Unable to write to IOMMU perf counter"
