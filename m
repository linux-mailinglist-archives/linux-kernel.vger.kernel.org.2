Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3339D5AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFGHQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:16:20 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:34346 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGHQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:16:19 -0400
Received: by mail-yb1-f171.google.com with SMTP id i6so8865254ybm.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 00:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Lcb9Jcod6GLY84gSlwgtlrw4cij9QYZr+2pTn+iIc1I=;
        b=EBZgG6XSiLJnQhUIUXSCgP3C0lfu3GMOqeX4AY0EbXFcMwr7nLE191tPRwXcP+VKkS
         nAkPlEAx15KgNRrmyKnnqJy8aaNPGbPZva6CyvXGiJJpqNCMbm6AXAhJqavyqzwUPAv4
         xLJaTvE2i6e8JSjFCsU6DrhHgFofKrHTjeasQ4J9lTmLjgL/p/XXtxVPVc55FM2qJp/K
         KCWJvE33AC5MskkM9aKwjVPj0XhGwq3HjKwER4OzDKcyAbBxFVS/KPwxDXdNa4WTbnN8
         84ZHfL34IeOyT8PJWNEiWxk1CLzsBkOjzd8cTmLWttZY6AlvM78IRNCAIvmb00uVY//Q
         1SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Lcb9Jcod6GLY84gSlwgtlrw4cij9QYZr+2pTn+iIc1I=;
        b=k+gBKwxruiAioKzvQ/ydLu2ZiIunWGfg7FLKGDfPKN7E+uiEIINfQdwpapIi37jM8P
         YfqW8OXgSzwJjpF+LM+7f2nz4udB0yuhgUT9Lbhq+I1PE51Xbjkj8oz+4BRhzVRmPWXq
         vwHlxF9tVslRJFyP2/T8HMrTsreNTjIcxbTImtIR+SsZQJ9SgWZncMjNTjvFh1i4RGPp
         JHyBtiHnkguXj4jYCtoHgSWe0eQSdrgY7pneetLqPJcwCYsdSnmvkeT88VTjdiGVzqTZ
         lWwwCjBNEXSGbutYjVG+KakbeRptcpT2PDilESA8CF+78AV7h5dWXABf6Vb+n9hj9rHv
         QX5g==
X-Gm-Message-State: AOAM532wUzzH7s3p+McpJ+h8cXREcQ1qay5hjvveqkl/QOqpWwhkVowx
        lRKYexqwvlhJ5uD2IzAAsl1qAoM2AFWX2A19hiU=
X-Google-Smtp-Source: ABdhPJzkvfX2ZYrptXhapWM+nyQy1QwqXbNFYqomqoyU6cpWDuBbxzfTkh8JnfrtURw0ZdRQ/VUQ9pmo1RyLwCBfpZU=
X-Received: by 2002:a25:ef42:: with SMTP id w2mr20888308ybm.34.1623049993098;
 Mon, 07 Jun 2021 00:13:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:7808:b029:b1:3756:370a with HTTP; Mon, 7 Jun 2021
 00:13:12 -0700 (PDT)
Reply-To: davidbojana20@gmail.com
From:   davidbojana <aadia084@gmail.com>
Date:   Mon, 7 Jun 2021 07:13:12 +0000
Message-ID: <CAA-c2iU0OS4hpmMOL=2Q7xK-EC9Zj3coRA1qR4fkMPfhdwqOyQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JfQtNGA0LDQstC10LnRgtC1LCDQm9GO0LHQtdC30L3QviDQktC4INC40L3RhNC+0YDQvNC40YDQ
sNC80LUsINGH0LUg0YLQvtC30Lgg0LjQvNC10LnQuywg0LrQvtC50YLQviDQtSDQtNC+0YHRgtC4
0LPQvdCw0Lsg0LTQvg0K0LLQsNGI0LDRgtCwINC/0L7RidC10L3RgdC60LAg0LrRg9GC0LjRjywg
0L3QtSDQtSDQs9GA0LXRiNC60LAsINCwINC1INC90LDRgdC+0YfQtdC9INC60YrQvCDQstCw0YEu
INCY0LzQsNC8DQrQv9GA0LXQtNC70L7QttC10L3QuNC1ICg3IDUwMCAwMDAsMDAg0LTQvtC70LDR
gNCwKSwg0L7RgdGC0LDQstC10L3QviDQvtGCINC80L7RjyDQv9C+0YfQuNC90LDQuyDQutC70LjQ
tdC90YIsDQrQuNC90LbQtdC90LXRgCDQmtCw0YDQu9C+0YEsINC60L7QudGC0L4g0L3QvtGB0Lgg
0YHRitGJ0L7RgtC+INC40LzQtSwg0LrQvtC50YLQviDQvdGP0LrQvtCz0LAg0LUg0YDQsNCx0L7R
gtC40Lsg0Lgg0LUNCtC20LjQstGP0Lsg0YLRg9C6INCyINCb0L7QvNC1INCi0L7Qs9C+LiDQnNC+
0Y/RgiDQv9C+0YfQuNC90LDQuyDQutC70LjQtdC90YIg0Lgg0YHQtdC80LXQudGB0YLQstC+INGB
0LAg0YPRh9Cw0YHRgtCy0LDQu9C4INCyDQrQsNCy0YLQvtC80L7QsdC40LvQvdCwINC60LDRgtCw
0YHRgtGA0L7RhNCwLCDQvtGC0L3QtdC70LAg0LbQuNCy0L7RgtCwINC40LwuINCp0LUg0YHQtSDR
gdCy0YrRgNC20LAg0YEg0LLQsNGBINC60LDRgtC+DQrQvdCw0Lkt0LHQu9C40LfQutC40Y8g0YDQ
vtC00L3QuNC90LAg0L3QsCDQv9C+0YfQuNC90LDQu9C40Y8sINC30LAg0LTQsCDQvNC+0LbQtdGC
0LUg0LTQsCDQv9C+0LvRg9GH0LjRgtC1INGB0YDQtdC00YHRgtCy0LAg0LfQsA0K0LjRgdC60L7Q
stC10YLQtS4g0KHQu9C10LQg0LHRitGA0Lcg0L7RgtCz0L7QstC+0YAg0YnQtSDQstC4INC40L3R
hNC+0YDQvNC40YDQsNC8INC30LAg0L3QsNGH0LjQvdC40YLQtSDQt9CwINC/0YDQuNC70LDQs9Cw
0L3QtQ0K0L3QsCDRgtC+0LfQuCDQt9Cw0LLQtdGCLCDQvNC+0LvRjywg0YHQstGK0YDQttC10YLQ
tSDRgdC1INGBINC80LXQvSDQv9C+INGC0L7Qt9C4INCy0YrQv9GA0L7RgQ0KKGRhdmlkYm9qYW5h
MjBAZ21haWwuY29tKQ0K
