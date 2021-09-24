Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1069416A95
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244036AbhIXDoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbhIXDoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:44:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3545DC061574;
        Thu, 23 Sep 2021 20:42:29 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h129so10954697iof.1;
        Thu, 23 Sep 2021 20:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3UUDv1+b3n48/wDBnvG4Aoih4TKW41g6MDyvFhmeoig=;
        b=McLlDxNTsJZ816KR3tXiM5NAeQuVnQDeYJ7t8AMc6luKvjAHdzChdy65DfuGTqV0YR
         GnI3MUTGESWLbTVk2dh/+6v604Dy0wcqO7eKg5FF1hCAG3RHjvFNbSdDq07+QaL/qBsT
         94U4YecrMlrKS9cSEt1oYzumzRfZRo8LqztKd6177M+H/6wLPfqP4SAXBesJFKc2oN+B
         +alT86QA5QNKFLz4D8mkMb7pXdcTemPZm40DDn+MJfM1Q9crSw/lpzO3i6Q25JrJOKlP
         72vPkHiSw0cEK797IUT7ItzMelDEdTo2a9S761HA7OPgLHy4BF8w7/NWwcv4e09ecIyh
         7R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3UUDv1+b3n48/wDBnvG4Aoih4TKW41g6MDyvFhmeoig=;
        b=X7vYktbvrnMOQ3VoW2VfKzV7rqX5UciLsoKZDoRVnrmULft0yRwUb6gR2+403i5D21
         xDf0ZQGIdamdnkqpxOi3LKrgPekjqPjFqG0SIkHQJakYtq3GUyj2NJWDIRHZATLhPGiv
         +y5w4WlgikRoPmLsReLEzFTa1gqoVZCUISHO39+yL8eBihXFxlTnqiSKma+Lm5XFHKhR
         LQkGO4wrGcqUy6Er3dtXdQ4E0sUZUHBrqWBA6cWFLHLfakjrt9/k7G51Y+AC1I/YdQp5
         AybOhfRpS70ja8gQ4P9C7x+U0fpXpFWUdHDz39yX9p+CtdAkpID4uP2/IlAVWYUuNHiX
         ay0Q==
X-Gm-Message-State: AOAM530SwXgv4sps82DVG3ipEZnpfTeDnjwNChoqs3g+JJX2bMcsZyA7
        k6onvsD33E72Vt5DKbeFTElYwizbut6hrynLdcs=
X-Google-Smtp-Source: ABdhPJz3EMRFfj80QcMPD35uzUYzouY3diu0pGNfspwM8KJWJoPVd8GpQnPRtlACy7QhPf5qTOYb2oWNGAH6XgV5QLU=
X-Received: by 2002:a5e:d80a:: with SMTP id l10mr6834336iok.36.1632454948282;
 Thu, 23 Sep 2021 20:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210923081951.261281-1-yang.yang29@zte.com.cn>
In-Reply-To: <20210923081951.261281-1-yang.yang29@zte.com.cn>
From:   Alex Shi <seakeel@gmail.com>
Date:   Fri, 24 Sep 2021 11:41:52 +0800
Message-ID: <CAJy-AmnDr-i6E7JPAGpt6EgVDTSxgFtygzriKJeOmuLd061P+Q@mail.gmail.com>
Subject: Re: [PATCH v3] docs/zh_CN: Add zh_CN/accounting/delay-accounting.rst
To:     cgel.zte@gmail.com
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, yang.yang29@zte.com.cn,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBTZXAgMjMsIDIwMjEgYXQgNDoyMyBQTSA8Y2dlbC56dGVAZ21haWwuY29tPiB3cm90
ZToNCj4NCj4gRnJvbTogWWFuZyBZYW5nIDx5YW5nLnlhbmcyOUB6dGUuY29tLmNuPg0KPg0KPiBB
ZGQgdHJhbnNsYXRpb24gemhfQ04vYWNjb3VudGluZy9kZWxheS1hY2NvdW50aW5nLnJzdCBhbmQg
bGlua3MgaXQNCj4gdG8gemhfQ04vYWNjb3VudGluZy9pbmRleC5yc3Qgd2hpbGUgY2xlYW4gaXRz
IHRvZG8gZW50cnkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWWFuZyA8eWFuZy55YW5nMjlA
enRlLmNvbS5jbj4NCg0KSGkgWWFuZ3lhbmcsDQpZb3UgIGNvdWxkIHBpY2sgdXAgdGhlICdyZXZp
ZXdlZC1ieScgY29udmVuaWVudGx5IHdoZW4geW91IHVwZGF0ZSB0bw0KbmV3IHZlcnNpb24uDQoN
ClRoYW5rcw0KDQo+IC0tLQ0KPiB2MzoNCj4gLSBhZGQgbWlzc2luZyBwZXJpb2QuDQo+IHYyOg0K
PiAtIGRlbGV0ZSB1c2VsZXNzIGJsYWNrbGluZS4NCj4gLS0tDQo+ICAuLi4vemhfQ04vYWNjb3Vu
dGluZy9kZWxheS1hY2NvdW50aW5nLnJzdCAgICAgfCAxMTIgKysrKysrKysrKysrKysrKysrDQo+
ICAuLi4vdHJhbnNsYXRpb25zL3poX0NOL2FjY291bnRpbmcvaW5kZXgucnN0ICAgfCAgIDIgKy0N
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMTEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9hY2Nv
dW50aW5nL2RlbGF5LWFjY291bnRpbmcucnN0DQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9hY2NvdW50aW5nL2RlbGF5LWFjY291bnRpbmcucnN0IGIv
RG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWNjb3VudGluZy9kZWxheS1hY2NvdW50
aW5nLnJzdA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjA2
NWE0MjRkOWIyYQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNs
YXRpb25zL3poX0NOL2FjY291bnRpbmcvZGVsYXktYWNjb3VudGluZy5yc3QNCj4gQEAgLTAsMCAr
MSwxMTIgQEANCj4gKy4uIGluY2x1ZGU6OiAuLi9kaXNjbGFpbWVyLXpoX0NOLnJzdA0KPiArDQo+
ICs6T3JpZ2luYWw6IERvY3VtZW50YXRpb24vYWNjb3VudGluZy9kZWxheS1hY2NvdW50aW5nLnJz
dA0KPiArOlRyYW5zbGF0b3I6IFlhbmcgWWFuZyA8eWFuZy55YW5nMjlAenRlLmNvbS5jbj4NCj4g
Kw0KPiArLi4gX2NuX2RlbGF5LWFjY291bnRpbmcucnN0Og0KPiArDQo+ICs9PT09PT09PQ0KPiAr
5bu26L+f6K6h5pWwDQo+ICs9PT09PT09PQ0KPiArDQo+ICvku7vliqHlnKjnrYnlvoXmn5Dkupvl
hoXmoLjotYTmupDlj6/nlKjml7bvvIzkvJrpgKDmiJDlu7bov5/jgILkvovlpoLkuIDkuKrlj6/o
v5DooYznmoTku7vliqHlj6/og73kvJrnrYnlvoUNCj4gK+S4gOS4quepuumXskNQVeadpei/kOih
jOOAgg0KPiArDQo+ICvln7rkuo7mr4/ku7vliqHnmoTlu7bov5/orqHmlbDlip/og73luqbph4/n
lLHku6XkuIvmg4XlhrXpgKDmiJDnmoTku7vliqHlu7bov5/vvJoNCj4gKw0KPiArYSkg562J5b6F
5LiA5LiqQ1BV77yI5Lu75Yqh5Li65Y+v6L+Q6KGM77yJDQo+ICtiKSDlrozmiJDnlLHor6Xku7vl
iqHlj5HotbfnmoTlnZdJL0/lkIzmraXor7fmsYINCj4gK2MpIOmhtemdouS6pOaNog0KPiArZCkg
5YaF5a2Y5Zue5pS2DQo+ICsNCj4gK+W5tuWwhui/meS6m+e7n+iuoeS/oeaBr+mAmui/h3Rhc2tz
dGF0c+aOpeWPo+aPkOS+m+e7meeUqOaIt+epuumXtOOAgg0KPiArDQo+ICvov5nkupvlu7bov5/k
v6Hmga/kuLrpgILlvZPnmoTosIPmlbTku7vliqFDUFXkvJjlhYjnuqfjgIFpb+S8mOWFiOe6p+OA
gXJzc+mZkOWItuaPkOS+m+WPjemmiOOAgumHjeimgeS7u+WKoQ0KPiAr6ZW/5pyf5bu26L+f77yM
6KGo56S65Y+v6IO96ZyA6KaB5o+Q6auY5YW255u45YWz5LyY5YWI57qn44CCDQo+ICsNCj4gK+mA
mui/h+S9v+eUqHRhc2tzdGF0c+aOpeWPo++8jOacrOWKn+iDvei/mOWPr+aPkOS+m+S4gOS4que6
v+eoi+e7hO+8iOWvueW6lOS8oOe7n1VuaXjov5vnqIvvvInmiYDmnInku7vliqENCj4gK++8iOaI
lue6v+eoi++8ieeahOaAu+W7tui/n+e7n+iuoeS/oeaBr+OAguatpOexu+axh+aAu+W+gOW+gOaY
r+mcgOimgeeahO+8jOeUseWGheaguOadpeWujOaIkOabtOWKoOmrmOaViOOAgg0KPiArDQo+ICvn
lKjmiLfnqbrpl7TnmoTlrp7kvZPvvIznibnliKvmmK/otYTmupDnrqHnkIbnqIvluo/vvIzlj6/l
sIblu7bov5/nu5/orqHkv6Hmga/msYfmgLvliLDku7vmhI/nu4TkuK3jgILkuLrlrp7njrANCj4g
K+i/meS4gOeCue+8jOS7u+WKoeeahOW7tui/n+e7n+iuoeS/oeaBr+WcqOWFtueUn+WRveWRqOac
n+WGheWSjOmAgOWHuuaXtueahuWPr+iOt+WPlu+8jOS7juiAjOehruS/neWPr+i/m+ihjA0KPiAr
6L+e57ut44CB5a6M5pW055qE55uR5o6n44CCDQo+ICsNCj4gK+aOpeWPow0KPiArLS0tLQ0KPiAr
DQo+ICvlu7bov5/orqHmlbDkvb/nlKh0YXNrc3RhdHPmjqXlj6PvvIzor6XmjqXlj6PnlLHmnKzn
m67lvZXlj6bkuIDkuKrljZXni6znmoTmlofmoaPor6bnu4bmj4/ov7DjgIJUYXNrc3RhdHMNCj4g
K+WQkeeUqOaIt+aAgei/lOWbnuS4gOS4qumAmueUqOaVsOaNrue7k+aehO+8jOWvueW6lOavj3Bp
ZOaIluavj3RnaWTnmoTnu5/orqHkv6Hmga/jgILlu7bov5/orqHmlbDlip/og73loavlhpkNCj4g
K+ivpeaVsOaNrue7k+aehOeahOeJueWumuWtl+auteOAguingQ0KPiArDQo+ICsgICAgIGluY2x1
ZGUvbGludXgvdGFza3N0YXRzLmgNCj4gKw0KPiAr5YW25o+P6L+w5LqG5bu26L+f6K6h5pWw55u4
5YWz5a2X5q6144CC57O757uf6YCa5bi45Lul6K6h5pWw5Zmo5b2i5byP6L+U5ZueIENQVeOAgeWQ
jOatpeWdlyBJL0/jgIHkuqTmjaLjgIHlhoXlrZgNCj4gK+WbnuaUtuetieeahOe0r+enr+W7tui/
n+OAgg0KPiArDQo+ICvlj5bku7vliqHmn5DorqHmlbDlmajkuKTkuKrov57nu63or7vmlbDnmoTl
t67lgLzvvIzlsIblvpfliLDku7vliqHlnKjor6Xml7bpl7Tpl7TpmpTlhoXnrYnlvoXlr7nlupTo
tYTmupDnmoTmgLvlu7bov5/jgIINCj4gKw0KPiAr5b2T5Lu75Yqh6YCA5Ye65pe277yM5YaF5qC4
5Lya5bCG5YyF5ZCr5q+P5Lu75Yqh55qE57uf6K6h5L+h5oGv5Y+R6YCB57uZ55So5oi356m66Ze0
77yM6ICM5peg6ZyA6aKd5aSW55qE5ZG95Luk44CCDQo+ICvoi6XlhbbkuLrnur/nqIvnu4TmnIDl
kI7kuIDkuKrpgIDlh7rnmoTku7vliqHvvIzlhoXmoLjov5jkvJrlj5HpgIHmr490Z2lk55qE57uf
6K6h5L+h5oGv44CC5pu05aSa6K+m57uG5L+h5oGv6KeBDQo+ICt0YXNrc3RhdHPmjqXlj6PnmoTm
j4/ov7DjgIINCj4gKw0KPiArdG9vbHMvYWNjb3VudGluZ+ebruW9leS4reeahOeUqOaIt+epuumX
tOeoi+W6j2dldGRlbGF5cy5j5o+Q5L6b5LqG5LiA5Lqb566A5Y2V55qE5ZG95Luk77yM55So5Lul
5pi+56S6DQo+ICvlu7bov5/nu5/orqHkv6Hmga/jgILlhbbkuZ/mmK/kvb/nlKh0YXNrc3RhdHPm
jqXlj6PnmoTnpLrkvovjgIINCj4gKw0KPiAr55So5rOVDQo+ICstLS0tDQo+ICsNCj4gK+S9v+eU
qOS7peS4i+mFjee9rue8luivkeWGheaguDo6DQo+ICsNCj4gKyAgICAgICBDT05GSUdfVEFTS19E
RUxBWV9BQ0NUPXkNCj4gKyAgICAgICBDT05GSUdfVEFTS1NUQVRTPXkNCj4gKw0KPiAr5bu26L+f
6K6h5pWw5Zyo5ZCv5Yqo5pe26buY6K6k5YWz6Zet44CCDQo+ICvoi6XpnIDlvIDlkK/vvIzlnKjl
kK/liqjlj4LmlbDkuK3lop7liqA6Og0KPiArDQo+ICsgICBkZWxheWFjY3QNCj4gKw0KPiAr5pys
5paH5ZCO57ut55qE6K+05piO5Z+65LqO5bu26L+f6K6h5pWw5bey5byA5ZCv44CC5Lmf5Y+v5Zyo
57O757uf6L+Q6KGM5pe277yM5L2/55Soc3lzY3Rs55qEa2VybmVsLnRhc2tfZGVsYXlhY2N0DQo+
ICvov5vooYzlvIDlhbPjgILms6jmhI/vvIzlj6rmnInlnKjlkK/nlKjlu7bov5/orqHmlbDlkI7l
kK/liqjnmoTku7vliqHmiY3kvJrmnInnm7jlhbPkv6Hmga/jgIINCj4gKw0KPiAr57O757uf5ZCv
5Yqo5ZCO77yM5L2/55So57G75Ly8Z2V0ZGVsYXlzLmPnmoTlt6Xlhbfojrflj5bku7vliqHmiJbn
ur/nqIvnu4TvvIh0Z2lk77yJ55qE5bu26L+f5L+h5oGv44CCDQo+ICsNCj4gK2dldGRlbGF5c+WR
veS7pOeahOS4gOiIrOagvOW8jzo6DQo+ICsNCj4gKyAgICAgICBnZXRkZWxheXMgWy10IHRnaWRd
IFstcCBwaWRdIFstYyBjbWQuLi5dDQo+ICsNCj4gK+iOt+WPlnBpZOS4ujEw55qE5Lu75Yqh5LuO
57O757uf5ZCv5Yqo5ZCO55qE5bu26L+f5L+h5oGvOjoNCj4gKw0KPiArICAgICAgICMgLi9nZXRk
ZWxheXMgLXAgMTANCj4gKyAgICAgICDvvIjovpPlh7rkv6Hmga/lkozkuIvkvovnm7jkvLzvvIkN
Cj4gKw0KPiAr6I635Y+W5omA5pyJdGdpZOS4ujXnmoTku7vliqHku47ns7vnu5/lkK/liqjlkI7n
moTmgLvlu7bov5/kv6Hmga86Og0KPiArDQo+ICsgICAgICAgIyAuL2dldGRlbGF5cyAtdCA1DQo+
ICsNCj4gKw0KPiArICAgICAgIENQVSAgICAgY291bnQgICByZWFsIHRvdGFsICAgICAgdmlydHVh
bCB0b3RhbCAgIGRlbGF5IHRvdGFsDQo+ICsgICAgICAgICAgICAgICA3ODc2ICAgIDkyMDA1NzUw
ICAgICAgICAxMDAwMDAwMDAgICAgICAgMjQwMDE1MDANCj4gKyAgICAgICBJTyAgICAgIGNvdW50
ICAgZGVsYXkgdG90YWwNCj4gKyAgICAgICAgICAgICAgIDAgICAgICAgMA0KPiArICAgICAgIFNX
QVAgICAgY291bnQgICBkZWxheSB0b3RhbA0KPiArICAgICAgICAgICAgICAgMCAgICAgICAwDQo+
ICsgICAgICAgUkVDTEFJTSBjb3VudCAgIGRlbGF5IHRvdGFsDQo+ICsgICAgICAgICAgICAgICAw
ICAgICAgIDANCj4gKw0KPiAr6I635Y+W5oyH5a6a566A5Y2V5ZG95Luk6L+Q6KGM5pe255qE5bu2
6L+f5L+h5oGvOjoNCj4gKw0KPiArICAjIC4vZ2V0ZGVsYXlzIC1jIGxzIC8NCj4gKw0KPiArICBi
aW4gICBkYXRhMSAgZGF0YTMgIGRhdGE1ICBkZXYgIGhvbWUgIG1lZGlhICBvcHQgICByb290ICBz
cnYgICAgICAgIHN5cyAgdXNyDQo+ICsgIGJvb3QgIGRhdGEyICBkYXRhNCAgZGF0YTYgIGV0YyAg
bGliICAgbW50ICAgIHByb2MgIHNiaW4gIHN1YmRvbWFpbiAgdG1wICB2YXINCj4gKw0KPiArDQo+
ICsgIENQVSAgY291bnQgICByZWFsIHRvdGFsICAgICAgdmlydHVhbCB0b3RhbCAgIGRlbGF5IHRv
dGFsDQo+ICsgICAgICAgNiAgICAgICA0MDAwMjUwICAgICAgICAgNDAwMDAwMCAgICAgICAgIDAN
Cj4gKyAgSU8gICBjb3VudCAgIGRlbGF5IHRvdGFsDQo+ICsgICAgICAgMCAgICAgICAwDQo+ICsg
IFNXQVAgY291bnQgICBkZWxheSB0b3RhbA0KPiArICAgICAgIDAgICAgICAgMA0KPiArICBSRUNM
QUlNICAgICAgY291bnQgICBkZWxheSB0b3RhbA0KPiArICAgICAgIDAgICAgICAgMA0KPiArDQo+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9hY2NvdW50aW5n
L2luZGV4LnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2FjY291bnRpbmcv
aW5kZXgucnN0DQo+IGluZGV4IDM2MmU5MDdiNDFmOS4uMDkwZjkzNzc2ZmFhIDEwMDY0NA0KPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9hY2NvdW50aW5nL2luZGV4LnJz
dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9hY2NvdW50aW5nL2lu
ZGV4LnJzdA0KPiBAQCAtMTYsMTAgKzE2LDEwIEBADQo+ICAgICA6bWF4ZGVwdGg6IDENCj4NCj4g
ICAgIHBzaQ0KPiArICAgZGVsYXktYWNjb3VudGluZw0KPg0KPiAgVG9kb2xpc3Q6DQo+DQo+ICAg
ICBjZ3JvdXBzdGF0cw0KPiAtICAgZGVsYXktYWNjb3VudGluZw0KPiAgICAgdGFza3N0YXRzDQo+
ICAgICB0YXNrc3RhdHMtc3RydWN0DQo+IC0tDQo+IDIuMjUuMQ0K
