Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59D43D031
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbhJ0SBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233651AbhJ0SBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4369B60F92;
        Wed, 27 Oct 2021 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635357555;
        bh=HQ+IZGHNYxOehvG0a9COxhhADZqU0Z/4UL+e4i3hi6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1mfUrSf5O+OArXxcIo4WLYza6v4oz8s4xzCKCVBOiQNwWxbeoRcKRwZbEYEyirv+
         Y6lqKHJDLlpnhuxfvsUfaF333R4ULwPjyhCXByg7m0qc4ayjFsk3XNxUOQVJV0dD48
         CkLe8K2xSfiHVVInrtxNwobeUb+bNRQJt234yz4rQbRgdDnNxzXSR/+6uCnXvO113Z
         7Fmmytqfjq6Qpkp6Z/i7i4U4Xt1Z+o/VM1/aJBzMFCT7O9/EsOWb4wHdo3erpWzRyh
         n3XZuYZJEde7KcaqPCzy0Y3W7uWj+RJBFPJXiqODXA5ez8/oG0IKjeGSP+kxJuqgYQ
         v3RP3EgLpcOWg==
Date:   Wed, 27 Oct 2021 13:59:09 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Anton Lundin <glance@acc.umu.se>,
        openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Openipmi-developer] Issue with panic handling and ipmi
Message-ID: <YXmTbYhFvDJ0m5KX@sashalap>
References: <20210916145300.GD108031@montezuma.acc.umu.se>
 <20210916163945.GY545073@minyard.net>
 <20210917101419.GE108031@montezuma.acc.umu.se>
 <20210917120758.GA545073@minyard.net>
 <20210917125525.GF108031@montezuma.acc.umu.se>
 <20210917131916.GB545073@minyard.net>
 <20210917132648.GG108031@montezuma.acc.umu.se>
 <20210920113802.GC545073@minyard.net>
 <20210920141231.GH108031@montezuma.acc.umu.se>
 <20210920144146.GD545073@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210920144146.GD545073@minyard.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 09:41:46AM -0500, Corey Minyard wrote:
>On Mon, Sep 20, 2021 at 04:12:31PM +0200, Anton Lundin wrote:
>> On 20 September, 2021 - Corey Minyard wrote:
>>
>> > Well, that was dumb.  Fix follows...
>> >
>> > Thanks for working on this.  On your approval, I'll send this to Linus.
>>
>> Winner winner chicken dinner!
>>
>> This fixes the issue, and now panic timer works, and we get crashdumps
>> to pstore.
>>
>> Great job, I approve!
>>
>>
>> Thanks for your help getting this fixed.
>
>Thanks for reporting this.  I'll get the patch in.

Hey Corey,

Just checking in to see if this patch was lost; I haven't seen it in
Linus's tree just yet.

-- 
Thanks,
Sasha
