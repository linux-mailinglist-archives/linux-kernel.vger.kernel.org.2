Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704563F414F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhHVToE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 15:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhHVToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 15:44:02 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54EC061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 12:43:21 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so30478970oti.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=DMfIWOhFe3qaC9h+9YLAP+c2LBKRQ3gdYwp7WysDJrs=;
        b=ADqz53oR6xeOoSl6KMMNcE1Fqk4NMeVzVnjfvty5wLCMJRXE0Mr13O+rpFqxzflphZ
         prtOJOd00OQ7GLPy0pxdbQugOt8bL67ZAu+99Nh5XJVfmGWU8FOy+rjVnkduvoCsmaXa
         4wnSOcDEqXTHwJU0lq0ncuEzhP2yQxHV0ELKUz6dwBeyO10feJD4nX/GUN0BbIw2ImSr
         h/5yyFtaQeCLkVJuXkOSED4jUfo9pR7lTml7K8O8QqVswj/yHS/onsROmmR17mRlH/Ei
         XjJmfaDDSWhJQkqCB9KRHpb2y3dWQaSFmFFWYbM1pkJlT0x6R529cDjD4KOZitFIDZfD
         FRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=DMfIWOhFe3qaC9h+9YLAP+c2LBKRQ3gdYwp7WysDJrs=;
        b=kM0Vf+s2xnqK8ULRQsDUigZkGEQLNrEA2VIyrojuwZzPwEHHYIA5vDcpz+93NNOU5t
         XWM9JmHZkWNGI9rCwUcSoPzdybMxkcLen7l+YJeFmy5kKpY2hQocR9UUTzK0FRrNBN1a
         /YrVH9EqdbkIgE6fkv1C2IBxT/Qtc8tx0zcN7CI+m9AdAyV8W5IrtcoRGUQUypEpUNGu
         dbSJtER6kwgKpWPcpfy5+lsOCzf8ybKbmFdRttsQVCYitPahADja2uKDGh0ls2zjiLZ6
         oDkHg4sP+ENIXVit1uDo2ihlynM4OYSy8tm8W7VGHTNWm9tbQ0Hhmr7QIxjD4ifWfH2E
         CIBA==
X-Gm-Message-State: AOAM532hbNecU7+c80rbKp+khNIUVHv3I/L/p2TBqhO8EwKPIDe5pRED
        9AvDIv9mOteNV2q0c/6Bz1UbO3viU070Wona4Q==
X-Google-Smtp-Source: ABdhPJwbKXbe+EfpoGR9pE6TyLi08w3EJLS+7mfMLLaZhmrlixZw9pG3SqaLN+B+6it8wRqPHRy+f7zCYpYC5TNit48=
X-Received: by 2002:a9d:4683:: with SMTP id z3mr23759432ote.95.1629661400855;
 Sun, 22 Aug 2021 12:43:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:1e89:0:0:0:0 with HTTP; Sun, 22 Aug 2021 12:43:20
 -0700 (PDT)
Reply-To: nandung726@gmail.com
In-Reply-To: <CAHVnpaszL7b9+4UHf5q5vMye0w=XgHBr2OMWBsn1e_W4-Fqf7w@mail.gmail.com>
References: <CAHVnpasJr5XzF96-J=cTN5_e_gAopyFWJtMstUfrPwDnYOnjiA@mail.gmail.com>
 <CAHVnpav-XVm=8bjT-==bG_qEd+hcKyRJU0s1EaK1sgQLWEx44g@mail.gmail.com>
 <CAHVnpassL0SoJkLLNbBDvms_BSSaq=HELS4+xuO9o0VOMM7kSg@mail.gmail.com>
 <CAHVnpas-0_FMDSTXczxQpTO+J3cogT_pQ6hA_dMjOr5PfW-p_g@mail.gmail.com>
 <CAHVnpavTFbsFSv9d7Pm=ExQ-qXQszL56teJQQwAH2bhaso6weg@mail.gmail.com>
 <CAHVnpauNMyQVvD63ugjFG-DMJ2yO9RzE__hQipvyvQNWghKuGw@mail.gmail.com>
 <CAHVnpauK+mSy-34SvMM6mrR3-F944gJ2oz9hgLN0smW7qfkHMg@mail.gmail.com>
 <CAHVnpasrOKK0wF=es2Hp3JV2gGzgFuup=6W12eZK+XM5iZoHuA@mail.gmail.com> <CAHVnpaszL7b9+4UHf5q5vMye0w=XgHBr2OMWBsn1e_W4-Fqf7w@mail.gmail.com>
From:   An Dung Nguyen <geoffroyadjivon3@gmail.com>
Date:   Sun, 22 Aug 2021 19:43:20 +0000
Message-ID: <CAHVnpau05FHbnXPuSxr3q5zJF2Khvx2ShjgnvY-8n=+kZZ78QQ@mail.gmail.com>
Subject: Fwd: Investment in your country
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
My name is An Dung Nguyen I am contacting you because I want know the
area that i will establish my money and it will be profitable in your
country.

What I am trying to say is that I want to invest in your country
please I need your guidance.

Get back to me so that I will tell you more about myself and the investment
