Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249533D7A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbhG0Pyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:54:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53848 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhG0Pyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:54:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id A26C51F40AF7
To:     "kernelci@groups.io" <kernelci@groups.io>
Cc:     kernelci-members <kernelci-members@groups.io>,
        automated-testing@lists.yoctoproject.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci-tsc@groups.io" <kernelci-tsc@groups.io>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: KernelCI working group: Web Dashboard
Message-ID: <f3874e7d-ccfe-4a2d-d054-9b7bf9e8b44d@collabora.com>
Date:   Tue, 27 Jul 2021 16:54:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last year's KernelCI Community Survey[1] showed the importance of
having a good web dashboard.  About 70% of respondents would use
one if it provided the information they needed efficiently.
While other things are arguably even more important, such as
testing patches from mailing lists, replying to stable reviews
and sending email reports directly to contributors in a "natural"
workflow, the web dashboard has been a sticking point for a
while.

There have been several attempts at solving this problem, using
Elastic Stack and Grafana among other things, but there isn't a
single framework able to directly provide an off-the-shelf
solution to the community's needs.  In fact, the first issue is
the lack of understanding of these needs: who wants to use the
web dashboard, and how?  Then, how does one translate those needs
into a user interface?  Doing this requires skills that engineers
who regularly contribute to KernelCI typically don't have.  As
such, a dedicated working group is being created in order to fill
this gap.

The aim is to coordinate efforts and try to follow best practices
to make steady progress and avoid repeating the same mistakes.
Most likely, we will need some help from proper web developers
who aren't part of the usual KernelCI community.  This may be
facilitated by the KernelCI LF project budget if approved by the
governing board.

In order to get started, we would need to have maybe 3 to 5
people available to focus on this.  It doesn't necessarily mean a
lot of hours spent but actions to be carried out on a daily or
weekly basis.  So far we have Gustavo Padovan as our new KernelCI
Project Manager and a few people have expressed interest but we
still need formal confirmation.


Here's a GitHub project dedicated to the new web dashboard:

  https://github.com/orgs/kernelci/projects/4

I've created a couple of issues to get started about user
stories, and some initial milestones as a basic skeleton:

  https://github.com/kernelci/kernelci-project/milestones


This is ultimately a community-driven effort to address the needs
of the kernel community.  Please share any thoughts you may have
on this, whether you want to add some user stories, share some
expertise, be officially in the working group or take part in
this effort in any other way.

Best wishes,
Guillaume

[1] https://foundation.kernelci.org/blog/2020/07/09/kernelci-community-survey-report/
