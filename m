Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40DC40C79D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhIOOlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhIOOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:41:05 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE26AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1631716786;
        bh=sHaOiUjejnIRpE9+LJyb3LmvDC0jUxuT7LHMj6pfSmI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WI09caynJKDyVqCXNm6RO9SQu8Pq4znXD2nctw/XD4lZo3BcTHEPMlIlkhSUYNzrT
         B/3tTyCCTw7GMPdafa72riiRowFkrw6zdglo2tlXvO8hlM+JgqLzVPZQTFndy7vj+0
         RpvELGsygrGNzQ+vE/ZgFtRQfa9fJOSd0z068Dv8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 34660128012D;
        Wed, 15 Sep 2021 07:39:46 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N0mWLoY_hpV2; Wed, 15 Sep 2021 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1631716786;
        bh=sHaOiUjejnIRpE9+LJyb3LmvDC0jUxuT7LHMj6pfSmI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WI09caynJKDyVqCXNm6RO9SQu8Pq4znXD2nctw/XD4lZo3BcTHEPMlIlkhSUYNzrT
         B/3tTyCCTw7GMPdafa72riiRowFkrw6zdglo2tlXvO8hlM+JgqLzVPZQTFndy7vj+0
         RpvELGsygrGNzQ+vE/ZgFtRQfa9fJOSd0z068Dv8=
Received: from jarvis.lan (c-67-166-170-96.hsd1.va.comcast.net [67.166.170.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4A8D01280127;
        Wed, 15 Sep 2021 07:39:45 -0700 (PDT)
Message-ID: <eb487cc71d0f9f93c29b8eb9fa93d1169257757e.camel@HansenPartnership.com>
Subject: Re: Reminder: Voting procedures for the Linux Foundation Technical
 Advisory Board
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Laura Abbott <laura@labbott.name>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
Date:   Wed, 15 Sep 2021 10:39:43 -0400
In-Reply-To: <dc45975a-86df-a70d-ff15-58a3bdcf09ee@labbott.name>
References: <fccbdadc-a57a-f6fe-68d2-0fbac2fd6b81@labbott.name>
         <b90db9e7-9b6b-c415-d087-3505ba0be0d6@labbott.name>
         <YUH+DO5aHWGVdNb7@pendragon.ideasonboard.com>
         <dc45975a-86df-a70d-ff15-58a3bdcf09ee@labbott.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-15 at 10:36 -0400, Laura Abbott wrote:
> On 9/15/21 10:07, Laurent Pinchart wrote:
> > Hi Laura,
> > 
> > On Wed, Sep 15, 2021 at 09:58:32AM -0400, Laura Abbott wrote:
> > > On 9/9/21 12:49, Laura Abbott wrote:
> > > > Hi,
> > > > 
> > > > Reminder that the Linux Foundation Technical Advisory Board
> > > > (TAB) annual
> > > > election will be held virtually during the 2021 Kernel Summit
> > > > and Linux
> > > > Plumbers Conference. Voting will run from September 20th to
> > > > September
> > > > 23rd 16:00 GMT-4 (US/Eastern). The voting criteria for the 2021
> > > > election
> > > > are:
> > > > 
> > > > There exist three kernel commits in a mainline or stable
> > > > released
> > > > kernel that both
> > > > - Have a commit date in the year 2020 or 2021
> > > > - Contain an e-mail address in one of the following tags or
> > > > merged
> > > > tags (e.g. Reviewed-and-tested-by)
> > > > -- Signed-off-by
> > > > -- Tested-by
> > > > -- Reported-by
> > > > -- Reviewed-by
> > > > -- Acked-by
> > > > 
> > > > If you have more than 50 commits that meet this requirement you
> > > > will
> > > > receive a ballot automatically.
> > > > 
> > > > If you have between 3 and 49 commits that meet this requirement
> > > > please
> > > > e-mail tab-elections@lists.linuxfoundation.org to request your
> > > > ballot.
> > > > We strongly encourage everyone who meets this criteria to
> > > > request a
> > > > ballot.
> > > > 
> > > > We will be using Condorcet Internet Voting
> > > > Service (CIVS) https://civs1.civs.us/ . This is a voting
> > > > service
> > > > focused on security and privacy. There are sample polls on the
> > > > website if you would like to see what a ballot will look like.
> > > > 
> > > > If you have any questions please e-mail
> > > > tab-elections@lists.linuxfoundation.org.
> > > > 
> > > > Thanks,
> > > > Laura
> > > > 
> > > > P.S. Please also consider this another reminder to consider
> > > > running for
> > > > the TAB as well
> > > 
> > > Final reminder: please remember to request your ballot for the
> > > TAB
> > > elections. If you know others who are eligible please encourage
> > > them to request a ballot as well.
> > 
> > When are the ballots supposed to be sent ? It would be nice to
> > avoid
> > requiring everybody to check whether they're below or above the 50
> > commits threshold manually :-)
> > 
> 
> The ballots will be sent sometime after Monday September 20th
> 9:00am GMT-4 (US/Eastern).
> 
> I did make an attempt to send e-mails to the > 50 commits individuals
> but there is a chance my e-mail got eaten by spam filters or just
> didn't get sent out. I discovered Google Apps' e-mail limits and
> that you should not attempt to bcc too many people. This is something
> I'd like to handle in a more automated fashion next year to make
> it easier for both voters and those running the elections.

You're welcome to my bulk email scripts I use for Plumbers.  They
*should* work with any SMTP server but, obviously, I've only tested
them with my hansenpartnership.com one.

James


