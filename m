Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1335593E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244074AbhDFQdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhDFQdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:33:46 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ED0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:33:37 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id r12so8126621vsj.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=8z6k0nvfMeU4+kk1Rlj4CMcpU7JmVD+ziX5/+jJBhDQ=;
        b=GZ1dtc5fhSxEdvvCs/xU7BbrGVIT5/ZcAKY0pk/BwedF+Fg9P0A9fA3QagYNiSFY2y
         62hhv2t8pNSk2xwbN2m4n9eFZbvoHFMWkIHLdxQsQM8mu/Qs6nWDONEQGL3mg5mlzJYg
         pGUm/PmN6kjagTIk8KOocByP9/NZ4VftK10mWqas9Z+5Crt3fwME41uhLhbtqhvyIQFl
         E+m8uLCWxB5IBuogUhBzYbWnnCygWi2C0DYqORcYfFJhAThJt64ndCt/fXixjjX74cQe
         hgG/i0dN69jCE2Oq2FWUGLUkWS/pQROKMbpJ8X1bDrDByu8WMDY2TKSgCs84URnJStKL
         kBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=8z6k0nvfMeU4+kk1Rlj4CMcpU7JmVD+ziX5/+jJBhDQ=;
        b=G9xn27EmCwHJxxtaFQpyKCwfUZmUPxW0hrvKEIft43Dw+JNCANBdpkguoICFpN211X
         iQ2cfevJDV+oDoKVyNFLpfA4doj6NKsed7GOXYz1CZbLEgjQ5sH3eWDEgxGQ53BshpkE
         KPO3MQsCmuJRd/HLBwWBiQjU4W2ZOu2xMSBB7DTF8aS2CqJpBdsj/oDGXAycZHf4gl6+
         erO/HlJfRD29jt30ldkk52OvobTGZK5H/DnqoZLErEF8UteG/KJPfAXMGG/M7Fc+afZl
         +GmmJjQQFlHkUmeEwDpe0wCo/mUOrpjKSur8U3RiCcVzM0aISy5eYQbwyZIcAg/8Hzuc
         e6KQ==
X-Gm-Message-State: AOAM530JRa4SQrlXUkHAJzNPsdTr2gKjcY42XFbRx9mLAbSww7E0VUqS
        ksRpsYPMY4v76zihbU+cEWlar9PlnOyaPiodCEo=
X-Google-Smtp-Source: ABdhPJzP7cLXwXtYERURX84X+HArAtoImOQ1im1lFMbpfog91ExWFp4LSsseUgwSK1jO1TuKMBXrb6qH3ByKXMHAptA=
X-Received: by 2002:a67:fac8:: with SMTP id g8mr17969023vsq.42.1617726816844;
 Tue, 06 Apr 2021 09:33:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f8c6:0:0:0:0:0 with HTTP; Tue, 6 Apr 2021 09:33:36 -0700 (PDT)
Reply-To: moneygramdepromo@gmail.com
In-Reply-To: <CAFy6TRB8dWLNGJ2F814J8sE7HoEN=zCoTYbc-2gBeZCHSTpzMg@mail.gmail.com>
References: <CAFy6TRAMDpv4OjpJih844XQ_WdkAxGK0d_tfGmDOYsrvQhN=WQ@mail.gmail.com>
 <CAFy6TRBJcpwrONPQ8-f=3RZdJ=CubxwP48zxsZUqUYs=zYT8jw@mail.gmail.com>
 <CAFy6TRDqWqr6-q2PuTKfW6g1iXK9xAmooJtWHpXqgt-3YbeY2w@mail.gmail.com>
 <CAFy6TRALRihpuQFKiRhcUQ0cy4dZHSguEpYvBn2M1ACM7rYb3g@mail.gmail.com>
 <CAFy6TRD69-hagcUL_b93gPk8BBDRniafxN=uq3Xmwzm9+QiHaw@mail.gmail.com>
 <CAFy6TRBLK-Bif=3hKtu_LyNGZoqQ5c=FLpjE8AkU7HGdEtro=g@mail.gmail.com>
 <CAFy6TRBfo7X00iTXQNaM3qbFtJiVZ-CZq944pGRXOgZgR5j5wQ@mail.gmail.com>
 <CAFy6TRAv-4EsCAJCyqDRuwoM74T7ZGO41nFNywqZruEdTqhyYA@mail.gmail.com>
 <CAFy6TRBUMJkn3hS=cOcDMeTCb5Bz=HThvGJaubBsOX4WpWqQfQ@mail.gmail.com>
 <CAFy6TRChjZZnKPQYzOz5t3FN_bqELdeOUMgx67=gEfP-iF+jBA@mail.gmail.com>
 <CAFy6TRBfAKRckf4u7cpFWGryrbVWJSiwSi9HUg07j3CtkCxc8A@mail.gmail.com>
 <CAFy6TRD_fEL8do7Vi5b4R_h3D6EG7k++HN-LWN8B3EmwS3e_8A@mail.gmail.com>
 <CAFy6TRAbBEtrDQOoMnvUhDu3onXsDx2PKe0KSzpKytzM9hVyaQ@mail.gmail.com>
 <CAFy6TRDdBgjiUggZh_heZ2apcekjQdXFYab1wgbtTVOCg637Ew@mail.gmail.com>
 <CAFy6TRC=ZPJoZmzRRDWdA0ue_oXE7zWqjnZt+f1_YL10qLPKZQ@mail.gmail.com>
 <CAFy6TRAkM8csFYrMc_WnCDYT7WL4f+R56Kd2eCutDpoqh1c_Fg@mail.gmail.com>
 <CAFy6TRALJf7F4ghGn=1eg9iuQ698o1mY=ZH9wAz8BZ0gm1CjSw@mail.gmail.com>
 <CAFy6TRD=axZtx3_iYzifSc0Sf-S_No1ZO9z2jPvEy-j0+RthyQ@mail.gmail.com>
 <CAFy6TRDg+MkHKX_3UU_1Ump_fDfZxhLN6AJyPW=7H+PqFqFvVQ@mail.gmail.com>
 <CAFy6TRCqW1LRh_d2051H=wNgSkLMSpWjBEJ0==3iXMEjkAGz0w@mail.gmail.com>
 <CAFy6TRBZ+Df4UBs58kU3JNTMPGZa+mT+Z07z8bMB1jT5iP-JwQ@mail.gmail.com>
 <CAFy6TRCOJQv_Z=rsabfVundyxh3qVkROGGoh8Nf1iFET2PY6xg@mail.gmail.com>
 <CAFy6TRBHWe2E+3HDCzs9F86CpQjqvjEXppQ7JBMk0pqjaSZ4CA@mail.gmail.com>
 <CAFy6TRBh1urzEJqooEjgeF6HHuoW5PX-JM1U10JKBjvRp-gMAg@mail.gmail.com>
 <CAFy6TRD8KJjt5eOSQoVZzrfezAzquOxqLyU7g-0_g3u4+psVjA@mail.gmail.com>
 <CAFy6TRD=xD=-VDzfOypYvJC5nh38V57C=m=bcJj93=9drtXFzQ@mail.gmail.com>
 <CAFy6TRCUU2onN+vVJ_KtjaUX2E7Ei9TtoUYK1uKChFTs5=Yqdw@mail.gmail.com>
 <CAFy6TRC2d_54wg3roARv34iNqt0ATrSd+hbcy2hZ_MDs1LKSZQ@mail.gmail.com>
 <CAFy6TRBuz4dGvzRk3pAGwo3u2jm_mpWTPdf=qDT5+JNeuTg-Gg@mail.gmail.com>
 <CAFy6TRA7eDQLCd_FAqOiA6HS_HxiQVPOTe0K8CL=EeDjAnjGPw@mail.gmail.com>
 <CAFy6TRAcnv3tcU0qJbngqqEHh4B_3CzsSAb_6N0vQaF+DVq1iQ@mail.gmail.com>
 <CAFy6TRDECiwyoR_WLb8OmWJqXCBnqpouStdh2MeeSD-jazY7Kg@mail.gmail.com>
 <CAFy6TRB_ZLObiQZ-xfpYOw=n+PZ+OVEkCRTWyFjBrWDOxkBVbg@mail.gmail.com>
 <CAFy6TRCLWw6NghfkZPnzrHYeUjKtpMERNcPU3JQE5Ho6i_ZAYQ@mail.gmail.com>
 <CAFy6TRCr6F0jyFmBDdvZr1AXM4d66Zt_v+=rqSJnKxfKek+2kQ@mail.gmail.com>
 <CAFy6TRD264yeW7=o_5qoswWTfkOg=TysBSh-sC=DyA915KOuQQ@mail.gmail.com>
 <CAFy6TRAEeYRo76MTRBwjvQOsme1a_J=1oyKrMmaxC2fYNE5pGQ@mail.gmail.com>
 <CAFy6TRCoLkwQMN8EDXfecR_BKOpBX-xLUgLEi2Pt8+=e2+2sJg@mail.gmail.com>
 <CAFy6TRD4mdhBBUWqDRKU+ScGsyXTzkjD6dhicXD2yZK2PG3Z=w@mail.gmail.com>
 <CAFy6TRBeLDaTD1sH355W_dgpVW5eYeKv13_y5t4iaa7+zv1jtQ@mail.gmail.com>
 <CAFy6TRDQNd9+z1u+WT+KJfTE+ERNAeosy0PaOKy_Vua-f2QhaQ@mail.gmail.com>
 <CAFy6TRBDr+uUdHE-4kOssZswcpROqArKJxpwYAjxZ=fqSGzp8A@mail.gmail.com>
 <CAFy6TRDgVyNeaGQn2-bkQPTa5XD089wKegoSD3oT_j64pvrSEg@mail.gmail.com>
 <CAFy6TRA3h8-pf90Eekh_fjEn=E5qMpOCTgCn-SuX6H4Mm_i5Sg@mail.gmail.com>
 <CAFy6TRBv9Db_R0A+4CZkcDwMRWsrsP9HGiE2adzEXjezR0q23g@mail.gmail.com>
 <CAFy6TRCNEE36sD_Pcn1jN0dDeTTfkfoq1S_xk745Rw8FOw+Uxw@mail.gmail.com>
 <CAFy6TRAJ9JfK5udVEFgV4cxCCT_X_ciVKhC8RjvGpbOLEWMsVw@mail.gmail.com>
 <CAFy6TRCp+d++wK-g6+L-mjboj5gNS20eN6RNzdM3uHUcJVp8og@mail.gmail.com>
 <CAFy6TRBrjKyQWpfwTpUN0duXSV7g9_odSWjPvhEvgHzvOnVAEA@mail.gmail.com>
 <CAFy6TRAsXTDSPwOXGCVoYW5759n0fbPJJmBZautYh2icUZ8FsA@mail.gmail.com>
 <CAFy6TRB+kyA-YkAh=kaBx2YkCq56JmnJgBx19x1Y2HsxvPO38A@mail.gmail.com>
 <CAFy6TRBC489dV3RJHQwyKdReCssG41KUbdpQGUf8tX0=Ko9Ziw@mail.gmail.com>
 <CAFy6TRDcfN2O4yh09ZbCO+KSz3GsvPE7xOd0aRpNxQ4D8V_MBQ@mail.gmail.com>
 <CAFy6TRAZGLee6hnu3rnkBztt5=UseC=ZbrGcmMOG0VpetjKU_Q@mail.gmail.com>
 <CAFy6TRBMhYYM5EGfx7DjKPXeRW-nFQQzni0hjSkf4qhBS6n-Xw@mail.gmail.com>
 <CAFy6TRCGyKuXHD=f=gFUoTXCznuE++81uh5midmjz+CSiMbK-w@mail.gmail.com>
 <CAFy6TRDtFayy_hs=GTWjHPOQG+hqcV5WdnNTmmvzwcOPYnDonw@mail.gmail.com> <CAFy6TRB8dWLNGJ2F814J8sE7HoEN=zCoTYbc-2gBeZCHSTpzMg@mail.gmail.com>
From:   Alexander Holmes <bobomor18@gmail.com>
Date:   Tue, 6 Apr 2021 16:33:36 +0000
Message-ID: <CAFy6TRBnZVZ6=GQLjknZ7W85h=iJzdKA9wp8ek0gmHY3aNFsPg@mail.gmail.com>
Subject: CONGRATULATIONS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you today?

This is MoneyGram International Inc. we are contacting you concerning
your winning fund $1.500, 000.00 USD; your e-mail won $1.500, 000.00
dollars through Internet contest, and lottery bonus under MoneyGram
International Inc. Worldwide. The lottery bonus is contesting once in
a year, and we are doing it to promote this company MoneyGram
International Inc. The last contest was made through the internet by
people=E2=80=99s email worldwide, for example. USA, CANADA, RUSSIA, EUROPE,
ASIA, AFRICA, UNITED KINGDOM, GERMANY, TOGO, SOUTH AFRICA, UAE,
ETC...........................

We are contacting you because you are among the winning people and
your winning code is [XHMG02639]. We have programmed your daily
transfer payment at the minimum of =E2=82=AC4,500 Euros daily. Therefore yo=
u
are advised to contact branch office Togo, with your complete info,
such as below.

Your surname......................
Your middle name..................
Your name........................
Your home address...............
Your country........................
Your phone number.................
Your occupation/ your work...................
Your passport or Identity Card copy.......................

Kindly contact the MoneyGram Agent Mr. DENIS KODJO, Phone: +228
79541985, via this email ( moneygramdepromo@gmail.com ) to release
your first payment pick up information.

Regards
CEO: W. Alexander Holmes
