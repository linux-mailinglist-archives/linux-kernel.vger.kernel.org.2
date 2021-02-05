Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57E0310F96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhBEQ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhBEQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:25:33 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D808C061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:07:15 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id y14so8810640ljn.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9T498taodTGcCME+4kEpXQ8GfyFgHTEmTtWV4SGhP7E=;
        b=hkV6nHOMDRQRlIePJMWcKyuKlTTTB/EoykUOQZkZ4Z/sOmU4163tSd/QeBxyNz82pr
         cMfp0zaBK+mUb1sCwT6V2GQqvYGI0uqKS1DRVL29EuBN62YHbNG7/nfeieuQ4jjBI/rG
         0Oik3d7ONM/cDYdkscWp6gLmaPTE0duzFPa3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9T498taodTGcCME+4kEpXQ8GfyFgHTEmTtWV4SGhP7E=;
        b=ZQjOVKJCr+hXnyqZ3j5W8emfO1p4gBCrZLEEJ+IY1lLn9TLE7msqS7e5T4fpO4SCLh
         9yr92LpHPWGSathdvywMIK1QF4YUM1mpkl2en7LKpF5ZRzGOROfWOSTfNhc7xYbV7Suy
         4DzQhTqnff1Db5Irmgp2Y2BPfvKRjBXWIw38kNxmduOShByMfmN+bnMfzQuYtZNxna23
         NAQWJgdoTiYQ0R+Djr8wDp/Nkzc1vAaTIMbD/mrHG8YZt9Woq5T3pQT7K7gy0mqk/AEe
         FOjXb7128A6uDhvtDtxv6QDGAMXnpfsEzxGK+PTPUVLSbTiPCvDOA0Thu4jdo7Xhs4DC
         5KBA==
X-Gm-Message-State: AOAM532ToLFFGKGznFlbjGB/L1yrEmobW6X8ug/8XG7Q2SW5C/L4zMgT
        DhiUAcmXDe9mclwoxs0sfyvIoTLtYGxOLg==
X-Google-Smtp-Source: ABdhPJwJ8nsXCQthr7yHnAXx3dXbwtw7PWqEYW0byG5t8iViCfLtaPRpA8snqhBqQyxF5g+BquPCIw==
X-Received: by 2002:a2e:b5d8:: with SMTP id g24mr3375732ljn.279.1612548433523;
        Fri, 05 Feb 2021 10:07:13 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 64sm1087737ljj.80.2021.02.05.10.07.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 10:07:12 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id a17so8839485ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:07:11 -0800 (PST)
X-Received: by 2002:a2e:850d:: with SMTP id j13mr3383636lji.507.1612548431551;
 Fri, 05 Feb 2021 10:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20210205080456.30446-1-pbonzini@redhat.com> <YB2HykY8laADI+Qm@google.com>
In-Reply-To: <YB2HykY8laADI+Qm@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Feb 2021 10:06:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiA_QoHP6rxK+tSWM3c_N8dGzAPohhdESyL=M7uLuKR0g@mail.gmail.com>
Message-ID: <CAHk-=wiA_QoHP6rxK+tSWM3c_N8dGzAPohhdESyL=M7uLuKR0g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM fixes for 5.11-rc7
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Jonny Barker <jonny@jonnybarker.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 10:00 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Ah, shoot.  Too late now, but this should have been attributed to Jonny, I was
> just shepherding the official patch along and forgot to make Jonny the author.

I put a note in the merge message, fwiw..

         Linus
