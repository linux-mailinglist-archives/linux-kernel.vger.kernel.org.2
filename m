Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A996832DF35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 02:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCEBp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 20:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCEBpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 20:45:55 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE3C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 17:45:53 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id e19so435034ejt.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 17:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jQAAzkMyDz9j2A6XfWMQGCSaoR8rT2Fso6F62ldjHg=;
        b=bDqeNAH84+nJyInnN4WTMsRnjdw75/XreazONyhpvGLex+Q0RCII/NWn7wzQUSAu8j
         lfJAChB1VzlvI1Q739ir64e7tn437yxHNo41Jf5+Cne7k/vtuDrE15H749xSV7gv3Gji
         jaKUTTrWzJbIGqtcEOn0/3BBNGIQe6dvikIdNltDqGUVCYq0hyuxcaRZj9WQw/AIjL3s
         2AAz66ATU1T1wKPv/kTZKpbtcfeIfJHwZmmcxmBOssF5QwXTO6Prq1yh6i4/+WNJZIAm
         E6IfP/BFcuPxGprkW96zr4IHthYoFJETpE+7jIu5SpHvE1gJ9i87BH7TZ1tEpTTB63Vi
         Vyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jQAAzkMyDz9j2A6XfWMQGCSaoR8rT2Fso6F62ldjHg=;
        b=RZfIXm4bElIZcGwOh5nK2MWKjHgBZHJ4TtSvNWwILCf6Gtiuvc0TAV0Jf2CUmnJ6jf
         lGfbvggBQCcmId22xe+sy6ah9p4ewPzzSJAG6CXVW6ijzd7z9mVC72RNLAO0bWgrp0oH
         faFpvmFYIwx8/TxMtyxsQzb5mvBseBjIRWuPPRUqG4hNjEIQ+7JLuLkSkhiR4tkMp2Dt
         uhnN0UmfMOa2LiQKIeQPMzMvxZJp9FJeo03jvzAnGtYC+M5Ajm+c2dIYtfoGoyV3mIy7
         WHpr2X7ECPBOw93QajNnnlMb9xBrunfXc+p2aSJsqZ8Io0N8d5B6xAaVhZ5yfWmHB5lT
         UhyQ==
X-Gm-Message-State: AOAM530s2cebtNxiCZ6LCkw6fACqYv7KCMkpwTIuk4SRdAQuD82IZkub
        FtrBRq6few9bU7DKKWBHVbeks1huohd8IUK/offK
X-Google-Smtp-Source: ABdhPJzL6KN7ohNuopHXUHTY5N50drq9D6Opy/MeC8ZA8MApREWAtEryhlz7TohVEuG0EtSlBqyZ1X6NbT5qGO133Ls=
X-Received: by 2002:a17:906:2bd6:: with SMTP id n22mr271467ejg.91.1614908752118;
 Thu, 04 Mar 2021 17:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20210212163709.3139-1-nramas@linux.microsoft.com> <87273030-2303-e791-4e5d-25373faf0880@linux.microsoft.com>
In-Reply-To: <87273030-2303-e791-4e5d-25373faf0880@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 20:45:41 -0500
Message-ID: <CAHC9VhT4pnsFTL3N8pZgrgpqzgCU+Odd4V=SGvTA9QcKAGwasw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: measure state and policy capabilities
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 2:20 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 2/12/21 8:37 AM, Lakshmi Ramasubramanian wrote:
>
> Hi Paul,
>
> > SELinux stores the configuration state and the policy capabilities
> > in kernel memory.  Changes to this data at runtime would have an impact
> > on the security guarantees provided by SELinux.  Measuring this data
> > through IMA subsystem provides a tamper-resistant way for
> > an attestation service to remotely validate it at runtime.
> >
> > Measure the configuration state and policy capabilities by calling
> > the IMA hook ima_measure_critical_data().
> >
>
> I have addressed your comments on the v2 patch for selinux measurement
> using IMA. Could you please let me know if there are any other comments
> that I need to address in this patch?

The merge window just closed earlier this week, and there were a
handful of bugs that needed to be addressed before I could look at
this patch.  If I don't get a chance to review this patch tonight, I
will try to get to it this weekend or early next week.

-- 
paul moore
www.paul-moore.com
