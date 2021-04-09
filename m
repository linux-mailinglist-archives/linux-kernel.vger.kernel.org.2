Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE71D35A872
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 23:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbhDIVol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 17:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhDIVok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 17:44:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32CC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 14:44:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so5998771wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xXnoWdHvFEMpnYeMmCx8+vDj7r73l2UDR2+MNWmyRCU=;
        b=RGbxbx4m1+uucwlFeDcsTASEd+2tMnURvBeMFOQOO+2JYG9D2ieQjdFDp9cQHCp109
         sIhiRtyoXEJ/qLCzx/2SFFUKe9iCkIBoM8mXOQcP+d8tj9yo0LSxNnPEEysM3JIk8FnT
         Jyf/6HOxnPAIxC4fvz5Fawa0p6cllkJGma8khzxS4vSD0bI/kfkXSr2sTYy/nuXRP5Jy
         Y/f/L5z8C8hrHJkucYTKmT5Lm7wEt82aW3/W4w9dmvxErxN5TOH25DJgIvzmgSQDO+rO
         PdFdkf94IbmxTR0oKIteZ+O3at2i1egzCJiahBRt/gVMbfRD3k8IcIp5qns8s4dcNzoB
         yzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xXnoWdHvFEMpnYeMmCx8+vDj7r73l2UDR2+MNWmyRCU=;
        b=lwR+DK5gI9lJLEKpIkL8O0Au9SeiNVmsBHosxXtyqnoRK4bK27HNH4E6D9VWIcvWif
         y7ynJKXf9VwsdtTTJ5TgpEGpSN1TyFV2VGb7RQpSqsKWCbNEKOSTNblIX+fxV9Xj6OY4
         yuJK2auHzaDk6F1NWhG/z/W+Mn2WlVDBzsMbej8O9r4KpkRGkbso1/c4ZN3ktkU1fQiH
         KYt+yX5lC48ymubPvHXlvBmETWd1J5uutLCXLApTsTEHfdQ+BZwOPQkgENgtEAPwDama
         QlUDKCUJRt0nhHVGLLmeI/FS9ypGr8hl+WWqipiQLYVDzfuW5KQED9Bw2yrelIB6uyCH
         qZyg==
X-Gm-Message-State: AOAM533M61KKsxxekahZKI71tsWmdjcL6+QYZGMGcgy21l3iOKmx1ABr
        mcx8vUS/Up9ImhFvbmxh4fZceS3WyqGQEOfu8FU=
X-Google-Smtp-Source: ABdhPJyo/cBN5IWNYMo/8ab0L3CBlZKmBHyq+wGuy5B+6pPiQpTjUwhULEETgssmOA1c+2ynahTLUN0KtDXZOXxi7Fk=
X-Received: by 2002:a05:600c:4b86:: with SMTP id e6mr15525700wmp.78.1618004664816;
 Fri, 09 Apr 2021 14:44:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:5609:0:0:0:0:0 with HTTP; Fri, 9 Apr 2021 14:44:24 -0700 (PDT)
Reply-To: rmadamkoenig@gmail.com
From:   Mrs Ruhama Koenig <engr.charlesluanga@gmail.com>
Date:   Fri, 9 Apr 2021 22:44:24 +0100
Message-ID: <CADG9tUaeBPbUOhxkxZnuPU43V=R78DjS_5m7N6Sq6tSDRejCyA@mail.gmail.com>
Subject: Re: PLEASE TREAT AS URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20

My Dearest,

Please forgive me for stressing you with my predicaments as I know
that this letter may come to you as big surprise. Actually, I came
across your E-mail from my personal search afterward I decided to
email you directly believing that you will be honest to fulfill my
final wish before or after my death.

Meanwhile, I am Madam Ruhama Koenig, 73 years, am from USA, childless.
I am suffering from Adenocarcinoma Cancer of the lungs for the past 8
years and from all indication my condition is really deteriorating as
my doctors have confirmed and courageously advised me that I may not
live beyond 3 weeks from now for the reason that my tumor has reached
a critical stage which has defiled all forms of medical treatment.

Since my days are numbered, I=E2=80=99ve decided willingly to fulfill my
long-time vow to donate to the underprivileged the sum of ($18.5M)
Eighteen Million five Hundred Thousand Dollars I deposited in a
different bank account for a very longtime because I have tried to
handle this project by myself but I have seen that my health could not
allow me to do so anymore. My promise for the poor includes building
of well-equipped charity foundation hospital and a technical school. I
will explain to you why I wanted a total stranger for this when I
receive your positive reply.

If you will be honest, obedient, kind and willing to assist me handle
this charity project as I=E2=80=99ve mentioned here and can avoid contact w=
ith
anybody for this fund until my fund reaches your hands, I will like
you to provide me your personal data like:

(1) Your full name:
(2) Country:
(3) Phone number:
(4) Age:
(5) Gender:
(6) Your identity:

Contact me via my direct email:( rmadamkoenig@gmail.com )

My account officer warned me that anybody am sending to them as the
beneficiary for this fund must keep secret until he or she receives my
fund to avoid impersonation and wrong transfer.

Best Regards!

Mrs. Ruhama Koenig
