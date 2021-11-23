Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728FE45A592
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhKWO1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:27:45 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:46642 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbhKWO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:27:44 -0500
Received: by mail-lf1-f50.google.com with SMTP id b1so90962538lfs.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mb6XQM/akz1+x0yL9NugZJt7uaKfbV1Ol/sda1hI7Fs=;
        b=UMTBrhvosA/ML/aUlVG5M43EILCefEcY9/QepGLipufcL/XE9DvP63d0a/WvMvfUaA
         QN5KkKFZzsM5pakLv+mdEBGUZfVtifJRYFpgLub5BarL1rI36cxhXiHgseJI24ZNPPD3
         J/XbBgkfeqfmTUM2bwI6zJBVw+Eoy0N0F5EtcnfbsVkDM97B7UzHCntyqUdu03R3NuIM
         erFP4ruhrPo+OExWuZwFr2FnOj50dVx3huvDZnvUGBbwGP3NHMlXoxEfjLCnCAzP6SY1
         t6CYEATbu8GYyme26ziy+Z7pOvBj6iwpuOr4GBtbL5oYOZoCHyXb6lGrnr7YdvUldwfz
         EJ3A==
X-Gm-Message-State: AOAM532UuouU7kuOdd25RJrcLxHfDCW/ubxBZWC1UG3/2ww/oyT9fHlS
        QfcqLOW1CFVG+n7Q7nllfBVJUKNy+fXGsDm6sKk=
X-Google-Smtp-Source: ABdhPJxJO70DLeLgRacFO/IJZKQ9fgh8TosLgZUIdGmKNUUVjqPH8boZmbrL6Iisw/M26BjnJCGjMDEuMWY7yGC5FO4=
X-Received: by 2002:a05:6512:3b90:: with SMTP id g16mr5141519lfv.216.1637677475417;
 Tue, 23 Nov 2021 06:24:35 -0800 (PST)
MIME-Version: 1.0
References: <0f03a9e2-4611-4b5c-962f-93a7e1d2bde8@www.fastmail.com>
 <8425e818-f6cc-ae52-ac6b-9cc80515c238@linux.intel.com> <c659c2cc-fd87-4506-b0a8-4d22530c59c3@www.fastmail.com>
In-Reply-To: <c659c2cc-fd87-4506-b0a8-4d22530c59c3@www.fastmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 23 Nov 2021 15:24:24 +0100
Message-ID: <CAJvTdKkUxTYuUp3BjzF-hChEpmRrWB0Ai-xgqdHHvXiD_5b7-Q@mail.gmail.com>
Subject: Re: Revisiting XFD-based AMX and heterogenous systems
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Arjan van de Ven <arjan@linux.intel.com>,
        Asit K Mallick <asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 1:22 AM Andy Lutomirski <luto@kernel.org> wrote:

> Sure, but I bet the demand will be there.  The desktop gamer types will flip off E cores and flip on AVX512 and call it a day.  But the ones who want battery life will be annoyed, and I bet someone at Intel is contemplating how to switch it at runtime.

The premise of this thread is erroneous.
See Arjan's response.


-- 
Len Brown, Intel Open Source Technology Center
