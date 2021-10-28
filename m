Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0085843D8B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 03:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJ1BmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 21:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhJ1BmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:42:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D71ED610FD;
        Thu, 28 Oct 2021 01:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635385192;
        bh=ytYQeufNPmG0y/a7R9lsQ0yU6nEE5eEZ2Wb9wHEiiFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdUELk9U5B1lJTOjXGuJ9uu74yoFOnUZFbrzb98STR8X0hzIx7JGTyYPkQeOSQZGR
         6nqT2QzHY4DH6/qXVPq6G+DZ1h3De+EuAdlBpNq7R1Y3gxi06hkRPJcpRPRR/gV3/d
         n1/98h4OStSUXhJXSDL92WfW++8m+0b0NDx65oDD3h7gKwKSBo1gBVMojw9KM0vDKb
         0s1h5uwE5O0AeALvrNizx8kB1dLFWrR+mV9og/edXIjD0kBgNYT7pis2XVA5LvOG49
         /0gURT4fK+mvS3BCRzAoiyGHglYQ9nniqawI+DCJTcqBj3T/KVp59JMMs0yU/pF0Z+
         vmTRPj77pxT/w==
Date:   Wed, 27 Oct 2021 21:39:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Anton Lundin <glance@acc.umu.se>,
        openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Openipmi-developer] Issue with panic handling and ipmi
Message-ID: <YXn/ZnlgXp6iuWLJ@sashalap>
References: <20210917101419.GE108031@montezuma.acc.umu.se>
 <20210917120758.GA545073@minyard.net>
 <20210917125525.GF108031@montezuma.acc.umu.se>
 <20210917131916.GB545073@minyard.net>
 <20210917132648.GG108031@montezuma.acc.umu.se>
 <20210920113802.GC545073@minyard.net>
 <20210920141231.GH108031@montezuma.acc.umu.se>
 <20210920144146.GD545073@minyard.net>
 <YXmTbYhFvDJ0m5KX@sashalap>
 <20211027182027.GG2744412@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211027182027.GG2744412@minyard.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 01:20:27PM -0500, Corey Minyard wrote:
>On Wed, Oct 27, 2021 at 01:59:09PM -0400, Sasha Levin wrote:
>> On Mon, Sep 20, 2021 at 09:41:46AM -0500, Corey Minyard wrote:
>> > On Mon, Sep 20, 2021 at 04:12:31PM +0200, Anton Lundin wrote:
>> > > On 20 September, 2021 - Corey Minyard wrote:
>> > >
>> > > > Well, that was dumb.  Fix follows...
>> > > >
>> > > > Thanks for working on this.  On your approval, I'll send this to Linus.
>> > >
>> > > Winner winner chicken dinner!
>> > >
>> > > This fixes the issue, and now panic timer works, and we get crashdumps
>> > > to pstore.
>> > >
>> > > Great job, I approve!
>> > >
>> > >
>> > > Thanks for your help getting this fixed.
>> >
>> > Thanks for reporting this.  I'll get the patch in.
>>
>> Hey Corey,
>>
>> Just checking in to see if this patch was lost; I haven't seen it in
>> Linus's tree just yet.
>
>I generally wait until the merge window for changes.  It's too late in
>the process for a patch now unless it's really critical.
>
>rc7 is out now, the merge window should be opening soon.

Ah, great. I thought it would go in via one of the -rc releases given
it's a fix.

Thank you!

-- 
Thanks,
Sasha
