Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE473A95A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhFPJOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhFPJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:14:53 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:12:48 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id x22so543318uap.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fg+Lwm8bqclQbxxF9nKW4sgpvY121G0MYdrkC/2k1M8=;
        b=eLGiC8kkhgquOH+uwR66kHv1IPOXh5NS6AtUvw8ENiPjX3MbCqGOFI3kx2g+dx6Tnc
         o1gP20fNEjAVj2TSPTcBjM2RhiYrf1lr/9RdX6k41CyvK+0LvDzAuF1pNfR8SPDFVnIU
         UdbGzPAZBwGtCf4UeXvuvKO6AWBy035AlYzcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fg+Lwm8bqclQbxxF9nKW4sgpvY121G0MYdrkC/2k1M8=;
        b=mWG6wXnfqZ5oL1rWeEXEkBVIx2KMpiaQiGZsXCQMVw/MGM36L9DutJP7U57nSkhhg5
         h6dKEEyjjeOlaDEfGGCiPq/6xpmTWNxlQLBdEHC1J1onV9wIV6nJvqwGWVvhs34etOzA
         pV5kpcEXJ9/drIA8xMDB7tvU+fYxjPk92ed281Hb5KND27VaSk38WmBFnb4F5ZYH2b1q
         hdKGYryTEmFBRsTbZnpl8iYapi7WgVajGu8bHpfFgui6EmLFetPq5EK95RFmbQbwZ0Gf
         i8Ton92FVGkCppItRFDuz+bD7FBnvvXvX8TgsjixR1FGV1hrpf03icxFSMJsV2iSHLI/
         QQpQ==
X-Gm-Message-State: AOAM532GCATtAxCk5AUbms5fq4nfvmr/1OYsS0KeQqp1WEtW0hjRzEaE
        nRV7dIngproNT02lybzlJ7t9i88zcMszGREmFx7f9g==
X-Google-Smtp-Source: ABdhPJyPqKdYY+BCjGVxp5kVHCSvHJwrxRylVWbgfp624rwp6rN9DLHefYeKSZBh8olnEWhl+VTCJoi+r4cet117ZYM=
X-Received: by 2002:ab0:6448:: with SMTP id j8mr3590542uap.13.1623834767170;
 Wed, 16 Jun 2021 02:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
 <162375278118.232295.14989882873957232796.stgit@web.messagingengine.com>
In-Reply-To: <162375278118.232295.14989882873957232796.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Jun 2021 11:12:36 +0200
Message-ID: <CAJfpegttf+kYBCLsUc9eFLc-KNaN=0smdSMoemAK6t52Kb=fEg@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] kernfs: use VFS negative dentry caching
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 at 12:26, Ian Kent <raven@themaw.net> wrote:
>
> If there are many lookups for non-existent paths these negative lookups
> can lead to a lot of overhead during path walks.
>
> The VFS allows dentries to be created as negative and hashed, and caches
> them so they can be used to reduce the fairly high overhead alloc/free
> cycle that occurs during these lookups.
>
> Use the kernfs node parent revision to identify if a change has been
> made to the containing directory so that the negative dentry can be
> discarded and the lookup redone.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
