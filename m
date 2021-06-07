Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F0C39DDED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhFGNpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFGNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:45:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DEDC061766;
        Mon,  7 Jun 2021 06:43:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o12so5313952plk.8;
        Mon, 07 Jun 2021 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k+196/sAn9PjLH1T5WW09ZALSStxAC7P96OlISkNyw4=;
        b=pTV90WVFF9qU4vzTLK+t4NmsQ9lU6B2DH8dYKBwoB+kiarSMsXud3wStglYk+EkgHF
         HDC4WW+EYNawMdStyFsC5rMkNa3TVII21iiAp8zh+yxYdfswNOziX8yp8VaVzGKDgUjv
         eHsogDuRH61eAtK3JORdj/5f9sprtaPzX6VTtEyiKYZOeEpEBEBrv1F6fTV5NV2dvSgv
         YlIhjZ+cN6jlZ2Ar+o98QfaEgJi1E5YIAiDxt2PgTVAdCTCg8ob9bjL03PyJ2d+9yNaw
         BxLAxzKWl+Br22SLn4Q2vH3CJCLbzz9y7pdaPK1F2OioGiu0+c4NvylSUx2exXVQc/Jz
         9f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k+196/sAn9PjLH1T5WW09ZALSStxAC7P96OlISkNyw4=;
        b=ohj5Bnl3NSzXoRJ1PRfU1fxauW9FDEBSkzl3TtX3sLG1jQJ6B4zK2KdUN9CwJURVPz
         F+Zq2UGwol08aO49Fa0l95gwkt0LrdcTMVR+gFEP7bafAQj/eN7ZIsX1fYeTaKLtcWJo
         TYQryJY/Ycco3MPribFyVMHxGbmpYGJXk8ysevu9tuFCIOrnMt2s47M8Dc+ap7Hycai2
         nePQzznlj07LPpQ5vcXBBTU23k0XzCQqmlMLNB6toDIYHjxWF7RmtcYK4YsKYRoX/J4j
         aMfTH2fsy1H5IqgezHmO7/dbUG9bzK/Cje87St5jNwbsoPTl83CBw4frTI4ZIvJn46Nx
         Z8Ug==
X-Gm-Message-State: AOAM5337NPr4CMjzwZ4qHlTKGnhQg9mBiKnMZTXQoQkc/iLe7MkPYft1
        mbcik2Q3np3Vof2zSg0l9eTSU6bUqQwuISB0wX/SP5mVdmyFZaZx
X-Google-Smtp-Source: ABdhPJy6SuwabGiADaimFaR8cD2sz6Mucq0y3VUEU634hCJz4KYCm4l1FgnLyiWVwHgcRzDQsXBk9Suv3NoEvqgHoKM=
X-Received: by 2002:a17:90a:2f22:: with SMTP id s31mr14785587pjd.62.1623073428380;
 Mon, 07 Jun 2021 06:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210607093433.39160-1-src.res@email.cn> <CAMU9jJrkxTUgS0P3tpr-Udw9WqUgqCJ2D0G+ja5UX=B+4DRw7g@mail.gmail.com>
In-Reply-To: <CAMU9jJrkxTUgS0P3tpr-Udw9WqUgqCJ2D0G+ja5UX=B+4DRw7g@mail.gmail.com>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Mon, 7 Jun 2021 21:43:37 +0800
Message-ID: <CAMU9jJq5ykLjZK2NFo98FxuKDmJnSCcUGn2-N53ioX9nspBSLA@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: add a translation for index
To:     Hu Haowen <src.res@email.cn>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yanteng Si <siyanteng@loongson.cn>, "Wu X.C." <bobwxc@email.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q0MgWGlhbmdjaGVuZw0KDQp0ZW5nIHN0ZXJsaW5nIDxzdGVybGluZ3RlbmdAZ21haWwuY29tPiDk
uo4yMDIx5bm0NuaciDfml6XlkajkuIAg5LiL5Y2IOTo0MOWGmemBk++8mg0KPg0KPiBDQyBzaXlh
bnRlbmdAbG9vbmdzb24uY24NCj4gSHUgSGFvd2VuIDxzcmMucmVzQGVtYWlsLmNuPiDkuo4yMDIx
5bm0NuaciDfml6XlkajkuIAg5LiL5Y2INTozN+WGmemBk++8mg0KPiA+DQo+ID4gVGhlIG9yaWdp
bmFsIGZpbGUgaGFzIGFkZGVkIGEgZm9ybWVyIGludHJvIGluIGNvbW1pdCBiNTEyMDhkNDFjNmE0
ZTdmYzJmMA0KPiA+ICgiZG9jczogVHdlYWsgdGhlIHRvcC1sZXZlbCBTcGhpbnggcGFnZSIpIGFu
ZCBoZW5jZSB1cGRhdGUgdGhlIENoaW5lc2UNCj4gPiB2ZXJzaW9uIGZvciBpdC4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEh1IEhhb3dlbiA8c3JjLnJlc0BlbWFpbC5jbj4NCj4gPiAtLS0NCj4g
PiAgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0IHwgNSArKysrKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0IGIvRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0DQo+ID4gaW5kZXggMWY5NTNkMzQzOWE1
Li4wMDMxMjZhYmMwZDYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vaW5kZXgucnN0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMv
emhfQ04vaW5kZXgucnN0DQo+ID4gQEAgLTE3LDYgKzE3LDExIEBADQo+ID4gICAgICoq57+76K+R
6K6h5YiSOioqDQo+ID4gICAgIOWGheaguOS4reaWh+aWh+aho+asoui/juS7u+S9lee/u+ivkeaK
leeov++8jOeJueWIq+aYr+WFs+S6juWGheaguOeUqOaIt+WSjOeuoeeQhuWRmOaMh+WNl+mDqOWI
huOAgg0KPiA+DQo+ID4gK+i/meaYr+WGheaguOaWh+aho+agkeeahOmhtue6p+ebruW9leOAguWG
heaguOaWh+aho++8jOWwseWDj+WGheaguOacrOi6q+S4gOagt++8jOWcqOW+iOWkp+eoi+W6puS4
iuaYr+S4gOmhueatow0KPiBob3cgYWJvdXQ6DQo+DQo+IOi/meaYr+S4reaWh+WGheaguOaWh+ah
o+agkeeahOmhtue6p+ebruW9leOAgg0KPiA+ICvlnKjov5vooYznmoTlt6XkvZzvvJvlvZPmiJHk
u6zliqrlipvlsIborrjlpJrliIbmlaPnmoTmlofku7bmlbTlkIjmiJDkuIDkuKrov57otK/nmoTm
lbTkvZPml7blsKTlhbblpoLmraTjgILlj6YNCj4gPiAr5aSW77yM6ZqP5pe25qyi6L+O5oKo5a+5
5YaF5qC45paH5qGj6L+b6KGM5pS56L+b77yb5aaC5p6c5oKo5oOz5o+Q5L6b5biu5Yqp77yM6K+3
5Yqg5YWldmdlci5rZXJuZWwub3JnDQo+IOS4reaWh+WGheaguOaWh+aho+i/m+ihjOaUuei/m++8
mw0KPiA+ICvkuIrnmoRsaW51eC1kb2Ppgq7ku7bliJfooajjgIINCj4g5LiK55qEbGludXgtZG9j
6YKu5Lu25YiX6KGo77yM5YWI5pS56L+b5Y6f5aeL6Iux5paH5paH5qGj77yM5YaN5bCG5YW257+7
6K+R5Li65Lit5paH5ZCO77yM5pu05paw55u45bqU55qE5Lit5paH5paH5qGj44CCDQo+ID4gKw0K
PiA+ICDorrjlj6/or4HmlofmoaMNCj4gPiAgLS0tLS0tLS0tLQ0KPiA+DQo+ID4gLS0NCj4gPiAy
LjI1LjENCj4gPg0KPiBCVFcsIEkgdGhpbmsgdGhlc2UgYXJlIHNpbWlsYXIgdG8gImRpc2NsYWlt
ZXItemhfQ04iLCBidXQgbm90IGFzIGdvb2QNCj4gYXMgdGhlIGxhdHRlci4NCj4NCj4gQWxleCBh
bmQgWGlhbmdjaGVuZywgd2hhdCBkbyB5b3UgdGhpbms/DQo+DQo+IFRoYW5rcywNCj4gWWFudGVu
Zw0K
