Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0001A367FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbhDVLlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235977AbhDVLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619091636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMXkQKD92XEqLOdKkZ9LkipLsjeMEu880iIF7KLHuos=;
        b=d7v6HegVpmxiYScMgtjFRAGyUXwrLofd4EhUcdvEL79bsQ1kCsNILv8ZSDubQwlFecYQ5X
        XYAxh6DbQf3UWAOikmGrVCH110QmLcrQyT844m3KaUJ5FeZDiLDSEVo0kuk5hNPDZBteQQ
        5k7/KpQ6wpeoIrpIhnXnmOSSjbGM0A4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-yYLuBz4pMCSLBOXAmFVQDg-1; Thu, 22 Apr 2021 07:39:52 -0400
X-MC-Unique: yYLuBz4pMCSLBOXAmFVQDg-1
Received: by mail-yb1-f197.google.com with SMTP id u73-20020a25ab4f0000b0290410f38a2f81so19534978ybi.22
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 04:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMXkQKD92XEqLOdKkZ9LkipLsjeMEu880iIF7KLHuos=;
        b=Kbi6/5NnO+qR2uZU9d1TY71ryduRI1QdVR9GhZ9M1X1TEEwNrt9ZnI25m8dzmEjUei
         NMmU8NVWS26el50elKS+sHK31fOGzckgO77MRMP4COVwaimU4KxQ+FkZ7gwe8PUDh+5M
         8C1HQ+1mhHj9H99/w4jAXuRd5AtWM2Zwkyry/RvVEKNBIEL1vu71yIiWrrTzQrTCkt/s
         Af1THuV1jRdTRLM/G4TKyKbRdwsL5uuUiV96j4G6BE5LUHzOvwbSHLBBN0PxiSkSuNzW
         sDSPItsAzL64kAdDTVDPCacb2Y3cXyLgY0xDsxFugzA8yWoXtTa/s39MvDMioVU4OIhk
         2PPA==
X-Gm-Message-State: AOAM532L/CnbMXL/vTD9UGitUX+GivFHzPGUPdzsCHRaUOV+9+j6dQLF
        uTlygw4vCWD2VQTFPJmoRpsietz8/+MjlfmrOZyG5Uv9vZo2yNfPfWJh7YzRpSqYWwZJQ9JYsts
        L2QsJKKUfCXgyvag7aktcuZpDZzjMecLEfFpb4/eY
X-Received: by 2002:a25:7085:: with SMTP id l127mr4068968ybc.293.1619091591518;
        Thu, 22 Apr 2021 04:39:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyhE6DS/eW1dR9xemDwBcQEmjxrQY+fv1G9l6m2UGwYtINpsqaUV9AJsTDjlsF+gV/DTMftEHXE3GlbORd3Hk=
X-Received: by 2002:a25:7085:: with SMTP id l127mr4068951ybc.293.1619091591336;
 Thu, 22 Apr 2021 04:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com> <CAHC9VhTFPHO7YtTxSZNcEZwoy4R3RXVu-4RrAHRtv8BVEw-zGA@mail.gmail.com>
In-Reply-To: <CAHC9VhTFPHO7YtTxSZNcEZwoy4R3RXVu-4RrAHRtv8BVEw-zGA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 22 Apr 2021 13:39:39 +0200
Message-ID: <CAFqZXNts94w-hMhzCjKW5sHrVw2pw2w7cMQ3+Q2suJ_XUUpUwg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] selinux,anon_inodes: Use a separate SELinux class
 for each type of anon inode
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:38 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > This series aims to correct a design flaw in the original anon_inode
> > SELinux support that would make it hard to write policies for anonymous
> > inodes once more types of them are supported (currently only userfaultfd
> > inodes are). A more detailed rationale is provided in the second patch.
> >
> > The first patch extends the anon_inode_getfd_secure() function to accept
> > an additional numeric identifier that represents the type of the
> > anonymous inode being created, which is passed to the LSMs via
> > security_inode_init_security_anon().
> >
> > The second patch then introduces a new SELinux policy capability that
> > allow policies to opt-in to have a separate class used for each type of
> > anon inode. That means that the "old way" will still
>
> ... will what? :)

Whoops, I thought I had gone over all the text enough times, but
apparently not :) It should have said something along the lines of:

...will still work and will be used by default.

>
> I think it would be a very good idea if you could provide some
> concrete examples of actual policy problems encountered using the
> current approach.  I haven't looked at these patches very seriously
> yet, but my initial reaction is not "oh yes, we definitely need this".

An example is provided in patch 2. It is a generalized problem that we
would eventually run into in Fedora policy (at least) with the
unconfined_domain_type attribute and so far only hypothetical future
types of anon inodes.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

