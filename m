Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66E6309F30
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhAaWML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhAaWFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:05:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E97C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:04:47 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s24so9172702pjp.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=fMpwIVXy1EXMPiytalR0ppy2UrjVRFooJd8ie54asOY=;
        b=iAhORKnxxWQ2r9W81ggb4ym4K9riCOx5ywRWM88ub2JfF4OB9QiJbv/SVqz1ygmnSd
         AW6J4v9YIoDQucReWo3G14M1sWzXGCteVbsnAhAHwQUCcwUc4i3rEZnCIbgrr2R/Rr/t
         Qava921UX3u7Fj/eIV7Hh2HDoa89L8StonWeRzkmW7/szc2R86kN/0oHlTXHpLZ3p9/y
         j9CyhM1Oi/F5RNFiVm0Uez/csLPbnXoJOrehCGkklm+iw3nCePqCEeNa4Uwhz9lCpsdJ
         b5i8Ia4bVqnKGpl3zbKJUGK/LQuzx87AzTFEMdvG3VOC3bUkIUgxqtuKj/CGjbIQ766K
         fgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=fMpwIVXy1EXMPiytalR0ppy2UrjVRFooJd8ie54asOY=;
        b=uUKjJmzwZoSPwifkQRfiosjl/e8mENpYzo+TnrzL0/K+vbOHNu2Ut4wxkTaAdTuMIy
         HDxXDEcuaVJgVvAHg2HRvCi23XfS1M7JATlNIMF0Lpd+YXPYvt/NNGfWKUYQIGYidmbg
         wrSixDI/A4ETQxMGtKHyj2npnEIp/HtZ+5gQ11GRJgSljAJArFdr7pOaXmroB5eTdQ1t
         VE3PzSrBG0pgDlyfr3PK0yQroGeXW1bequqTIf2LDPN+GxlS4gmW0CWW/ZoHbk2nEv24
         F9cJSCVRI8XOK75NyR+8G01HZiWrvK90mgShZPjDTiFAxQLIr4syryJZO55ouCMWVUoO
         EHcQ==
X-Gm-Message-State: AOAM5338CMZoddRgdckfBmhJjkGrdshvN2V9OPVqKuyIA/gFBi7qX6dS
        GZ5Wrbc/1EClURvVEFR1NRFxtw==
X-Google-Smtp-Source: ABdhPJyv1GHgFKkIT0LVGawa5GQ5evss0LgCqhESimh/Ti673OrzwjQ/2kVMlYjaXTv8i/cplSYykA==
X-Received: by 2002:a17:902:8ec1:b029:dc:8ae1:7a22 with SMTP id x1-20020a1709028ec1b02900dc8ae17a22mr14817479plo.6.1612130686932;
        Sun, 31 Jan 2021 14:04:46 -0800 (PST)
Received: from ?IPv6:2600:1010:b05e:e964:2432:9f62:e00b:9795? ([2600:1010:b05e:e964:2432:9f62:e00b:9795])
        by smtp.gmail.com with ESMTPSA id z15sm15468921pfr.89.2021.01.31.14.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 14:04:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
Date:   Sun, 31 Jan 2021 14:04:44 -0800
Message-Id: <0456DEB3-2EA6-4CA6-AA59-E5E1D8F1A77A@amacapital.net>
References: <CAHk-=wgeG7WP_vxho_bfENK3rYP9zUF0_ZjA1X3OftERrs_j2w@mail.gmail.com>
Cc:     Kyle Huey <me@kylehuey.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        Robert O'Callahan <rocallahan@gmail.com>
In-Reply-To: <CAHk-=wgeG7WP_vxho_bfENK3rYP9zUF0_ZjA1X3OftERrs_j2w@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 31, 2021, at 1:30 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFBtw Kyle, do you have a good simple test-case for this? Clearly t=
his
> is some weird special case use, and regular single-stepping works
> fine.
>=20
>=20

Indeed, and I have tests for this.

TBH, the TIF_SINGLESTEP code makes no sense, and I think it has at least thr=
ee overloaded meanings. I can try to look in a bit.  I=E2=80=99ve mostly avo=
ided breaking it in the past, but that doesn=E2=80=99t mean I understand the=
 original intent.=
