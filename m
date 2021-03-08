Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AFD33073C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhCHFWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbhCHFWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:22:18 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76F7C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 21:22:15 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id t16so8069609ott.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 21:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rfkP+RUBC/I5TihxB9dtySzi9ltoQb0x3qn6GVvaR/w=;
        b=Ejb8pOslvl56wuvJOKDmLjU14IIQBlenT4w1dk85WLaRKr82GSMOTstLgdC5HUtJpW
         SKhaBcSEllDbRpgs0sPDY511HQu6XQ3GANeJclNF83pbmNRaAkha+SeiEOEfj30iMeYV
         to4cax8gozbuj/4UV+thu3Fa18YXcs8WCqUxeSjaVsmTLMqBYQ44PDgRVqdAV/PHmv4a
         Eb4l9oOGGlaFWM6d3H943Iz2uNXGCyKH0iZ9fJa0dGYpGihBa+UrmBVFvGU6LNjsDRZp
         /9v2aQOeQ0N/NcImh55+XWFcDy4IK+uI990krioykZVSSWtT/igqWI1+u0yiQOUfHRiv
         JEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rfkP+RUBC/I5TihxB9dtySzi9ltoQb0x3qn6GVvaR/w=;
        b=Jndj/1kLI4smicJjEPaSYhvmmuYUt1kAXv6/WSJAjpcGdeIMd7yW4w0FNQnGtDLIFW
         mYAQ5l7hxP5Dmmy13rI0EYIl/G0+S+WhqcpM8CBl+HYrpbhomL2JZ3XlFqx4fKhCVY5k
         Q8czWa9XJop5cJmU/El/6NtYO5x2PYi0akEJK7KBet6GVaa4h+6Vdm/FG9fK4af1iNdn
         kYoi5Wevm7UQVcx0bK426hVFznG9F20dlqFxf4m2iMA/pePaTq/Uyh7oSGGkBWlvA/GP
         HTHj0NqtAWScU+J1r8zmD1CF9g2H5lQIRP3/jfcOoMMxVUaqEDlptxdHrHLLvgbFeuaG
         Jn/g==
X-Gm-Message-State: AOAM530PukI4BppNyVZ2va3TLVCqlqCIA2M7ljiy653YJklQb1Yg4FYY
        7lT0BJk/m/n7amRK+Uth8igeLZR3hEs=
X-Google-Smtp-Source: ABdhPJydbu3dKG3UxgHGRDTOT5Lc6Zl669C2qObnlmBunK35CSyfd3QQsQFm6bvwCRFrHweLgRoeag==
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr4890092otq.256.1615180935123;
        Sun, 07 Mar 2021 21:22:15 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a7sm2198352oon.8.2021.03.07.21.22.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Mar 2021 21:22:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 7 Mar 2021 21:22:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.12-rc2
Message-ID: <20210308052213.GA201328@roeck-us.net>
References: <CAHk-=whH-stL2zLCf02HZaOeQgS4oGa7eEiHeYZGj-orK-PX0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whH-stL2zLCf02HZaOeQgS4oGa7eEiHeYZGj-orK-PX0g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 05:54:10PM -0800, Linus Torvalds wrote:
> Ok, so this is a couple of days early, but rc1 had the nasty swapfile
> issue, so I'm just accelerating rc2 a bit.
> 
> Outside of the swapfile IO offset fix, the only other thing that
> stands out is some io_uring thread handling re-organization, which not
> only solved a few fundamental issues, but actually made the code
> smaller and simpler too.
> 
> Other than that it all looks pretty normal: drivers dominate (with
> sound being most notable, with the ASoC Intel SOF support being split
> up sanely). But there's some btrfs work, kvm, iscsi, etc. A few random
> things all over.
> 
> Shortlog appended for your viewing pleasure, and I sincerely hope (and
> believe) that rc2 is in a lot better shape than rc1 was.
> 

At least it survives my tests.

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 435 pass: 435 fail: 0

Guenter
