Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B151421710
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhJDTQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhJDTQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:16:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E99CC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:14:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y1so580898plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IZk9KcURE39bItBr2JToxRyweMkJ3IjYCdF9eyKRjvk=;
        b=EEQ2L2aiO+nrZEAym3NhF53k7qNxmtpkp7nOwL+6KGkTEV5J4XK2IF8vJ9FOq7OCnu
         gF8SDf5+yPIvLU9ZsRJGw5G/oD0fj5zSJe3J/ea5JN5q8DHgwrDAQQVWt6S9tQUbxD+g
         BYtEP6BWb617WJIiIZWcycPZ8ZLLQmlV1Unms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IZk9KcURE39bItBr2JToxRyweMkJ3IjYCdF9eyKRjvk=;
        b=nXsXJt4A1hq3XWRTQbu7GJ2UgCwjjLNS5eRSxCbG+5SUefoSPSS84rEvRwe/6uTDBE
         BDUljVjh9v6PtkeFF5d6VEGJ6lbOBqT3VPyRg3pP26F6mY0Y4RbnHHXGNe/HMHCaeDyi
         8D+lLIJ/Jk2adk5X4aBm0hOA267lCCVaBnDKhw9ba50Huw7PuW4kw+JMgu9vc8fqH7+B
         zmBdPgciCugPf+0QmmuvUK9PQxqMHfoePIjEyXkrE+3IbsKPSl8qwC2J+npbX/LHNQqV
         188WsCI7HoUlkk5kl7/fBeIDfdYh0otFwXPt9C7q3vhykBpMAo9kznvGACc2h5k2EHXq
         fpRQ==
X-Gm-Message-State: AOAM533tG6EFpAKSSsM6gnkjEIPARqoD4rEUmbA1am6/65U/KLIhPXWi
        D1fNHOsodlIPvXFP83zacARXIg==
X-Google-Smtp-Source: ABdhPJww4GWrgQH04OALPBHlAyJO0Fe92Q5UeML6U9bLBjb1q3ZSyi2fj5J+OXoZ9XJxAqnGWVtyXQ==
X-Received: by 2002:a17:902:d887:b0:13e:e77:7a21 with SMTP id b7-20020a170902d88700b0013e0e777a21mr1268205plz.66.1633374872817;
        Mon, 04 Oct 2021 12:14:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w8sm9962911pfd.4.2021.10.04.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:14:32 -0700 (PDT)
Date:   Mon, 4 Oct 2021 12:14:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/1] x86: change default to
 spec_store_bypass_disable=prctl spectre_v2_user=prctl
Message-ID: <202110041214.564BF23@keescook>
References: <202109111411.C3D58A18EC@keescook>
 <AAA2EF2C-293D-4D5B-BFA6-FF655105CD84@redhat.com>
 <20211004175431.5myyh2wqnxbwqnwh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004175431.5myyh2wqnxbwqnwh@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 10:54:31AM -0700, Josh Poimboeuf wrote:
> On Sat, Sep 11, 2021 at 07:01:40PM -0700, Josh Poimboeuf wrote:
> > 
> > 
> > > On Sep 11, 2021, at 2:13 PM, Kees Cook <keescook@chromium.org> wrote:
> > > 
> > > ﻿On Wed, Nov 04, 2020 at 06:50:54PM -0500, Andrea Arcangeli wrote:
> > >> Switch the kernel default of SSBD and STIBP to the ones with
> > >> CONFIG_SECCOMP=n (i.e. spec_store_bypass_disable=prctl
> > >> spectre_v2_user=prctl) even if CONFIG_SECCOMP=y.
> > > 
> > > Hello x86 maintainers!
> > > 
> > > I'd really like to get this landed, so I'll take this via the
> > > seccomp-tree unless someone else speaks up. This keeps falling off
> > > the edge of my TODO list. :)
> > 
> > Thanks!  You can add my
> > 
> > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Hi Kees,
> 
> Ping - I don't see this patch in linux-next.  Are you planning on grabbing this
> for the next merge window?

Thanks for the reminder! I've pushed this to the seccomp next tree.

-- 
Kees Cook
