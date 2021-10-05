Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9418D4227AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhJENWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhJENW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:22:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626FC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:20:39 -0700 (PDT)
Received: from [IPV6:2804:14c:137:85b2:dfef:cce1:3539:7b45] (unknown [IPv6:2804:14c:137:85b2:dfef:cce1:3539:7b45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: padovan)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 812321F43A9B;
        Tue,  5 Oct 2021 14:20:36 +0100 (BST)
Message-ID: <ad9e9763-8345-1a6f-f138-73cd4d8a7458@collabora.com>
Date:   Tue, 5 Oct 2021 10:20:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [kernelci-members] KernelCI working group: Web Dashboard
Content-Language: en-US
From:   Gustavo Padovan <gustavo.padovan@collabora.com>
To:     kernelci-members@groups.io
Cc:     "kernelci@groups.io" <kernelci@groups.io>,
        automated-testing@lists.yoctoproject.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci-tsc@groups.io" <kernelci-tsc@groups.io>
Reply-To: kernelci-members@groups.io
References: <1695B2FF4ECA569A.21772@groups.io>
Organization: Collabora Ltd.
In-Reply-To: <1695B2FF4ECA569A.21772@groups.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/21 13:34, Gustavo Padovan wrote:
> Hi Greg,
>
> On Tuesday, July 27, 2021 12:58 -03, "Greg KH" <gregkh@linuxfoundation.org> wrote:
>
>> On Tue, Jul 27, 2021 at 04:54:46PM +0100, Guillaume Tucker wrote:
>>> Last year's KernelCI Community Survey[1] showed the importance of
>>> having a good web dashboard.  About 70% of respondents would use
>>> one if it provided the information they needed efficiently.
>>> While other things are arguably even more important, such as
>>> testing patches from mailing lists, replying to stable reviews
>>> and sending email reports directly to contributors in a "natural"
>>> workflow, the web dashboard has been a sticking point for a
>>> while.
>>>
>>> There have been several attempts at solving this problem, using
>>> Elastic Stack and Grafana among other things, but there isn't a
>>> single framework able to directly provide an off-the-shelf
>>> solution to the community's needs.  In fact, the first issue is
>>> the lack of understanding of these needs: who wants to use the
>>> web dashboard, and how?  Then, how does one translate those needs
>>> into a user interface?  Doing this requires skills that engineers
>>> who regularly contribute to KernelCI typically don't have.  As
>>> such, a dedicated working group is being created in order to fill
>>> this gap.
>>>
>>> The aim is to coordinate efforts and try to follow best practices
>>> to make steady progress and avoid repeating the same mistakes.
>>> Most likely, we will need some help from proper web developers
>>> who aren't part of the usual KernelCI community.  This may be
>>> facilitated by the KernelCI LF project budget if approved by the
>>> governing board.
>>>
>>> In order to get started, we would need to have maybe 3 to 5
>>> people available to focus on this.  It doesn't necessarily mean a
>>> lot of hours spent but actions to be carried out on a daily or
>>> weekly basis.  So far we have Gustavo Padovan as our new KernelCI
>>> Project Manager and a few people have expressed interest but we
>>> still need formal confirmation.
>>>
>>>
>>> Here's a GitHub project dedicated to the new web dashboard:
>>>
>>>    https://github.com/orgs/kernelci/projects/4
>>>
>>> I've created a couple of issues to get started about user
>>> stories, and some initial milestones as a basic skeleton:
>>>
>>>    https://github.com/kernelci/kernelci-project/milestones
>>>
>>>
>>> This is ultimately a community-driven effort to address the needs
>>> of the kernel community.  Please share any thoughts you may have
>>> on this, whether you want to add some user stories, share some
>>> expertise, be officially in the working group or take part in
>>> this effort in any other way.
>> How do we "join" the working group?  I'm willing to help out from the
>> "user who will use this a lot and complain about things that do not
>> work well" point of view :)
> Congratulations! You are now part of the working group. :) For now, anyone that is interested can step up, and maybe in a few weeks we can formalize with those who wants to take on the journey together with us in this working group.
>
> Based on the replies to this thread I can put together an initial agenda and follow up with the potential times for a kick-off meeting.

Here's a poll with some proposed times for us to schedule the first 
meeting next week: https://doodle.com/poll/pbhpeu5cbxp49ghz

Please reply to it ASAP.

Regards,

Gustavo

