Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5CC421C9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhJECan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhJECal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:30:41 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9FDC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 19:28:52 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso24103219ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 19:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f2ero1y1gmEJfH32D2XLFnzAZr3+FZcasvXGyKDqLCU=;
        b=W0MYSB2x/YIZopJuRawbdXmTnHiiWWgkkFobfLTKN0NPNatPlZslDi3WxP5Jhc7C51
         kpaq+f6pReghDbGUReAfyVFm3AqcAtKFKg0fVm3BGMmNqliXHKApMpvYXoxfkBY2XtSL
         z0odnVhDEi3DBOZVSQoYA+PZk/tofK5OcYlUshlQLbNEpG8jwDVuk2A6A+InjajpYvnk
         wGjZkRUiPQWgz0jHUPAWj4l/QFdixGXSlSMdTn47RTf71ZJi0D7Q5zXtWAIGOBKeaOUb
         kQVo32Gczc3BY0otzWE4R+C9FbuRjLTqkw2eb6axIcEYniZe6gi+oBLDcjqrZfmtHQKb
         qR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=f2ero1y1gmEJfH32D2XLFnzAZr3+FZcasvXGyKDqLCU=;
        b=WJ3UsXsjzVj6ZAqf6JtZGgrOwGCER+zyPUsHibKU5+x8xIA20Tjo+1Y+vT42BacAgS
         yhsgdNtxOVQGf8fYTEsCo9bMkkjc/6hWXAHOfS+2hoT94TuK05wfCUc3aLU09HWE5ejY
         aBSJ4GqaXPdFS9JMkDs6hnAYabrALhRzbd6wsZ9uJI6Tko0hoCBaxkC5unPcxhl6HUoF
         vKiTQjz7iSBRGpFMSoHaX7F+z4pQeFeGrpitGpaKxiCjHjVdFS/lPMyMmyqUAhvXSLw+
         +iLOggnd/HbmiP23sMcsPwOYNbefdB31G7/igP8NsO6i/KXPh27pzXFxVaQ81byVzL94
         2DRg==
X-Gm-Message-State: AOAM531SJl1AefVl9T5ZK2XUkL03QiVoT+te3SKrF673gXSr6g2vfbcD
        FBWKqognw8nwXLLOKdipqUYcq7QnSWk=
X-Google-Smtp-Source: ABdhPJzIHYv29EPV9T+RP3mGJKpsdYSF8txsX1YPNK4xNHNVbfXk+SpHRukQnf1bmAqxp5ZvB6zxjg==
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr12551424otr.301.1633400931505;
        Mon, 04 Oct 2021 19:28:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s10sm3055138oib.58.2021.10.04.19.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 19:28:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 4 Oct 2021 19:28:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc4
Message-ID: <20211005022849.GA1391135@roeck-us.net>
References: <CAHk-=wifo=ocAVFtoutuLQvqYyNz1r014uJD8TRPJKpVaPLrRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wifo=ocAVFtoutuLQvqYyNz1r014uJD8TRPJKpVaPLrRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 02:26:40PM -0700, Linus Torvalds wrote:
> This release continues to look pretty normal after the initial
> hiccups. At least going purely by number of commits, we're right smack
> dab in the middle of the normal range for this time in the release
> cycle, and the diffstat looks fairly normal too. A bit less
> driver-heavy than usual, perhaps, but nothing big, and nothing that
> makes me go "that's strange".
> 
> One thing standing out in the diffs might be the m68k 'set_fs()'
> removal - not really a regression fix, but it has been pending for a
> while, and it turned out that the problems attributed to it were due
> to an entirely unrelated m68k signal handling issue. So with that
> fixed, we could get rid of set_fs from another architecture. There's a
> few more architectures I'd like to see it removed from, but all the
> actively maintained ones have already removed it, so on the whole
> set_fs really is a thing of the past, only used by legacy
> architectures.
> 
> Anyway, about a third of the diff is drivers (net, sound, rdma, gpu),
> with the rest being a mix of arch updates (the m68k set_fs stuff and
> some kvm patches), tooling (mostly selftest updates), filesystem code
> and core networking.
> 
> The appended shortlog gives you more details, but if you really want
> to dig into it, go for the git tree.
> 
> Go test,

Looking pretty good here.

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 480 pass: 480 fail: 0

Guenter
