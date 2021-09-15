Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7940C9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhIOQNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhIOQNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:13:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3237C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5GMpr0nwj9BDuXZAOLebAWNyAgkX4q5XFQCx3cBvq7w=;
        t=1631722346; x=1632931946; b=SSf5bsEwJPdgw5sjcsyNUTlYE2w5ds4MyRcdOXRTTlKydO/
        utgtx6ANr1KkMcjfooRw82LApwKLvrTpLott3NlR7qVgx69a1BEPkOT6R/wD6caKSFf9sE/U4jc+m
        yWpkqQeuoRdyY93ZgwqHg6PtQsnl+m0d8m12YWRtnYc9gzuihK47YQA5DuTGzMv2YW1PPWdFJg2kZ
        bqK8VPGIViNxZxO0tfmn6ZhLx81FmuXP5w34+2hzMUIxzCe0vsye3xOiw8ahBJiVjr/kzCflakUAm
        xUfA8iJjqqC5FrH1HRIs+5WCWQapfOV+zc2BbyhUe/KM+E2o9dicF+BU0A1rDULA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mQXWK-007NTi-2S;
        Wed, 15 Sep 2021 18:12:24 +0200
Message-ID: <86f8da0a8e54f7f6a988182dfb67857f45b13898.camel@sipsolutions.net>
Subject: Re: Reminder: Voting procedures for the Linux Foundation Technical
 Advisory Board
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Laura Abbott <laura@labbott.name>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
Date:   Wed, 15 Sep 2021 18:12:23 +0200
In-Reply-To: <1efba77b-965f-62cc-8f80-1e2b0a4f5c2a@labbott.name>
References: <fccbdadc-a57a-f6fe-68d2-0fbac2fd6b81@labbott.name>
         <b90db9e7-9b6b-c415-d087-3505ba0be0d6@labbott.name>
         <YUH+DO5aHWGVdNb7@pendragon.ideasonboard.com>
         <dc45975a-86df-a70d-ff15-58a3bdcf09ee@labbott.name>
         <6db59b8a4874b60cab7069fd06d180c2601bb427.camel@sipsolutions.net>
         <1efba77b-965f-62cc-8f80-1e2b0a4f5c2a@labbott.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-15 at 12:11 -0400, Laura Abbott wrote:
> 
> You should only request a ballot if you think you have between
> 3-49 commits. I agree this is a bit confusing and this should
> have been worded better and we'll make sure to do better next
> year.

Oh, I think this was clear - but someone might e.g. have 60 commits
spread between multiple email addresses, and not be sure how you
counted, etc.

johannes

