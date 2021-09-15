Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F063240C711
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbhIOOI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhIOOI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:08:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:07:37 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 135A324F;
        Wed, 15 Sep 2021 16:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1631714855;
        bh=B8sNMjsHWO2IS+i3QosGmRifQg8fEZRXQepBTDac2/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XpvMqI/UTMMHAwmBR9vV2eV6IS6WJOm28kYOjewogfTwNWPS1Ux8VzmB7ATyavbZo
         +W6q2mTZ2MJxF23M1tylPYHvK3X8byuRZOimCHxAtIJct8cpvIK2C20CigT74/uhcr
         pCOiQwhe3J3rvKJWM8ydaLoLkH3O+NodLitREth0=
Date:   Wed, 15 Sep 2021 17:07:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Laura Abbott <laura@labbott.name>
Cc:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
Subject: Re: Reminder: Voting procedures for the Linux Foundation Technical
 Advisory Board
Message-ID: <YUH+DO5aHWGVdNb7@pendragon.ideasonboard.com>
References: <fccbdadc-a57a-f6fe-68d2-0fbac2fd6b81@labbott.name>
 <b90db9e7-9b6b-c415-d087-3505ba0be0d6@labbott.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b90db9e7-9b6b-c415-d087-3505ba0be0d6@labbott.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Wed, Sep 15, 2021 at 09:58:32AM -0400, Laura Abbott wrote:
> On 9/9/21 12:49, Laura Abbott wrote:
> > Hi,
> > 
> > Reminder that the Linux Foundation Technical Advisory Board (TAB) annual
> > election will be held virtually during the 2021 Kernel Summit and Linux
> > Plumbers Conference. Voting will run from September 20th to September
> > 23rd 16:00 GMT-4 (US/Eastern). The voting criteria for the 2021 election
> > are:
> > 
> > There exist three kernel commits in a mainline or stable released
> > kernel that both
> > - Have a commit date in the year 2020 or 2021
> > - Contain an e-mail address in one of the following tags or merged
> > tags (e.g. Reviewed-and-tested-by)
> > -- Signed-off-by
> > -- Tested-by
> > -- Reported-by
> > -- Reviewed-by
> > -- Acked-by
> > 
> > If you have more than 50 commits that meet this requirement you will
> > receive a ballot automatically.
> > 
> > If you have between 3 and 49 commits that meet this requirement please
> > e-mail tab-elections@lists.linuxfoundation.org to request your ballot.
> > We strongly encourage everyone who meets this criteria to request a
> > ballot.
> > 
> > We will be using Condorcet Internet Voting
> > Service (CIVS) https://civs1.civs.us/ . This is a voting service
> > focused on security and privacy. There are sample polls on the
> > website if you would like to see what a ballot will look like.
> > 
> > If you have any questions please e-mail 
> > tab-elections@lists.linuxfoundation.org.
> > 
> > Thanks,
> > Laura
> > 
> > P.S. Please also consider this another reminder to consider running for
> > the TAB as well
> 
> Final reminder: please remember to request your ballot for the TAB
> elections. If you know others who are eligible please encourage
> them to request a ballot as well.

When are the ballots supposed to be sent ? It would be nice to avoid
requiring everybody to check whether they're below or above the 50
commits threshold manually :-)

-- 
Regards,

Laurent Pinchart
