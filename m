Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6245344E72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCVSYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhCVSXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:23:40 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41173C061762
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:23:40 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id x187-20020a4a41c40000b02901b664cf3220so4320037ooa.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8IsZawFgEMa/0h+2q6OtKz/L5NfIYbaENUQzEsilOyw=;
        b=fytfpucsCXX8JYqavXWhmK18qqDucTkmIpt34S50xGs2cV+bQypGhXDz0XGnZXIl8o
         7WyjutBpRabNrGCSnObLGYmN9b8K0VYGZLykVOOl/hb2zSbhaTKkViRbFq48IQl+P0At
         Pu075Xcvab7PqFOJByqhqMAXFOJwxzXwwwKYhF1eKImXTHuOzTXNRU8mzk7nuuQTztXm
         9nNfYd897h0rImxTCRJZv0ysCHVfaIJyR2U+VPK9rfGSoEPcqr/56Ws2L/fmpr/EvgF1
         nK2i4QI0GxFy77w8NrUEpYHLbIrY9URRvlEOIea3Kk7T0m79zpEAKtYfGfHjIsR2MDf6
         8J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IsZawFgEMa/0h+2q6OtKz/L5NfIYbaENUQzEsilOyw=;
        b=Cpm/cB/qSgpu0H5SnnQ7YNeRz4Oa6U6uFBnxiBRgEafDDz473zgXgQQ1ZEbk6kMFKY
         1xnfcfesoNEC9CiIgnhlJiKzFTxEIQjPnPekuEOqa50WmCfQZ2V4nSpAUpAWSiv9CcaJ
         cd6rXYiDCwfLR3AQ6TlT5/sHv2xhlwo9bRl74NYNi+52XrvkiW0L2eTEfGV8C0SGFYlb
         ywMcQRchW0VDVA/u9tNGjYwn8KbTel/0TDqPLrMVHs1/2W1sFDqx/CitBnIxAF8db3nK
         T0nRfYcis0Rk/AJdGXbJqismHgXV5nujIVEsHhYacu2D7vav7QF1F3MUDz4AR2toqQzv
         aOiw==
X-Gm-Message-State: AOAM533Cj/yLAF+My/CQWGhgmlRskc8+K0M2Yo6JAmnTCEZhPookqlZH
        79qTErRKsxqzIBaXCoD+3tVlsXQ+jfA=
X-Google-Smtp-Source: ABdhPJwkUL3QcO+y7QvTQQ5BhdTBa2rPlznkaQeQAqGZXrfBAvt4GV/Wff3XamSjmKgEy4giFXNGng==
X-Received: by 2002:a4a:b987:: with SMTP id e7mr659399oop.92.1616437419169;
        Mon, 22 Mar 2021 11:23:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t2sm3169939ool.18.2021.03.22.11.23.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Mar 2021 11:23:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Mar 2021 11:23:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.12-rc4
Message-ID: <20210322182336.GA240669@roeck-us.net>
References: <CAHk-=whDxybSS63==ycQiNobvamDmoyxQo1JL-31Tup8azbeWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whDxybSS63==ycQiNobvamDmoyxQo1JL-31Tup8azbeWw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 03:34:58PM -0700, Linus Torvalds wrote:
> Very much an average rc4, possibly just a tad on the smaller side of average.
> 
> Nothing here particularly stands out. The diffstat looks a bit more
> spread out than it perhaps normally would do, because of the removal
> of the (never used) MODULE_SUPPORTED_DEVICE() thing that causes some
> trivial line removal in various drivers, but not only did it never do
> anything, it wasn't actually even all that common (ie it certainly
> wasn't a "most drivers" kind of situation).
> 
> Anyway, drivers (sound, gpu, nvme, USB), some filesystem updates,
> io-uring (signal fixes and cleanups), arch fixes (mostly RISC-V and
> x86 kvm), and just random small things all over.
> 
> So I'll just tempt the fates and say that everything looks pretty
> normal and this release seems to look good despite the rc1 hiccup,
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 437 pass: 437 fail: 0

Guenter
