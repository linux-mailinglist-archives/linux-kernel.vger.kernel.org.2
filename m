Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0A376F9A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 06:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhEHEj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 00:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhEHEjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 00:39:54 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CF6C061574;
        Fri,  7 May 2021 21:38:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m37so8824294pgb.8;
        Fri, 07 May 2021 21:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mGk0kVg1R4M2lDrV1XZ1qOw5t+AQ596A0i9SpPo96oQ=;
        b=iD46IKEY6zTfDT4bs9KpSFt3SisfygC8LQkkATDzrCOd50sHRxg09x9EiZmrxu6W3c
         GLDXxP4rCAHk06QAjGhtQ6LDVY6/t+mTr7hQxMJJYFoA9EgfZq1PRPQ/FxMIziB5kRqn
         TEsRxEXLL3cmXnLA5DY5kf6Y5vQ2PbzQRtGcMUkvRzREvEfcpMrMpsJq6zGOkGyWalBN
         xXTVHOX+jS1Iq29TNKkeUpSkGwT7+HmoqzlGpEbQWqLwxMEmsWzD8/PeXgou5pF9ca3L
         t90MlmeD68tj92C3hI2XBCcQGXXYpN+O5oD3rcMHLnWrdvRhigZl2CTJTJ+fWFFrLn1t
         JUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mGk0kVg1R4M2lDrV1XZ1qOw5t+AQ596A0i9SpPo96oQ=;
        b=idSjjGHsT34p5DPoq3kXeUmRgyfgYNGCxbSPfgXaNfk0UZKPGL2g5yHsDtbzYdS5Rj
         V1tZVFDBokeyzFiMM5E3U/NPOdUe4ddXDQlUJQDe2VmStM2qjsJeixG/dbf98PMx6C9U
         lVCnqIRK1TC6dFfXhEpF8Rtx9j/fCK9LFH0mqnAa/PMXKRy09uxHsoQ7SwZy+8JdeTfm
         X3vCfP0tgvJsTWm3jz0T2D2Q8/GJc2EaDP95NkrZjnNMFEos0RQBot6+TEkhwJEk2CrG
         p+3EDK/zkGTUBK6IyHlYzzxOQSPuJLfS+fXgWy9dbPpIP53fuVFmBkPnI7Kxz2CIqtOo
         fO4Q==
X-Gm-Message-State: AOAM532TtpgEn0OKBKlvQJdtRf8MAs5xmwv43csOxt4XOPI1cIggeWaR
        FLLR1zH0CnW4xvYCVrjRsHxkpHxhZu7vndWfgEs=
X-Google-Smtp-Source: ABdhPJw7eJ67syCIfdLg7HJ8JUfNMhxHCscfv7dPVwMV5rOPlzPY50SrTQfsyRtem5jKQxGz4Q+93qUGFS17IVqE+Ik=
X-Received: by 2002:a62:aa04:0:b029:28e:f2ee:f7a8 with SMTP id
 e4-20020a62aa040000b029028ef2eef7a8mr14304317pff.62.1620448732515; Fri, 07
 May 2021 21:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210508030741.82655-1-wanjiabing@vivo.com>
In-Reply-To: <20210508030741.82655-1-wanjiabing@vivo.com>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Sat, 8 May 2021 12:38:43 +0800
Message-ID: <CAMU9jJo47KgsoCaCm-+hRjBgAbqkTDvTkZmjwWA_PC_F8nhRSQ@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Remove obsolete translation file
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IFlhbnRlbmcgU2kgPHNpeWFudGVuZ0Bsb29uZ3Nvbi5jbj4NCg0KV2FuIEpp
YWJpbmcgPHdhbmppYWJpbmdAdml2by5jb20+IOS6jjIwMjHlubQ15pyIOOaXpeWRqOWFrSDkuIrl
jYgxMTowOOWGmemBk++8mg0KPg0KPiBUaGlzIHRyYW5zbGF0aW9uIGZpbGUgd2FzIHJlcGxhY2Vk
IGJ5DQo+ICAgIERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2FkbWluLWd1aWRlL3Nl
Y3VyaXR5LWJ1Z3MucnN0DQo+IHdoaWNoIHdhcyBjcmVhdGVkIGluIGNvbW1pdCAyZDE1MzU3MTAw
M2IgKCJkb2NzL3poX0NOOiBBZGQNCj4gemhfQ04vYWRtaW4tZ3VpZGUvc2VjdXJpdHktYnVncy5y
c3QiKS4NCj4gVGhpcyBpcyBhIHRyYW5zbGF0aW9uIGxlZnQgb3ZlciBmcm9tIGhpc3RvcnkuIFJl
bW92ZSBpdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogV2FuIEppYWJpbmcgPHdhbmppYWJpbmdAdml2
by5jb20+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vU2VjdXJp
dHlCdWdzIHwgNTAgLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUwIGRl
bGV0aW9ucygtKQ0KPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL3poX0NOL1NlY3VyaXR5QnVncw0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMvemhfQ04vU2VjdXJpdHlCdWdzIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vU2VjdXJpdHlCdWdzDQo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRl
eCAyZDBmZmZkMTIyY2UuLjAwMDAwMDAwMDAwMA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy96aF9DTi9TZWN1cml0eUJ1Z3MNCj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSw1MCAr
MCwwIEBADQo+IC1DaGluZXNlIHRyYW5zbGF0ZWQgdmVyc2lvbiBvZiBEb2N1bWVudGF0aW9uL2Fk
bWluLWd1aWRlL3NlY3VyaXR5LWJ1Z3MucnN0DQo+IC0NCj4gLUlmIHlvdSBoYXZlIGFueSBjb21t
ZW50IG9yIHVwZGF0ZSB0byB0aGUgY29udGVudCwgcGxlYXNlIGNvbnRhY3QgdGhlDQo+IC1vcmln
aW5hbCBkb2N1bWVudCBtYWludGFpbmVyIGRpcmVjdGx5LiAgSG93ZXZlciwgaWYgeW91IGhhdmUg
YSBwcm9ibGVtDQo+IC1jb21tdW5pY2F0aW5nIGluIEVuZ2xpc2ggeW91IGNhbiBhbHNvIGFzayB0
aGUgQ2hpbmVzZSBtYWludGFpbmVyIGZvcg0KPiAtaGVscC4gIENvbnRhY3QgdGhlIENoaW5lc2Ug
bWFpbnRhaW5lciBpZiB0aGlzIHRyYW5zbGF0aW9uIGlzIG91dGRhdGVkDQo+IC1vciBpZiB0aGVy
ZSBpcyBhIHByb2JsZW0gd2l0aCB0aGUgdHJhbnNsYXRpb24uDQo+IC0NCj4gLUNoaW5lc2UgbWFp
bnRhaW5lcjogSGFycnkgV2VpIDxoYXJyeXhpeW91QGdtYWlsLmNvbT4NCj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAtRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9zZWN1cml0eS1idWdzLnJzdCDnmoTkuK3m
lofnv7vor5ENCj4gLQ0KPiAt5aaC5p6c5oOz6K+E6K665oiW5pu05paw5pys5paH55qE5YaF5a65
77yM6K+355u05o6l6IGU57O75Y6f5paH5qGj55qE57u05oqk6ICF44CC5aaC5p6c5L2g5L2/55So
6Iux5paHDQo+IC3kuqTmtYHmnInlm7Dpmr7nmoTor53vvIzkuZ/lj6/ku6XlkJHkuK3mlofniYjn
u7TmiqTogIXmsYLliqnjgILlpoLmnpzmnKznv7vor5Hmm7TmlrDkuI3lj4rml7bmiJbogIXnv7sN
Cj4gLeivkeWtmOWcqOmXrumimO+8jOivt+iBlOezu+S4reaWh+eJiOe7tOaKpOiAheOAgg0KPiAt
DQo+IC3kuK3mlofniYjnu7TmiqTogIXvvJog6LS+5aiB5aiBIEhhcnJ5IFdlaSA8aGFycnl4aXlv
dUBnbWFpbC5jb20+DQo+IC3kuK3mlofniYjnv7vor5HogIXvvJog6LS+5aiB5aiBIEhhcnJ5IFdl
aSA8aGFycnl4aXlvdUBnbWFpbC5jb20+DQo+IC3kuK3mlofniYjmoKHor5HogIXvvJog6LS+5aiB
5aiBIEhhcnJ5IFdlaSA8aGFycnl4aXlvdUBnbWFpbC5jb20+DQo+IC0NCj4gLQ0KPiAt5Lul5LiL
5Li65q2j5paHDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLUxpbnV45YaF5qC45byA5Y+R6ICF6K6k5Li6
5a6J5YWo6Z2e5bi46YeN6KaB44CC5Zug5q2k77yM5oiR5Lus5oOz6KaB55+l6YGT5b2T5LiA5Liq
5pyJ5YWz5LqODQo+IC3lronlhajnmoTmvI/mtJ7ooqvlj5HnjrDnmoTml7blgJnvvIzlubbkuJTl
roPlj6/og73kvJrooqvlsL3lv6vnmoTkv67lpI3miJbogIXlhazlvIDjgILor7fmiorov5nkuKrl
ronlhagNCj4gLea8j+a0nuaKpeWRiue7mUxpbnV45YaF5qC45a6J5YWo5Zui6Zif44CCDQo+IC0N
Cj4gLTEpIOiBlOezuw0KPiAtDQo+IC1saW51eOWGheaguOWuieWFqOWboumYn+WPr+S7pemAmui/
h2VtYWlsPHNlY3VyaXR5QGtlcm5lbC5vcmc+5p2l6IGU57O744CC6L+Z5pivDQo+IC3kuIDnu4Tn
i6znq4vnmoTlronlhajlt6XkvZzkurrlkZjvvIzlj6/ku6XluK7liqnmlLnlloTmvI/mtJ7miqXl
kYrlubbkuJTlhazluIPlkozlj5bmtojkuIDkuKrkv67lpI3jgILlrokNCj4gLeWFqOWboumYn+ac
ieWPr+iDveS8muS7jumDqOWIhueahOe7tOaKpOiAhemCo+mHjOW8lei/m+mineWklueahOW4ruWK
qeadpeS6huino+W5tuS4lOS/ruWkjeWuieWFqOa8j+a0nuOAgg0KPiAt5b2T6YGH5Yiw5Lu75L2V
5ryP5rSe77yM5omA6IO95o+Q5L6b55qE5L+h5oGv6LaK5aSa5bCx6LaK6IO96K+K5pat5ZKM5L+u
5aSN44CC5aaC5p6c5L2g5LiN5riF5qWa5LuA5LmIDQo+IC3mmK/mnInluK7liqnnmoTkv6Hmga/v
vIzpgqPlsLHor7fph43muKnkuIDkuIthZG1pbi1ndWlkZS9yZXBvcnRpbmctYnVncy5yc3Tmlofk
u7bkuK3nmoTmpoLov7Dov4fnqIvjgILku7sNCj4gLeS9leaUu+WHu+aAp+eahOS7o+eggemDveaY
r+mdnuW4uOacieeUqOeahO+8jOacque7j+aKpeWRiuiAheeahOWQjOaEj+S4jeS8muiiq+WPlua2
iO+8jOmZpOmdnuWug+W3sue7jw0KPiAt6KKr5YWs5biD5LqO5LyX44CCDQo+IC0NCj4gLTIpIOWF
rOW8gA0KPiAtDQo+IC1MaW51eOWGheaguOWuieWFqOWboumYn+eahOWul+aXqOWwseaYr+WSjOa8
j+a0nuaPkOS6pOiAheS4gOi1t+WkhOeQhua8j+a0nueahOino+WGs+aWueahiOebtA0KPiAt5Yiw
5YWs5byA44CC5oiR5Lus5Zac5qyi5bC95b+r5Zyw5a6M5YWo5YWs5byA5ryP5rSe44CC5b2T5LiA
5Liq5ryP5rSe5oiW6ICF5L+u5aSN6L+Y5rKh5pyJ6KKr5a6M5YWo5Zyw55CGDQo+IC3op6PvvIzo
p6PlhrPmlrnmoYjmsqHmnInpgJrov4fmtYvor5XmiJbogIXkvpvlupTllYbljY/osIPvvIzlj6/k
u6XlkIjnkIblnLDlu7bov5/lhazlvIDjgILnhLbogIzvvIzmiJHku6wNCj4gLeacn+acm+i/meS6
m+W7tui/n+WwveWPr+iDveeahOefreS6m++8jOaYr+WPr+aVsOeahOWHoOWkqe+8jOiAjOS4jeaY
r+WHoOS4quaYn+acn+aIluiAheWHoOS4quaciOOAguWFrOW8gA0KPiAt5pel5pyf5piv6YCa6L+H
5a6J5YWo5Zui6Zif5ZKM5ryP5rSe5o+Q5L6b6ICF5Lul5Y+K5L6b5bqU5ZWG5rS96LCI5ZCO55qE
57uT5p6c44CC5YWs5byA5pe26Ze06KGo5piv5LuO5b6IDQo+IC3nn63vvIjnibnmrornmoTvvIzl
roPlt7Lnu4/ooqvlhazkvJfmiYDnn6XpgZPvvInliLDlh6DkuKrmmJ/mnJ/jgILkvZzkuLrkuIDk
uKrln7rmnKznmoTpu5jorqTmlL/nrZbvvIzmiJENCj4gLeS7rOaJgOacn+acm+mAmuefpeWFrOS8
l+eahOaXpeacn+aYrzflpKnnmoTlronmjpLjgIINCj4gLQ0KPiAtMykg5L+d5a+G5Y2P6K6uDQo+
IC0NCj4gLUxpbnV45YaF5qC45a6J5YWo5Zui6Zif5LiN5piv5LiA5Liq5q2j5byP55qE5Zui5L2T
77yM5Zug5q2k5LiN6IO95Yqg5YWl5Lu75L2V55qE5L+d5a+G5Y2P6K6u44CCDQo+IC0tDQo+IDIu
MjAuMQ0KPg0K
