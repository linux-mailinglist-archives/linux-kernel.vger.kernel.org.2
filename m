Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CAB369650
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbhDWPlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:41:07 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:16127 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhDWPlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:41:06 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 11:41:05 EDT
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id 01584208CC;
        Fri, 23 Apr 2021 17:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1619192078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKYgUPg98TBKS/ZY+chiTR1DckAZhCd21sI7/QoNsQI=;
        b=u1JNUw8D/ow/40pjuetWS84Y4GHE9bhAwDBW51+V7vHHjuedltOEB3ZzP5UEyebd1MvtBr
        YsLkpfi+GCRfinJvXjLa8hY4nFGzMg1rAsNJ5UaRsIF2XoWOqHjXlegJRjeMlvpYTMEGGg
        fjkPQoE/doN94lQcfrowarM+ba9cwArvq2mH5uTR+s8qFxXVtYJTe8fO8XbcYpM7a6hAw2
        Vjj8z14zkLtH3FqVpHDX2nJAbftjabid3jHHnEK96wFt4MxXN6Qtm4SESStNxoFi8IdPIu
        d4xJ3UAPQNkC/56u9MnU+lcnb+CoZjSQp7s/bNyNNXFLrh4TFmyavtsATuZlUg==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.4; Fri, 23 Apr
 2021 17:34:37 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%13]) with mapi id
 15.01.2242.008; Fri, 23 Apr 2021 17:34:37 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "thomas.petazzoni@free-electrons.com" 
        <thomas.petazzoni@free-electrons.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: AW: [PATCH 1/4] clk: mvebu: Fix a memory leak in an error handling
 path
Thread-Topic: [PATCH 1/4] clk: mvebu: Fix a memory leak in an error handling
 path
Thread-Index: AQHXOAlra2sQAacEjUWcDYHHPtnRKKrB+sUc///ko4CAAFZ1Wg==
Date:   Fri, 23 Apr 2021 15:34:37 +0000
Message-ID: <ec52f27bb33f419481653fe1a0b35419@bfs.de>
References: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
 <27db232fdd14e14d493f29a5404d9e643f09cc96.1619157996.git.christophe.jaillet@wanadoo.fr>
 <3e38da0e86c045d3aefd46f375e8b48e@bfs.de>,<f26e2ad3-d1b8-de96-febe-5b8f52abdf8f@wanadoo.fr>
In-Reply-To: <f26e2ad3-d1b8-de96-febe-5b8f52abdf8f@wanadoo.fr>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.40]
x-tm-as-product-ver: SMEX-14.0.0.3080-8.6.1012-26110.001
x-tm-as-result: No-10--2.642500-5.000000
x-tmase-matchedrid: 7RlxjwaqaMLRubRCcrbc5grcxrzwsv5u3dCmvEa6IiGoLZarzrrPmYHe
        Wvo2w5AlKsWWHEzJoyEqG/HhH1yTFoZKkFFIbQIA9aPMjkYccfkB4JHtiamkLPRPcu3uH/G00+m
        f+4Do0Dj+AlHJqOD4IHZaiQH57N/neASYyytjzKSJUlmL3Uj0mA5GMzfaGfZvrcN9BdgNdeblMv
        pqkHcOyln3wG3NurRldqQQIhr5j4vfkJeYYItMRTkWEAXjjR2RnnjOyk87HN98YCCIGSc4tfFnz
        pYjk62hK52HYCW7VBPIdhbSUjG6GYHmS1Qw23jCC4s/hE51YdWhp756/rM6Up8euMsD0OFm8z70
        XDTUjsbp6aRZpxSKWhItqQ/criE61u+8t82ayB2bbGl0ztMplyYof8qPjr5VYy6fApvL8BdAHOg
        8qEtqyI+pAn19BHXOPHM1hBoOGp5BJacAbR6CMZCANcFtZ7wT64sVlliWKx+/WXZS/HqJ2lZ0V5
        tYhzdWxEHRux+uk8jQ9TRN0mhS122h+FZFOY0P3tkdvQp2yTcJ6CGGOfMtJZMsu+T1MEaScYftG
        if//zUcl9PTuT60/PcE+fk37wf+eqiDLopACgpQTCDtSN+G0N/SJznOClIxoCAKAoIb2WYM/vKz
        x1GusR3L41iYoouZ8XlA7aX0aQ0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--2.642500-5.000000
x-tmase-version: SMEX-14.0.0.3080-8.6.1012-26110.001
x-tm-snts-smtp: 4AC192502F063FFE80FAC32ED90A4AEFBF6C3DE4FF1789D42FE304EED772D5922000:9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spamd-Result: default: False [-9.90 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BAYES_SPAM(5.10)[100.00%];
         DKIM_SIGNED(0.00)[bfs.de:s=dkim201901];
         WHITELIST_LOCAL_IP(-15.00)[10.129.90.31];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-1.000];
         FREEMAIL_TO(0.00)[wanadoo.fr,baylibre.com,kernel.org,bootlin.com,free-electrons.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: mx01-sz.bfs.de;
        none
X-Spam-Status: No, score=-9.90
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yep,
there was a patch containing while()/free(), i guessed the comment
was accidentaly copied (or do i mixup something ?)

forget about it, the comment was confusing me.=20
IMHO it is the wrong way around.
I would say:

 sightly rearrange the code:
    - use kasprintf instead of kzalloc/sprintf to simplify code and avoid a
      magic number
If an error occurs in the for_each loop, clk_name must be freed.
 goto bail_out;
=20
as side effect more that 9 clk_cpu are now correctly shown.

hope that helps,

re,
 wh
________________________________________
Von: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Gesendet: Freitag, 23. April 2021 14:02:17
An: Walter Harms; mturquette@baylibre.com; sboyd@kernel.org; gregory.clemen=
t@bootlin.com; thomas.petazzoni@free-electrons.com
Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-janitor=
s@vger.kernel.org
Betreff: AW: [PATCH 1/4] clk: mvebu: Fix a memory leak in an error handling=
 path

WARNUNG: Diese E-Mail kam von au=DFerhalb der Organisation. Klicken Sie nic=
ht auf Links oder =F6ffnen Sie keine Anh=E4nge, es sei denn, Sie kennen den=
/die Absender*in und wissen, dass der Inhalt sicher ist.


Le 23/04/2021 =E0 13:42, Walter Harms a =E9crit :
> nitpicking:
>   clk_name could be replaced with cpuclk[cpu].clk_name

Agreed, Thx.
I'll wait a few days to see if there are other comments before sending a
v2. (especially if 4/4 is correct or not)
I'll also add "clk-cpu:" after "clk: mvebu:"

> and the commit msg is from the other patch (free  cpuclk[cpu].clk_name)
>

But here, I don't follow you.
What do you mean? Which other patch?

Do you mean that the commit message has to be updated accordingly?
(ie: s/clk_name/cpuclk[cpu].clk_name/ must be freed)


> jm2c,
>
> re,
>   wh
> ________________________________________
> Von: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Gesendet: Freitag, 23. April 2021 08:25:01
> An: mturquette@baylibre.com; sboyd@kernel.org; gregory.clement@bootlin.co=
m; thomas.petazzoni@free-electrons.com
> Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-janit=
ors@vger.kernel.org; Christophe JAILLET
> Betreff: [PATCH 1/4] clk: mvebu: Fix a memory leak in an error handling p=
ath
>
> WARNUNG: Diese E-Mail kam von au=DFerhalb der Organisation. Klicken Sie n=
icht auf Links oder =F6ffnen Sie keine Anh=E4nge, es sei denn, Sie kennen d=
en/die Absender*in und wissen, dass der Inhalt sicher ist.
>
>
> If an error occurs in the for_each loop, clk_name must be freed.
>
> In order to do so, sightly rearrange the code:
>     - move the allocation to simplify error handling
>     - use kasprintf instead of kzalloc/sprintf to simplify code and avoid=
 a
>       magic number
>
> Fixes: ab8ba01b3fe5 ("clk: mvebu: add armada-370-xp CPU specific clocks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The { } around the 1 line block after kasprintf is intentional and makes
> sense with 2/2
> ---
>   drivers/clk/mvebu/clk-cpu.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
> index c2af3395cf13..a11d7273fcc7 100644
> --- a/drivers/clk/mvebu/clk-cpu.c
> +++ b/drivers/clk/mvebu/clk-cpu.c
> @@ -195,17 +195,17 @@ static void __init of_cpu_clk_setup(struct device_n=
ode *node)
>          for_each_of_cpu_node(dn) {
>                  struct clk_init_data init;
>                  struct clk *clk;
> -               char *clk_name =3D kzalloc(5, GFP_KERNEL);
> +               char *clk_name;
>                  int cpu, err;
>
> -               if (WARN_ON(!clk_name))
> -                       goto bail_out;
> -
>                  err =3D of_property_read_u32(dn, "reg", &cpu);
>                  if (WARN_ON(err))
>                          goto bail_out;
>
> -               sprintf(clk_name, "cpu%d", cpu);
> +               clk_name =3D kasprintf(GFP_KERNEL, "cpu%d", cpu);
> +               if (WARN_ON(!clk_name)) {
> +                       goto bail_out;
> +               }
>
>                  cpuclk[cpu].parent_name =3D of_clk_get_parent_name(node,=
 0);
>                  cpuclk[cpu].clk_name =3D clk_name;
> --
> 2.27.0
>
>

