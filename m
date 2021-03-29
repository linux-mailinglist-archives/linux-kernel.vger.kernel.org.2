Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332B634D7A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhC2S5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:57:52 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:36860 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhC2S5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:57:37 -0400
Received: by mail-ej1-f48.google.com with SMTP id a7so21091051ejs.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fg4T1toksbX6wYWOQA9Y4u4lfMcCUeyne4oYFvBGONg=;
        b=tu2i2XkLFLbz+col2+fcNBdbaYdNaUaUsgEPL6QZDK83kFnEKkgf1F8mV3viGYxxAo
         SC9GBZxsSXZrGNwbPgFclTpiXHzf6jkhaTb+7YW2hKKPUXIj1xvrWIVQEmy3xEKyR8PS
         JwJ+h3yABngjs8oL2koxPH/p3YKMoYJ7UbgiTCVBvfwc4HSEwCtaSGr18ssc7ElBTW8a
         37zAYixpf9BpzrPXpWrbp4KoIqcVJQ/p2xFatFt6OC88GoDVhMq1SghIVjvH41DzMNgy
         DA0aKYyl1l+cUW9IXGGs4Zg6EkyLjquHR4aHspXyOTk236k7WEO3i/hKUUvvdgLaStlJ
         rGqA==
X-Gm-Message-State: AOAM532mVZ3snVjbT8lR51Hpbaod4OjcrZDrVmpTW2euy5YyktJJt1FH
        dBLWaIR4LvudVWxlNHouA+KRxWVaGI3QghjLs58=
X-Google-Smtp-Source: ABdhPJygtQkRo0D4Yy9BT5cy38x+9L0MYd7T755PdhfzD0n6u1cHCRH3Gu6eL74xK/SC/007z1ts5mCoFYYBnkcMfEY=
X-Received: by 2002:a17:907:ea3:: with SMTP id ho35mr30013433ejc.219.1617044256430;
 Mon, 29 Mar 2021 11:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdKm4qKw8D8b+NokBsdiE5yBj=LTiH50VuxJY2aAL8qQq6g@mail.gmail.com>
 <09AB34BD-7DB8-4DBD-A538-F3AE642F8C8A@amacapital.net>
In-Reply-To: <09AB34BD-7DB8-4DBD-A538-F3AE642F8C8A@amacapital.net>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 29 Mar 2021 14:57:25 -0400
Message-ID: <CAJvTdKkZU3kFiC-5_xwVUNnwzM2QmVS3u1aY-RY=S6_Tw3f5zg@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 1:43 PM Andy Lutomirski <luto@amacapital.net> wrote:

> > *switching* XCR0 on context switch is slow, but perfectly legal.
>
> How slow is it?  And how slow is switching XFD?  XFD is definitely serializing?

XCR0 writes in a VM guest cause a VMEXIT..
XCR writes in a VM guest do not.

I will find out what the relative cost is on bare metal, where VMEXIT
is not an issue.
-- 
Len Brown, Intel Open Source Technology Center
