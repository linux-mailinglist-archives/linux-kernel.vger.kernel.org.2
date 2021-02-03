Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD49630DEFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhBCQAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhBCP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:58:40 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E57C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:57:59 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v3so25182qtw.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xywV9eMRMiWViCjiK4rzNmLwiq1zdJg8S+9jtfPFzMw=;
        b=QAu01BkZL7yF73qfm2zuunwSuRnuzrhcX40XHeO4gvcNVjMyM8x0os3EVHymtyIpiW
         cvYkqO/4ZTu4fsQA63iTvbkcOl3p4pAD+mvE/l+heD/NBTBx7yu6surPVLHqqjejUwFw
         SEelkjNO8vUNVluvv1IagkMgPJUKrz6o7Xqbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xywV9eMRMiWViCjiK4rzNmLwiq1zdJg8S+9jtfPFzMw=;
        b=Mee8w804oKiP35lEKpsJOky2quX/gYsBlTs77Lx4xjN04u2EU9+p9IXlltJM2DVZuU
         t+yZnDDewYAyVDAj4Xk1lJ4QPcx495f3Jp07u3s1urUDTNsBuvkmXJF2HQLjA0i/dIIe
         JRHSoDcX/T5OpgTOxHiBwI/tPB5QFP36gTDWazOyO4yQQmlQyp67Gqa7Ny+Sz0+/BoUv
         nNHlQiGuC0fpkqZmPzPNxJjW02i0K7MaKhU+XqbyigFjwjaIzv+Sc681r/Bj6Skfssyp
         QI3J4v29kuOMKwUR4N3QLkzY5lJSjfEiE+LsDM5uoBdgFIQp+L/Lq0Kk0kqwreyszTsZ
         xuVQ==
X-Gm-Message-State: AOAM5338eHpKjFo0vdZstW/wbVSlNfh7z2cyWKN1eY6fwut6GWG4j16L
        46LozSo580D3GToTjJZItq69+Igb6Q1qaQ==
X-Google-Smtp-Source: ABdhPJyYe0Au8B7KNRc1zCY8FJDJvLyfDQIDsP+5wylj2jwRBKg8QKifiWCF1TPgcQgIKSMBXRe4Hg==
X-Received: by 2002:ac8:6b45:: with SMTP id x5mr3104910qts.226.1612367878566;
        Wed, 03 Feb 2021 07:57:58 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id r26sm1623144qtu.51.2021.02.03.07.57.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 07:57:57 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id j84so85188ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:57:57 -0800 (PST)
X-Received: by 2002:a25:da53:: with SMTP id n80mr5263122ybf.79.1612367877243;
 Wed, 03 Feb 2021 07:57:57 -0800 (PST)
MIME-Version: 1.0
References: <1612005840-4342-1-git-send-email-stephenzhangzsd@gmail.com>
 <CAD=FV=WQ7iCQFf6Qb3agM4DCt_Df3c6BwV_T6tEMMxXArbY_5A@mail.gmail.com>
 <CALuz2=erXGa2q_ODOpARK9yb_GQo0nOLWnP-PuBMCc+pv8Cp4Q@mail.gmail.com>
 <CAD=FV=Xcywabh3U0=hzd8DXR2gdwLBEFsbwLof7Y6LMu+ViPNA@mail.gmail.com> <CALuz2=cApyqB2FWvf8GVhAtGJrBGVWxTvQmiiOFUN+zouqZOUA@mail.gmail.com>
In-Reply-To: <CALuz2=cApyqB2FWvf8GVhAtGJrBGVWxTvQmiiOFUN+zouqZOUA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Feb 2021 07:57:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wfg4NOCioKA4OHuaKezGgusc38YgMQ9U6Zvo7dO=zY2w@mail.gmail.com>
Message-ID: <CAD=FV=Wfg4NOCioKA4OHuaKezGgusc38YgMQ9U6Zvo7dO=zY2w@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: kdb_support: Fix debugging information problem
To:     Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 3, 2021 at 3:31 AM Stephen Zhang <stephenzhangzsd@gmail.com> wr=
ote:
>
> Doug Anderson <dianders@chromium.org> =E4=BA=8E2021=E5=B9=B42=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:40=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> <tab>kdb_dbg_printf(AR, "returns [...] (%s)\n",
>> <tab><tab>       ret, symtab->sym_start, [...], symtab->sym_name);
>
>
> Thank you for the detailed explanation. In this case, Shouldn't the "ret"=
  be under
> the "(AR"? like below:
>
> <tab>kdb_dbg_printf(AR, "returns [...] (%s)\n",
> <tab><tab>               ret, symtab->sym_start, [...], symtab->sym_name)=
;
>
>  See
> <https://www.kernel.org/doc/html/v5.10/process/coding-style.html#breaking=
-long-lines-and-strings>
> where it says "A very commonly used style is to align descendants to a fu=
nction open parenthesis".
> The "descendants" here means the next line, right?

Yes, "descendants" means the next line.

I have a guess about what your problem is.  In kernel land, tabs are 8
spaces, not 4.  Also make sure your editor is using a fixed-width
font.  In gmail my example might not look like it's lining up, but
when you go into the editor it should.

-Doug
