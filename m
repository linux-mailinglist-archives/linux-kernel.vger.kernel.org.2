Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FE33ECCBF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 04:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhHPCrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 22:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHPCra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:47:30 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A6CC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:46:59 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id u13-20020a9d4d8d0000b02905177c9e0a4aso8794523otk.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m3zIO7YSxFlKSzrswIBHe4O0J9GiGIFxIZnF2bznjyM=;
        b=gENak4ByqKebjpiamPGcz24T+VeAoJU+uK4soWII4zjgoycoYdI1rrNQHHB/CyP/y7
         2huxOK1ZqVNlQU0Xa53jAI9q3KFuR6S3gJLysZUneSXvMZQGR8t+jjX5lDee+BOKn1Jm
         RceEtw8K9QdPIG7iTxwLQYp79p5S0MkxcZjGidt6fx/s5zh8WC+W6BDDryb/IW9z6Yo0
         Svcs6IpZR8C6HylI6/+Zw/PqEp5R4SWOlLGfslILB624SjAiqwAWzMSMPsY9f57XejeU
         ZgWk6z30ip42GPZGbbhO3Cwcd2w6OH5VI9tsafGwAxQ60TmahNg5zY8qiBW4bqeTUtj1
         HILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=m3zIO7YSxFlKSzrswIBHe4O0J9GiGIFxIZnF2bznjyM=;
        b=gYRBGUoDUPKEvMZwYDBW0ZpQSjmpC8+my8SKMeAG96RjR3g/7Sfj8TfEXI1yWc7pB5
         xlIdiJ4kVLmtR1rcveA6kt7Pmo6KU5vfX+pcRf9/7vEoFAoFxr5mS+i9q8G/LSA444fC
         6H9KZAA3n6Wlm2nFrv6cY3INm7KeY1cL1W8KAfB+DM8G50tx86ArkvHKkW7376C83IDO
         XbF4wXs6ClgVXhPqRaxq3Xnes8PW0hWAz542tKlHsHh1Pb9e6H113AhChLMevycbXZnN
         H1T6nvuTekukpgsAQxE7+9EN4MsRBncQ3CXWGWGOyBK+CSAZIqvklsz4DysfT0eRFgiB
         s2Hg==
X-Gm-Message-State: AOAM5323TeCBfAZrrtz2wabk5UDLLl6uztLxGIPv7YqREhVd4fkjrOKr
        sAnk+Jw+YwiHbynaXqPz3vfWGkexO9M=
X-Google-Smtp-Source: ABdhPJxKTYN4WP3Chcra+3+9cW8Adgf6t0AWANmowtDoDAnSa9cDijp/8LWIYtBbKqqaorZGNRxLWA==
X-Received: by 2002:a9d:1b48:: with SMTP id l66mr11199396otl.261.1629082019091;
        Sun, 15 Aug 2021 19:46:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i27sm1223982ots.12.2021.08.15.19.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 19:46:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 15 Aug 2021 19:46:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.14-rc6
Message-ID: <20210816024656.GA212454@roeck-us.net>
References: <CAHk-=wi8=9QbNFFZ1PwZ=J-3w6LkhF68_rEns-mN1DCJrYo1qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi8=9QbNFFZ1PwZ=J-3w6LkhF68_rEns-mN1DCJrYo1qQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 02:07:59PM -1000, Linus Torvalds wrote:
> Another fairly normal week. A little over half is driver fixes
> (networking, sound, gpu, block are the bulk of it, but there's other
> noise in there too), with the other half being the usual mix:
> architecture, filesystems (ceph and cifs), core kernel and networking
> and some documentation fixes.
> 
> Nothing particular stands out to me. Go test, we should be getting
> pretty close to done with this release...
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 480 pass: 479 fail: 1
Failed tests:
	arm:z2:pxa_defconfig:nodebug:nocd:nofs:nonvme:noscsi:notests:novirt:nofdt:flash8,384k,2:rootfs

Guenter
