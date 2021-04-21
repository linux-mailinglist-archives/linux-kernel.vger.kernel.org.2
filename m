Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3572136735B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbhDUTWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbhDUTWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:22:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84ECC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:21:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h20so22225132plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4wHOD7Qw6RwtvH7OJ8GDhh6xL/du4W9oaZCTwmSnKbY=;
        b=KnbPbz/xJS6nJ8coo4e/Zg5YKn3k4A5WHmXZEdB/Q6jrRKug6gEP/SDPo6iz344PuO
         OK21f2AV8dCTCzzXvqO0nrfsKuhUI2AE0+lZFG/h+NACir8dogq7fqoz5ERjKyorBPof
         sRWVZ872LfE6pSeb1TjiPZwiwh/0qU+3fuIcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4wHOD7Qw6RwtvH7OJ8GDhh6xL/du4W9oaZCTwmSnKbY=;
        b=FCIp5SRsEOlVz1t3m2tzI969lAobXXfopRZJLrlDMeXCxmfdyON+lr5uk4G3WLMrdC
         jPCkPoRHjZ2Y4qgtBYH9npadwaEv9bJsD6fgcR/MeAX4mnAAy7jLL83JK7dxr+FsoMAU
         5F+LhYPYD0G1YaOFz6sJKld4ChI3G7FQNjikpd23vH5jJ5Q/fBcNFoEq1eteOOP6rjmN
         ntxHLBXJpo84+jhF5WBXX7tFROLgeC1yvcm5m58MgYMZZDfrDaWm/2wFC3gXUuzsYr/l
         tBosLHLdYkQZ457wAc04sj2Ms0imnY1lptNMrRISE6TpBvSm+9LJ1V+8oYLeCDjREcT4
         hU2Q==
X-Gm-Message-State: AOAM530GKJCEsG6+R49pG8+cR4/8+RrQd6PUTg1eii+9kon/93vaXID5
        fZkc/1wrL7JLha7ehhdEQBq9ug==
X-Google-Smtp-Source: ABdhPJzy0b3ULxWrwlgYJ/EDlDNMw9tyVlXZ5vatyDi8V2grgT6tAT2DukSmSumGmIqzImUqvoOOaQ==
X-Received: by 2002:a17:902:bb94:b029:eb:7a3e:1fe with SMTP id m20-20020a170902bb94b02900eb7a3e01femr33739407pls.25.1619032899207;
        Wed, 21 Apr 2021 12:21:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fy1sm147798pjb.14.2021.04.21.12.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:21:38 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:21:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Feng Tang <feng.tang@intel.com>,
        Don Zickus <dzickus@redhat.com>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/3] perf/binfmt/mm: remove in-tree usage of
 MAP_EXECUTABLE
Message-ID: <202104211220.B7648776D@keescook>
References: <20210421093453.6904-1-david@redhat.com>
 <m1eef3qx2i.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1eef3qx2i.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:03:49PM -0500, Eric W. Biederman wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
> > Stumbling over the history of MAP_EXECUTABLE, I noticed that we still
> > have some in-tree users that we can get rid of.
> >
> > A good fit for the whole series could be Andrew's tree.
> 
> In general this looks like a good cleanup.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yeah, the PROT_EXEC parts are the only piece with meaning in the exec
allocations.

Reviewed-by: Kees Cook <keescook@chromium.org>

> As far as I can see we can go after MAP_DENYWRITE the same way.
> Today deny_write_access in open_exec is what causes -ETXTBSY
> when attempting to write to file that is current executing.

Oh, interesting point. I didn't realize MAP_DENYWRITE was separate from
deny_write_access().

-Kees

-- 
Kees Cook
