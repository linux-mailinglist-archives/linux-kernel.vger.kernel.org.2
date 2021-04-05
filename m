Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858C73545D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhDERK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhDERKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:10:21 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650BC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 10:10:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i81so12255761oif.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tqy0qtW2fBA0Y5rqk0Bik8PQVnC8hERiXdq7a+DHWsE=;
        b=GHe8XKx6DrdvD66XotWuUbBvifLyu/1wNC5dr9HZUmuw27yI8jJCkNgByNJjdmPQQi
         Eq0orfHoqCCM2RflV0raqRqGx7caNdMhSl1iqXLswAtRnllCR3q2bgRfPcXT35BC+H5V
         p+tWuyUjjPtxF1HigfpGHcIb31HRFPMx4bSIsMVUSdG0WhOOGGCAAlEZaFv//N2ML70c
         vhNEPfcJIg4KHUAMT/KFisDeRUgvVRQSoGYYWaF2wykszXIHHI+V5HtifBnmwN9Igrf9
         Ifzs9T0lijErEPab5Ee1LUYUnTOmGmR/5TUEcaQXEBScZVmaugEr31tKtcXYcPdNP+qX
         Niqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tqy0qtW2fBA0Y5rqk0Bik8PQVnC8hERiXdq7a+DHWsE=;
        b=q4YHHlmZusW5XhrzNathLkUZH8/95H+uNjKWQWysQR4a7iK16q5UHHIcnD3MxHfRBr
         CjoHaF0+PWBCR9onOIiOmRUJX8Pq/22Y92b4wKsFWnO8LOGeEDgsLiOUIGP2WnkZ3Dwq
         euKAJyimYtvPxqcw/atdDM+fvYfkG0wlyY8oXraUtX5VrRrbfuQ6sWuOyyG/hUJvgHkq
         oFBGiZ6xv40BdqTstRMRJm2RF3EDqqaeNdXct5+T9r749L3X54nTwBWR4/KugBQzxaCg
         XhIEvzNOkv2piGBFhPxTzVYoBBD9UoH76xbapuWzkExwpetpxONZ3upDsvhZrty4ZI4O
         rkrg==
X-Gm-Message-State: AOAM533EHIvPcKOlnod5rhhGFnJ6I38fxaIwzsGerYBqowiTS8VTD9XO
        xroIpI+YyOuhsCiEJg+n+UYFtcVw490=
X-Google-Smtp-Source: ABdhPJye/h+zxPhISybnzZFxZmWdl5Vd+EfyYcpTFJ+qKClX3HFSj6BVX/wHne9k6G+cCaqvQwB+Lw==
X-Received: by 2002:aca:d90a:: with SMTP id q10mr83716oig.63.1617642613393;
        Mon, 05 Apr 2021 10:10:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o6sm4172009otj.81.2021.04.05.10.10.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Apr 2021 10:10:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Apr 2021 10:10:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.12-rc6
Message-ID: <20210405171011.GA72391@roeck-us.net>
References: <CAHk-=whK9=wafv+cSLCGqFGPBbgp67Dut3jKCnWB--8y7Lxonw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whK9=wafv+cSLCGqFGPBbgp67Dut3jKCnWB--8y7Lxonw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 02:30:58PM -0700, Linus Torvalds wrote:
> Well, if rc5 was bigger than usual, and I worried about what that
> meant for this release, rc6 is positively tiny.
> 
> So I think it was just due to the usual random timing fluctuations,
> probably mainly networking updates (which were in rc5, but not in
> rc6). Which means that unless things change in the next two weeks, the
> schedule for this release is going to be the usual one.
> 
> Most of the changes here are drivers (gpu and usb stand out, that's
> not because of any huge changes, it's mainly because everything else
> is even smaller) and some arch updates (mainly x86 kvm, but some
> arm64, powerpc, s390, xtensa and RISC-V too).
> 
> The rest is random other stuff (with io_uring showing up again, but
> much smaller this time).
> 
> The shortlog is appended - small and easy to scan if you care about the details.
> 
> So hey, in between all those extra helpings of memma - it is Easter,
> after all - go ahead and do some more testing as we approach the final
> weeks of the release,
> 

No change in test results since last week, except that I added a number
of network interface sanity tests which all pass.

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 460 pass: 459 fail: 1
Failed tests:
	openrisc:or1ksim_defconfig

Guenter
