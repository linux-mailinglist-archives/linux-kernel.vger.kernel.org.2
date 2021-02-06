Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32576311D29
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 13:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBFMp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 07:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBFMpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 07:45:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B40C061756
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 04:44:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d16so10854523wro.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 04:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FdxkSResqQzkMQudO+mFnTtwity6/Y5j5OUXY7bW1CY=;
        b=Aa1oif6wIeCk38mTPALdE/pM3IoRCp1VTkKq6cVjr/teo80g5ZDn9wwJKv68yBwVKt
         qurR6BM7I9gYh/8T8nz/jyNfDIXvovtr5O5PMbcbd7AAO4Q1wxK6vvSoTcT3F6rtpmAI
         v+vj0/V+uu8aKJSvTLcpBIB/Wg7LBmRayxQHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FdxkSResqQzkMQudO+mFnTtwity6/Y5j5OUXY7bW1CY=;
        b=j2N+ll6/XXLgwdEdCDQMBTSy+bIXw7lMZi/OWNY6ZUokNsSB8RopKKakC66udWhlgH
         WL2aMdm23DNtO6QLSHmFRvOfwIIbrJqSBJRgzHSxBA4qsenVbZLrXEDaei2lN4WFKw/9
         0o51CVnvbb3oVjBtxM1eYZNjTYXf7zocAr05lKMuwJ0PkIMj14101jwdyHHRfDc5eFuB
         uL2jTySO5GD2//KPir7PCyr7PvHOafholgJcc6U9alJuYYIcRMG1PJrYBSZkRLiGe8Sc
         XBRMTToaWY4DuO8eAF6l7V9QuC8TmZGmlMgLQvyrSBRUxS+rPT/lHFZbp37FXoHRuuP2
         Vtzw==
X-Gm-Message-State: AOAM533j+owpydUiW+6S5lJkPLAeqwa8Qyn0irGXY6dUlWJWyPDNAvYm
        Evm7rmFXx4lMVbchS8E3x8OGwA==
X-Google-Smtp-Source: ABdhPJyU0DSUD06+MJYK5IN96/TSbHWfYrAodvWTr13jCnWBAwHvl1W0Y0XNV8ZPPivdRQOVLvIyZw==
X-Received: by 2002:adf:fb0c:: with SMTP id c12mr10268601wrr.6.1612615482067;
        Sat, 06 Feb 2021 04:44:42 -0800 (PST)
Received: from localhost ([85.255.234.177])
        by smtp.gmail.com with ESMTPSA id r17sm15877486wro.46.2021.02.06.04.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 04:44:41 -0800 (PST)
Date:   Sat, 6 Feb 2021 12:44:39 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <YB6PN8VsVo4pNxCb@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
 <YB11jybvFCb95S9e@alley>
 <20210205124748.4af2d406@gandalf.local.home>
 <YB3Kf896Zt9O+/Yh@chrisdown.name>
 <YB5Bsyk4o3Mqr6Li@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YB5Bsyk4o3Mqr6Li@kroah.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman writes:
>> > I'm not against the idea. I don't think it belongs in /proc. Perhaps
>> > debugfs is a better place to put it.
>>
>> Any location is fine with me, as long as it gets to userspace. How does
>> <debugfs>/printk/formats or <debugfs>/printk/formats/<module> sound to you?
>
>That's fine with me, but I'd like to see the patch with this in it first
>before approving it :)

Thanks! I'll send v2 soon then with the aforementioned changes, and a move to 
debugfs.
