Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD8633DF78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhCPUqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 16:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhCPUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:44:46 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1E6C061763
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 13:44:45 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id v123so18980472vsv.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLa3leTdMzh1rknpkLUWnm0PAOSso4HRgQA5K7IK6MM=;
        b=e+TXEaCKvma4VGpnwpOaaFkLknHBGuDmEKybhDxTF83sGcUnhvMjnyd4FKoakznEV3
         L+49y3mjg3y9zPjYOau5jDdMUzS1QeQc8EZHIuCnYCEvlu/U3MIphrqZ/uP5UmkwxxeL
         +/myGc8pDphpzzZ7FTh/9hJKxPT9p26Ia2eDhTGk6iETFEiye/52lqU41RoUHrn74DWh
         Z9MX2qar1Tdy5UlVzs8F5VgOHw+sA5zNyUhbhgEJg7yulcKmANZ/MdTHXU3HQZNR3/3z
         jprq7sQ3GQvcxl+Y7QEUl59VHWT5WD2/UpeliEvsAr6IQyyxoheHA9cHYYw051xuDx5U
         BC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLa3leTdMzh1rknpkLUWnm0PAOSso4HRgQA5K7IK6MM=;
        b=jTfdr4KfIE4hYjQp8oDN7qnwYI9+RaqSPW1Vg245rHN5FoSO8hQSO4WhCIMbTPv6RG
         NkBcTcu4/ZrgpCy6e2+zHozMur70d5V5o02Cf9z2h5DPZePIHnC3EvHZktk/SyiJarSW
         Qg7k2Q36HTxxXSGCpytsSLcd2gV5ESZVsSaJGjkxumPa3h+nuQM3MmraKZsMVx0ZICcp
         Rgv+fEaIbcbEhBJED+1cRJrj+6EDV5YzlIbcU5dSEKQEJJZTZtr8UxIwfKh2SS7G04KB
         lmDvYyJUjbM3guAps3K85drqCsqo5E0oJJKmaacFEDvJl8wAXflAsES37rGE5aUGaGYw
         xlJw==
X-Gm-Message-State: AOAM530Owl1P/vH9j6AJSiSAck3eXyFzm1Zsoub+drFyWuEpeXco50nB
        +Pet2v4xaapdPEn1haGLYnBTM0x3wMqXm6gV4iAlWg==
X-Google-Smtp-Source: ABdhPJwQSd1vGWBZTCJlQRmCK62EXrLyrNMXIW37KTTCmpBtYEbzwPtXhGB1KcQUzWMwYntm7fopfaHU36IppUu0V+Q=
X-Received: by 2002:a67:db98:: with SMTP id f24mr1241866vsk.13.1615927484959;
 Tue, 16 Mar 2021 13:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-18-samitolvanen@google.com> <202103111851.69AA6E59@keescook>
In-Reply-To: <202103111851.69AA6E59@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 16 Mar 2021 13:44:33 -0700
Message-ID: <CABCJKucpFHC-9rvT7uNF+E-Jh20fz69zdO49_4p8G_Sb634qmw@mail.gmail.com>
Subject: Re: [PATCH 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 6:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Mar 11, 2021 at 04:49:19PM -0800, Sami Tolvanen wrote:
> > Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Random thought: the vDSO doesn't need special handling because it
> doesn't make any indirect calls, yes?

That might be true, but we also filter out CC_FLAGS_LTO for the vDSO,
which disables CFI as well.

Sami
