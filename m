Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4CF3F4198
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 22:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhHVUzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 16:55:51 -0400
Received: from cloud48395.mywhc.ca ([173.209.37.211]:44420 "EHLO
        cloud48395.mywhc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbhHVUzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 16:55:50 -0400
Received: from modemcable064.203-130-66.mc.videotron.ca ([66.130.203.64]:57988 helo=[192.168.1.179])
        by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <olivier@trillion01.com>)
        id 1mHuUm-0001XV-30; Sun, 22 Aug 2021 16:55:08 -0400
Message-ID: <e4c296adcb7f0b1fb0cc0acc21c129761b6e2b90.camel@trillion01.com>
Subject: Re: [PATCH] kernel: make TIF_NOTIFY_SIGNAL and core dumps co-exist
From:   Olivier Langlois <olivier@trillion01.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Tony Battersby <tonyb@cybernetics.com>
Date:   Sun, 22 Aug 2021 16:55:06 -0400
In-Reply-To: <7fb2d8a6-951c-092c-ccaa-15522ae2ed01@kernel.dk>
References: <76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk>
         <CAHk-=wgBMNC1ePTgqM6f0iBH94KE5_oHQYD2sqCbjev0KaZ6Kw@mail.gmail.com>
         <7fb2d8a6-951c-092c-ccaa-15522ae2ed01@kernel.dk>
Organization: Trillion01 Inc
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-19 at 08:59 -0600, Jens Axboe wrote:
> 
> You're absolutely right. On the io_uring side, in the current tree,
> there's only one check where current != task being checked - and
> that's
> in the poll rewait arming. That one should likely just go away. It
> may
> be fine as it is, as it just pertains to ring exit cancelations. We
> want
> to ensure that we don't rearm poll requests if the process is
> canceling
> and going away. I'll take a closer look at that one.
> 
> For this particular patch, I agree it's racy. I'll see if I can come
> up
> with something better...
> 
I have finally found the patch that you wanted me to test. I'm going to
do it ASAP despite still having issue.

I do have a different approach to solve the same core dump issue.

Feel free to consider it if this can avoid the race condition described
here.


