Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556E40C8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbhIOPvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhIOPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:51:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C46C061787
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Wh5enwv0q3T6plDf5AFiVoXl9LkOcmja36omfE/zBKQ=;
        t=1631720977; x=1632930577; b=bLS3q7GzzAWgU1QtSnTgxXn3mWVnIc/ar8ivDShdBlX/631
        ARsgutIKdiE1aCxGaztxxzQ7EeGypnFDnPn115pb2c6bJL3Xkz3X0kfYuvbRt6tgadXYv1orP/y8C
        uIAv/k2UxNskoiLIITjLnxSRKV2bLC5+VMeburDgOqsFDVeyQ1cDJhzJsUlf7pbsK/EejUT6+hKWY
        MB1xCEy+FdgLSq47holXUl4M/aeoxHdzeHMeDc+e4km4V1SMCdAtd5qAj7z6rTcxMqivjoyjSl8pv
        adHUznQ9gwUNfTnVOvF3Q8rFRB4p9HR14wfsjnXJ80zMQ8KFb6Hz8mHXt+2gGQAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mQXAD-007MvQ-HC;
        Wed, 15 Sep 2021 17:49:33 +0200
Message-ID: <6db59b8a4874b60cab7069fd06d180c2601bb427.camel@sipsolutions.net>
Subject: Re: Reminder: Voting procedures for the Linux Foundation Technical
 Advisory Board
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Laura Abbott <laura@labbott.name>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
Date:   Wed, 15 Sep 2021 17:49:32 +0200
In-Reply-To: <dc45975a-86df-a70d-ff15-58a3bdcf09ee@labbott.name>
References: <fccbdadc-a57a-f6fe-68d2-0fbac2fd6b81@labbott.name>
         <b90db9e7-9b6b-c415-d087-3505ba0be0d6@labbott.name>
         <YUH+DO5aHWGVdNb7@pendragon.ideasonboard.com>
         <dc45975a-86df-a70d-ff15-58a3bdcf09ee@labbott.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-15 at 10:36 -0400, Laura Abbott wrote:
> 
> I did make an attempt to send e-mails to the > 50 commits individuals

So if we got the "look for your ballot" email from you, that means we're
on the list?

I agree with Laurent, it's a bit confusing now to figure out whether we
should request or not, and if we have to request before the automated
ones are sent out, we can't wait for that either.

I'm sure I'm on the list, but I guess others aren't quite so sure.

johannes

