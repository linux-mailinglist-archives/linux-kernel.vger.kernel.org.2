Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8300838F2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhEXSWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:22:46 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42984 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbhEXSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:22:45 -0400
Received: by mail-ed1-f54.google.com with SMTP id i13so33076194edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTRAn6sKnTpFLjexpEsWGr3qh3gJ0MoVGcpa7DMK578=;
        b=I4D8Gsfnj4uJECQ9i5XFtDvT7/xCeOhehqik0+/T+0I8V+9a0vvpxZ8K/Zy7z2phDx
         JJ6H4XgPQ5rTXrOcxhtIExL5LFtzyjZReUBZl/NGG1mD8Qq82PwfwMI/+11Oj4A+JCvJ
         VSWXrd8Qwn8DWoLlzTzR3zpY8lI+2a5QlpWZKxCitI+yE/ZbCIHMMrE2L6r5vd3HRevY
         fmvQIZnxQdipr9opIEIhsWjOFRxrA3BZEUKv5djua32YVa3KxX+dqjBBY4l76atnwt1E
         suhEplnIKXTkcqOhz2stq3x/p7h30FUz5IsuwmtdnmL91WHGnpW9oKdpn3xyiYUdmF3N
         XUug==
X-Gm-Message-State: AOAM533GGSirB4CzKwxPsI8P5AQAgyAYOn99v4v5Sd8hvU2ZpYuYKsQ8
        E74lDAThWe8Yd1UvslwgNJntacEK9Sa/JQ9Io6M=
X-Google-Smtp-Source: ABdhPJw6vU4G3l2YTagz5gO4ugX7pzLV5Gtn3cUx+8qVU48cI3vngX63ipQU5FtBGPv1MOo7BIOPXM8KWajyCChKAwg=
X-Received: by 2002:a05:6402:5a:: with SMTP id f26mr27248413edu.306.1621880476224;
 Mon, 24 May 2021 11:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-22-chang.seok.bae@intel.com> <8c8d91ae-5a3b-9523-725d-134840102df7@kernel.org>
 <CAJvTdKnU6g2H-R67G8LCs4cs0_NqnOzoKbC3J+iNGayFE5RGMQ@mail.gmail.com> <5a645958-10ab-46e7-9650-e5746a8d2276@www.fastmail.com>
In-Reply-To: <5a645958-10ab-46e7-9650-e5746a8d2276@www.fastmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 24 May 2021 14:21:05 -0400
Message-ID: <CAJvTdKkTSv7zc2eT1Ni6+k=V_faCCWmMo5oNunQQt-P7FkON-Q@mail.gmail.com>
Subject: Re: [PATCH v5 21/28] x86/fpu/amx: Initialize child's AMX state
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 2:14 PM Andy Lutomirski <luto@kernel.org> wrote:

> What does VOLATILE mean in this context?

Volatile means caller-saved.

Volatile registers can not be used for globals, static, or for
parameter passing.

ie. By the time the callee is running, they must be assumed to be invalid.

This means that any routine, including the target of a system call,
such as fork/clone, can't assume that any data exists in these
registers.

-- 
Len Brown, Intel Open Source Technology Center
