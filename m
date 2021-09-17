Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C9340F2A1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhIQGzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIQGzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:55:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF462C061574;
        Thu, 16 Sep 2021 23:53:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f21so5558731plb.4;
        Thu, 16 Sep 2021 23:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=svXHuGHxKjWzR3sN2c/0P1oAvWMIfAPKeWaVAUpp/PU=;
        b=d1lL4r52QaTKO4VxBF1Ojd4wp6gPZLH/5XU9xFe0qunFzD8a5Y/e4ha595BtkvEKrw
         nUTjITUyOzUPTc2kbNMjN8x7uykuP4ByWgnNNf1VggrtvL7yBWtFgxoaXsRiZs8eRuij
         wXzGPwLgHU0kpD9xLjoh4Xg8WiDVirBL1vxk1/DcEKCR5DSGMIHWBQQZugLibTUL+mGX
         RYdt4ArsXeELIhyZZhZpHGK1GSYrjWC0/x7DLncDF6145+n2AjeoTM8Lkqc81CcjqrzC
         DXBBXzqUOSISMzUpZhfjSydst57orv35l6mellqEz70L/GUWiX4u56RMEK0Rb1DnEoIF
         7f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=svXHuGHxKjWzR3sN2c/0P1oAvWMIfAPKeWaVAUpp/PU=;
        b=AtnB7bcIR7REATeqlw2c0LH9JQZN+11ahoX1F32BO4KU7Wg0BBudG51QAMXIrWloaF
         /T0OGmTBrQR/M4dngViFtkp/kj6zrc15iqPATjZWmfUFOvvdycgn4rfq4335h/O/fU6e
         Wz/k4SS8Fmus0EkbM0+wv43T5P1Xxo0djXcAe41RevQLcIDu9pIzRUZzFYaE+Qsk76a+
         zOnfowqqsGXYnyXmtJEPsY7n+49L8dMnJytBXXO1gAObBs35dZ9pwsL0NmxxaqVP+yMi
         UJI+4giJDJgubFPlKkwNjzkNT0j5ifa6+Ks7ICZOWyiRmNHvHy1r4TYmB5uHGYjethZL
         IR8Q==
X-Gm-Message-State: AOAM532ts7/1z/uNOk/FOjMqWMFYgrKsH8Tca9TvZ9PXZ+ajiWl8dTcz
        ooJe2SoSU/1o65BFz9Sux8s3N4pleXtFsUc+AM8=
X-Google-Smtp-Source: ABdhPJxyV8BUJB09rFrJ7BdgAxTkTUQXsk0wxMz7O4cg1d4bEZVtGe3QPGXr3b+0Tywzxcqoy+bsO+hRfWmF9frn7oo=
X-Received: by 2002:a17:902:b713:b0:132:5a48:18cb with SMTP id
 d19-20020a170902b71300b001325a4818cbmr8179008pls.50.1631861629596; Thu, 16
 Sep 2021 23:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210915132037.169162-1-yang.yang29@zte.com.cn>
In-Reply-To: <20210915132037.169162-1-yang.yang29@zte.com.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Fri, 17 Sep 2021 14:53:39 +0800
Message-ID: <CAMU9jJqyTipnair8f6oTpP6VYoGhMVft3Qzv95m8TE5NowpHKA@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Add zh_CN/accounting/delay-accounting.rst
To:     cgel.zte@gmail.com
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, yang.yang29@zte.com.cn,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PGNnZWwuenRlQGdtYWlsLmNvbT4g5LqOMjAyMeW5tDnmnIgxNeaXpeWRqOS4iSDkuIvljYg5OjIx
5YaZ6YGT77yaDQo+DQo+IEZyb206IFlhbmcgWWFuZyA8eWFuZy55YW5nMjlAenRlLmNvbS5jbj4N
Cj4NCj4gQWRkIHRyYW5zbGF0aW9uIHpoX0NOL2FjY291bnRpbmcvZGVsYXktYWNjb3VudGluZy5y
c3QgYW5kIGxpbmtzIGl0DQo+IHRvIHpoX0NOL2FjY291bnRpbmcvaW5kZXgucnN0IHdoaWxlIGNs
ZWFuIGl0cyB0b2RvIGVudHJ5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFlhbmcgPHlhbmcu
eWFuZzI5QHp0ZS5jb20uY24+DQo+IC0tLQ0KPiAgLi4uL3poX0NOL2FjY291bnRpbmcvZGVsYXkt
YWNjb3VudGluZy5yc3QgICAgIHwgMTE0ICsrKysrKysrKysrKysrKysrKw0KPiAgLi4uL3RyYW5z
bGF0aW9ucy96aF9DTi9hY2NvdW50aW5nL2luZGV4LnJzdCAgIHwgICAyICstDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWNjb3VudGluZy9kZWxh
eS1hY2NvdW50aW5nLnJzdA0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xh
dGlvbnMvemhfQ04vYWNjb3VudGluZy9kZWxheS1hY2NvdW50aW5nLnJzdCBiL0RvY3VtZW50YXRp
b24vdHJhbnNsYXRpb25zL3poX0NOL2FjY291bnRpbmcvZGVsYXktYWNjb3VudGluZy5yc3QNCj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi4xZGY3ZDIzNTRlMDcN
Cj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9D
Ti9hY2NvdW50aW5nL2RlbGF5LWFjY291bnRpbmcucnN0DQo+IEBAIC0wLDAgKzEsMTE0IEBADQo+
ICsuLiBpbmNsdWRlOjogLi4vZGlzY2xhaW1lci16aF9DTi5yc3QNCj4gKw0KPiArOk9yaWdpbmFs
OiBEb2N1bWVudGF0aW9uL2FjY291bnRpbmcvZGVsYXktYWNjb3VudGluZy5yc3QNCj4gKzpUcmFu
c2xhdG9yOiBZYW5nIFlhbmcgPHlhbmcueWFuZzI5QHp0ZS5jb20uY24+DQo+ICsNCj4gKy4uIF9j
bl9kZWxheS1hY2NvdW50aW5nLnJzdDoNCj4gKw0KPiArDQpvbmx5IG5lZWQgb25lIGJsYWNrbGlu
ZS4NCj4gKz09PT09PT09DQo+ICvlu7bov5/orqHmlbANCj4gKz09PT09PT09DQo+ICsNCj4gK+S7
u+WKoeWcqOetieW+heafkOS6m+WGheaguOi1hOa6kOWPr+eUqOaXtu+8jOS8mumAoOaIkOW7tui/
n+OAguS+i+WmguS4gOS4quWPr+i/kOihjOeahOS7u+WKoeWPr+iDveS8muetieW+hQ0KPiAr5LiA
5Liq56m66ZeyQ1BV5p2l6L+Q6KGM44CCDQo+ICsNCj4gK+WfuuS6juavj+S7u+WKoeeahOW7tui/
n+iuoeaVsOWKn+iDveW6pumHj+eUseS7peS4i+aDheWGtemAoOaIkOeahOS7u+WKoeW7tui/n++8
mg0KPiArDQo+ICthKSDnrYnlvoXkuIDkuKpDUFXvvIjku7vliqHkuLrlj6/ov5DooYzvvIkNCj4g
K2IpIOWujOaIkOeUseivpeS7u+WKoeWPkei1t+eahOWdl0kvT+WQjOatpeivt+axgg0KPiArYykg
6aG16Z2i5Lqk5o2iDQo+ICtkKSDlhoXlrZjlm57mlLYNCj4gKw0KPiAr5bm25bCG6L+Z5Lqb57uf
6K6h5L+h5oGv6YCa6L+HdGFza3N0YXRz5o6l5Y+j5o+Q5L6b57uZ55So5oi356m66Ze044CCDQo+
ICsNCj4gK+i/meS6m+W7tui/n+S/oeaBr+S4uumAguW9k+eahOiwg+aVtOS7u+WKoUNQVeS8mOWF
iOe6p+OAgWlv5LyY5YWI57qn44CBcnNz6ZmQ5Yi25o+Q5L6b5Y+N6aaI44CC6YeN6KaB5Lu75Yqh
DQo+ICvplb/mnJ/lu7bov5/vvIzooajnpLrlj6/og73pnIDopoHmj5Dpq5jlhbbnm7jlhbPkvJjl
hYjnuqfjgIINCj4gKw0KPiAr6YCa6L+H5L2/55SodGFza3N0YXRz5o6l5Y+j77yM5pys5Yqf6IO9
6L+Y5Y+v5o+Q5L6b5LiA5Liq57q/56iL57uE77yI5a+55bqU5Lyg57ufVW5peOi/m+eoi++8ieaJ
gOacieS7u+WKoQ0KPiAr77yI5oiW57q/56iL77yJ55qE5oC75bu26L+f57uf6K6h5L+h5oGv44CC
5q2k57G75rGH5oC75b6A5b6A5piv6ZyA6KaB55qE77yM55Sx5YaF5qC45p2l5a6M5oiQ5pu05Yqg
6auY5pWI44CCDQo+ICsNCj4gK+eUqOaIt+epuumXtOeahOWunuS9k++8jOeJueWIq+aYr+i1hOa6
kOeuoeeQhueoi+W6j++8jOWPr+WwhuW7tui/n+e7n+iuoeS/oeaBr+axh+aAu+WIsOS7u+aEj+e7
hOS4reOAguS4uuWunueOsA0KPiAr6L+Z5LiA54K577yM5Lu75Yqh55qE5bu26L+f57uf6K6h5L+h
5oGv5Zyo5YW255Sf5ZG95ZGo5pyf5YaF5ZKM6YCA5Ye65pe255qG5Y+v6I635Y+W77yM5LuO6ICM
56Gu5L+d5Y+v6L+b6KGMDQo+ICvov57nu63jgIHlrozmlbTnmoTnm5HmjqcNCj4gKw0KPiArDQo+
ICvmjqXlj6MNCj4gKy0tLS0NCj4gKw0KPiAr5bu26L+f6K6h5pWw5L2/55SodGFza3N0YXRz5o6l
5Y+j77yM6K+l5o6l5Y+j55Sx5pys55uu5b2V5Y+m5LiA5Liq5Y2V54us55qE5paH5qGj6K+m57uG
5o+P6L+w44CCVGFza3N0YXRzDQo+ICvlkJHnlKjmiLfmgIHov5Tlm57kuIDkuKrpgJrnlKjmlbDm
ja7nu5PmnoTvvIzlr7nlupTmr49waWTmiJbmr490Z2lk55qE57uf6K6h5L+h5oGv44CC5bu26L+f
6K6h5pWw5Yqf6IO95aGr5YaZDQo+ICvor6XmlbDmja7nu5PmnoTnmoTnibnlrprlrZfmrrXjgILo
p4ENCj4gKw0KPiArICAgICBpbmNsdWRlL2xpbnV4L3Rhc2tzdGF0cy5oDQo+ICsNCj4gK+WFtuaP
j+i/sOS6huW7tui/n+iuoeaVsOebuOWFs+Wtl+auteOAguezu+e7n+mAmuW4uOS7peiuoeaVsOWZ
qOW9ouW8j+i/lOWbniBDUFXjgIHlkIzmraXlnZcgSS9P44CB5Lqk5o2i44CB5YaF5a2YDQo+ICvl
m57mlLbnrYnnmoTntK/np6/lu7bov5/jgIINCj4gKw0KPiAr5Y+W5Lu75Yqh5p+Q6K6h5pWw5Zmo
5Lik5Liq6L+e57ut6K+75pWw55qE5beu5YC877yM5bCG5b6X5Yiw5Lu75Yqh5Zyo6K+l5pe26Ze0
6Ze06ZqU5YaF562J5b6F5a+55bqU6LWE5rqQ55qE5oC75bu26L+f44CCDQo+ICsNCj4gK+W9k+S7
u+WKoemAgOWHuuaXtu+8jOWGheaguOS8muWwhuWMheWQq+avj+S7u+WKoeeahOe7n+iuoeS/oeaB
r+WPkemAgee7meeUqOaIt+epuumXtO+8jOiAjOaXoOmcgOmineWklueahOWRveS7pOOAgg0KPiAr
6Iul5YW25Li657q/56iL57uE5pyA5ZCO5LiA5Liq6YCA5Ye655qE5Lu75Yqh77yM5YaF5qC46L+Y
5Lya5Y+R6YCB5q+PdGdpZOeahOe7n+iuoeS/oeaBr+OAguabtOWkmuivpue7huS/oeaBr+ingQ0K
PiArdGFza3N0YXRz5o6l5Y+j55qE5o+P6L+w44CCDQo+ICsNCj4gK3Rvb2xzL2FjY291bnRpbmfn
m67lvZXkuK3nmoTnlKjmiLfnqbrpl7TnqIvluo9nZXRkZWxheXMuY+aPkOS+m+S6huS4gOS6m+eu
gOWNleeahOWRveS7pO+8jOeUqOS7peaYvuekug0KPiAr5bu26L+f57uf6K6h5L+h5oGv44CC5YW2
5Lmf5piv5L2/55SodGFza3N0YXRz5o6l5Y+j55qE56S65L6L44CCDQo+ICsNCj4gK+eUqOazlQ0K
PiArLS0tLQ0KPiArDQo+ICvkvb/nlKjku6XkuIvphY3nva7nvJbor5HlhoXmoLg6Og0KPiArDQo+
ICsgICAgICAgQ09ORklHX1RBU0tfREVMQVlfQUNDVD15DQo+ICsgICAgICAgQ09ORklHX1RBU0tT
VEFUUz15DQo+ICsNCj4gK+W7tui/n+iuoeaVsOWcqOWQr+WKqOaXtum7mOiupOWFs+mXreOAgg0K
PiAr6Iul6ZyA5byA5ZCv77yM5Zyo5ZCv5Yqo5Y+C5pWw5Lit5aKe5YqgOjoNCj4gKw0KPiArICAg
ZGVsYXlhY2N0DQo+ICsNCj4gK+acrOaWh+WQjue7reeahOivtOaYjuWfuuS6juW7tui/n+iuoeaV
sOW3suW8gOWQr+OAguS5n+WPr+WcqOezu+e7n+i/kOihjOaXtu+8jOS9v+eUqHN5c2N0bOeahGtl
cm5lbC50YXNrX2RlbGF5YWNjdA0KPiAr6L+b6KGM5byA5YWz44CC5rOo5oSP77yM5Y+q5pyJ5Zyo
5ZCv55So5bu26L+f6K6h5pWw5ZCO5ZCv5Yqo55qE5Lu75Yqh5omN5Lya5pyJ55u45YWz5L+h5oGv
44CCDQo+ICsNCj4gK+ezu+e7n+WQr+WKqOWQju+8jOS9v+eUqOexu+S8vGdldGRlbGF5cy5j55qE
5bel5YW36I635Y+W5Lu75Yqh5oiW57q/56iL57uE77yIdGdpZO+8ieeahOW7tui/n+S/oeaBr+OA
gg0KPiArDQo+ICtnZXRkZWxheXPlkb3ku6TnmoTkuIDoiKzmoLzlvI86Og0KPiArDQo+ICsgICAg
ICAgZ2V0ZGVsYXlzIFstdCB0Z2lkXSBbLXAgcGlkXSBbLWMgY21kLi4uXQ0KPiArDQo+ICvojrfl
j5ZwaWTkuLoxMOeahOS7u+WKoeS7juezu+e7n+WQr+WKqOWQjueahOW7tui/n+S/oeaBrzo6DQo+
ICsNCj4gKyAgICAgICAjIC4vZ2V0ZGVsYXlzIC1wIDEwDQo+ICsgICAgICAg77yI6L6T5Ye65L+h
5oGv5ZKM5LiL5L6L55u45Ly877yJDQo+ICsNCj4gK+iOt+WPluaJgOaciXRnaWTkuLo155qE5Lu7
5Yqh5LuO57O757uf5ZCv5Yqo5ZCO55qE5oC75bu26L+f5L+h5oGvOjoNCj4gKw0KPiArICAgICAg
ICMgLi9nZXRkZWxheXMgLXQgNQ0KPiArDQo+ICsNCj4gKyAgICAgICBDUFUgICAgIGNvdW50ICAg
cmVhbCB0b3RhbCAgICAgIHZpcnR1YWwgdG90YWwgICBkZWxheSB0b3RhbA0KPiArICAgICAgICAg
ICAgICAgNzg3NiAgICA5MjAwNTc1MCAgICAgICAgMTAwMDAwMDAwICAgICAgIDI0MDAxNTAwDQo+
ICsgICAgICAgSU8gICAgICBjb3VudCAgIGRlbGF5IHRvdGFsDQo+ICsgICAgICAgICAgICAgICAw
ICAgICAgIDANCj4gKyAgICAgICBTV0FQICAgIGNvdW50ICAgZGVsYXkgdG90YWwNCj4gKyAgICAg
ICAgICAgICAgIDAgICAgICAgMA0KPiArICAgICAgIFJFQ0xBSU0gY291bnQgICBkZWxheSB0b3Rh
bA0KPiArICAgICAgICAgICAgICAgMCAgICAgICAwDQo+ICsNCj4gK+iOt+WPluaMh+WumueugOWN
leWRveS7pOi/kOihjOaXtueahOW7tui/n+S/oeaBrzo6DQo+ICsNCj4gKyAgIyAuL2dldGRlbGF5
cyAtYyBscyAvDQo+ICsNCj4gKyAgYmluICAgZGF0YTEgIGRhdGEzICBkYXRhNSAgZGV2ICBob21l
ICBtZWRpYSAgb3B0ICAgcm9vdCAgc3J2ICAgICAgICBzeXMgIHVzcg0KPiArICBib290ICBkYXRh
MiAgZGF0YTQgIGRhdGE2ICBldGMgIGxpYiAgIG1udCAgICBwcm9jICBzYmluICBzdWJkb21haW4g
IHRtcCAgdmFyDQo+ICsNCj4gKw0KPiArICBDUFUgIGNvdW50ICAgcmVhbCB0b3RhbCAgICAgIHZp
cnR1YWwgdG90YWwgICBkZWxheSB0b3RhbA0KPiArICAgICAgIDYgICAgICAgNDAwMDI1MCAgICAg
ICAgIDQwMDAwMDAgICAgICAgICAwDQo+ICsgIElPICAgY291bnQgICBkZWxheSB0b3RhbA0KPiAr
ICAgICAgIDAgICAgICAgMA0KPiArICBTV0FQIGNvdW50ICAgZGVsYXkgdG90YWwNCj4gKyAgICAg
ICAwICAgICAgIDANCj4gKyAgUkVDTEFJTSAgICAgIGNvdW50ICAgZGVsYXkgdG90YWwNCj4gKyAg
ICAgICAwICAgICAgIDANCj4gKw0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xh
dGlvbnMvemhfQ04vYWNjb3VudGluZy9pbmRleC5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy96aF9DTi9hY2NvdW50aW5nL2luZGV4LnJzdA0KPiBpbmRleCAzNjJlOTA3YjQxZjkuLjA5
MGY5Mzc3NmZhYSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhf
Q04vYWNjb3VudGluZy9pbmRleC5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vYWNjb3VudGluZy9pbmRleC5yc3QNCj4gQEAgLTE2LDEwICsxNiwxMCBAQA0KPiAg
ICAgOm1heGRlcHRoOiAxDQo+DQo+ICAgICBwc2kNCj4gKyAgIGRlbGF5LWFjY291bnRpbmcNCj4N
Cj4gIFRvZG9saXN0Og0KPg0KPiAgICAgY2dyb3Vwc3RhdHMNCj4gLSAgIGRlbGF5LWFjY291bnRp
bmcNCj4gICAgIHRhc2tzdGF0cw0KPiAgICAgdGFza3N0YXRzLXN0cnVjdA0KR29vZCBqb2IsIEkn
bSB2ZXJ5IGludGVyZXN0ZWQgaW4gdGhpcyBzZXJpZXMgb2YgZG9jdW1lbnRzIGFuZCBJJ20NCmxv
b2tpbmcgZm9yd2FyZCB0byB5b3VyIHN1YnNlcXVlbnQgdHJhbnNsYXRpb25zLiBUaGlzIGlzIGlu
dmFsdWFibGUNCmZvciBDaGluZXNlIGRldmVsb3BlcnMgd2hvIGFyZSBub3QgZ29vZCBhdCBFbmds
aXNoLCB0aGFuayB5b3UgdmVyeQ0KbXVjaCBmb3IgeW91ciBjb250cmlidXRpb24uDQoNClRoYW5r
cywNCg0KWWFudGVuZw0K
