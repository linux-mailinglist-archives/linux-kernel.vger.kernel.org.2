Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B93BD8AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhGFOqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhGFOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:45:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2AC05BD0D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 07:34:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1670444wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dnxcz/j4jG7HOHqQqtlrR1/gzrXIHBGiVaeaud+bq1k=;
        b=ZiPC5E1vvjR+gWMyDSxYovoTYlmZkcT0KsnREYe9VplS0xxrBAQpNLBpBLa8rGfk2L
         r5o4PQfdkNYqTbAL70aohbU9JJvyCl8gWTiCricSt9hkBS+MpZVNRGC1croOmTbR9mMN
         nZ77ToVsVEZmMMgi2hByimoSm6KMJccSasCUXcNV2xbY3afowZAu5bbnDkojVu6ApOoa
         ynh7OQoh1g4fVfliqRvd3iJDkD6dRv6fHJaZ/lrUwWCDHcCrEKq7UKBEft//LbaFi6mn
         UmVaXxx7+Lj3ZylhOVuoLMNMIKJU+MKmWSxGtG8TPcr5XD5yD/YCce5i3xUi5elcM+Z2
         hK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dnxcz/j4jG7HOHqQqtlrR1/gzrXIHBGiVaeaud+bq1k=;
        b=Zw0/4y3Fd01UkA48QR8jNQBeoRp3lnMLLTvnbTFVH9gr4kVADcv4a2PTyyzwjn+lM+
         rjtrZGo495BTRZoeYHmsNS4aTbStjKZXyCDTBqJ2v6M1EQt1yUh6wx8Qcsh/iv1o+Dfg
         UKz5lxP6r6eRtjF07Juam4t2tq9e9yVj1qoC4hFoECDIL706H8r9DMCK7DAVVwmPcZv5
         N0RuXVf0gXFoLLxzTWBjmLzdlblvhXSU+5CD2EWLAmsPzXillo1oZ5ZjJqcSNeAlPn2w
         EARh3Px0eSl0e+yQh4RtVTap0TEjvb0bnazoQ+24Ziddhs3CbAp5M2rqrjKDhrxo4gj+
         MTaQ==
X-Gm-Message-State: AOAM532StTvxJw6jTWHcLgMDiPzIQBDNybHCI1Z6GRdW3X3BNNAhT6W1
        5sp3bhPNiTDYBxn1tSd47dptAg==
X-Google-Smtp-Source: ABdhPJxfaenUatsMwKqcqHPDvtnSYMFEMLRXvzeRlYaQpb+QZ5H8KRAvj//aDlwQjov+ZhP4O6Ga4A==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr1153093wmb.90.1625582063590;
        Tue, 06 Jul 2021 07:34:23 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:396a:6bf2:9c33:26ce])
        by smtp.gmail.com with ESMTPSA id b8sm3351889wmb.20.2021.07.06.07.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:34:22 -0700 (PDT)
Date:   Tue, 6 Jul 2021 16:34:17 +0200
From:   Marco Elver <elver@google.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, hare@suse.de,
        syzkaller-bugs@googlegroups.com
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.13+ merge window
Message-ID: <YORp6acYukSgM2PO@elver.google.com>
References: <e118d4b2fb924156f791564483336e7125276c47.camel@HansenPartnership.com>
 <YORh1+8Mk5RYCzx7@elver.google.com>
 <yq1wnq3ed3i.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1wnq3ed3i.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 10:27AM -0400, Martin K. Petersen wrote:
> Marco,
>
> > On Fri, Jul 02, 2021 at 09:11AM +0100, James Bottomley wrote:
> > [...]
> >>       scsi: core: Kill DRIVER_SENSE
> > [...]
> >
> > As of this being merged, most of our syzbot instances are broken with:
>
> I believe this should fix it:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=5.14/scsi-queue&id=c43ddbf97f46b93727718408d60a47ce8c08f30c

Indeed it does! For "scsi: virtio_scsi: Do not overwrite SCSI status":

	Tested-by: Marco Elver <elver@google.com>

Thanks,
-- Marco
