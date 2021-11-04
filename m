Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB68445B95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 22:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhKDVVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 17:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhKDVVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 17:21:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA7C061714;
        Thu,  4 Nov 2021 14:18:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::e2d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C44B166B3;
        Thu,  4 Nov 2021 21:18:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C44B166B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1636060703; bh=m04wQGZL6NYoYduVGJGOPPPUdZd6dcd+aEuYMF8QdkM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OMAMDb52R3ZRZobeTdVD93uoZq6kmxS6osp7FCeWih+U5biyTWTI/ylEFPQ42ukus
         rVzxQV+18NC7lHzTvGNCCT5epvWMmCUfJkP2qff+xuVwl5JsbSGM6xmVbjAQVEOJIP
         6z/MimIMyjTGRs5pa923FyAy6S8pT8/xdWMn7XzO/rJY241EIHy1utI6mFKKY6pz5C
         SbR+DW9IS+qFt0t+Or+rH/6iYdcuwGCOp4X28x9RkIn9JoU7vcAerfnHdX7+dbsd9b
         PqyWEvyvQlk+0Ie13BlV42xX3SVyOM/DP7ensLxs2KiZTC8N0X9dDxUTNBSqnREGyW
         a1doUos494WMw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/10] user_events: Add documentation file
In-Reply-To: <20211104210809.GA2486@kbox>
References: <20211104170433.2206-1-beaub@linux.microsoft.com>
 <20211104170433.2206-11-beaub@linux.microsoft.com>
 <8735obrbao.fsf@meer.lwn.net> <20211104210809.GA2486@kbox>
Date:   Thu, 04 Nov 2021 15:18:23 -0600
Message-ID: <87tugrpqlc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beau Belgrave <beaub@linux.microsoft.com> writes:

> On Thu, Nov 04, 2021 at 01:05:51PM -0600, Jonathan Corbet wrote:
>> Examples are great, but they are best placed under samples/ (or tools/
>> if they do something useful) where readers can build and run them.
>> 
> Ok, sounds good. Is it fine to include user mode samples in there? I
> quickly checked and most appear to be modules. Maybe there is a better
> place for user mode examples?

User-mode stuff is fine - at least, *I* don't object to it! :)

Thanks,

jon
