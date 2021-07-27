Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC63D7B05
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhG0QeJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jul 2021 12:34:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54834 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhG0QeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:34:08 -0400
Received: from chickenburger.collabora.co.uk (chickenburger.collabora.co.uk [46.235.227.242])
        by bhuna.collabora.co.uk (Postfix) with ESMTP id ADDCE1F42BAF;
        Tue, 27 Jul 2021 17:34:06 +0100 (BST)
From:   "Gustavo Padovan" <gustavo.padovan@collabora.com>
In-Reply-To: <YQAtNc4R1K3o6rxb@kroah.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 2804:14c:137:85b2:d6c3:aadf:21b3:ca4b
Date:   Tue, 27 Jul 2021 17:34:06 +0100
Cc:     "kernelci@groups.io" <kernelci@groups.io>,
        automated-testing@lists.yoctoproject.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci-tsc@groups.io" <kernelci-tsc@groups.io>
To:     kernelci-members@groups.io
MIME-Version: 1.0
Message-ID: <3cea-61003580-1-23f95f80@24125827>
Subject: =?utf-8?q?Re=3A?= [kernelci-members] KernelCI working =?utf-8?q?group=3A?= 
 Web Dashboard
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
 
On Tuesday, July 27, 2021 12:58 -03, "Greg KH" <gregkh@linuxfoundation.org> wrote: 
 
> On Tue, Jul 27, 2021 at 04:54:46PM +0100, Guillaume Tucker wrote:
> > Last year's KernelCI Community Survey[1] showed the importance of
> > having a good web dashboard.  About 70% of respondents would use
> > one if it provided the information they needed efficiently.
> > While other things are arguably even more important, such as
> > testing patches from mailing lists, replying to stable reviews
> > and sending email reports directly to contributors in a "natural"
> > workflow, the web dashboard has been a sticking point for a
> > while.
> > 
> > There have been several attempts at solving this problem, using
> > Elastic Stack and Grafana among other things, but there isn't a
> > single framework able to directly provide an off-the-shelf
> > solution to the community's needs.  In fact, the first issue is
> > the lack of understanding of these needs: who wants to use the
> > web dashboard, and how?  Then, how does one translate those needs
> > into a user interface?  Doing this requires skills that engineers
> > who regularly contribute to KernelCI typically don't have.  As
> > such, a dedicated working group is being created in order to fill
> > this gap.
> > 
> > The aim is to coordinate efforts and try to follow best practices
> > to make steady progress and avoid repeating the same mistakes.
> > Most likely, we will need some help from proper web developers
> > who aren't part of the usual KernelCI community.  This may be
> > facilitated by the KernelCI LF project budget if approved by the
> > governing board.
> > 
> > In order to get started, we would need to have maybe 3 to 5
> > people available to focus on this.  It doesn't necessarily mean a
> > lot of hours spent but actions to be carried out on a daily or
> > weekly basis.  So far we have Gustavo Padovan as our new KernelCI
> > Project Manager and a few people have expressed interest but we
> > still need formal confirmation.
> > 
> > 
> > Here's a GitHub project dedicated to the new web dashboard:
> > 
> >   https://github.com/orgs/kernelci/projects/4
> > 
> > I've created a couple of issues to get started about user
> > stories, and some initial milestones as a basic skeleton:
> > 
> >   https://github.com/kernelci/kernelci-project/milestones
> > 
> > 
> > This is ultimately a community-driven effort to address the needs
> > of the kernel community.  Please share any thoughts you may have
> > on this, whether you want to add some user stories, share some
> > expertise, be officially in the working group or take part in
> > this effort in any other way.
> 
> How do we "join" the working group?  I'm willing to help out from the
> "user who will use this a lot and complain about things that do not
> work well" point of view :)

Congratulations! You are now part of the working group. :) For now, anyone that is interested can step up, and maybe in a few weeks we can formalize with those who wants to take on the journey together with us in this working group.

Based on the replies to this thread I can put together an initial agenda and follow up with the potential times for a kick-off meeting.

Regards,

Gustavo

