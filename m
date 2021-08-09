Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F893E3D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhHIBXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhHIBXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:23:00 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D35C061757
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 18:22:39 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id z6-20020a0568302906b02904f268d34f86so15908166otu.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 18:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=90ci/n6jLsbwK/bkwHeIPPX127Rbh+qCSTmy7nz6yIs=;
        b=hc31EG9utNmLKfIZemAhbVRGRk8plpcYNeZyq8PLJjqfXN66QpESniUSaC5hBgRihO
         uUnlXMtVmbiVheMl7CHee2nk1wgJ7sxQiYQpTP/1FW9PZyAB3qVLzWIbR809kshLUuqT
         +LYZ2rLWCmatuO9lIHXabv3T22cGXD+QBFarSrGGtlt04nYNCzIsQ41uUoc51yp+xRpk
         HPtAHnDMVduLNCjRvHvDyf5b9j+GceT4C54htutvAEdsxzmB7iuB+xIs9BuVugH+DBPn
         jYj+q9rNe9LTbdCe7VnenNgjjnsmJ+tyf3cjGbFB7oNNxbxKZuakVYH5bwcUXxpaEEPg
         o4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=90ci/n6jLsbwK/bkwHeIPPX127Rbh+qCSTmy7nz6yIs=;
        b=WmOCDsFIQ5n+UmlklsGZEqV06ur1UxAeIv1vGAfx/WOtax1q4bWKHTQb6SxB8mOsXh
         pvZ6BKDcQLUZhUq50c1Osq2+TUFwNiCRupiUiF6rvLepoqnE+xh4YwTcbvmZUUbft8iB
         agESBieWmtqGANTeijYk24RzzpS2U5oMX4WtmLLxSe4uHogJGLrjWoIkToDPHtFFkEoc
         7OEx+3b2A6XnjyFuY1DJpXv4Hi/78qxlH2/VVGnuqeYM2Vfku2QURNoWr+D1fviOffg9
         lHkFMpgOAb4BvUEvfnjaRIVCh1HefFUS2N+gNHmLllxD71x2xWazXVIqs/q1xNOvn0zQ
         pk/g==
X-Gm-Message-State: AOAM533cKqfvCcKzBtD88Iad9Wv6PmI8AiOOjnUThF3l4rxjoEuVlLOf
        yiQ1sRLr6peBYVAoECZuVN/i3YO03ws=
X-Google-Smtp-Source: ABdhPJzW8kyCCB4IizJ0T8zvuOtr1T6TILFcX0hrK0AwWNoE2Jaw/l/gr+LCm5eu5aeL4Aj2DTjOqg==
X-Received: by 2002:a05:6830:2a09:: with SMTP id y9mr15556562otu.217.1628472159257;
        Sun, 08 Aug 2021 18:22:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e13sm1495572oiw.38.2021.08.08.18.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 18:22:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 8 Aug 2021 18:22:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.14-rc5
Message-ID: <20210809012237.GA3681747@roeck-us.net>
References: <CAHk-=wg8QmMMBCEYCV0gPM2GqRQObsQ__fK0r8C6SYAg3Upyjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8QmMMBCEYCV0gPM2GqRQObsQ__fK0r8C6SYAg3Upyjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 02:00:36PM -0700, Linus Torvalds wrote:
> Things are looking perfectly normal. Size is nominal, diffstat looks
> pretty normal, and the changes are all in the usual places, with just
> under 60% being drivers, and the rest the usual mix of architecture
> updates, core kernel, networking, and some selftests.
> 
> The shortlog is appended for people who want to scan the details, but
> I can't think of anything in here that looks odd or noteworthy.
> 
> Which is just how it should be by rc5.  Let's hope the trend continues,
> 

Nothing new on the testing side of things.

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 481 pass: 480 fail: 1
Failed tests:
	arm:z2:pxa_defconfig:nodebug:nocd:nofs:nonvme:noscsi:notests:novirt:nofdt:flash8,384k,2:rootfs

The fix for the failing test is queued in -next and in pending-fixes
and has been there for a while. See commit 45bb1faa29ef ("mtd: core:
handle flashes without OTP gracefully").

Guenter
