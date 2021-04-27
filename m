Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A3036CBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhD0TlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbhD0TlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:41:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBADC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:40:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d15so18290036ljo.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1qy5wxeRoVOmQDNZKC3zuT1I7B8Wmbsg1PWKuM1gGo=;
        b=KQMj4gOjxXdq3F3sCekOUpnM5wUKPyax2VsvJVD3UzXPCmwhInGgQ3fsNWZv9jhWkS
         qBZ/uIkzoLhC494xEh1cVAGnDJC5c8kGoJZeHTrYfBs91mJHMHPmbcTgI3U2IIDIAWEt
         WCscorxAa8dU8ukT54NW+qyPhOwFaTMq+lo1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1qy5wxeRoVOmQDNZKC3zuT1I7B8Wmbsg1PWKuM1gGo=;
        b=CFHJjKszrTZCmG0WzBBPeI0MZ4wPvnbue0ZS+TJSTg3ceIkxmQ4K1jAT7aScMfiD5S
         xci/le8n+uYrgdm96HjtlvDH6imaXfxzZsIZs/T10N5kAYgxfszdwOtOGgz9ACkbVDOX
         qXO0WADzvpkdCn/DOoNVe1nU1hwH/BCYLTyON/GROQae4f2VnOtHV4Aovg4HRSqzfopN
         S0YsRG7lFtz9lEqtJ9V1wdnrQgISMXoYBjXJES7Cm6TQYOnfHu1+pzueUXDKI3D32zq3
         ES7lOiEDCDYkfcNHc5LzVsKCv83p47AWVxDaRH4ejwIf0AYaemjUuJoEJDQUWhFY91a4
         Q0pg==
X-Gm-Message-State: AOAM533SDrZySzQVRx9FwqjjwF3AxZO+QN1eisEcA1nBtrITJ4j8ma5f
        scWgGgoPYHsV6BQDSZotaAwwwIahDnnLC820
X-Google-Smtp-Source: ABdhPJxjsy7rdJqeepMq+6DsN3eL7fO/OT5IljrmTYEBvQVCv0ScPphXQAO9So+ezmJXM/YLn4XdCw==
X-Received: by 2002:a05:651c:321:: with SMTP id b1mr18180128ljp.67.1619552426303;
        Tue, 27 Apr 2021 12:40:26 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id u10sm170113lfq.243.2021.04.27.12.40.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 12:40:25 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 124so14417888lff.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:40:25 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr17323063lfu.201.1619552425277;
 Tue, 27 Apr 2021 12:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210427025805.GD3122264@magnolia>
In-Reply-To: <20210427025805.GD3122264@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 12:40:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
Message-ID: <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
To:     "Darrick J. Wong" <djwong@kernel.org>, Jia He <justin.he@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 7:58 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Please pull this single patch to the iomap code for 5.13-rc1, which
> augments what gets logged when someone tries to swapon an unacceptable
> swap file.  (Yes, this is a continuation of the swapfile drama from last
> season...)

Hmm. I've pulled this, but that "iomap_swapfile_fail()" thing seems a
bit silly to me.

We have '%pD' for printing a filename. It may not be perfect (by
default it only prints one component, you can do "%pD4" to show up to
four components), but it should "JustWork(tm)".

And if it doesn't, we should fix it.

So instead of having a kmalloc/kfree for the path buffer, I think you
should have been able to just do

    pr_err("swapon: file %pD4 %s\n", isi->file, str);

and be done with it.

And no, we don't have a ton of %pD users, so if it's ugly or buggy
when the file is NULL, or has problems with more (of fewer) than four
path components, let's just fix that (added Jia He and Al Viro to
participants, they've been the two people doing %pd and %pD - for
'struct dentry *' and 'struct file *' respectively).

                Linus
