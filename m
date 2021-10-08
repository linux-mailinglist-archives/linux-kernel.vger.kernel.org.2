Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19189426EF8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhJHQ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230118AbhJHQ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633710442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pknefudsHGI016f0bFGfCECMYB0JCq/ZzGMi/undZ+0=;
        b=YtX0+EXOV9ldWKZ6acWbDpEfZQ+q2m9WFwAmhADKp/40b4CW+SlmtHrPEREg+WkCIw4YRB
        8YnR9yWDbRZiVpDN5SSEtMKUWXnCKShDByhU9QhMNMVfY3CjI2Skmnuxh2gNOhp9Pty28J
        KxcnrWScUhz9UrTq9VFhg1xYyRzVju8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-pgM3GM2cMvipS0aSq41bOw-1; Fri, 08 Oct 2021 12:27:11 -0400
X-MC-Unique: pgM3GM2cMvipS0aSq41bOw-1
Received: by mail-io1-f71.google.com with SMTP id t6-20020a6b0906000000b005d9a34ee5b9so7833361ioi.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 09:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pknefudsHGI016f0bFGfCECMYB0JCq/ZzGMi/undZ+0=;
        b=UJJ240vT90G2MrXyr9U/033FqS6PN7NcN5JPo66Jzo2ayUk/PxpJgZ3puLW4PEKUZO
         DkKLPi7Lin+E0B16y55fczLThRiF4Y0nHw8cPoPLj4YQB+x5k/rd3lP48zzUU+cyxrt+
         vlp3F0N2tGfsj3bKBf12VSZv6gbVH6Bm1uBjxHyREd8ZYZaMJCWTDj5NSuoejphQYTbc
         VtrfvOdAX7Oe92TeB65CWBS33u3I+EuZozUf59Pqgg8jzuJF0naJbu+Qm2KSOZmfDXBs
         /zccTkmg2vfNMmz23X88dc+WmXyW4wuK8iD8MJIPKpmO5+h0n4vQhNdsxpQcfpRvWDBJ
         YIqg==
X-Gm-Message-State: AOAM533gYTsXVLJ4omw5M7+MkHC7pyQw7ujTJAEt2W2LpukEeRlJaYyL
        /ksiatnRlPMXE9hieyxyI3Rs2MGawUoz2m9G8C5gwQS/TCGSIKkILSiFOFyi2plZ+MXeeMcKa/L
        bCz0n53EnAGN6KQmFLCPOhUEu
X-Received: by 2002:a92:1a08:: with SMTP id a8mr8593524ila.67.1633710430709;
        Fri, 08 Oct 2021 09:27:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw17lk0IORa40WoV1+wTR6qwC1nxW938ShtV1oqA8tMMFD6I5s2CsBSR2ZRMc15Q/NeYYNsNg==
X-Received: by 2002:a92:1a08:: with SMTP id a8mr8593511ila.67.1633710430542;
        Fri, 08 Oct 2021 09:27:10 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id d1sm1141023ion.47.2021.10.08.09.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:27:09 -0700 (PDT)
Date:   Fri, 8 Oct 2021 11:27:07 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Trivial dynamic debug fixups
Message-ID: <20211008162707.nc6vr22srcmga5fp@halaneylaptop>
References: <20210920205444.20068-1-ahalaney@redhat.com>
 <670b5afa-0d76-7e78-2b31-f1d4355dd026@akamai.com>
 <YWBrXZrqdoETlqWG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWBrXZrqdoETlqWG@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 06:01:33PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 08, 2021 at 11:58:57AM -0400, Jason Baron wrote:
> > Adding Greg to this (should have added him earlier)
> > 
> > Greg, if you are ok with this series, we'd like to have it added
> > to -next.
> 
> What series?
> 
> Have a pointer to it?  It would help if it was actually sent to me if
> people want it applied...
> 
> thanks,
> 
> greg k-h
> 

Sorry Greg, that's probably my bad.. still getting used to the kernel's
workflow.

Here's the lore link: https://lore.kernel.org/all/20210920205444.20068-1-ahalaney@redhat.com/

Did I do something silly when sending the patches? I basically
just added everyone manually when using git send-email.

I found who to add via:

    ahalaney@halaneylaptop ~/git/linux (git)-[master] % ./scripts/get_maintainer.pl 0002-dyndbg-Remove-support-for-ddebug_query-param.patch                                     :(
    Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION,commit_signer:1/2=50%)
    Jason Baron <jbaron@akamai.com> (maintainer:DYNAMIC DEBUG)
    Martin Kepplinger <martink@posteo.de> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:1/3=33%,removed_lines:1/5=20%)
    Andrew Halaney <ahalaney@redhat.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:2/3=67%,removed_lines:4/5=80%)
    "Paul E. McKenney" <paulmck@kernel.org> (commit_signer:14/89=16%,authored:7/89=8%,added_lines:44/527=8%)
    Thomas Gleixner <tglx@linutronix.de> (commit_signer:11/89=12%)
    Andrew Morton <akpm@linux-foundation.org> (commit_signer:11/89=12%)
    Peter Zijlstra <peterz@infradead.org> (commit_signer:8/89=9%,removed_lines:13/137=9%)
    Will Deacon <will@kernel.org> (commit_signer:7/89=8%)
    "Maciej W. Rozycki" <macro@orcam.me.uk> (added_lines:90/527=17%)
    Muchun Song <songmuchun@bytedance.com> (added_lines:28/527=5%)
    Viresh Kumar <viresh.kumar@linaro.org> (removed_lines:14/137=10%)
    Robin Murphy <robin.murphy@arm.com> (removed_lines:13/137=9%)
    Randy Dunlap <rdunlap@infradead.org> (removed_lines:10/137=7%)
    Lu Baolu <baolu.lu@linux.intel.com> (removed_lines:10/137=7%)
    linux-doc@vger.kernel.org (open list:DOCUMENTATION)
    linux-kernel@vger.kernel.org (open list)


per patch, and I just hit the maintainers and the lists specified
since I figured the commit_signers don't care. Did I goof up?

Thanks,
Andrew

