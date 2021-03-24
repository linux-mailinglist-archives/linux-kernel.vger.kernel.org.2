Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E2C347F55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhCXR2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbhCXR17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:27:59 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF4C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:27:59 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n198so22354146iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkvrcaymK6nSkgfkJGgjGP9hBUdmwS1OrQXMATb+QVk=;
        b=SyaUL9buRE+4NRrJxT8QWDicV8Zbw3Nwp/PDzCzWvQFIcwsdPe7KDuLRo+AhKkzx4B
         eO+4YSC3shbcQo1ofW917Jep1T5hs1NunTQV/aKRJB87MhV3gKd9DjjI3wVnfxTyQKpU
         FdBLvWKQvgxwGGIt5rLLv5eV4WD+2tS66ftEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkvrcaymK6nSkgfkJGgjGP9hBUdmwS1OrQXMATb+QVk=;
        b=fR/FYjQi/ouXXseBt9UnB7AxdFGO2UPMg/e/f8/aS71kCE3ptabdiBFQ9vpGhQY7SI
         OPz8NgBGYQcj0H6QlLaQSWRxIZeCTg6clMXMywXLvVfvoqGbwZcmkU5JkW79kIBigUfI
         gHqebIDXMBEV3aarlErtc2GfSY5TjwdpY4Mzq40KhOdsT/66Z0cscn13hqIHywRd2T6h
         jEFLxId3QcSEbyXZ8XzRsp0p5Uj39uHRlldVVhksPGhqQ1rQ6uvi/hURBrX49DpXycvI
         +5TMHReT0uGlEH4RSEWaAU95RqIPu1C8K8KgdGUmTjay+sG6HBUp7zDgYSWe8yueSrgk
         QY7w==
X-Gm-Message-State: AOAM532UND/OPl1BCuUh4T5T3Ymxv4V6R2+qpV1EETUaAW4tSMQhkRvk
        +ejNKDdKYSQPnljSijD4FggciFvItcSJPg==
X-Google-Smtp-Source: ABdhPJyHyoLxfjmrbznZwoktp9WlIx6t7o+1m/ysE6gdHmN0JxD36yq0isxCV3QaXWaGr8rns7jbbQ==
X-Received: by 2002:a5d:9d01:: with SMTP id j1mr3328793ioj.195.1616606877935;
        Wed, 24 Mar 2021 10:27:57 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id c16sm1392626ils.2.2021.03.24.10.27.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 10:27:57 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id z9so22084077ilb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:27:56 -0700 (PDT)
X-Received: by 2002:a05:6e02:2161:: with SMTP id s1mr3520805ilv.161.1616606876703;
 Wed, 24 Mar 2021 10:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <2813194.1616574081@warthog.procyon.org.uk>
In-Reply-To: <2813194.1616574081@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Mar 2021 10:27:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSVA4UnkQySJ1fu9joWJE1g48OxMCBYiApjE40G5ph5Q@mail.gmail.com>
Message-ID: <CAHk-=wjSVA4UnkQySJ1fu9joWJE1g48OxMCBYiApjE40G5ph5Q@mail.gmail.com>
Subject: Re: [GIT PULL] cachefiles, afs: mm wait fixes
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 1:21 AM David Howells <dhowells@redhat.com> wrote:
>
>  - I've included these together since they are an excerpt from a patch
>    series of Willy's, but I can send the first separately from the other
>    two if you'd prefer since they touch different modules.

It's small enough and related enough that one pull request makes sense.

>  - AuriStor (auristor.com) have added certain of my branches to their
>    automated AFS testing, hence the Tested-by kafs-testing@auristor.com tag
>    on the patches in this set.  Is this the best way to represent this?

Looks sane to me.

Thanks,
            Linus
