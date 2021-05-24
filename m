Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B029138DF09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 03:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhEXB7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 21:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhEXB7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 21:59:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB21C061574;
        Sun, 23 May 2021 18:58:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q6so13931850pjj.2;
        Sun, 23 May 2021 18:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jCtgzjCClBSQtUU7LwrqukXj+kZVkiIw6coIo/OGtnU=;
        b=Ofwdln73QEDuF45bdqyN1Fk+P3+jtMNZ02BpWhl7sly8T7z9eGHTdQeOCC4hTbOwY9
         rMNySOVLNji2Eu7KJoY0p7xd9cmd1PNuzExwZ78dzs4yKsJ5jMzNdw0Dt2f3A3t7X+7F
         +O1AN+w/r65jw/ADEWv/MoXWflgLz4+xCs5LbV70CEd17hJku9e2RdSDPxMnJAsYl+kY
         sGuA9GObHVTajH9lcgOzGOHlt0cfgmCvBnwO+OBpiMLS33xfXArF2zAxx/j006X02OIL
         B7rIjRqrWerrA7jXdiOYkVKuriECUVANc1L0EIUy6CHvpqRxvTT6k7E+Sc1TKxyYsU8g
         00Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jCtgzjCClBSQtUU7LwrqukXj+kZVkiIw6coIo/OGtnU=;
        b=FVy1XesRn+Ym2dU7ZxcW4jlEy17MjcUfFSghf7inkc9imHAvzi4UY8079KszYCuXNe
         RCQfwEjn1c2ZY8GpRqYJ0h14hjEQt27cva2I1qs1OZug5lYQQfPEzYjo3DtgWS4k7YN8
         APAyf64zQFvxFIQrshZ1RAtnTg2HIHbwr5sLz1fH3twi2W+N31El4vuL6FwMwcLGa5ab
         DMnp5GWTofMCfO0NkR+wzHl42S5oreskbtJowqYF1WwAUs1DCDSSGvTQ89oFA2O5kGqn
         mpToD/avTdiIJxnBJ6/or95lfvL9qih+eQxd+la3jKRUlltyfDn5TbYs/zu+4omzc22M
         oK9Q==
X-Gm-Message-State: AOAM532Y7I2c1X1tyGCC/RmECThkDIZ77IW5x/c4ntZY9XHxyJqKnz2l
        xcO2LZfneVrqdK6gfOxPMizbwct0YZSU+td+1Q8=
X-Google-Smtp-Source: ABdhPJy4MRqed6QyTy9fd1+WYGe0qFlie4CNYug1y1uiYMMcObYFXIP4KQaIYLBBSINpcDTN9lHlxuLAudEuzoAgKGg=
X-Received: by 2002:a17:90b:1885:: with SMTP id mn5mr21871211pjb.24.1621821484572;
 Sun, 23 May 2021 18:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210522080214.88050-1-src.res@email.cn>
In-Reply-To: <20210522080214.88050-1-src.res@email.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Mon, 24 May 2021 09:57:55 +0800
Message-ID: <CAMU9jJqdaKXWtUz_s=muFcJq81SouUJNOHSa-ZGCWXOFLK6wQw@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Add Chinese translations for new contents
To:     Hu Haowen <src.res@email.cn>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Yanteng Si <siyanteng@loongson.cn>,
        "Wu X.C." <bobwxc@email.cn>, jaixun.yang@flygoat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgaGFvd2VuOg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgdXBkYXRlLCBidXQgdGhpcyB1cGRhdGUg
aXMgYWxyZWFkeSBpbmNsdWRlZCBpbjoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWRv
Yy8yMDIxMDUyMTExMzc1Mi5HQTI0NTgxQGJvYnd4Yy50b3AvVC8jdA0KDQpIdSBIYW93ZW4gPHNy
Yy5yZXNAZW1haWwuY24+IOS6jjIwMjHlubQ15pyIMjLml6Xlkajlha0g5LiL5Y2INDowMuWGmemB
k++8mg0KPg0KPiBBIGRvY3VtZW50IHVwZGF0ZWQgaW4gY29tbWl0IDFjMzFmMGI2N2NmYTZkNGNk
NDFkICgibW9kdWxlOiBhZGQgcHJpbnRrDQo+IGZvcm1hdHMgdG8gYWRkIG1vZHVsZSBidWlsZCBJ
RCB0byBzdGFja3RyYWNlcyIpLCBoZW5jZSBhZGQgQ2hpbmVzZQ0KPiB0cmFuc2xhdGlvbnMgZm9y
IGl0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIdSBIYW93ZW4gPHNyYy5yZXNAZW1haWwuY24+DQo+
IC0tLQ0KPiAgLi4uL3RyYW5zbGF0aW9ucy96aF9DTi9jb3JlLWFwaS9wcmludGstZm9ybWF0cy5y
c3QgICAgICAgfCA5ICsrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vY29y
ZS1hcGkvcHJpbnRrLWZvcm1hdHMucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhf
Q04vY29yZS1hcGkvcHJpbnRrLWZvcm1hdHMucnN0DQo+IGluZGV4IDYyNGEwOTBlNmVlNS4uMTE2
YWJjMDQ2YmZlIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9D
Ti9jb3JlLWFwaS9wcmludGstZm9ybWF0cy5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMvemhfQ04vY29yZS1hcGkvcHJpbnRrLWZvcm1hdHMucnN0DQo+IEBAIC0xMjIsNiAr
MTIyLDE1IEBAIHNlcV9wcmludGYoKe+8jOiAjOS4jeaYr3ByaW50aygp77yJ55Sx55So5oi356m6
6Ze06L+b56iL6K+75Y+W77yM5L2/55So5LiL6Z2i5o+PDQo+ICBgYEJgYCDljaDkvY3nrKbnmoTn
u5PmnpzmmK/luKbmnInlgY/np7vph4/nmoTnrKblj7flkI3vvIzlnKjmiZPljbDloIbmoIjlm57m
uq/ml7blupTor6Xkvb/nlKjjgILljaDkvY3nrKblsIbogIPomZHnvJbor5HlmajkvJjljJYNCj4g
IOeahOW9seWTje+8jOW9k+S9v+eUqOWwvumDqOiwg+eUqOW5tuS9v+eUqG5vcmV0dXJuIEdDQ+Wx
nuaAp+agh+iusOaXtu+8jOWPr+iDveS8muWPkeeUn+i/meenjeS8mOWMluOAgg0KPg0KPiAr5aaC
5p6c5Y2g5L2N56ym5piv5Zyo5LiA5Liq5qih5Z2X5LmL5Lit77yM5Y+v5Zyo5Y2g5L2N56ym5pyr
5bC+5re75YqgIGBgYmBgIOS7peWcqOespuWPt+WQjeWQjuaJk+WNsOaooeWdl+WQjeensOWSjOWP
r+mAieaehOW7uklE44CCDQo+ICsNCj4gKzo6DQpidWlsZCB3YXJuaW5nISBhZGQgb25lIGJsYWNr
IGxpbmUgaGVyZS4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWRvYy9DQUUtMG41MFV2
ZTRnRXdEZko0d3QtdEZCakprU3RKMUViNmpIbnRqY1JNTC1IQ2tHVXdAbWFpbC5nbWFpbC5jb20v
VC8jdA0KDQpUaGFua3MsDQpZYW50ZW5nDQo+ICsgICAgICAgICVwUyAgICAgdmVyc2F0aWxlX2lu
aXQrMHgwLzB4MTEwIFttb2R1bGVfbmFtZV0NCj4gKyAgICAgICAgJXBTYiAgICB2ZXJzYXRpbGVf
aW5pdCsweDAvMHgxMTAgW21vZHVsZV9uYW1lIGVkNTAxOWZkZjVlNTNiZTM3Y2IxYmE3ODk5Mjky
ZDdlMTQzYjI1OWVdDQo+ICsgICAgICAgICVwU1JiICAgdmVyc2F0aWxlX2luaXQrMHg5LzB4MTEw
IFttb2R1bGVfbmFtZSBlZDUwMTlmZGY1ZTUzYmUzN2NiMWJhNzg5OTI5MmQ3ZTE0M2IyNTllXQ0K
PiArICAgICAgICAgICAgICAgICh3aXRoIF9fYnVpbHRpbl9leHRyYWN0X3JldHVybl9hZGRyKCkg
dHJhbnNsYXRpb24pDQo+ICsgICAgICAgICVwQmIgICAgcHJldl9mbl9vZl92ZXJzYXRpbGVfaW5p
dCsweDg4LzB4ODggW21vZHVsZV9uYW1lIGVkNTAxOWZkZjVlNTNiZTM3Y2IxYmE3ODk5MjkyZDdl
MTQzYjI1OWVdDQo+ICsNCj4gIOadpeiHqkJQRiAvIHRyYWNpbmfov73ouKrnmoTmjqLmn6XmjIfp
kogNCj4gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4NCj4gLS0NCj4gMi4y
NS4xDQo+DQo=
