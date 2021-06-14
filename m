Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711453A695E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhFNOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:55:47 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:37584 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbhFNOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:55:46 -0400
Received: by mail-ed1-f49.google.com with SMTP id b11so46903054edy.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1k5fd6mKNqY1euuO7MBCmhyw9enp2o5T0bf444E9wZQ=;
        b=DMMkfHNGsvRoNFd8+s2uc8FDBa/9aViVr8lK+cb35GFPaCuDCQTWrYU2KcNK/aSI8h
         IHlEkabZFuzWz0+lIpdIcy+ybQZBJ9penrZ2QCmVdM+fs6X9sKKiBbIzcvRYt6MvArWo
         ergZJC02n2p90L9yIj07VopU7c56op4GbqiHW6vCASsv5A7W5ausDD9z+SFJeh+iBJaK
         fA4G63V96HxcUqNQKnP72J0sUSwLtlVLM0wudfBSZyI6vbgjKnjy9Br8sU/VRUZCwjPs
         W43jAWwvkMBIxiyAIvRIS8paEzVMX72Ju4UTMOTFDcTHSzOAwt8JlOjS5QLCfypDM+8q
         haGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1k5fd6mKNqY1euuO7MBCmhyw9enp2o5T0bf444E9wZQ=;
        b=MUsH6oJ1p1rR/q5vxWMMf8HXJ1KidgQcW9Wqn0f7fGC0ahH3kbycU2V+p/1vKbwio2
         6dXM23MwvCBFbFSNcL4nAS4NL/HTa8qyn76eR2v9Mr8GsyMGz4piR23GRAvWuLhP6omh
         EFUAlbEs7PO2HlZoeK6/W5WNNJZVHLaBLXB3vCbNzjcv4MO+sbdppS4y43G086vmZZbj
         6Y0TrM6La7JPes+jQE53rjBmUJXzuQ6OYMxOkvuQm1gHiEAaf7ZwsMYWLGn8aqELuzo6
         yVmE6EVP/jPatZSnw51mbwdPRRjYYry1xVMIoYrlukpq/ZTqQWm5avKMBILufXmtMuIx
         VmNQ==
X-Gm-Message-State: AOAM530nKGasDr5wCUFabKUfLrJgoIbbzNysx6fG1QTc+bVUIevfCYl7
        zekPOZwIbKK8tqZqsLgx/nc=
X-Google-Smtp-Source: ABdhPJwxy0uF2fylGSRlMxqVlMgcw07LmMo4ejkrLkEgxaOtaLNrP585i+aWaeprtSIx2PeG1oa6rQ==
X-Received: by 2002:a05:6402:111a:: with SMTP id u26mr17082782edv.260.1623682362379;
        Mon, 14 Jun 2021 07:52:42 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id de19sm9271440edb.70.2021.06.14.07.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 07:52:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v2] x86/resctrl: Fix kernel-doc in pseudo_lock.c
Date:   Mon, 14 Jun 2021 16:52:40 +0200
Message-ID: <2668591.RLH4pUzd2n@linux.local>
In-Reply-To: <4de714ab-47f4-97e3-c35f-184b1218e681@intel.com>
References: <20210608234902.9316-1-fmdefrancesco@gmail.com> <4de714ab-47f4-97e3-c35f-184b1218e681@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 12, 2021 12:09:46 AM CEST Reinette Chatre wrote:
> Hi Fabio,
>
Hi Reinette,
> 
> On 6/8/2021 4:49 PM, Fabio M. De Francesco wrote:
> > Added undocumented parameters, rewrote some phrases, and fixed some
> > formatting issues. Most of the warnings detected by scripts/kernel-doc.
> 
> Please write commit message in imperative tone ... eg, "Add undocumented
> parameters ..."
> 
> Also, please refrain from making changes that are not related to the
> goal. The goal according to the subject of the patch is to fix
> kernel-doc issues - the "rewrote some phrases" is not related to this goal.
> 
> The "rewrote some phrases" really is not clear to me ... you do not
> mention this in your commit message but you seem to also capitalize each
> kernel-doc description? This is not a kernel-doc warning but something
> you chose to do. Please be specific in your commit message about any
> things that are not kernel-doc warnings that you do to warrant it to be
> classified as "Fix kernel-doc". For example, if indeed one of your goals
> are to capitalize all kernel-doc descriptions, add that as a goal to the
> commit log to help reader understand the changes. I think this will also
> help you to consider what is actually an issue and what is your preference.
> 
> When you say "Most of the warnings detected ... " - which warnings did
> it miss? How were other issues detected?
> 
> This patch is unclear regarding its goal - the subject and commit
> message indicate that this is about fixing kernel-doc issue while the
> patch does much more.
> 
I agree with you: I went too far and then I made changes that are not related 
to the goal as stated in the subject: "Fix kernel-doc issues". Obviously the 
same is valid for the patch to internal.h.

I've already removed everything from the pseudo_lock.c patch that should not 
be there and I'm about to send a new version. Soon after this one I'll also 
send a v2 patch to internal.h.

For what is related to style, if you agree with me, I'd like to have it 
consistent: always capitalize the first word which describes a parameter, and 
always use consistent punctuation among different lines and comments, so I'd 
prepare a patch (or a series) to the files in resctrl. I could called them 
"Make consistent use of capitalization and punctuation". What about it? 

I've also noticed some minor grammar issues (e.g., exist -> exits (in 
pseudo_lock.c, line 752 - pseudo-lock -> pseudo-locked in many other lines). 
What do you think if I make a "Fix English grammar" patch? So what about this 
other too?

[cut]

Thanks very much for your review,

Fabio
> 
> Reinette




