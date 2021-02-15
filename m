Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303CC31C0AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhBORdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhBOQkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:40:40 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:39:42 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id q4so6541322otm.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xUldSWLjMreSywHlnew2k/s1SmsyRFU0IU3Ao8uyahY=;
        b=b5i/rtohTLPnu/Wp6CWLwaN4pEJeGEYeeXHLg5u3AbopPO6DSRJ7iqc9vkyI/nhi7x
         zFpgRBliDXqSPAb8pLI+TY/ffxOj0VU0iPluNTbGvjkFlVq8WBX7Le5xzzDrIQhCtAmU
         /olwCs3VfcSKxZ6ZfXGSFUFUf/gDxJBD46sd/hvdajiIS40X5Qa84kReQpt6CKGuO3yZ
         9FI22RmrZCo1jOI6HoJvaCLrQA+xSlkSeSIGeHg1KapIcyz1etw0oUgsgGjBSrpLOdTY
         U0PwFo/OVl1AW2qJ0nGkIbAP0B5G/kdcij9KIQjlb90XWWuPrBjug/1dyyVUxwWbUd22
         4rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xUldSWLjMreSywHlnew2k/s1SmsyRFU0IU3Ao8uyahY=;
        b=Z1DhxxqByd1YeMmEG6wlnyaNUgtK3hrSbnu8Vp5erUofHiKHDlTA8sH2yqcUD50N6Y
         kIBD5T3ogmnjonWPBu1zqk8Y63iXSbyuI6A7iFprwVD5x/iFsj2+b2fdB43arOLyQk9z
         yXoL9Qvf2R9SX6aWJCrVN8TLIzN6x/poRZrVAPRXCZsBr0M7G73RkHAy9ivmCvyLmWUT
         9x+zRHK0yjRJhZxhJkiLbog6NxHsIbvJGMj/5zL0jfYcqDKjZDyaG6W8wTd8pdHHtExz
         pEFdtqESWpK2o9SfT2v+JnubQXvkclWOEOuO/mzP4U29GLFJ2gV+RvjWX+ROyejbD15j
         MSBw==
X-Gm-Message-State: AOAM530//Pw+aIoQJeN+NJmA8uOvDDPXIvzFyY/Sv913eL+DzM6uLaIW
        1RO5fYBB/8BbmvjwP+EvHpc=
X-Google-Smtp-Source: ABdhPJzOtfy++KqLNekNb7EE3MOZhPZRrOCOcXbziSQuujPdHcK14o9INBpXot1uG5odDBlMlP+Wxg==
X-Received: by 2002:a9d:6002:: with SMTP id h2mr12283524otj.124.1613407181400;
        Mon, 15 Feb 2021 08:39:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j5sm3859384oij.48.2021.02.15.08.39.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Feb 2021 08:39:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Feb 2021 08:39:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Subject: Re: [patch V2 13/13] x86/softirq/64: Inline do_softirq_own_stack()
Message-ID: <20210215163939.GA144191@roeck-us.net>
References: <20210209234041.127454039@linutronix.de>
 <20210210002513.382806685@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210002513.382806685@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:40:54AM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> There is no reason to have this as a seperate function for a single caller.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>

When building ARCH=um SUBARCH="x86_64" defconfig:

kernel/softirq.c: In function 'invoke_softirq':
arch/x86/include/asm/irq_stack.h:199:19: error: 'hardirq_stack_inuse' undeclared

./arch/x86/include/asm/irq_stack.h:84:33: error: ‘hardirq_stack_ptr’ undeclared (first use in this function)

Guenter

---
bisect log:

# bad: [52a0bcb60e40f30211cb5cbbb0f582ec4e91d896] Add linux-next specific files for 20210215
# good: [92bf22614b21a2706f4993b278017e437f7785b3] Linux 5.11-rc7
git bisect start 'HEAD' 'v5.11-rc7'
# good: [9f44811a4ca6db01e73017e565381549b3c3fc60] next-20210212/mtd
git bisect good 9f44811a4ca6db01e73017e565381549b3c3fc60
# good: [88a516b8c681d666e252abfa5e346606d94653a3] Merge remote-tracking branch 'devicetree/for-next'
git bisect good 88a516b8c681d666e252abfa5e346606d94653a3
# bad: [1c623c776046c4b9d47f70f07928980815578cc1] Merge remote-tracking branch 'char-misc/char-misc-next'
git bisect bad 1c623c776046c4b9d47f70f07928980815578cc1
# bad: [f70ed845051885a4887dd76cb7c616b8f4a2942c] Merge remote-tracking branch 'drivers-x86/for-next'
git bisect bad f70ed845051885a4887dd76cb7c616b8f4a2942c
# bad: [f1b61f7b4fb971f281978fb905507e9ac9b2d973] Merge branch 'core/mm'
git bisect bad f1b61f7b4fb971f281978fb905507e9ac9b2d973
# bad: [364af1939d1ec3512b69bcdc035063a60f9c0b3e] Merge branch 'ras/core'
git bisect bad 364af1939d1ec3512b69bcdc035063a60f9c0b3e
# bad: [9db733e3c78c9c00fa93860078674f23d6dd8b7d] Merge branch 'x86/entry'
git bisect bad 9db733e3c78c9c00fa93860078674f23d6dd8b7d
# bad: [a3251c1a36f595046bea03935ebe37a1e1f1f1d7] Merge branch 'x86/paravirt' into x86/entry
git bisect bad a3251c1a36f595046bea03935ebe37a1e1f1f1d7
# good: [f83d1a0190bf6ac788a848454d21daee2299d085] x86/acpi: Annotate indirect branch as safe
git bisect good f83d1a0190bf6ac788a848454d21daee2299d085
# good: [a0cfc74d0b00c5201e1c09e28b2dc01c8088f809] x86/irq: Provide macro for inlining irq stack switching
git bisect good a0cfc74d0b00c5201e1c09e28b2dc01c8088f809
# good: [db1cc7aede37eb9235759131ddfefd9c0ea5136f] softirq: Move do_softirq_own_stack() to generic asm header
git bisect good db1cc7aede37eb9235759131ddfefd9c0ea5136f
# good: [53c9d9240944088274aadbbbafc6138ca462db4f] x86/pv: Switch SWAPGS to ALTERNATIVE
git bisect good 53c9d9240944088274aadbbbafc6138ca462db4f
# good: [ab234a260b1f625b26cbefa93ca365b0ae66df33] x86/pv: Rework arch_local_irq_restore() to not use popf
git bisect good ab234a260b1f625b26cbefa93ca365b0ae66df33
# bad: [72f40a2823d6e16229ab58b898c6f22044e5222f] x86/softirq/64: Inline do_softirq_own_stack()
git bisect bad 72f40a2823d6e16229ab58b898c6f22044e5222f
# first bad commit: [72f40a2823d6e16229ab58b898c6f22044e5222f] x86/softirq/64: Inline do_softirq_own_stack()
