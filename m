Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1741572D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 05:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbhIWDuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 23:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239258AbhIWDt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:49:57 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5684C06114C;
        Wed, 22 Sep 2021 20:41:07 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y197so6255366iof.11;
        Wed, 22 Sep 2021 20:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PbeSu0J1ofgmspF9voDb6kobQTJG4Zst9d8T8zkV8DI=;
        b=WCD3qEK1EEBUUwvGzd/4GVizUvJSbVon9umAR8Ovh3hno0m65Kg7cRAwpbljLX4Ktt
         kkjxkhK0SM4aTrZFNqWdOO31quQ4iGn+bmAIk1Z+DcKmSR0ZO36X/GK6hLznUB+BpqbY
         cT2/aqk1teM/xyTsWvgN5BXXpsVrpR5pKW5+ZzGkraIj4W1PW+M/NLIkKGz7PYJRPX/d
         EbyfCAdC+pN7y6df5LC8gKcefqE2TFaUM0X1bRAgSq91S5UI5UJ+h9mcPYc5NqPXkZhU
         19ZpM/eilCdPKqcTKOfSmHcTsOE06ZYUEHNu7NAcPDaU71QPKi12G901gFzeSba48Fp6
         t0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PbeSu0J1ofgmspF9voDb6kobQTJG4Zst9d8T8zkV8DI=;
        b=r+ORbRJyYgdUUndqUAroL1EzQnTgfdf7Vco9RjZQdFYKbO+xo+SMmqoYDS8mhKKEu5
         33vXuSLrEoDC/byMQWIyPtjxd1qMoVEAw7wsZCD2gFK6Ie3lrxuyh75CQonRJLVnuFst
         mAiwefLMTPAEIc4/kRgBiOIQDw+tuXbUzEoixzvtnTwdd4FAqVGbdNKXPZ8c8XBIqWRc
         1Ld6TuGTQVu79DnCmi1fXlugKB6KVvcgNr4rQplZbZxAyH7b5PPURYJu/MY2ehA5pEgq
         dovZpbxbtoPgLPMxbYA606OcCoDQUsV3HQ51jTBxxZSSDZjLotqnLBa54SqD/I+kb4T1
         DPfg==
X-Gm-Message-State: AOAM533IqRdi38l7vGSjQTRdfrQu4STf0y9C13gzdC8RbQ+mF5gMBKfd
        K+bzFi8YrvjRhOrIGQQCoyRH7rLa/nVpoGRxMGs=
X-Google-Smtp-Source: ABdhPJx51mEHqYczPEwDp8yCoaFyxJiRNFIRsMQFOOujFb+GsrH6XYQipbXA/zsUXVg1KBKEObrX01tgZluRhmyidsQ=
X-Received: by 2002:a02:77d5:: with SMTP id g204mr2141014jac.25.1632368467143;
 Wed, 22 Sep 2021 20:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210917072047.228685-1-yang.yang29@zte.com.cn>
In-Reply-To: <20210917072047.228685-1-yang.yang29@zte.com.cn>
From:   Alex Shi <seakeel@gmail.com>
Date:   Thu, 23 Sep 2021 11:40:30 +0800
Message-ID: <CAJy-AmkC5FFzuH5EUnQSB3DNBSZTHn5_cHBXN6dEvMosrvg4cA@mail.gmail.com>
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

T24gRnJpLCBTZXAgMTcsIDIwMjEgYXQgMzoyMSBQTSA8Y2dlbC56dGVAZ21haWwuY29tPiB3cm90
ZToNCj4NCj4gRnJvbTogWWFuZyBZYW5nIDx5YW5nLnlhbmcyOUB6dGUuY29tLmNuPg0KPg0KPiBB
ZGQgdHJhbnNsYXRpb24gemhfQ04vYWNjb3VudGluZy9kZWxheS1hY2NvdW50aW5nLnJzdCBhbmQg
bGlua3MgaXQNCj4gdG8gemhfQ04vYWNjb3VudGluZy9pbmRleC5yc3Qgd2hpbGUgY2xlYW4gaXRz
IHRvZG8gZW50cnkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWWFuZyA8eWFuZy55YW5nMjlA
enRlLmNvbS5jbj4NCj4gLS0tDQo+IHYyOiBkZWxldGUgdXNlbGVzcyBibGFja2xpbmUNCj4gLS0t
DQo+ICAuLi4vemhfQ04vYWNjb3VudGluZy9kZWxheS1hY2NvdW50aW5nLnJzdCAgICAgfCAxMTMg
KysrKysrKysrKysrKysrKysrDQo+ICAuLi4vdHJhbnNsYXRpb25zL3poX0NOL2FjY291bnRpbmcv
aW5kZXgucnN0ICAgfCAgIDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTE0IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3Ry
YW5zbGF0aW9ucy96aF9DTi9hY2NvdW50aW5nL2RlbGF5LWFjY291bnRpbmcucnN0DQo+DQo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9hY2NvdW50aW5nL2Rl
bGF5LWFjY291bnRpbmcucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWNj
b3VudGluZy9kZWxheS1hY2NvdW50aW5nLnJzdA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBp
bmRleCAwMDAwMDAwMDAwMDAuLjc2MGY5Njg3NmVhMg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBi
L0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2FjY291bnRpbmcvZGVsYXktYWNjb3Vu
dGluZy5yc3QNCj4gQEAgLTAsMCArMSwxMTMgQEANCj4gKy4uIGluY2x1ZGU6OiAuLi9kaXNjbGFp
bWVyLXpoX0NOLnJzdA0KPiArDQo+ICs6T3JpZ2luYWw6IERvY3VtZW50YXRpb24vYWNjb3VudGlu
Zy9kZWxheS1hY2NvdW50aW5nLnJzdA0KPiArOlRyYW5zbGF0b3I6IFlhbmcgWWFuZyA8eWFuZy55
YW5nMjlAenRlLmNvbS5jbj4NCj4gKw0KPiArLi4gX2NuX2RlbGF5LWFjY291bnRpbmcucnN0Og0K
PiArDQo+ICs9PT09PT09PQ0KPiAr5bu26L+f6K6h5pWwDQo+ICs9PT09PT09PQ0KPiArDQo+ICvk
u7vliqHlnKjnrYnlvoXmn5DkupvlhoXmoLjotYTmupDlj6/nlKjml7bvvIzkvJrpgKDmiJDlu7bo
v5/jgILkvovlpoLkuIDkuKrlj6/ov5DooYznmoTku7vliqHlj6/og73kvJrnrYnlvoUNCj4gK+S4
gOS4quepuumXskNQVeadpei/kOihjOOAgg0KPiArDQo+ICvln7rkuo7mr4/ku7vliqHnmoTlu7bo
v5/orqHmlbDlip/og73luqbph4/nlLHku6XkuIvmg4XlhrXpgKDmiJDnmoTku7vliqHlu7bov5/v
vJoNCj4gKw0KPiArYSkg562J5b6F5LiA5LiqQ1BV77yI5Lu75Yqh5Li65Y+v6L+Q6KGM77yJDQo+
ICtiKSDlrozmiJDnlLHor6Xku7vliqHlj5HotbfnmoTlnZdJL0/lkIzmraXor7fmsYINCj4gK2Mp
IOmhtemdouS6pOaNog0KPiArZCkg5YaF5a2Y5Zue5pS2DQo+ICsNCj4gK+W5tuWwhui/meS6m+e7
n+iuoeS/oeaBr+mAmui/h3Rhc2tzdGF0c+aOpeWPo+aPkOS+m+e7meeUqOaIt+epuumXtOOAgg0K
PiArDQo+ICvov5nkupvlu7bov5/kv6Hmga/kuLrpgILlvZPnmoTosIPmlbTku7vliqFDUFXkvJjl
hYjnuqfjgIFpb+S8mOWFiOe6p+OAgXJzc+mZkOWItuaPkOS+m+WPjemmiOOAgumHjeimgeS7u+WK
oQ0KPiAr6ZW/5pyf5bu26L+f77yM6KGo56S65Y+v6IO96ZyA6KaB5o+Q6auY5YW255u45YWz5LyY
5YWI57qn44CCDQo+ICsNCj4gK+mAmui/h+S9v+eUqHRhc2tzdGF0c+aOpeWPo++8jOacrOWKn+iD
vei/mOWPr+aPkOS+m+S4gOS4que6v+eoi+e7hO+8iOWvueW6lOS8oOe7n1VuaXjov5vnqIvvvInm
iYDmnInku7vliqENCj4gK++8iOaIlue6v+eoi++8ieeahOaAu+W7tui/n+e7n+iuoeS/oeaBr+OA
guatpOexu+axh+aAu+W+gOW+gOaYr+mcgOimgeeahO+8jOeUseWGheaguOadpeWujOaIkOabtOWK
oOmrmOaViOOAgg0KPiArDQo+ICvnlKjmiLfnqbrpl7TnmoTlrp7kvZPvvIznibnliKvmmK/otYTm
upDnrqHnkIbnqIvluo/vvIzlj6/lsIblu7bov5/nu5/orqHkv6Hmga/msYfmgLvliLDku7vmhI/n
u4TkuK3jgILkuLrlrp7njrANCj4gK+i/meS4gOeCue+8jOS7u+WKoeeahOW7tui/n+e7n+iuoeS/
oeaBr+WcqOWFtueUn+WRveWRqOacn+WGheWSjOmAgOWHuuaXtueahuWPr+iOt+WPlu+8jOS7juiA
jOehruS/neWPr+i/m+ihjA0KPiAr6L+e57ut44CB5a6M5pW055qE55uR5o6nDQoNCm1pc3NlZCBh
IHBlcmlvZCBoZXJlLg0KDQpOaWNlIHdvcmsgZm9yIGFsbCBvdGhlciBwYXJ0cyENCg0KUmV2aWV3
ZWQtYnk6IEFsZXggU2hpIDxhbGV4c0BrZXJuZWwub3JnPg0KDQo+ICsNCj4gKw0KPiAr5o6l5Y+j
DQo+ICstLS0tDQo+ICsNCj4gK+W7tui/n+iuoeaVsOS9v+eUqHRhc2tzdGF0c+aOpeWPo++8jOiv
peaOpeWPo+eUseacrOebruW9leWPpuS4gOS4quWNleeLrOeahOaWh+aho+ivpue7huaPj+i/sOOA
glRhc2tzdGF0cw0KPiAr5ZCR55So5oi35oCB6L+U5Zue5LiA5Liq6YCa55So5pWw5o2u57uT5p6E
77yM5a+55bqU5q+PcGlk5oiW5q+PdGdpZOeahOe7n+iuoeS/oeaBr+OAguW7tui/n+iuoeaVsOWK
n+iDveWhq+WGmQ0KPiAr6K+l5pWw5o2u57uT5p6E55qE54m55a6a5a2X5q6144CC6KeBDQo+ICsN
Cj4gKyAgICAgaW5jbHVkZS9saW51eC90YXNrc3RhdHMuaA0KPiArDQo+ICvlhbbmj4/ov7Dkuobl
u7bov5/orqHmlbDnm7jlhbPlrZfmrrXjgILns7vnu5/pgJrluLjku6XorqHmlbDlmajlvaLlvI/o
v5Tlm54gQ1BV44CB5ZCM5q2l5Z2XIEkvT+OAgeS6pOaNouOAgeWGheWtmA0KPiAr5Zue5pS2562J
55qE57Sv56ev5bu26L+f44CCDQo+ICsNCj4gK+WPluS7u+WKoeafkOiuoeaVsOWZqOS4pOS4qui/
nue7reivu+aVsOeahOW3ruWAvO+8jOWwhuW+l+WIsOS7u+WKoeWcqOivpeaXtumXtOmXtOmalOWG
heetieW+heWvueW6lOi1hOa6kOeahOaAu+W7tui/n+OAgg0KPiArDQo+ICvlvZPku7vliqHpgIDl
h7rml7bvvIzlhoXmoLjkvJrlsIbljIXlkKvmr4/ku7vliqHnmoTnu5/orqHkv6Hmga/lj5HpgIHn
u5nnlKjmiLfnqbrpl7TvvIzogIzml6DpnIDpop3lpJbnmoTlkb3ku6TjgIINCj4gK+iLpeWFtuS4
uue6v+eoi+e7hOacgOWQjuS4gOS4qumAgOWHuueahOS7u+WKoe+8jOWGheaguOi/mOS8muWPkemA
geavj3RnaWTnmoTnu5/orqHkv6Hmga/jgILmm7TlpJror6bnu4bkv6Hmga/op4ENCj4gK3Rhc2tz
dGF0c+aOpeWPo+eahOaPj+i/sOOAgg0KPiArDQo+ICt0b29scy9hY2NvdW50aW5n55uu5b2V5Lit
55qE55So5oi356m66Ze056iL5bqPZ2V0ZGVsYXlzLmPmj5DkvpvkuobkuIDkupvnroDljZXnmoTl
kb3ku6TvvIznlKjku6XmmL7npLoNCj4gK+W7tui/n+e7n+iuoeS/oeaBr+OAguWFtuS5n+aYr+S9
v+eUqHRhc2tzdGF0c+aOpeWPo+eahOekuuS+i+OAgg0KPiArDQo+ICvnlKjms5UNCj4gKy0tLS0N
Cj4gKw0KPiAr5L2/55So5Lul5LiL6YWN572u57yW6K+R5YaF5qC4OjoNCj4gKw0KPiArICAgICAg
IENPTkZJR19UQVNLX0RFTEFZX0FDQ1Q9eQ0KPiArICAgICAgIENPTkZJR19UQVNLU1RBVFM9eQ0K
PiArDQo+ICvlu7bov5/orqHmlbDlnKjlkK/liqjml7bpu5jorqTlhbPpl63jgIINCj4gK+iLpemc
gOW8gOWQr++8jOWcqOWQr+WKqOWPguaVsOS4reWinuWKoDo6DQo+ICsNCj4gKyAgIGRlbGF5YWNj
dA0KPiArDQo+ICvmnKzmloflkI7nu63nmoTor7TmmI7ln7rkuo7lu7bov5/orqHmlbDlt7LlvIDl
kK/jgILkuZ/lj6/lnKjns7vnu5/ov5DooYzml7bvvIzkvb/nlKhzeXNjdGznmoRrZXJuZWwudGFz
a19kZWxheWFjY3QNCj4gK+i/m+ihjOW8gOWFs+OAguazqOaEj++8jOWPquacieWcqOWQr+eUqOW7
tui/n+iuoeaVsOWQjuWQr+WKqOeahOS7u+WKoeaJjeS8muacieebuOWFs+S/oeaBr+OAgg0KPiAr
DQo+ICvns7vnu5/lkK/liqjlkI7vvIzkvb/nlKjnsbvkvLxnZXRkZWxheXMuY+eahOW3peWFt+iO
t+WPluS7u+WKoeaIlue6v+eoi+e7hO+8iHRnaWTvvInnmoTlu7bov5/kv6Hmga/jgIINCj4gKw0K
PiArZ2V0ZGVsYXlz5ZG95Luk55qE5LiA6Iis5qC85byPOjoNCj4gKw0KPiArICAgICAgIGdldGRl
bGF5cyBbLXQgdGdpZF0gWy1wIHBpZF0gWy1jIGNtZC4uLl0NCj4gKw0KPiAr6I635Y+WcGlk5Li6
MTDnmoTku7vliqHku47ns7vnu5/lkK/liqjlkI7nmoTlu7bov5/kv6Hmga86Og0KPiArDQo+ICsg
ICAgICAgIyAuL2dldGRlbGF5cyAtcCAxMA0KPiArICAgICAgIO+8iOi+k+WHuuS/oeaBr+WSjOS4
i+S+i+ebuOS8vO+8iQ0KPiArDQo+ICvojrflj5bmiYDmnIl0Z2lk5Li6NeeahOS7u+WKoeS7juez
u+e7n+WQr+WKqOWQjueahOaAu+W7tui/n+S/oeaBrzo6DQo+ICsNCj4gKyAgICAgICAjIC4vZ2V0
ZGVsYXlzIC10IDUNCj4gKw0KPiArDQo+ICsgICAgICAgQ1BVICAgICBjb3VudCAgIHJlYWwgdG90
YWwgICAgICB2aXJ0dWFsIHRvdGFsICAgZGVsYXkgdG90YWwNCj4gKyAgICAgICAgICAgICAgIDc4
NzYgICAgOTIwMDU3NTAgICAgICAgIDEwMDAwMDAwMCAgICAgICAyNDAwMTUwMA0KPiArICAgICAg
IElPICAgICAgY291bnQgICBkZWxheSB0b3RhbA0KPiArICAgICAgICAgICAgICAgMCAgICAgICAw
DQo+ICsgICAgICAgU1dBUCAgICBjb3VudCAgIGRlbGF5IHRvdGFsDQo+ICsgICAgICAgICAgICAg
ICAwICAgICAgIDANCj4gKyAgICAgICBSRUNMQUlNIGNvdW50ICAgZGVsYXkgdG90YWwNCj4gKyAg
ICAgICAgICAgICAgIDAgICAgICAgMA0KPiArDQo+ICvojrflj5bmjIflrprnroDljZXlkb3ku6To
v5DooYzml7bnmoTlu7bov5/kv6Hmga86Og0KPiArDQo+ICsgICMgLi9nZXRkZWxheXMgLWMgbHMg
Lw0KPiArDQo+ICsgIGJpbiAgIGRhdGExICBkYXRhMyAgZGF0YTUgIGRldiAgaG9tZSAgbWVkaWEg
IG9wdCAgIHJvb3QgIHNydiAgICAgICAgc3lzICB1c3INCj4gKyAgYm9vdCAgZGF0YTIgIGRhdGE0
ICBkYXRhNiAgZXRjICBsaWIgICBtbnQgICAgcHJvYyAgc2JpbiAgc3ViZG9tYWluICB0bXAgIHZh
cg0KPiArDQo+ICsNCj4gKyAgQ1BVICBjb3VudCAgIHJlYWwgdG90YWwgICAgICB2aXJ0dWFsIHRv
dGFsICAgZGVsYXkgdG90YWwNCj4gKyAgICAgICA2ICAgICAgIDQwMDAyNTAgICAgICAgICA0MDAw
MDAwICAgICAgICAgMA0KPiArICBJTyAgIGNvdW50ICAgZGVsYXkgdG90YWwNCj4gKyAgICAgICAw
ICAgICAgIDANCj4gKyAgU1dBUCBjb3VudCAgIGRlbGF5IHRvdGFsDQo+ICsgICAgICAgMCAgICAg
ICAwDQo+ICsgIFJFQ0xBSU0gICAgICBjb3VudCAgIGRlbGF5IHRvdGFsDQo+ICsgICAgICAgMCAg
ICAgICAwDQo+ICsNCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3po
X0NOL2FjY291bnRpbmcvaW5kZXgucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhf
Q04vYWNjb3VudGluZy9pbmRleC5yc3QNCj4gaW5kZXggMzYyZTkwN2I0MWY5Li4wOTBmOTM3NzZm
YWEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2FjY291
bnRpbmcvaW5kZXgucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L2FjY291bnRpbmcvaW5kZXgucnN0DQo+IEBAIC0xNiwxMCArMTYsMTAgQEANCj4gICAgIDptYXhk
ZXB0aDogMQ0KPg0KPiAgICAgcHNpDQo+ICsgICBkZWxheS1hY2NvdW50aW5nDQo+DQo+ICBUb2Rv
bGlzdDoNCj4NCj4gICAgIGNncm91cHN0YXRzDQo+IC0gICBkZWxheS1hY2NvdW50aW5nDQo+ICAg
ICB0YXNrc3RhdHMNCj4gICAgIHRhc2tzdGF0cy1zdHJ1Y3QNCj4gLS0NCj4gMi4yNS4xDQo+DQo=
