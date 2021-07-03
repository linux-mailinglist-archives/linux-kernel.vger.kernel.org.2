Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0390C3BAA13
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhGCTEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 15:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGCTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 15:04:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC4C061765
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jul 2021 12:01:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j39-20020a05600c1c27b029020028e48b8fso2882651wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JEpecsenF7iAJjgXAMFTkwJ9cBqVkoo+kUXfejr1pKk=;
        b=QbeoomPd6EjJRFoTq1BvZhgrd6h99OOxxAGqC4Z3TSuIr6HRO2xyZsOnCb7yiSBeTk
         dR88b5n6U0frdC/yfPSjVMviFd/oFe3Ej3c4mzE135VMOxddOjJGgwmrifuucGPiUn1h
         YHjtkr+tnA64VNd5Nq3SrGX0duEdvo/z9W82ibQnhHv7GqAyuGrlxjKAQr+BvKR3q/tp
         L3cebByB5jTBEi/iribuscFzC4E8jf8DAVTtX9XrMIR1lXPHqhItcRFVYmGSEBF4c3Pi
         QnwkrYgV2OP2RQo36v5tcyvHW2+S5CHLPcmth9lX2rLMkAiCw98pkmFFxDVFXYyJKtu7
         YWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JEpecsenF7iAJjgXAMFTkwJ9cBqVkoo+kUXfejr1pKk=;
        b=a5sv5bFh3DbLsBkilhGwNrIA/zsaZplROpBfvbrEydJhSs9u9ErLy0GA/8lANfp5cZ
         obRyU/ZLZTg3D02cLKoaFrCBYPOCpbhmCQzmLtOEZ/+JvsmzMKQTIfRIm/IrszHeOir5
         rUIy/wSxjronI2rsInsd991rhTu0FEegXUuTtBxvVIrrSyQJbsDvnYqXpfK6p5r+rjGo
         iAReeB+I4oas/aJR2P+H/PRXm8FSnKQWzW1gzKhQ2fRZwAkzdRGs0Exg35b8MLlKuikp
         hzzg9VctEzeuR82SxvyIgv1LUmhaf57zN43dVzBrH3cNeyimUQEdUSgngMzZL/JUIyyD
         oh4A==
X-Gm-Message-State: AOAM532TRSgPwpYTwXBDnvDaNtb4UQuJJVetSVLiPp2YaDHf9XeSeHoq
        l2/fV6jFpKngLrr4o1RhN7g=
X-Google-Smtp-Source: ABdhPJxO9XGrSF0iCQmGMMgulp1wMRQChDmxihWbODFm8XYP888myiUJlTeaLwavnVYmLaUqEIB7Lg==
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr5967521wmg.184.1625338906074;
        Sat, 03 Jul 2021 12:01:46 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id l2sm6775765wms.20.2021.07.03.12.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jul 2021 12:01:45 -0700 (PDT)
Subject: Re: [Bug 213577] New: kernel_lockdown.7 seems to be incorrect about
 automatically enabling lockdown mode in secure boot mode
To:     bugzilla-daemon@bugzilla.kernel.org,
        David Howells <dhowells@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <bug-213577-216477@https.bugzilla.kernel.org/>
Cc:     Pedro Principeza <pedro.principeza@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dann frazier <dann.frazier@canonical.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <0fd0f9af-65e8-b9fa-6487-ef28deb7e502@gmail.com>
Date:   Sat, 3 Jul 2021 21:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bug-213577-216477@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a few CCs.

On 6/25/21 8:58 AM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=213577
> 
>             Bug ID: 213577
>            Summary: kernel_lockdown.7 seems to be incorrect about
>                     automatically enabling lockdown mode in secure boot
>                     mode
>            Product: Documentation
>            Version: unspecified
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: man-pages
>           Assignee: documentation_man-pages@kernel-bugs.osdl.org
>           Reporter: peter@typeblog.net
>         Regression: No
> 
> As of the time of posting, the kernel_lockdown.7 manpage [1] contains a
> description about how lockdown mode is enabled by default when using EFI secure
> boot:
> 
>> On an EFI-enabled x86 or arm64 machine, lockdown will be automatically
>> enabled
> if the system boots in EFI Secure Boot mode.
> 
> I have not followed lockdown development upstream recently, but it seems that
> as of today the feature described above is still a downstream patch shipped by
> some distributions like Fedora [2][3]. If this is the case, then including this
> statement in the man page would be inappropriate, since it would not apply to
> other distributions such as Arch Linux which do not include said patches.
> 
> [1]:
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man7/kernel_lockdown.7#n31
> [2]:
> https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/Patchlist.changelog#_205
> [3]:
> https://gitlab.com/cki-project/kernel-ark/-/commit/5850c93175b9d2e1081873f4bbe08dead202cb08
> 

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
