Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6779414059
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 06:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhIVETZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 00:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhIVETY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 00:19:24 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AC1C061574;
        Tue, 21 Sep 2021 21:17:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so1318616pgc.6;
        Tue, 21 Sep 2021 21:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y1xRC/wRm1PKDZvMaEIj7Vy5KYyXOgkTuQZiH61aGG0=;
        b=R3mHdIcdqDO6EMgLwEhwhvWv+mpFaV1qSgxeGR009oy1KYYgSWKPF57VhOA9Xf+pfN
         dQfNVeoHDYMHaEv4BNZQZ2GqrnuNT8qPwDm0viYd2Fiu81zzg9+icWQqV+t/Y/B0QyCM
         dH6lYM4eBlpdNav5m8Bs7jH6keSxxxnrfDh58znrtBXL5IOFyDuqEVkjqOx1KSA+VyLW
         RwLL8z+4Ly47ed1t6molFcdlI5LvCdEqPGjjPPjD7MKKiIBFpFHeJJaic0PzuGfXDiQK
         kzUidNgX9lJRcD5HsjLarptF4wxYcxMQS4vUrDNMnls0H31e4pQLb2YC0ZwDd+nWz0hy
         Ns2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y1xRC/wRm1PKDZvMaEIj7Vy5KYyXOgkTuQZiH61aGG0=;
        b=WitxCAw5MYb6GGFiN1qDmZGYshltXGKc6QHWg/ACPW9eA98La44d3978nLE+LbHwfI
         4GV8zXlRSqSUPSJgPAJmhpfjlv2+nZwRY12FqdeqdO3oSo/Ef0VOXA3++upAWY3P0xUf
         y2rJOXDd3Wh43AUKXtfAK2fIwmsHhzR1sqC1fxggQiXhVUU5cKSUqwJkQyIl2XYUOsEQ
         B6Ibm+0EYX3rHECxQLbGP8/4eWrXxRbvgZFgFKf46pbK8lYeLM+wYjcBbxY/apQBj61C
         cGGdXQsS3ngB+IYFN5vkTe1PUZJ35J3o75s/1Z3ougVdIqs7viZ0NsFYFho2vYgF6Ybb
         3LAg==
X-Gm-Message-State: AOAM532O87f31IbGA1DZ0JJ3Cfh/Jz2KHfNQ4WDX+trMlmi/ltM3qRnQ
        UK5aQbjM0VoZTVvY/eV8AcfMOSdkfVAae+PtKxc=
X-Google-Smtp-Source: ABdhPJytN5yk8CkltiQrQ1yr2Oah10YKT5zKsPD0N/vEKyYl/SMTUOmG0NSBdvVzVG1moFHvWanOhvk7SYqxu6B3UDM=
X-Received: by 2002:a63:dc42:: with SMTP id f2mr31293828pgj.152.1632284274456;
 Tue, 21 Sep 2021 21:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210917072047.228685-1-yang.yang29@zte.com.cn>
In-Reply-To: <20210917072047.228685-1-yang.yang29@zte.com.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Wed, 22 Sep 2021 12:17:43 +0800
Message-ID: <CAMU9jJoNY9Abdmsqv9cZ-MvZKCitJOkvPU_LAMo93t5-Xob9LQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs/zh_CN: Add zh_CN/accounting/delay-accounting.rst
To:     cgel.zte@gmail.com
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, yang.yang29@zte.com.cn,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PGNnZWwuenRlQGdtYWlsLmNvbT4g5LqOMjAyMeW5tDnmnIgxN+aXpeWRqOS6lCDkuIvljYg4OjU4
5YaZ6YGT77yaDQo+DQo+IEZyb206IFlhbmcgWWFuZyA8eWFuZy55YW5nMjlAenRlLmNvbS5jbj4N
Cj4NCj4gQWRkIHRyYW5zbGF0aW9uIHpoX0NOL2FjY291bnRpbmcvZGVsYXktYWNjb3VudGluZy5y
c3QgYW5kIGxpbmtzIGl0DQo+IHRvIHpoX0NOL2FjY291bnRpbmcvaW5kZXgucnN0IHdoaWxlIGNs
ZWFuIGl0cyB0b2RvIGVudHJ5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFlhbmcgPHlhbmcu
eWFuZzI5QHp0ZS5jb20uY24+DQo+IC0tLQ0KPiB2MjogZGVsZXRlIHVzZWxlc3MgYmxhY2tsaW5l
DQo+IC0tLQ0KPiAgLi4uL3poX0NOL2FjY291bnRpbmcvZGVsYXktYWNjb3VudGluZy5yc3QgICAg
IHwgMTEzICsrKysrKysrKysrKysrKysrKw0KPiAgLi4uL3RyYW5zbGF0aW9ucy96aF9DTi9hY2Nv
dW50aW5nL2luZGV4LnJzdCAgIHwgICAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDExNCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWNjb3VudGluZy9kZWxheS1hY2NvdW50aW5nLnJzdA0K
Pg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWNjb3Vu
dGluZy9kZWxheS1hY2NvdW50aW5nLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3po
X0NOL2FjY291bnRpbmcvZGVsYXktYWNjb3VudGluZy5yc3QNCj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi43NjBmOTY4NzZlYTINCj4gLS0tIC9kZXYvbnVsbA0K
PiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9hY2NvdW50aW5nL2RlbGF5
LWFjY291bnRpbmcucnN0DQo+IEBAIC0wLDAgKzEsMTEzIEBADQo+ICsuLiBpbmNsdWRlOjogLi4v
ZGlzY2xhaW1lci16aF9DTi5yc3QNCj4gKw0KPiArOk9yaWdpbmFsOiBEb2N1bWVudGF0aW9uL2Fj
Y291bnRpbmcvZGVsYXktYWNjb3VudGluZy5yc3QNCj4gKzpUcmFuc2xhdG9yOiBZYW5nIFlhbmcg
PHlhbmcueWFuZzI5QHp0ZS5jb20uY24+DQo+ICsNCj4gKy4uIF9jbl9kZWxheS1hY2NvdW50aW5n
LnJzdDoNCj4gKw0KPiArPT09PT09PT0NCj4gK+W7tui/n+iuoeaVsA0KPiArPT09PT09PT0NCj4g
Kw0KPiAr5Lu75Yqh5Zyo562J5b6F5p+Q5Lqb5YaF5qC46LWE5rqQ5Y+v55So5pe277yM5Lya6YCg
5oiQ5bu26L+f44CC5L6L5aaC5LiA5Liq5Y+v6L+Q6KGM55qE5Lu75Yqh5Y+v6IO95Lya562J5b6F
DQo+ICvkuIDkuKrnqbrpl7JDUFXmnaXov5DooYzjgIINCj4gKw0KPiAr5Z+65LqO5q+P5Lu75Yqh
55qE5bu26L+f6K6h5pWw5Yqf6IO95bqm6YeP55Sx5Lul5LiL5oOF5Ya16YCg5oiQ55qE5Lu75Yqh
5bu26L+f77yaDQo+ICsNCj4gK2EpIOetieW+heS4gOS4qkNQVe+8iOS7u+WKoeS4uuWPr+i/kOih
jO+8iQ0KPiArYikg5a6M5oiQ55Sx6K+l5Lu75Yqh5Y+R6LW355qE5Z2XSS9P5ZCM5q2l6K+35rGC
DQo+ICtjKSDpobXpnaLkuqTmjaINCj4gK2QpIOWGheWtmOWbnuaUtg0KPiArDQo+ICvlubblsIbo
v5nkupvnu5/orqHkv6Hmga/pgJrov4d0YXNrc3RhdHPmjqXlj6Pmj5Dkvpvnu5nnlKjmiLfnqbrp
l7TjgIINCj4gKw0KPiAr6L+Z5Lqb5bu26L+f5L+h5oGv5Li66YCC5b2T55qE6LCD5pW05Lu75Yqh
Q1BV5LyY5YWI57qn44CBaW/kvJjlhYjnuqfjgIFyc3PpmZDliLbmj5Dkvpvlj43ppojjgILph43o
poHku7vliqENCj4gK+mVv+acn+W7tui/n++8jOihqOekuuWPr+iDvemcgOimgeaPkOmrmOWFtueb
uOWFs+S8mOWFiOe6p+OAgg0KPiArDQo+ICvpgJrov4fkvb/nlKh0YXNrc3RhdHPmjqXlj6PvvIzm
nKzlip/og73ov5jlj6/mj5DkvpvkuIDkuKrnur/nqIvnu4TvvIjlr7nlupTkvKDnu59Vbml46L+b
56iL77yJ5omA5pyJ5Lu75YqhDQo+ICvvvIjmiJbnur/nqIvvvInnmoTmgLvlu7bov5/nu5/orqHk
v6Hmga/jgILmraTnsbvmsYfmgLvlvoDlvoDmmK/pnIDopoHnmoTvvIznlLHlhoXmoLjmnaXlrozm
iJDmm7TliqDpq5jmlYjjgIINCj4gKw0KPiAr55So5oi356m66Ze055qE5a6e5L2T77yM54m55Yir
5piv6LWE5rqQ566h55CG56iL5bqP77yM5Y+v5bCG5bu26L+f57uf6K6h5L+h5oGv5rGH5oC75Yiw
5Lu75oSP57uE5Lit44CC5Li65a6e546wDQo+ICvov5nkuIDngrnvvIzku7vliqHnmoTlu7bov5/n
u5/orqHkv6Hmga/lnKjlhbbnlJ/lkb3lkajmnJ/lhoXlkozpgIDlh7rml7bnmoblj6/ojrflj5bv
vIzku47ogIznoa7kv53lj6/ov5vooYwNCj4gK+i/nue7reOAgeWujOaVtOeahOebkeaOpw0KPiAr
DQo+ICsNCj4gK+aOpeWPow0KPiArLS0tLQ0KPiArDQo+ICvlu7bov5/orqHmlbDkvb/nlKh0YXNr
c3RhdHPmjqXlj6PvvIzor6XmjqXlj6PnlLHmnKznm67lvZXlj6bkuIDkuKrljZXni6znmoTmlofm
oaPor6bnu4bmj4/ov7DjgIJUYXNrc3RhdHMNCj4gK+WQkeeUqOaIt+aAgei/lOWbnuS4gOS4qumA
mueUqOaVsOaNrue7k+aehO+8jOWvueW6lOavj3BpZOaIluavj3RnaWTnmoTnu5/orqHkv6Hmga/j
gILlu7bov5/orqHmlbDlip/og73loavlhpkNCj4gK+ivpeaVsOaNrue7k+aehOeahOeJueWumuWt
l+auteOAguingQ0KPiArDQo+ICsgICAgIGluY2x1ZGUvbGludXgvdGFza3N0YXRzLmgNCj4gKw0K
PiAr5YW25o+P6L+w5LqG5bu26L+f6K6h5pWw55u45YWz5a2X5q6144CC57O757uf6YCa5bi45Lul
6K6h5pWw5Zmo5b2i5byP6L+U5ZueIENQVeOAgeWQjOatpeWdlyBJL0/jgIHkuqTmjaLjgIHlhoXl
rZgNCj4gK+WbnuaUtuetieeahOe0r+enr+W7tui/n+OAgg0KPiArDQo+ICvlj5bku7vliqHmn5Do
rqHmlbDlmajkuKTkuKrov57nu63or7vmlbDnmoTlt67lgLzvvIzlsIblvpfliLDku7vliqHlnKjo
r6Xml7bpl7Tpl7TpmpTlhoXnrYnlvoXlr7nlupTotYTmupDnmoTmgLvlu7bov5/jgIINCj4gKw0K
PiAr5b2T5Lu75Yqh6YCA5Ye65pe277yM5YaF5qC45Lya5bCG5YyF5ZCr5q+P5Lu75Yqh55qE57uf
6K6h5L+h5oGv5Y+R6YCB57uZ55So5oi356m66Ze077yM6ICM5peg6ZyA6aKd5aSW55qE5ZG95Luk
44CCDQo+ICvoi6XlhbbkuLrnur/nqIvnu4TmnIDlkI7kuIDkuKrpgIDlh7rnmoTku7vliqHvvIzl
hoXmoLjov5jkvJrlj5HpgIHmr490Z2lk55qE57uf6K6h5L+h5oGv44CC5pu05aSa6K+m57uG5L+h
5oGv6KeBDQo+ICt0YXNrc3RhdHPmjqXlj6PnmoTmj4/ov7DjgIINCj4gKw0KPiArdG9vbHMvYWNj
b3VudGluZ+ebruW9leS4reeahOeUqOaIt+epuumXtOeoi+W6j2dldGRlbGF5cy5j5o+Q5L6b5LqG
5LiA5Lqb566A5Y2V55qE5ZG95Luk77yM55So5Lul5pi+56S6DQo+ICvlu7bov5/nu5/orqHkv6Hm
ga/jgILlhbbkuZ/mmK/kvb/nlKh0YXNrc3RhdHPmjqXlj6PnmoTnpLrkvovjgIINCj4gKw0KPiAr
55So5rOVDQo+ICstLS0tDQo+ICsNCj4gK+S9v+eUqOS7peS4i+mFjee9rue8luivkeWGheaguDo6
DQo+ICsNCj4gKyAgICAgICBDT05GSUdfVEFTS19ERUxBWV9BQ0NUPXkNCj4gKyAgICAgICBDT05G
SUdfVEFTS1NUQVRTPXkNCj4gKw0KPiAr5bu26L+f6K6h5pWw5Zyo5ZCv5Yqo5pe26buY6K6k5YWz
6Zet44CCDQo+ICvoi6XpnIDlvIDlkK/vvIzlnKjlkK/liqjlj4LmlbDkuK3lop7liqA6Og0KPiAr
DQo+ICsgICBkZWxheWFjY3QNCj4gKw0KPiAr5pys5paH5ZCO57ut55qE6K+05piO5Z+65LqO5bu2
6L+f6K6h5pWw5bey5byA5ZCv44CC5Lmf5Y+v5Zyo57O757uf6L+Q6KGM5pe277yM5L2/55Soc3lz
Y3Rs55qEa2VybmVsLnRhc2tfZGVsYXlhY2N0DQo+ICvov5vooYzlvIDlhbPjgILms6jmhI/vvIzl
j6rmnInlnKjlkK/nlKjlu7bov5/orqHmlbDlkI7lkK/liqjnmoTku7vliqHmiY3kvJrmnInnm7jl
hbPkv6Hmga/jgIINCj4gKw0KPiAr57O757uf5ZCv5Yqo5ZCO77yM5L2/55So57G75Ly8Z2V0ZGVs
YXlzLmPnmoTlt6Xlhbfojrflj5bku7vliqHmiJbnur/nqIvnu4TvvIh0Z2lk77yJ55qE5bu26L+f
5L+h5oGv44CCDQo+ICsNCj4gK2dldGRlbGF5c+WRveS7pOeahOS4gOiIrOagvOW8jzo6DQo+ICsN
Cj4gKyAgICAgICBnZXRkZWxheXMgWy10IHRnaWRdIFstcCBwaWRdIFstYyBjbWQuLi5dDQo+ICsN
Cj4gK+iOt+WPlnBpZOS4ujEw55qE5Lu75Yqh5LuO57O757uf5ZCv5Yqo5ZCO55qE5bu26L+f5L+h
5oGvOjoNCj4gKw0KPiArICAgICAgICMgLi9nZXRkZWxheXMgLXAgMTANCj4gKyAgICAgICDvvIjo
vpPlh7rkv6Hmga/lkozkuIvkvovnm7jkvLzvvIkNCj4gKw0KPiAr6I635Y+W5omA5pyJdGdpZOS4
ujXnmoTku7vliqHku47ns7vnu5/lkK/liqjlkI7nmoTmgLvlu7bov5/kv6Hmga86Og0KPiArDQo+
ICsgICAgICAgIyAuL2dldGRlbGF5cyAtdCA1DQo+ICsNCj4gKw0KPiArICAgICAgIENQVSAgICAg
Y291bnQgICByZWFsIHRvdGFsICAgICAgdmlydHVhbCB0b3RhbCAgIGRlbGF5IHRvdGFsDQo+ICsg
ICAgICAgICAgICAgICA3ODc2ICAgIDkyMDA1NzUwICAgICAgICAxMDAwMDAwMDAgICAgICAgMjQw
MDE1MDANCj4gKyAgICAgICBJTyAgICAgIGNvdW50ICAgZGVsYXkgdG90YWwNCj4gKyAgICAgICAg
ICAgICAgIDAgICAgICAgMA0KPiArICAgICAgIFNXQVAgICAgY291bnQgICBkZWxheSB0b3RhbA0K
PiArICAgICAgICAgICAgICAgMCAgICAgICAwDQo+ICsgICAgICAgUkVDTEFJTSBjb3VudCAgIGRl
bGF5IHRvdGFsDQo+ICsgICAgICAgICAgICAgICAwICAgICAgIDANCj4gKw0KPiAr6I635Y+W5oyH
5a6a566A5Y2V5ZG95Luk6L+Q6KGM5pe255qE5bu26L+f5L+h5oGvOjoNCj4gKw0KPiArICAjIC4v
Z2V0ZGVsYXlzIC1jIGxzIC8NCj4gKw0KPiArICBiaW4gICBkYXRhMSAgZGF0YTMgIGRhdGE1ICBk
ZXYgIGhvbWUgIG1lZGlhICBvcHQgICByb290ICBzcnYgICAgICAgIHN5cyAgdXNyDQo+ICsgIGJv
b3QgIGRhdGEyICBkYXRhNCAgZGF0YTYgIGV0YyAgbGliICAgbW50ICAgIHByb2MgIHNiaW4gIHN1
YmRvbWFpbiAgdG1wICB2YXINCj4gKw0KPiArDQo+ICsgIENQVSAgY291bnQgICByZWFsIHRvdGFs
ICAgICAgdmlydHVhbCB0b3RhbCAgIGRlbGF5IHRvdGFsDQo+ICsgICAgICAgNiAgICAgICA0MDAw
MjUwICAgICAgICAgNDAwMDAwMCAgICAgICAgIDANCj4gKyAgSU8gICBjb3VudCAgIGRlbGF5IHRv
dGFsDQo+ICsgICAgICAgMCAgICAgICAwDQo+ICsgIFNXQVAgY291bnQgICBkZWxheSB0b3RhbA0K
PiArICAgICAgIDAgICAgICAgMA0KPiArICBSRUNMQUlNICAgICAgY291bnQgICBkZWxheSB0b3Rh
bA0KPiArICAgICAgIDAgICAgICAgMA0KPiArDQphbSB3YXJuaW5nOg0KZ2l0L3JlYmFzZS1hcHBs
eS9wYXRjaDoxMjc6IG5ldyBibGFuayBsaW5lIGF0IEVPRi4NCg0Kd2l0aCB0aGlzDQpSZXZpZXdl
ZC1ieTogWWFudGVuZyBTaSA8c2l5YW50ZW5nQGxvb25nc29uLmNuPg0KDQpUaGFua3MsDQoNCllh
bnRlbmcNCg==
