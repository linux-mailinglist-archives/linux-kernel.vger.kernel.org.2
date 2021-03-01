Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE83329B84
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348856AbhCBBZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbhCATKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:10:23 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4CC061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 11:09:39 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t25so12225034pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 11:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=DY99Pdj2NKDNwQUif2gCJcVVcRz3SwLcFZLidQNqk1k=;
        b=DIckSBHQh4b6kqfgiILw4VD8A7AyW6H4YZ7AnlyuLKnF9kqVTGxI00KaPtfSv8ui0J
         unxpcoXna/2O83EudZsvqvLJhJZkD9IhT1F8DUoS5w5GLMejIWVZM0NVtQ3p6uySpJJy
         tvJUb/OubcAUEszzHjQQvsuxYePG4s10Az8I7EcNSG+t9ZxnS8mG6cvOijEhiMa+fTM7
         P2WsfFH8tEuJhnuXzDD25uw+yQd5vL3yGKh/EtmfYZi3U/dQNh/8ObctP46yFZKm1wVZ
         bUmP2n3fR5jpgNkVxpJqHhf+kzUwzBWzrlmK/2FwLd7z352fYAFziVofoBQ6km12F3pd
         PeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DY99Pdj2NKDNwQUif2gCJcVVcRz3SwLcFZLidQNqk1k=;
        b=X15MGhS61GpHH4RGgAfvaGkdTfJ1/RSM2lDbi33HKhxxLnKZD4hMFC9qYfxhkNlVH9
         4DPGT0AUDaonpbviSZHnDwvlBwRB+Cnt8AqPIKn42Tn+E5OmRg93KhbkKlSDedIqzyXK
         qntrIO8Oj+TTzqca9KoDyHProCj7FMFId1Yeyq+LqYU1Fo1h051oiHdJsQUmV9u9/fP1
         7OBDuQwNvLOOQuluHi1Cux9y0db+jYf9gZSdjFsL+6B3Yh1GwxuyTZzbx0YxihI/3A+J
         YvOtotWFBrNUxkIIdV3SuCvJD3s/1zCL7xibFRMAgNGaIjLtS9+US47gTHBiZUmWBhtR
         S0fQ==
X-Gm-Message-State: AOAM5322VaIZYYepulMpATZ/JlnNRzvGl50wzKmb6GJ2BzwsXggrAj1U
        zdVKMxFi/WszEOmZuK+ej0T5MA==
X-Google-Smtp-Source: ABdhPJwACM+uRVSHTQtC0DpMExRXW7wjYVVQ+uwm0bg92dMonbv1k1sO7k3QkY0FWBqAFoKOAUQcJQ==
X-Received: by 2002:a65:5c44:: with SMTP id v4mr14687438pgr.362.1614625779446;
        Mon, 01 Mar 2021 11:09:39 -0800 (PST)
Received: from [192.168.0.122] (c-67-180-165-146.hsd1.ca.comcast.net. [67.180.165.146])
        by smtp.gmail.com with ESMTPSA id d1sm148710pjc.24.2021.03.01.11.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 11:09:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for hwpoison page access.
Date:   Mon, 1 Mar 2021 11:09:36 -0800
Message-Id: <59469ECC-5316-4074-98EF-52FFF7940818@amacapital.net>
References: <8d0c76f97f35499f91a2b82d3e7c024d@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Aili Yao <yaoaili@kingsoft.com>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        yangfeng1@kingsoft.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8d0c76f97f35499f91a2b82d3e7c024d@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 1, 2021, at 11:02 AM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> Some programs may use read(2), write(2), etc as ways to check if
>> memory is valid without getting a signal.  They might not want
>> signals, which means that this feature might need to be configurable.
>=20
> That sounds like an appalling hack. If users need such a mechanism
> we should create some better way to do that.
>=20

Appalling hack or not, it works. So, if we=E2=80=99re going to send a signal=
 to user code that looks like it originated from a bina fide architectural r=
ecoverable fault, it needs to be recoverable.  A load from a failed NVDIMM p=
age is such a fault. A *kernel* load is not. So we need to distinguish it so=
mehow.

> An aeon ago ACPI created the RASF table as a way for the OS to
> ask the platform to scan a block of physical memory using the patrol
> scrubber in the memory controller.  I never did anything with it in Linux
> because it was just too complex and didn't know of any use cases.
>=20
> Users would want to check virtual addresses. Perhaps some new
> option MADV_CHECKFORPOISON to madvise(2) ?
>=20
> -Tony
