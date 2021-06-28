Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28F13B6698
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhF1QXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhF1QW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:22:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A7EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:20:30 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d5so13960930qtd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U7fXfGjadiL8isA1UEbZJYGUjr2KdPxa22wtkL8fYR8=;
        b=pV/7OfUk02PcQ9bRleE0yLppYhvY69BgBt3SYvAB8mVKwWVMQTt06R5K+RJBTaIa1b
         AO8oZ8+tFiC/covbKoFFlk4EKvVS/69aQChB4/LTkWHpmfJwYlFLRYvHxwSd3nN3lXr9
         X2OkcJFRvQCDfJIqAc1FRBF7rI/cagrbGCIYTFW6pt7tV3HW+we7cKBrFajqi1xzD7uS
         8iyg4Vl3R24D2FA+RkQgX4zZlr5g9D28gZZnLkh3+VcIW0ynNfXJpwZOoXhLoBpq+N91
         Mr1Mo92oJq3BEVbQRQFgw1S+LRzCj1U6hPfjQ5CWrLI1FF+D2iUPUKuJNHTatFmE6VM3
         k36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U7fXfGjadiL8isA1UEbZJYGUjr2KdPxa22wtkL8fYR8=;
        b=DQnXv3JJJaIRdvnxPYRAytkkWd20foK3ci+rQ4RFRSnp5T4oZLJXbhT2It8lkbQR4w
         xrPZH5/X3SDKBS6pc+jxQZGRftK6oA3A51DiQF+oE96OFTbBEn99XBZ+dqJcMGaXywdr
         dI4fH8rEedE7B4ejmj4yxjVbfvA/TF+K9Ol1mLQJA7R1a50ZLnUOytarIYenBkXHsk6U
         5izPxgmtEHP8JOhGvJA+ApZgx+naPj91dSATCrYRdg/YFxr+Rc/u9d2/1kW8Eg4oXs5G
         SzO/0zZhcTVZkCw4q271iYDsV2elwcAwMRxKmgYWG20QGhZ5S9jS4IPmy/9w+/nIP24R
         3WZQ==
X-Gm-Message-State: AOAM530kl6SMbmxdIRj5ZjiYR1QTeRl+CUZfXv2ocMD9sXCRu/1Lld9t
        6OM98EFwrN68dVcOwXJFOH8zjw==
X-Google-Smtp-Source: ABdhPJz9oN20ohmo1SYUNEJ984SoicNirF9kNToTI6f84nkXK3d/W9hgY6gqGE1GH+r5u9CFQGCmSg==
X-Received: by 2002:a05:622a:14d3:: with SMTP id u19mr22192270qtx.115.1624897229575;
        Mon, 28 Jun 2021 09:20:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id t139sm10262947qka.85.2021.06.28.09.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 09:20:28 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lxtzn-000emj-68; Mon, 28 Jun 2021 13:20:27 -0300
Date:   Mon, 28 Jun 2021 13:20:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Benjamin LaHaise <ben@communityfibre.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: linux-mm@kvack.org - limping on a backup
Message-ID: <20210628162027.GC4604@ziepe.ca>
References: <20210622145954.GA4058@kvack.org>
 <214c41fae1f1b148e5b04a58c1b018fb091d7e83.camel@HansenPartnership.com>
 <20210625171259.GG4058@kvack.org>
 <6f309c63f5b7be968ae679e81ab959db05681e8a.camel@HansenPartnership.com>
 <20210625192607.GH4058@kvack.org>
 <20210628134607.GA4604@ziepe.ca>
 <20210628135352.GL4058@kvack.org>
 <20210628142659.GB4604@ziepe.ca>
 <20210628144051.GM4058@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628144051.GM4058@kvack.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 10:40:51AM -0400, Benjamin LaHaise wrote:
> On Mon, Jun 28, 2021 at 11:26:59AM -0300, Jason Gunthorpe wrote:
> > Isn't a 7-bit conversion what I pointed at last time we talked about
> > this?
> 
> I changed several options in postfix last time this was raised, but as
> nobody ever provided a test case, I had no way of knowing if it worked or
> not.

I've been using a script like this against the lore public inbox git
repos to monitor my own domain's dkim cleanness and interaction with
list serves:

#!/usr/bin/python3
import subprocess
import collections

# Starting points
start = XXXXX # git commit id string

emails = collections.defaultdict(list)
commits = subprocess.check_output(["git","log","master","^" + start,'--pretty=format:%H %aN <%aE>']).decode()
for ln in commits.splitlines():
    commit,_,email = ln.partition(' ')
    if "nvidia.com" in email.lower():
        emails[email].append(commit)

fails = set()
not_empty = True;
while not_empty:
    not_empty = False;
    for email,commits in sorted(emails.items()):
        if email in fails or not commits:
            continue
        commit = commits[-1];
        del commits[-1]
        if commits:
            not_empty = True;
        msg = subprocess.check_output(["git","show",commit + ":m"]);
        try:
            subprocess.check_output(["dkimverify"], input=msg);
            #print(email)
        except:
            fails.add(email)
            print("Failed!", email, commit)

It has taken a lot of doing, but nvidia.com is now effectively DKIM
clean through vger.

You could run with with some known-good domains like nvidia.com,
facebook.com, google.com, to measure kvack's activity. Failures can
often be cross-correlated against a vger list and then you can do A/B
comparison to guess what is wrong.

> spec that ignores decades of that philosophy at the IETF.  And even if a
> DKIM signature passes, that's still not enough to trust the resulting
> email.  All it does is ensure that a small subset of valid emails get
> dropped on the floor.  This doesn't seem like an overall win.

I have no idea. It is here, people beyond us have made this decision,
we have to work within it. DMARC is ratcheting this up and is moving
to say if DKIM fails then emails should be discared.

Jason
