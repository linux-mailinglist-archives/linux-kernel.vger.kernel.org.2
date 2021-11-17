Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DC7453EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 04:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhKQDdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 22:33:09 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:35397 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhKQDdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 22:33:07 -0500
Received: by mail-pf1-f179.google.com with SMTP id c4so1334714pfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 19:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=895YRPhGbbjFFaWKhBPRuX0mIQNHTjsRgPz9absSumc=;
        b=jakKH3eXNDuKodLL1W5IZ7l8RvrUiI+0Ny2nDNvkxGHIKal5VEkiSYUnIwaqyYu+DR
         Gc3KwkHjGg9pwQNOTgq0RoJzn5BSCtIGjcF8dykKYAJiPau531FWIK2sMu2A3pPmqqoK
         n5G37LDpzME4EWAGUuP0xJaag7oIxvLmtgskAvQp67jCXFquEC01wOYUp6CBBpFMiT+3
         WahnXE5IQw/BemKzAVtFMn/ky7uvrabtZiotwH2BSXGa5wO7k19PZR8GTKOJWqCsFXBY
         /4FYCOya/KhbEEKtd2Nxaqjt/BlfP2U2CYzdC4M9czDrpofl9qJg9p9M/28WRahh3Rkx
         ciOg==
X-Gm-Message-State: AOAM530lBhU+ShlZ6TW/Ht90cwJG7sp8b5DYNiCDbHzAmPlb8/zh496G
        A5x4tbhgDm0fABYj2QyL1c0=
X-Google-Smtp-Source: ABdhPJwU/IwET3zdClUb2Z5KLHH7EaHhfI8Rb/CQE2Ip9HWx6ygcuQpN7cUyD79BCdr2B54OGTZmNQ==
X-Received: by 2002:a63:f94d:: with SMTP id q13mr2926410pgk.13.1637119809592;
        Tue, 16 Nov 2021 19:30:09 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id j7sm3623767pjf.41.2021.11.16.19.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 19:30:08 -0800 (PST)
Date:   Tue, 16 Nov 2021 19:30:06 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        axboe@kernel.dk, clemens@ladisch.de, arnd@arndb.de,
        gregkh@linuxfoundation.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, benh@kernel.crashing.org,
        rdna@fb.com, viro@zeniv.linux.org.uk, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, vbabka@suse.cz,
        sfr@canb.auug.org.au, jack@suse.cz, amir73il@gmail.com,
        rafael@kernel.org, tytso@mit.edu, julia.lawall@lip6.fr,
        akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] sysctl: add helper to register empty subdir
Message-ID: <20211117033006.qct3ve3tknfy3xy7@garbanzo>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-13-mcgrof@kernel.org>
 <878shasxkp.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878shasxkp.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 08:03:02AM -0500, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > The way to create a subdirectory from the base set of directories
> > is a bit obscure, so provide a helper which makes this clear, and
> > also helps remove boiler plate code required to do this work.
> 
> I agreee calling:
> register_sysctl("fs/binfmt_misc", sysctl_mount_point)
> is a bit obscure but if you are going to make a wrapper
> please make it the trivial one liner above.
> 
> Say something that looks like:
> 	struct sysctl_header *register_sysctl_mount_point(const char *path)
>         {
>         	return register_sysctl(path, sysctl_mount_point);
>         }
> 
> And yes please talk about a mount point and not an empty dir, as these
> are permanently empty directories to serve as mount points.  There are
> some subtle but important permission checks this allows in the case of
> unprivileged mounts.
> 
> Further code like this belong in proc_sysctl.c next to all of the code
> it is related to so that it is easier to see how to refactor the code if
> necessary.

Alrighty, it's been a while since this kernel/sysctl.c kitchen sink
cleanup... so it's time to respin this now that the merge window is
open.  I already rebased patches, addressed all input and now just
waiting to fix any compilation errors.  I'm going to split the patches
up into real small sets so to ensure we just get this through becauase
getting this in otherwise is going to be hard.

I'd appreciate folk's review once the patches start going out. I think
a hard part will be deciding what tree this should got through.

  Luis
