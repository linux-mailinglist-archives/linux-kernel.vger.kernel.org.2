Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128173A892C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhFOTHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:07:01 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:12910 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhFOTG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:06:58 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2021 15:06:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1623783896; x=1655319896;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=XCTfmrWHzE5N1215OOpIYMgsouXngQwcMQaEg3Gkd90=;
  b=kKcYAIDYFiPtpOb59vqHpCkXCCrzVWoXAcWFiCreOShJVZ+SZyK1e9Cb
   c91u/0xy5JgewzTMsdIP9aEoqhIuAkfMZHWAMuUkTCF7qv0MJwZlSB18X
   DVvtnqMSEvsUKdp0xjM8kYMtUoR33f3xSraFCU/FiV54G1OifAcBNhhMy
   CsWygNdSr7H5oykJdIxw/KfzZCbygne6IsOu6es/yFWiSgLYDe2aSb03X
   uZqFETPW0vNhp0kRTo6L0rf3QLSSrD5C7nM/xQUGH0reLMzxF5Rz4Jks9
   t94qxmJaQRtkNohry7oGVyx37FaqtwDt+/Pw5k9xWuFw7rbHaX/NkkX63
   A==;
IronPort-SDR: 0epKqnkxcjlMTXnmIGYdZ4BpmEK1ectujtMgujXcEBy1595LDxtNwXtvJvPxruK2Y/EkvTk+rh
 MGyZwoV8SElJhBjb6Rs28ml0q/XF5ooo/W8wPsdp2p8m1hYCH2hkQI1wchvPoDCCGQ0hG9ghgu
 P1HMiNUSl9SEHAazDMnocD2eHQI2UGToaUAtOuwO0tgW7YoXHV5xBQE/hE7JAOYEl1P8tbSHhy
 BcM7i6IbP0WAAIXxUMESlW+HyfmzR0a3MmqJREEhIXAIUzfTNhoGNlxr0RbZ+50Qeox59JH6nH
 gOM=
X-IPAS-Result: =?us-ascii?q?A2FxAgAU98hgf8XXVdFagQmBV4F8gXxshEiSBAOKS4s8h?=
 =?us-ascii?q?T+BfAIJAQEBD0EEAQGEUAKCaQIlNAkOAgQBAQEBAwIDAQEBAQUBAQYBAQEBA?=
 =?us-ascii?q?QEFBAEBAhABAW6FL0aCOCkBg20BAQEDEhFWEAsLDQICJgICIQESAQUBHAYTI?=
 =?us-ascii?q?oJPglYDLwWcWYEEPYsygTKBAYdODUwBCQ2BYhJ+KocJhmEngimBS4I3Nj6CI?=
 =?us-ascii?q?IFrg1CCZASCLFsSAXoTW4MbAQEBnjOaUoE0WgEGAoMDG5IShgyFWiulZi2GM?=
 =?us-ascii?q?540lQ0QI4ExghUzGiV/BmeBS1AZDo4rFoECAQiNQSQvOAIGCgEBAwmHFYJHA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:XWF4fBEwsdZ37O1Mzg7XCp1GfzlMhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k03RmSB9qQtKkMotGVmpioYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5pnebx9GiTajY75+I
 xe7oAvMvcQKnIVuLbo8xAHUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2Q
 rxeFzQmLns65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD+v9
 LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQds4YS2VcRMZcTyNOAo2+Y
 IUPAeQPPvtWoZfhqFYVsRuyGROhCP/zxjNUhHL727Ax3eQ7EQHB2QwtB9ABsHXVrdX1KacSV
 v2+w6rIzTrZbvNdxDDw6YjJcxAhu/6MXK58fdbfxEQ0CgPKkk+QpZb7MDyIy+QAqm6W5PdvW
 uyzkWAosR1xoiSxycc2jInEno0Yx1TA+Ch5zog5O9K1RUp0b9OnH5ZduSGXOoVqT84jX2xlu
 Sg3x74btZOmYSQHy4oqyhDQZvGEboWG7A/uWfqXLDxlh3xlYKqyiwiu/UWk0OHxVcm53ExUo
 iZYktTArG0B2hjR58WBV/Bz5F2u2SyV2ADW8uxEJEc0mrfFJJM52b4wk4YTsVzEHi/rhEX6l
 K+WeVsg+uiv8+nnZ6/ppp6YN4NtkgH+PbkiltWxAeglNgUDXXKX+eu71L3k8k35RKtFgucqn
 anetZDWPcUbpqinDA9Jyosv9QqzAjO83NkbnXQLNkxJdA+HgoTzJl3DJPL1Ae+6g1u2kTdrw
 /7GPqfmApXINnXCkLbgfbZn5E5d1AY/0d5S6olJCr4dOvL/QFH+u8HFDhMhKQy73/7nCMlh1
 oMZQW+PBq6ZMKXPsV6H/+4vIPeDZJUTuDnjL/go/ODujXAnll8HZ6Wp3oUYaGq+Hvt4J0WVe
 33sgs0OETRCgg1rYOnrlEeTGQJUfXGxX6UirmU3DYO6F5aFWoe3h7+B2zmTEZhfZ2QAAVeJR
 yTGbYKBDsYNeiKPJYdTkjUFHeywWY8o1En27yfnwKAhI+bJrH5L/an/3cR4srWA3So58iZ5W
 oHEiznlcg==
IronPort-HdrOrdr: A9a23:JqOFTaCWNGWXDnLlHel155DYdb4zR+YMi2TDtnoBNCC9F/byqy
 nAppUmPGDP+VAssR0b9exoe5PwOE80jKQFmrX5ZI3SJjUO21HYUL2Kj7GD/9SIIUSXnNK1s5
 0OT0EUMrDN5DZB4/oTnWGDYq4dKQ28gcKVbZu39QYLcegTUdAC0+6PMHf+LqTefngiOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="222640347"
Received: from mail-pg1-f197.google.com ([209.85.215.197])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2021 11:57:49 -0700
Received: by mail-pg1-f197.google.com with SMTP id f6-20020a6310060000b0290221a634c769so9353673pgl.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1m4IeEEent5jiHTe7biC0dGHPFqJqU242gYSqFmhd2U=;
        b=S6WOIfsgRaYyf5/vVkA31uRCtvy/OTPNcPJK5d1obWhoOyQqpSmBnt0dfbAE2Thhhd
         0Bk1EmPuZiX5wqbZyrcTj7OEKVq2mr/XQ5oqimWUerDNynathNr5A3j+n3jbmdDV97g2
         Eh6DW/dpVB36GQ3twkCkbgbFxew5utkkP9f612qzUimQLW7C5/g0tQdMFtd77P8aI2L4
         3kmAXUkHoVWWTgginUx8i5/bX7i82hIO8W5VrahgBRrtKp28+6+vYMP176DUmufFgRk/
         C0RgwPKOrPZvT1wa++DQKcfF+JXuRjRAyplXX0OrBd/sE+eFacDrgO1Ay/lZPzu32Ju2
         OYYg==
X-Gm-Message-State: AOAM530W5KsDWli1Da20Z2U+gKnmRusdAkJlIpgke9dAPTuVEiQb9hIO
        xTk65wXLZnm4QAvmDxl52+oRYMl4ZthOf+3IIJD6qKsMUIzVAYZrfxwFLy+ancMjFJjwLOzXdAY
        E071agYSHEJbi4+BB60fp8OkFpoFTeeTD+buocXTRUA==
X-Received: by 2002:a17:902:222:b029:11b:9cea:eea9 with SMTP id 31-20020a1709020222b029011b9ceaeea9mr5569411plc.11.1623783467795;
        Tue, 15 Jun 2021 11:57:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnkTPSM9O0evxxWoz2GwOJYtWkZDnGaLYRNeodg7FZ/Jmq190oka8F/MupXXIe3Jw4+gwacghDUcgcgzpBqmY=
X-Received: by 2002:a17:902:222:b029:11b:9cea:eea9 with SMTP id
 31-20020a1709020222b029011b9ceaeea9mr5569385plc.11.1623783467440; Tue, 15 Jun
 2021 11:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <CABvMjLRuGPgEJ3Ef7=sBk3m3oa+3HuyV9mVY0ZCYuHK=rJRA4w@mail.gmail.com>
 <YMjuPtKtiaVLLO0q@google.com>
In-Reply-To: <YMjuPtKtiaVLLO0q@google.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Tue, 15 Jun 2021 11:57:36 -0700
Message-ID: <CABvMjLSKe2ojoVTZOwv_Dr4P4rsDa334vBc_-T8sMTPUJ-f==g@mail.gmail.com>
Subject: Re: [PATCH] Input: hideep - fix the uninitialized use in hideep_nvm_unlock()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Demitry:

Thanks for your quick response, following your advice, a careful way
is changing the return type of  "hideep_nvm_unlock()" from void to
int, and its caller "hideep_program_nvm()" also needs to add the
return check.

If this sounds ok, I would go ahead to modify the patch accordingly.

On Tue, Jun 15, 2021 at 11:15 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Yizhuo,
>
> On Tue, Jun 15, 2021 at 10:26:09AM -0700, Yizhuo Zhai wrote:
> > Inside function hideep_nvm_unlock(), variable "unmask_code" could
> > be uninitialized if hideep_pgm_r_reg() returns error, however, it
> > is used in the later if statement after an "and" operation, which
> > is potentially unsafe.
>
> I do not think that simply initializing the variable makes the code
> behave any better. If we want to fix this properly we need to check for
> errors returned by hideep_pgm_r_reg() and hideep_pgm_w_reg() and exit
> this function early, signalling the caller about errors.
>
> >
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> > ---
> >  drivers/input/touchscreen/hideep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/touchscreen/hideep.c
> > b/drivers/input/touchscreen/hideep.c
> > index ddad4a82a5e5..49b713ad4384 100644
> > --- a/drivers/input/touchscreen/hideep.c
> > +++ b/drivers/input/touchscreen/hideep.c
> > @@ -363,7 +363,7 @@ static int hideep_enter_pgm(struct hideep_ts *ts)
> >
> >  static void hideep_nvm_unlock(struct hideep_ts *ts)
> >  {
> > -       u32 unmask_code;
> > +       u32 unmask_code = 0;
> >
> >         hideep_pgm_w_reg(ts, HIDEEP_FLASH_CFG, HIDEEP_NVM_SFR_RPAGE);
> >         hideep_pgm_r_reg(ts, 0x0000000C, &unmask_code);
> > --
> > 2.17.1
>
> Thanks.
>
> --
> Dmitry



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
