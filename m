Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB093699E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbhDWSlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:41:13 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:40869 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243442AbhDWSlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:41:12 -0400
Received: by mail-pj1-f50.google.com with SMTP id g1-20020a17090adac1b0290150d07f9402so1643150pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vXW1ncuBeNm0vbvh8xexOBQHSAIgyBx9VUAOPaNkiDI=;
        b=pRf9hfHAv7s8sLaodkphiNHMLI1Lbio6q7S0R8ButO5lZaVOrrNCRvOrdZ7FRCXbuk
         2yh13fYs9QKtTYFY30lzYhwxEW6gEmESPY7H1S6QhHNgnbjY/7xqcFxwbPrEVRtytylB
         pbpmNa2swoA/2XpE2BTk5x0wmxKtbW1mvJFcUyqkiRvJ6qFOvm3tZfW4lZXavOIl19dX
         RrWdUysM3sh0Acr8zQCcrJXp+/63SVXyBde0L5i8sRcKqrrxmG4yAccbpKw8wtntnZa0
         Ed7olC48FzNQax3ndVNk8VKKE96z5EG2zeo3qjJfhzEvYalDkvjl3tua/RhHKJssEs1F
         ZsmQ==
X-Gm-Message-State: AOAM531QZVLAPhqk1OQ7Pt1vt97WwfwXonZSDhmSk/mua4B9/qy0zHAf
        C8luqJN7sjXJct0DYwVcehw=
X-Google-Smtp-Source: ABdhPJyPvE3XgGYw480mwA8BPA6jUJakxJ67pFZ6GLgjPa6JQxXrqWGvIGV/sACV9M6Hdo6PoJjFuA==
X-Received: by 2002:a17:902:ed93:b029:ec:9760:894e with SMTP id e19-20020a170902ed93b02900ec9760894emr5049285plj.53.1619203235631;
        Fri, 23 Apr 2021 11:40:35 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a7sm8848715pjm.0.2021.04.23.11.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 11:40:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F1DEA40244; Fri, 23 Apr 2021 18:40:33 +0000 (UTC)
Date:   Fri, 23 Apr 2021 18:40:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
Message-ID: <20210423184033.GQ4332@42.do-not-panic.com>
References: <20210414085406.1842-1-mail@anirudhrb.com>
 <20210414125540.GJ4332@42.do-not-panic.com>
 <1e12bb24-9bb8-dad7-d852-02173ce41b6a@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e12bb24-9bb8-dad7-d852-02173ce41b6a@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 09:26:55AM -0600, Shuah Khan wrote:
> On 4/14/21 6:55 AM, Luis Chamberlain wrote:
> > In either case I documented well *why* we do these error checks
> > before sending a code to userspace on fw_sysfs_wait_timeout() since
> > otherwise it would be easy to regress that code, so please also
> > document that as I did.
> > 
> > I'll re-iterate again also:
> > 
> > 	Shuah's commit 0542ad88fbdd81bb ("firmware loader: Fix
> > 	_request_firmware_load() return val for fw load abort") also wanted to
> > 	distinguish the timeout vs -ENOMEM, but for some reason in the timeout
> > 	case -EAGAIN was being sent back to userspace. I am no longer sure if
> > 	that is a good idea, but since we started doing that at some point I
> > 	guess we want to keep that behaviour.
> > 
> > Shuah, can you think of any reason to retain -EAGAIN other than you
> > introduced it here? If there's no real good reason I think it can
> > simplify the error handling here. But, we *would* change what we do
> > to userspace... and for that reason we may have to live with it.
> > 
> 
> As I recall the reason for this patch was to be able to differentiate
> between timing out vs no memory case when driver was attempting to
> load firmware. I wish I added why to the change log.
> 
> The code seems to have changed a lot since my commit. I will take a look
> at the closely and let you know if this is still necessary late on
> today.

Shuah, *poke*

  Luis
