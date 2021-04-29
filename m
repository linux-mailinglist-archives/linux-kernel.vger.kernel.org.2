Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BAE36E484
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 07:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhD2FgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 01:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhD2FgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 01:36:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0879C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 22:28:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h15so13168767wre.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 22:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=b2FQYBTKIQxxvWpLdBy5hB+f/AWhIJ7bCL/fYgN0lJQ=;
        b=FU2tLJOp60qtDYlvEuc18TDIthKQB9ReglgwbUXVP2x7iCCHX7xvaZmKp3ymcyeEu/
         MPSqkCuPdt1ZOddmwCU0Em9cJPc+H2sdFtwGLD+/QLuafbgTUzda/8EkfrI7OkX4ho8p
         RBkbJ1kt6iu8aUcK8Xca2eyI9hLguf7s8gGscGAmjPG6/eTJHkgxTz2O1deUXqNOztRO
         cPwlE60xK+y5YSQiBGieg8yGK8hsVJCg3+jo9FbRZDYqstr2/Uzbo+jOWWKfSSi/q6JL
         UqWFX+gpYm6ewbY7StMqdyo1j2uOmQtm35+8O3L7JkibT7/7sQk7rRQBXT2kzniE4gb8
         oz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=b2FQYBTKIQxxvWpLdBy5hB+f/AWhIJ7bCL/fYgN0lJQ=;
        b=kQ4Ciuj92JO2Kwhj95+eZ4TEN28QuN/WZHQEpGgTqaJ3yaRUU8D9/o6mjjoH3KehSK
         ycOJTwNPdJU/CXJVC8iRYl7s/ZwGScn/dbVyvQ69VPYYKC+oxhrW/a/kgRtXAF+u7NoJ
         lf9u97tRYzfKUdNy3T0E3imr084l3qMjp3EpkMD8qTqOoaqPH7lPv7pJHd9m1TTF26WN
         +dH1L/fQjwUBYD8ELzCqIBoDPXZ0HVXy6TefqBGMrojo9Rj2GN5q+5K6GG/ycIBtAQfg
         0UqfU4acb6EiQ7saY471uA0x4NcvHDGHzWuhlVfIi0hARBKB5TNlTNcL8VMJFG5nYNex
         ob7A==
X-Gm-Message-State: AOAM5322sCIF01dvDGCLbl4x12qowGegGXolBSA4vjF9kL91BzwGIyqg
        2Ft7CU6r1NraBZGVERNTrd6nOxPKI1b59Bk0W8Q=
X-Google-Smtp-Source: ABdhPJzooUa35nX4yFBCXDLpj0pcryfvAdRjdK+YaKHFUJYl3oHfFAcvYO/goHMqqU0PLZ8qOiQCCfxfVKey94Uwm8U=
X-Received: by 2002:adf:dd4f:: with SMTP id u15mr26096807wrm.308.1619674126471;
 Wed, 28 Apr 2021 22:28:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:f401:0:0:0:0:0 with HTTP; Wed, 28 Apr 2021 22:28:46
 -0700 (PDT)
Reply-To: yakubujohn940@gmail.com
From:   Yakubu John <akachimiracle9@gmail.com>
Date:   Thu, 29 Apr 2021 06:28:46 +0100
Message-ID: <CAJbOLe8j2awsb=v+XYwtS7nfcL5No6KfQa=XuPJHQOdzW69F+A@mail.gmail.com>
Subject: Greetings Dear Friend,
To:     natural.jeon@gmail.com, tuckerfamilydent@gmail.com,
        duongbaongan3012@gmail.com, damienjeon@gmail.com,
        ieoneugene@gmail.com, jayeonjeon@gmail.com, ddpcrea@gmail.com,
        tacticalcombativesdiv@gmail.com, emily.yj.jeon@gmail.com,
        maxace70@gmail.com, mojavemel@aol.com, zzbroker@aol.com,
        katherineziff@aol.com, GottfriedAnger@aol.com, eugenecoin@aol.com,
        tanujac@aol.com, chaudhary.t@pg.com, shiulin@aol.com,
        ecsdel@aol.com, scohe078@aol.com, pastornancy8192@aol.com,
        marco.cozzolino@aol.com, huanganchi@hotmail.com,
        daizostudio@aol.com, carpiwlks@aol.com, amsellent@aol.com,
        phoeenixorg@aol.com, cjiwakurax@aol.com, jeansnotes@aol.com,
        qmi2@aol.com, tradeswomn@aol.com, skalash555@aol.com,
        lillianhg@aol.com, denisezao@yahoo.com, dzao@aol.com,
        jasonzao@hotmail.com, kenninomi@aol.com, worldaqua@aol.com,
        rblgirlie@aol.com, SFPResearc@aol.com, Awcantor@aol.com,
        KingFamilyReacts@aol.com, bruce4d@aol.com, k1tarsh1@aol.com,
        jhinte5635@aol.com, dcpozza@aol.com, RedDogFerris@aol.com,
        Abn187thpf@aol.com, agriwaste2@aol.com, Is0913@aol.com,
        namjae.jeon@samsung.com, sergey.senozhatsky.work@gmail.com,
        linux-kernel@vger.kernel.org, ljk0201@gmail.com,
        dohshin.jeon@gmail.com, jeonwonkwan@gmail.com, kimnaehye@gmail.com,
        j2motion@gmail.com, junjin0403@gmail.com, Rayjeon9695@gmail.com,
        mjsensei@gmail.com, mjeon@mccsc.edu, jeonoju@gmail.com,
        andrew.jeon@gmail.com, cybersurfer240@bright.net,
        jjeon0923@gmail.com, DanielRufoloMusic@gmail.com,
        isshjeon@gmail.com, hongseok.jeon@gmail.com, hanjunjeon@gmail.com,
        djkashnl@gmail.com, Redaksikabarwonosobo@gmail.com,
        choijm@gmail.com, kimleang_khun@yahoo.com, jeon@snu.ac.kr,
        clonghofer79@yahoo.com, liyatai118@yahoo.com.cn,
        micronpt@yahoo.com, g_e_montenegro@yahoo.com, meeess22@gmail.com,
        zbeans90@gmail.com, alswls4127@hanmail.net, parkwndjs@naver.com,
        hhj3274@naver.com, richcanz@yahoo.com, jeaninhollrp@gmail.com,
        bjovanovic@outlook.com, qilei.li@outlook.com, kjkintl@outlook.com,
        chu@hotmail.com, jyj@yahoo.co.kr, shjeon@intelpus.com,
        info@gnm-mail.com, Hwayoung.Jeon@colostate.edu,
        carlos.moura@mail.com, mail_a@mail.com, mail_b@mail.com,
        keemfunny@mail.com, cherrytreeproject@mail.com, info@jeonsa.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 


-- 


Greetings Dear Friend,


I need little of your time i have a business transaction to share with
you in sum of $10.2 Million USD which rightful

belongs to our customer Late Dr. Walid Ahmed Juffali who deposited the
money in our bank, bank of Africa(BOA)but

he died of cancer ever since then no one has been able to apply to the
bank regarding to the fund and the bank

is able to transfer this fund to your wish named bank account in your
Country also this deal is risk-free i am

absolutely assuring you that no trouble or problems will involved in
this transaction either In the short-run

or in the long-run of it, i need you to apply to the bank as his
business partner also kindly note that it will

be shared among us in the ratio Of 60%40 So my beloved kindly forward
Your details to me If you are in interested.



Your Full Name....

Your Bank Name....

Your Age And Sex....

Your Occupation....

Your Telephone Number...

Your Country Address....

A Copy Of Your Identity Card...

Yours Faithfully
Mr.Yakubu John
