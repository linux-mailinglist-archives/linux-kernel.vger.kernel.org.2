Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D293B85AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhF3PEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235352AbhF3PES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625065309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OHjD8pVyx0xZX4QhRB5WBgUBwBi/yaPIVBuvLE0fbPs=;
        b=BeHTk/0wohAJCYGEHJFcKd9CArC3bRLXnh8h6A/8muAaaa+UZbxYIHIM4sVe31KJVao7Ns
        99z2PSDzJ/uaKwnu1euXkSPo31ioQBmYdXZqy+CuvjIy4/vFI0SPr67+KbvmMnkDsovT4H
        /QSiTQy8Pjve6qwxc1+vo402LRf0wAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-Y4hI6FXfNOWQxOGf41_JQw-1; Wed, 30 Jun 2021 11:01:46 -0400
X-MC-Unique: Y4hI6FXfNOWQxOGf41_JQw-1
Received: by mail-wm1-f69.google.com with SMTP id i7-20020a05600c3547b02901eaa4d778adso614655wmq.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OHjD8pVyx0xZX4QhRB5WBgUBwBi/yaPIVBuvLE0fbPs=;
        b=Qqh68xOiB4p0HiqyPtj3hAhK51+1hhYQ0K0B/5uNxKWGul9pJp0hFxw1AVZtCBfWVd
         imPRMogJIW2DMbBH1Zoahjs1RkHNFY89o5Nn3NIck/SMLLnEphImnvPpxaD92rtf/6f+
         0o9SupsuokVEhxWVVZIQm1hL/7M4OQhEF3szmxUkA16Nlr2GFQFaPc7Pt8wVCXjuy85P
         OEWGoIRwShju1fgMw2oEajTupld20Dpbd3R6jL7fGW6jv9e/dBjcbIyOcNC6AHZ+Gjt+
         ULA5GWk1Of2tYlM7EGfKivWFT2XpM0O5D7oD4QhzmNl7heG8o4XeDz30OuE+myhpIx0d
         ek7g==
X-Gm-Message-State: AOAM530ErnWenFWIq8pI8HIpjhlZnR7bnWBQZQMRKRnk65//+gorsezt
        8GX5aU+/p0tqeaQC3d3YPdeaKoCn292FEUQJU4VSYAPYVRIj9P1cQctDoQ5HgEjqhlq7K8amZPQ
        0vBcRzZAPblOcaqTGC2iAbFUJ
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr39271106wry.175.1625065305723;
        Wed, 30 Jun 2021 08:01:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3lPU3a0hHSHya8DIwa8S9wyVNFFEGwVYtz1NeMuaxkx1lgw7Ijq4awOATArwjHFkH7fHvKQ==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr39271083wry.175.1625065305573;
        Wed, 30 Jun 2021 08:01:45 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id d17sm8593511wro.93.2021.06.30.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 08:01:44 -0700 (PDT)
Date:   Wed, 30 Jun 2021 16:01:42 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Daniel Walsh <dwalsh@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <YNyHVhGPe1bFAt+C@work-vm>
References: <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
 <YNvvLIv16jY8mfP8@mit.edu>
 <YNwmXOqT7LgbeVPn@work-vm>
 <YNyECw/1FzDCW3G8@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNyECw/1FzDCW3G8@mit.edu>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Theodore Ts'o (tytso@mit.edu) wrote:
> On Wed, Jun 30, 2021 at 09:07:56AM +0100, Dr. David Alan Gilbert wrote:
> > * Theodore Ts'o (tytso@mit.edu) wrote:
> > > On Tue, Jun 29, 2021 at 04:28:24PM -0400, Daniel Walsh wrote:
> > > > All this conversation is great, and I look forward to a better solution, but
> > > > if we go back to the patch, it was to fix an issue where the kernel is
> > > > requiring CAP_SYS_ADMIN for writing user Xattrs on link files and other
> > > > special files.
> > > > 
> > > > The documented reason for this is to prevent the users from using XATTRS to
> > > > avoid quota.
> > > 
> > > Huh?  Where is it so documented?
> > 
> > man xattr(7):
> >        The  file permission bits of regular files and directories are
> >        interpreted differently from the file permission bits of special
> >        files and symbolic links.  For regular files and directories the
> >        file permission bits define access to the file's contents,
> >        while for device special files they define access to the device
> >        described by the special file.  The file permissions of symbolic
> >        links are not used in access checks.
> 
> All of this is true...
> 
> >         *** These differences would
> >        allow users to consume filesystem resources in a way not
> >        controllable by disk quotas for group or world writable special
> >        files and directories.****
> 
> Anyone with group write access to a regular file can append to the
> file, and the blocks written will be charged the owner of the file.
> So it's perfectly "controllable" by the quota system; if you have
> group write access to a file, you can charge against the user's quota.
> This is Working As Intended.
> 
> And the creation of device special files take the umask into account,
> just like regular files, so if you have a umask that allows newly
> created files to be group writeable, the same issue would occur for
> regular files as device files.  Given that most users have a umask of
> 0077 or 0022, this is generally Not A Problem.
> 
> I think I see the issue which drove the above text, though, which is
> that Linux's syscall(2) is creating symlinks which do not take umask
> into account; that is, the permissions are always mode ST_IFLNK|0777.
> 
> Hence, it might be that the right answer is to remove this fairly
> arbitrary restriction entirely, and change symlink(2) so that it
> creates files which respects the umask.  Posix and SUS doesn't specify
> what the permissions are that are used, and historically (before the
> advent of xattrs) I suspect since it didn't matter, no one cared about
> whether or not umask was applied.
> 
> Some people might object to such a change arguing that with
> pre-existing file systems where there are symlinks which
> world-writeable, this might cause people to be able to charge up to
> 32k (or whatever the maximum size of the xattr supported by the file
> system) for each symlink.  However, (a) very few people actually use
> quotas, and this would only be an issue for those users, and (b) the
> amount of quota "abuse" that could be carried out this way is small
> enough that I'm not sure it matters.

Even if you fix symlinks, I don't think it fixes device nodes or
anything else where the permissions bitmap isn't purely used as the
permissions on the inode.

Dave

>      	    	  	      	  - Ted
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

