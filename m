Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09257441CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhKAOpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhKAOpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635777781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IimbsDmXt9JsV+5Ud+vfycacdBceMoawbI0yusPjM6Y=;
        b=O5CCm+KorB/Iv4PMIJAZX5QhgggEHp1jfknQlTF4ThCRIYdV4jEsLzcQsN5F7X5wlc7FKb
        ihyZObXBuEbw6aOQQqrxXYVYHgs40pU0GLnmpEjQJ4vsluhP2SMfZjhqJ1y+WkkFJUjQh0
        IpCAEfTYfRtvNLCFYTG7AYstV7FA1YQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-ddygt6B7NOaKaLJ2ZkD2lQ-1; Mon, 01 Nov 2021 10:43:00 -0400
X-MC-Unique: ddygt6B7NOaKaLJ2ZkD2lQ-1
Received: by mail-ed1-f71.google.com with SMTP id q6-20020a056402518600b003e28d92bb85so2369395edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IimbsDmXt9JsV+5Ud+vfycacdBceMoawbI0yusPjM6Y=;
        b=BD3ox2chTW6rGQmms1RpqrH/xcr2U0OOul5C/IIWmNa6KxNToIoqys1OrbO8IJCJh8
         yOAAp7ao0igIwbwsqDTFnTRa6kTkmljnOJqQ7SNM+15IYmvOuKSXqMXCYjUwMGBGHU8Z
         iqVmMYeuh4D4AwGR7uLRJdkp/oyuYvg2xzU8mnsm3wb+zWZ6CaHx5DppL0+Vpjtz53ui
         ssv7SMeLBzE3Ea6IhugHLHbhArlHbJxKZ2veQMEK6y+6QgiFZiArHSgHW5NTnBjXA6zD
         sKtGb1iL748bNN1qyHVnQ1qnoSnqE6SWXkyuqyCR1Hd8YYKrE7O/Wxct2c5kKhhyTWpV
         L3pg==
X-Gm-Message-State: AOAM532GldczmgQ4D5a8iyW+bwsW+IXMawxHlTCyWb5gdpB8LsWUnUVg
        N5eTnLvwouucOUM097EXrREkeUX4fxxhfUxoOgBjqfT9yifCZWKjDONemS5sIlvr2vxEEyw4Ph/
        a7eCpLeET4mHF8w0i46n5x/CJ
X-Received: by 2002:a17:906:3a0e:: with SMTP id z14mr29262258eje.111.1635777778918;
        Mon, 01 Nov 2021 07:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRv9BSqyeHZrkxI8HXDbJCrd6XZ9M6Vw0A2RLC8buZnu/68zqF4CSsKMaEqkwHGddkFeAclw==
X-Received: by 2002:a17:906:3a0e:: with SMTP id z14mr29262231eje.111.1635777778709;
        Mon, 01 Nov 2021 07:42:58 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id gs19sm3110772ejc.117.2021.11.01.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:42:58 -0700 (PDT)
Date:   Mon, 1 Nov 2021 15:42:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rostedt-trace:for-next 58/100]
 samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous prototype for
 function 'my_direct_func'
Message-ID: <YX/88QsleYGkt7PG@krava>
References: <202111010507.F9ud1mUL-lkp@intel.com>
 <YX/thIXtDzfhljX7@krava>
 <20211101102434.47e84754@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101102434.47e84754@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 10:24:34AM -0400, Steven Rostedt wrote:
> On Mon, 1 Nov 2021 14:37:08 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > >   
> > > >> samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous prototype for function 'my_direct_func' [-Wmissing-prototypes]  
> > >    void my_direct_func(unsigned long ip)
> > >         ^
> > >    samples/ftrace/ftrace-direct-multi.c:8:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > >    void my_direct_func(unsigned long ip)  
> > 
> > hum, that can actually be static.. I'll check
> > 
> 
> I'm not sure it can, because you call it from inline assembly, and the
> symbol may not be passed to the assembler.

yes, I just found that.. I actually could not add any input/output
arguments to asm, got a compilation error.. I think it's because
it's used outside any function

> 
> It may work with some options, but may not for all.
> 
> I think the best thing to do is just create a prototype to quiet the
> warning (with a comment).

ok, I'll send it.. should be on top of you for-next branch?

thanks,
jirka

