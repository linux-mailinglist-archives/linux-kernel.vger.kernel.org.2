Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10C235B21D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 09:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhDKHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKHME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 03:12:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77D6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 00:11:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w18so11325354edc.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 00:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2qQvGefAL3tZBLWIdiPaSRZ11kwhfAk0FTUmJJmz+7E=;
        b=RQSnQoALgoCXIk9RjZ5W3aFKQkerS55uQa2t2nGSLXNLhsvtKU15ibjXcPJ2N73cE1
         H4xqS37sdGcIK3wJgyqBfhHOc/C2KiD6qM8XCM8k3NthZPRgwpbKBBKEFR+PfkYKtwfl
         uzokBoRcFQZ2ObHxxZ081SOQxCj2Qsa0exxnRyBJvuwc8Gn6PBJwzxKvWCIAsaxpohwB
         l7n6WvJOYtnRmTqWRou5dNvTSMB4QOvuwb5WMaEWvY9RdMs+NORtpLGF2XIq9VEmHkJF
         VML3hwHAedqqNKKW0md8GtGK1TiY9zllV0DHbXAYl57qNXQPU/DeHZyvnIEKeG7nXOda
         h0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2qQvGefAL3tZBLWIdiPaSRZ11kwhfAk0FTUmJJmz+7E=;
        b=iU8BCmeWBe9URGT96NTQ8U0DcsoltbssNQKdSPjC2JpAJyILf1Y/UzYFbZTrBmwAW6
         QWuhK2IG39EhDHqB/UQaPhgq6Xudva4Hoq3bg8pK5A1aZwv/ETrh7FFsLkQtUtxyWCOq
         c1OBZlF4omvjG65c47rq0HUWHzbg2DmsUoWMS0v28yHyEprD1uxtP8yesZTeuqrlzDJF
         mTWus3T34GFLfUA3SkF2+64Pvs1ryjWea20KGKFGDmOXUCAGD/fbq/7GLD0dDPO7coDo
         /j80+WuukbQt41z4CmfX1Vpqu7b71Qbrlt+4xWD+kl/ja5E+gKHEdIyigcR4QHZzPXcR
         oh4w==
X-Gm-Message-State: AOAM532UTrMNbmRtbXPrg9iOwIWJhq8u5VQI3wOL/2ODwget1qriS86X
        KelZ/Mcf8yirVBDOb2judjVAYAkmmt0Bqn/D
X-Google-Smtp-Source: ABdhPJyWGwQrhQF+znYNqCKR9hqmLGuMtoC2zDPwDf2yUKiG8RbahoPV516gqsXIvvb1RIzDbHzqkg==
X-Received: by 2002:a50:eb8f:: with SMTP id y15mr24682645edr.115.1618125105440;
        Sun, 11 Apr 2021 00:11:45 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id j7sm4199225edv.40.2021.04.11.00.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 00:11:44 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 0/5] staging: rtl8723bs: Change
Date:   Sun, 11 Apr 2021 09:11:43 +0200
Message-ID: <3154849.IkRRYng9eG@localhost.localdomain>
In-Reply-To: <YHKZlqFy15QC9Mzz@kroah.com>
References: <20210410150008.5460-1-fmdefrancesco@gmail.com> <YHKZlqFy15QC9Mzz@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 11, 2021 8:39:18 AM CEST Greg KH wrote:
> On Sat, Apr 10, 2021 at 05:00:03PM +0200, Fabio M. De Francesco wrote:
> > Remove camelcase, correct misspelled words in comments, remove an
> > unused
> > variable, change the type of a variable and its use, change comparisons
> > with 'true' in controlling expressions.
> > 
> > Changes from v1: Fix a typo in subject of patch 1/5, add patch 5/5.
> 
> The subject line above is very odd :(
>
True. I've just read the output of git format in /tmp and noticed that the 
line with the "subject" was broken in two different one. I think I had 
pressed return while editing.

I'm about to send that series again with v3.

In the while I noticed you sent a note to let me know that the you have  
added the patch titled "staging: rtl8723bs: core: Remove an unused 
variable" to your staging git tree. 

I think this could be a potential issue because the same patch is in the 
series that I have to send anew. I put that patch in the series because 
yesterday you wrote that the message with subject "Outreachy patches caught 
up on.", asking to rebase and resend.

However, I'm about to send v3 of this patchset. I have no idea whether or 
not you will have problems in applying that. If you have problems with it, 
please let me know.

Thanks,

Fabio



