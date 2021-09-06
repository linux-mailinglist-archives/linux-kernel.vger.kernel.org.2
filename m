Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD526401687
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 08:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbhIFGm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 02:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbhIFGm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 02:42:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C77C061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 23:41:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u9so8115975wrg.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9ZKBQ6Qo+MKbRqA4C0CUyn4v2spzBO/uH3YajAUeuHc=;
        b=WrxXPTSexnqL9ywJmzn29EAd7m3zOxJI9r9q5J3R101rdaArwAA0ep2fVZRzubhJUe
         pJsKDflQ6zYIy3POZz+IcQbUisMU5vPhHMJ8lWf8qkPsd26d+g7xT+vpdAL8nUGB+jIr
         +oVjS8NOiSV+FVJl+FxgFK9n76oa2tBEoLBTTH3MzyqILrp4HT7WZ7sopFdbhbXYCGwx
         +Yd50SwwpSjwR2tPgENMUXdWbzGiUzc40ee3Wzh7KSyr73NO/THLq5A6dBFWmDlCxMJ/
         QYt2w5KTSo3h/LSVYkz1mwuL0Gl17xvzMinqfFIf3h4XLLmJEb/pivhx8etbey9PRZLq
         dmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=9ZKBQ6Qo+MKbRqA4C0CUyn4v2spzBO/uH3YajAUeuHc=;
        b=VD+EoaZBWDAqLQvSA6ZWOIsD3PNUbzHyPwYBIyqZ6BE7Tyzvjbu6QLc0FRQgx8KOqO
         cHBZiuqZGj/moDNjB1cECpAzBGGGPqFkj+soWCRrSRJfUE8Sb1PoX4uH8ye59Irfqb8v
         uW+Y8JwZFLIVyShagz7B1qfETpDhy0UsURN8XjEjk1gLejIHhdATf+q74LHFBosLYpHe
         y1f9xeoA0ozkvGK5k4QKNw1N5U8YCek/1SEUg6ckaLQZ03vkt9ofQ0lC6R0PKtvc/eVL
         gbYXaI2OAEd2encBnyNzRKXavYIWQATABRhzrfAy2vzANTi/ZxfvwqeLU9uj2QylXRkQ
         raSA==
X-Gm-Message-State: AOAM532r1HhE/FVZSFAgoS9rZD2mfJonW/DVEcRrl3b+S8r+DpeytR2v
        GirGlVKwJxWsFK0opVkNKlAdecaaP2UWPQEGQZM=
X-Google-Smtp-Source: ABdhPJzZ3mZbr/OrWTb0N/GHJVydPgMaL50t4Xg3CrXMleDnFpRQ6fr9wVjfN7uwN/IUbBtNnHtdbKIjd+hL9PvzZS8=
X-Received: by 2002:adf:e0cd:: with SMTP id m13mr11450350wri.137.1630910510922;
 Sun, 05 Sep 2021 23:41:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:ac89:0:0:0:0:0 with HTTP; Sun, 5 Sep 2021 23:41:48 -0700 (PDT)
Reply-To: michaelrachid7@gmail.com
From:   Michael Rachid <davidbaldwin378@gmail.com>
Date:   Mon, 6 Sep 2021 07:41:48 +0100
Message-ID: <CAH6Vp6nXS5dh2XVRtgLKAa3rtWHXwe7uXyd2ituVQKjSfHwPiQ@mail.gmail.com>
Subject: =?UTF-8?B?UHJvcG9zYWwgLyDUsdW81aHVu9Wh1oDVr9W41oLVqdW11bjWgtW2IEFycmFqYXJrdXQ=?=
        =?UTF-8?B?4oCZeXVu?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1Y3Vq9aA1aXVrNWrINWo1bbVr9Wl1oAsDQoNCtS11b0g1aPWgNW41oLVtCDVpdW0INWx1aXVpiDV
q9W0INWi1avVptW21aXVvSDVodW81aHVu9Wh1oDVr9WrINW01aHVvdWr1bYg1b/VpdWy1aXVr9Wh
1oHVttWl1azVuNaCINWw1aHVtNWh1oAsINW41oDVqCDVpdW9DQrVr9aB1aHVttWv1aHVttWh1bXV
qyDVrNW41oLVrtWl1awg1bHVpdWmINWw1aXVvzoNCtWG1aXWgNWj1oDVodW+1b7VodWuINWnINWw
1avVvdW41oLVtiDVtNWr1azVq9W41bYg1aTVuNWs1aHWgDog1YDVodW01bjVptW+1aHVriDVpdWy
1aXWhCwg1bjWgCDVodW01aXVtiDVq9W21bkg1oXWgNWr1bbVodWv1aHVtg0K1acg1ocg1aHVvNWh
1bbWgSDVvNWr1b3Vr9Wl1oDVqzoNCtWN1avWgNW41b4g1bbVt9Wl1oQg1bHVpdaAINWw1aXVv9Wh
1oTWgNaE1oDVuNaC1anVtdW41oLVttWoOg0KDQrVhNWh1bXWhNWsINWM1aHVudWr1aQuDQpTaXJl
bGkgeW5rZXIsDQoNClllcyBncnVtIHllbSBkemV6IGltIGJpem5lcyBhcnJhamFya2kgbWFzaW4g
dGVnaGVrYXRz4oCZbmVsdSBoYW1hciwgdm9yeQ0KeWVzIGt0c+KAmWFua2FuYXlpIGx1dHNlbCBk
emV6IGhldDoNCk5lcmdyYXZ2YXRzIGUgaGlzdW4gbWlsaW9uIGRvbGFyOiBIYW1venZhdHMgeWVn
aGVr4oCZLCB2b3IgYW1lbiBpbmNo4oCZDQpvcmluYWthbiBlIHlldiBhcnJhbnRz4oCZIHJyaXNr
ZXJpOg0KU2lyb3YgbnNoZWvigJkgZHplciBoZXRha+KAmXJr4oCZcnV04oCZeXVueToNCg0KTWF5
a+KAmWwgUnJhY2jigJlpZC4NCg0KDQoNCkRlYXIgZnJpZW5kLA0KDQpJIHdyaXRlIHRvIGluZm9y
bSB5b3UgYWJvdXQgYSBidXNpbmVzcyBwcm9wb3NhbCBJIGhhdmUgd2hpY2ggSSB3b3VsZA0KbGlr
ZSB0byBoYW5kbGUgd2l0aCB5b3UuDQpGaWZ0eSBtaWxsaW9uIGRvbGxhcnMgaXMgaW52b2x2ZWQu
IEJlIHJlc3QgYXNzdXJlZCB0aGF0IGV2ZXJ5dGhpbmcgaXMNCmxlZ2FsIGFuZCByaXNrIGZyZWUu
DQpLaW5kbHkgaW5kaWNhdGUgeW91ciBpbnRlcmVzdC4NCg0KTWljaGFlbCBSYWNoaWQuDQo=
