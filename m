Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F713E4B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhHIRuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbhHIRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:50:34 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC98C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:50:13 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id s48so31020320ybi.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=O4NMEur8QcJc4TO2WBpgWKn95vBrSIQfedD9EZ6Ad6E=;
        b=NHSFXr9JCzbE3KrdVbFqcn19A5Tnb4DkN29Tnro3GkqWCJWCuRqRtTFAVO2jsqaqW/
         K7EI9t7uVRC4FZCKZPflxqwmsKEQUewMajfHpt5YIxOg3Mn3Jclpk7Acdcm2gJJ2vtGA
         LpZkzh8B9fvK93BQU9AHJ0TMjib1XARHHAvje+yQDm4q147tIS5lwyqx4jLf3v1mK0o8
         KKEfqKxLpypWUSiZqA6ktVERUx01WFghhswcD3ubgJB2/kmlR7Kdcspq+Rv4ot5FnUcm
         S7FmYkdTYK+RvV+4nqyJD93BPa7TN0eyPZxnnifidYPgLf3D/cP44xCbz1SHIrycrx+R
         p6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=O4NMEur8QcJc4TO2WBpgWKn95vBrSIQfedD9EZ6Ad6E=;
        b=VUDmqW+VO4BJ4Iwaat2DcR3aa+iZMUyXWXrzGy1mxhOM841QPKs6vYGGRDcJQD1zch
         IqICc2fb/jd9qtrt1cAlBMvUOdgUlYNhyYjwzOmT+9H/hAS2GCyMej9WQDiT8kNnImdM
         FOKj6t+EsGepXutn3jdvwftk7pNsAZV8F5xlyD8qlwD54w46c8KVMeM1exjVBMzXy25P
         TiWnmbmv9Ap0Boobm9d0fh4jPMcL5rqBabWgJWGVwQpTSNYgxo+BGYCbvllxZFB/OFCO
         4HRoUjyM8XXu2KS9LSxeRD+3XiZ+iGHuIDTFlQHxkIVADM4ZBemy35JlZ9mESFP1NU2/
         1TFA==
X-Gm-Message-State: AOAM531fdOHwRmGJKV0KuYHHa0PD/dF7L5H/cAyo+LtPEpBfqeg5FNZ0
        G2aorKNoJQFY0KkWfjnuEv6xkFNV1pcEFBvtUk8=
X-Received: by 2002:a25:690f:: with SMTP id e15mt24884000ybc.473.1628531412783;
 Mon, 09 Aug 2021 10:50:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:918f:b029:eb:d45:8011 with HTTP; Mon, 9 Aug 2021
 10:50:12 -0700 (PDT)
Reply-To: mp034367@gmail.com
In-Reply-To: <CAOpEvtiGXf=qs3wB-vc20O6K1isE+rSqoWCH2YV0VuExuRyJJA@mail.gmail.com>
References: <CAOpEvtgnxJTxQRyYoNSawaG_ft3hEWGPBySGw-qp751NfYWEYA@mail.gmail.com>
 <CAOpEvtgYVEKzj-5FbN30nrTXdoHydxxc___NL+eog8gfteeP-g@mail.gmail.com>
 <CAOpEvtj+sRP4ioG3J=wjzh8eZ-jL-ivKaDN2gpXzA0EpjZPA7Q@mail.gmail.com>
 <CAOpEvtjBCMV4qaQtnwd1yyJ_Dyx+3Qt2zC_m=-QfRYPGcN=tPw@mail.gmail.com>
 <CAOpEvtjR3cRRzeucmJJLu-JXJkXhimxaoZwGpBpY2+AwQaOJgg@mail.gmail.com>
 <CAOpEvtjR6U1HKDonr1hLJsF+LOucxdimdgqHz2mrcQQe69ejxA@mail.gmail.com>
 <CAOpEvtjd4W0VC+q6mbTGCFsYXuVRSr5WjBBHGpCJHhPts8Rscw@mail.gmail.com>
 <CAOpEvthys1Bm3w3fG6thrKz6dBCUiky3yF63tjpBpupfu=EA_w@mail.gmail.com>
 <CAOpEvtjj5pu_QB_2jm2YoWrAe4Hw7GB72KX1Je0zxQjDEvobig@mail.gmail.com>
 <CAOpEvthB4BxxJJw-UV-q9=ZX3LzTgVTiXhPYaT3MOKyq=MpKxQ@mail.gmail.com>
 <CAOpEvti=ONcEt_Y4ZF3aDZhGa8vhHkDT1wMuEkQnWZDP+XG-AQ@mail.gmail.com>
 <CAOpEvtgnaMMzoK0pgEmVr1KfqQD0Cw1YuKTPhYxV4NrMn624PQ@mail.gmail.com>
 <CAOpEvtju2ocU313kd0oUyKtpcfaXYSeyiCya=EvBjb8UwmO2DA@mail.gmail.com>
 <CAOpEvtjy+U92RBKX4cZxPZk0Q16tkb+vrZ_BO8x_cTn5A5LweQ@mail.gmail.com>
 <CAOpEvtgHohF9p1T+G+FQkc6X4ogo_BsVgY3Enb69ssxoMTFpeQ@mail.gmail.com>
 <CAOpEvtitFdiE-C6q9NDpnRzweHviTHChXB+ep6DC2DD74uGjEg@mail.gmail.com>
 <CAOpEvtgBaumHG9PJ+U1fa+SH6LWw=P5QEyjowF=dMsTa6AM8Xw@mail.gmail.com>
 <CAOpEvtij7-GduJxc4NZS6ZdCuQiorT9BpSj_AZPJS7ZrOMjquw@mail.gmail.com>
 <CAOpEvtidVNK0THUroBU2Wbku0TyowKxABNJuNA3Ux5=m6SKiDA@mail.gmail.com>
 <CAOpEvtgbSVja2VOMiAAa-acR8prhd9j37Cuv2bP3CMTWmhCo9A@mail.gmail.com>
 <CAOpEvtiWc=-BXEKpfavFs6xBc5aRpV_Eb=-oAeYD1iXK3MxjZg@mail.gmail.com>
 <CAOpEvtg0yLRBvSSagsi0kORPn7sObHvSzrm2bzc2-q08Y=oEkg@mail.gmail.com>
 <CAOpEvtgkXP4_A6fNnxqaNDzxBV5gwQrfrpesv7c3qu2mdzM-kw@mail.gmail.com>
 <CAOpEvtgOCukSLLPdcTz6LszQAjUSMNv9gRC8pMHHF9knf1QJbA@mail.gmail.com>
 <CAOpEvtjJXjrVUR4Yfgv9AgeBbALbW2LqjrQfAwWis1-Ut6s36w@mail.gmail.com>
 <CAOpEvtitmX-jrXUfyvrtL4BymXGTXArCaZV5Rx6gFWA1TxqAAQ@mail.gmail.com>
 <CAOpEvti21qkZhAgwMDKTpxdQX69EBHoDxmD0719zjbXNpWtGTg@mail.gmail.com>
 <CAOpEvtiJDf2LWujDcogwNv9jgx+tA8yX2im+Um6Rz_QoMdP6CQ@mail.gmail.com>
 <CAOpEvtjCaCK8TkBQ1Q1nDxDuE6tTbYp2GYgKXMe7hWdzoVb+OA@mail.gmail.com>
 <CAOpEvtjz_YJOtkbA4+x-NU7z3S9fkK7RTmW2yd5HryO0wQpUKw@mail.gmail.com>
 <CAOpEvtjF9yMMFChLrTeUdujM6-kaDmFtsCNWpGxPKOB-ysyzvw@mail.gmail.com>
 <CAOpEvtj+iA3woj3H1D2KwFu+O=yQO+SWtDaU7a+smHOLMSDwMQ@mail.gmail.com>
 <CAOpEvtiRLpAsRNJp7EQ7UPhMO+KWi-2Tc=v3MaxiJG5=b2Gu+A@mail.gmail.com>
 <CAOpEvti46Nk+y9v5hbhMfrn5k7+wRXbVRTKWMfeyYUabGAQr+A@mail.gmail.com>
 <CAOpEvtjBQYcmseiuTy=L7rt-RqbngeuLcSMA1ZvsHW3SAJ9h7w@mail.gmail.com>
 <CAOpEvthfrRCLXWA7oFvs+GopY4rKPpvovy35zQdxLFcTkNU-Ow@mail.gmail.com>
 <CAOpEvtiQSXNWJBioXkW_-rSP9ZJ5y5kyfN9m3fRp7Q58uN+UoA@mail.gmail.com>
 <CAOpEvtiS-qnLZhPAxmjwqosYjY7qz9svLkZXnt05bUv_8iTQLQ@mail.gmail.com>
 <CAOpEvtjwMbXxqpzTiCRP25Y778EdrBcqto_YX8XahAPVQYbyDg@mail.gmail.com>
 <CAOpEvtjmYjNUB+FqEnGaVzkkq1Sb1-yZU9F5kyGUoCsgS5XN7Q@mail.gmail.com>
 <CAOpEvtjt1dfVhy1wtju-dnZg+EdW0VbbJbrp8g0n0JKVuO1e-g@mail.gmail.com>
 <CAOpEvthNydMqkxJx6qx9C2ebY1n6jMpaSfK+dRuv68=adHRq0w@mail.gmail.com>
 <CAOpEvtjLNLrNAGh9k+s=g1DYa=7XS48-twnHBU8KYFfSXr-HOg@mail.gmail.com>
 <CAOpEvtgV5GTcgf0T90Keoa1MUTmMF4yW9RPRa=bv2919ne5Kdg@mail.gmail.com>
 <CAOpEvtgaszVp-MfhLbH4Wg4bfod2HysxzQbOmYqkFtSyTiZBcg@mail.gmail.com>
 <CAOpEvtiU+6JhxtykD5bRA8cKrPrgwVU+Gz4i6EboCNVpzVysdQ@mail.gmail.com>
 <CAOpEvtj+zgYow+Q8ckp5mev2y_bTrhBirWExw-NF3JqCDS80CA@mail.gmail.com> <CAOpEvtiGXf=qs3wB-vc20O6K1isE+rSqoWCH2YV0VuExuRyJJA@mail.gmail.com>
From:   Pepe Edem <amedodziyaovi@gmail.com>
Date:   Mon, 9 Aug 2021 18:50:12 +0100
Message-ID: <CAOpEvtj_hAfg9DETt6ZiQpSrT56ZaspVX7fMgQjGJyb1d+yZPQ@mail.gmail.com>
Subject: Greetings
Cc:     mp034367@gmail.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day My Good Friend.

I am deeply sorry if I have in any manner disturbed your privacy.
Please forgive this unusual manner of contacting you, there is
absolutely going to be a great doubt and distrust in your heart in
respect of this email. There is no way for me to know whether I will
be properly understood, but it is my duty to write and reach out to
you as a person of transparency, honesty and high caliber. I'll
introduce myself once again, i am Mr. Pepe Edem, from Togo Republic. I
am also the Branch Bank Manager of Biatogo Bank, I was also the
Account Manager of my late client Mrs. Stella  Who might or might
not be related to you.

She traveled down to china on the 28th of December 2019 on a five
weeks business trip and after the successful transaction in china, she
flew back, not knowing she has been infected with the deadly
Coronavirus (COVID-19). And she sadly passed away on March 20th 2020.
She left the sum of $3.2 Million (Three Million, Two Hundred Thousand
United States Dollars) in our financial institute (Bank), she
specifically confided in me told me that "no one else knows about her
funds in our bank" that the funds was for a project before she passed
away while she was ill. And down here in our country at this present
day, once anyone passes away, after 1 Year if no relatives of the late
customer doesn't come to claim the funds/assets it'll be recycled, and
reported to the Central Bank where the greedy government will then
want to have their hands on the funds.

That's where you come in, since you bear the same surnames with her, I
want you to stand as her next of kin since no one else knows about
this funds in our bank besides me, and i don't think anyone will be
coming for it. I promise you that if you agree to assist in claiming
this funds from my Bank, we'll not bridge the law in any way because
I'll be your eyes and ears here in the Bank.

After all is settled we'll share the fund $3.2 Million 50% equally or
rather invest on whatever we choose. So I would really like to know
what you have to say in regards to my proposal.

Thanks
Mr. Pepe Edem.
