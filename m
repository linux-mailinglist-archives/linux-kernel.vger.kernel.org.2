Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6D53126B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBGScU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 13:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBGScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 13:32:16 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58329C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 10:31:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t29so8259463pfg.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 10:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=sJpbKfQz1Sf/lqNXg6DE2DivxCyn6HYIoM7Gm7iJ2x8=;
        b=Yw/rM/DQ4mpgg6RlV5bUpQHz9uDQxiMulb7nPPOysw6sPTP6G1p9thtNdXirNIhUYd
         rvfMIIdim1BlcDDxtRLSoA388VpH6fGt1I1e2nwb6A45S0XpC37O6ftBCyorjN7P44m8
         Wv4Fj/OsumTdrVhTZQAy4VCi6n+RfVRJ8+T+CerqNckoynOBGUnxUfiaFtGx+SiB8+WK
         zTke2Yf8d1R9olK64hcKnEwImagixLg6WZ48boLHQeeoSV0Jz0FDDsEk3NwhOoA36vUE
         a2QICY9vSHkDfzXfDj+BLxtobkHFg2IWXSTh6IfjUz5EtzrVPImlWV12pZmE9S02v8K0
         1vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=sJpbKfQz1Sf/lqNXg6DE2DivxCyn6HYIoM7Gm7iJ2x8=;
        b=SysGuhsjQD4A+9R7RwRYfgz3pCrdxuWoB9n4JT+l/S8d0BCpm9KzRtnE4JkbNRHJCw
         B7Go7l8ZbTFYiiqj/Mh1ISpIaJM1/gjnaCkzivCNza3OtSQCniTjZpwA4i17EQqiflMd
         JOuetrCyXi+6YCqiAsGpXSpsToIm8CpAD8jepVX/Cpp1DAB+85xSWghievMcGKkXqddX
         RDzBKomrT/Ygq7nVLh03LOU4CCR5YhUmNn66ofZR63x46YpiWPBOrktr2fcFLOeK0/W3
         fCM+ilrnfMIm2zmnxWV6f/wo6dZwtd0Tt5S1vhpxG1bNW+SQww6wJ3zoKN8YS94zUshl
         735w==
X-Gm-Message-State: AOAM533Q/UMaXVKOY0ZTLx2iylMFxKgcjlOyKEFNpD1h73PjajgUNAJ3
        eLVMog4LMnCyJ0stzq9JzapODQ==
X-Google-Smtp-Source: ABdhPJyOXcn++rC64ZJOxXLIgUX6hH/ticPcUuR8LbmlAurjFNLUrCMT0wlN0ISxvFIWCcy2rhloCw==
X-Received: by 2002:aa7:9a46:0:b029:1db:57ba:5e2 with SMTP id x6-20020aa79a460000b02901db57ba05e2mr5206071pfj.5.1612722693934;
        Sun, 07 Feb 2021 10:31:33 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:1cfc:6e60:639b:3d2f? ([2601:646:c200:1ef2:1cfc:6e60:639b:3d2f])
        by smtp.gmail.com with ESMTPSA id it6sm7019904pjb.15.2021.02.07.10.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 10:31:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
Date:   Sun, 7 Feb 2021 10:31:32 -0800
Message-Id: <2BFAADF3-EBAA-46D6-B1F6-7A41CB85DA1C@amacapital.net>
References: <661b9809-2c6a-5fc8-163b-a159b84c9ab8@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <661b9809-2c6a-5fc8-163b-a159b84c9ab8@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 7, 2021, at 10:19 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 2/7/21 9:58 AM, Borislav Petkov wrote:
>>> On Sun, Feb 07, 2021 at 09:49:18AM -0800, Linus Torvalds wrote:
>>> On Sun, Feb 7, 2021 at 2:40 AM Borislav Petkov <bp@suse.de> wrote:
>>>> - Disable CET instrumentation in the kernel so that gcc doesn't add
>>>> ENDBR64 to kernel code and thus confuse tracing.
>>> So this is clearly the right thing to do for now, but I wonder if
>>> people have a plan for actually enabling CET and endbr at cpl0 at some
>>> point?
>> It probably is an item on some Intel manager's to-enable list. So far,
>> the CET enablement concentrates only on userspace but dhansen might know
>> more about future plans. CCed.
>=20
> It's definitely on our radar to look at after CET userspace.
>=20
> The only question for me is whether it will be worth doing with the
> exiting kernel entry/exit architecture.

I assume you mean: is anyone sufficiently inspired to try to handle NMI corr=
ectly?  I have a whole pile of nacks saved up for incorrect implementations,=
 although I will try to wrap them in polite explanations of precisely what i=
s wrong :)

(I=E2=80=99ve contemplated doing this myself, and it doesn=E2=80=99t sound f=
un at all.)=
