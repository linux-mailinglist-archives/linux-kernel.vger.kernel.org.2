Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABE840848E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhIMGR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbhIMGRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:17:55 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:16:39 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c4so3567552pls.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MPbZhr4pvoljkI8sWZNbbYfKkKnwfyYYBYn2vSRal1E=;
        b=HCB8mRjwTiuZAmyRLVxRuv2CpBOeoVeU7grCujXTHkd7zQyRPsc2ZIsUybYZvaYutJ
         UIWr3QjxOuSJJFkowZehCUAAH6A+RsEPBM9bA/NJ6uo0zB6OvWwW6Z5NtmGnDUHPY2Yc
         EI3FUP9wsCGxNjL0RUr2rZfK6odRiNHy6FzE4PuuHFKQiTxJE9BBbXNZPzeLxX3u4eXk
         3r+qVsYjbOsTXOkRba+obC7ys4uvAujFbbghlMwW6/A232SIXmpY4MWqIi1twdf9a3R3
         np3SjqMiwMRopmdhyQlLXNQNOGi/9LfrjGvIDVgZhnbLEngg2dMTT1IOb+4ePRLRFTbD
         t08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=MPbZhr4pvoljkI8sWZNbbYfKkKnwfyYYBYn2vSRal1E=;
        b=IYGVfKh/54UBAnWajnclNRuNQLXnVfQB1RiOUD1qKFlOewyF6p1iVJBncuzQ+5IhEZ
         qbneYdpbkBR+dZSymmlkAj97QTsoVazAE1HBVG2JC0nHeyx6k1TvkyflcM9shTo8gsUs
         o/A//IAOU5XGsafkOmx/2OqnX2fWdDa1GVAojPSuZcgmTWCup0DRbFiUEW3uODYB+hF/
         emmEhh8p2Qfd7IUVj7eKv6Vaad7ipTV2qDP0Ct7Olnf5F2PXJLVRYuCI854Zn0XhKuCl
         U52HVs9aRCdOYFZ+j3yBwXIsbZu+qE4L2dCglYp3mLrhDoY6cR0LXi964ECvtoJFJwk1
         hY2g==
X-Gm-Message-State: AOAM530p2GRTHegc+wvBURKHZPtWZ/Psr85kmiaqvqId0ok7t44JN77w
        h5e0lmDHMdCqfIqL6FsCHeSTgPQz4Bmb54VguJo=
X-Google-Smtp-Source: ABdhPJx3xM7TpPIgTWmUzMJkLLc7bJcYc3M7DpLIjIxGe4yLGUJmxn1oEB8lXhfgpbmhZP1vyHrrbJNDqejVdngJrl4=
X-Received: by 2002:a17:903:4049:b0:13b:99ea:8899 with SMTP id
 n9-20020a170903404900b0013b99ea8899mr1765928pla.84.1631513799285; Sun, 12 Sep
 2021 23:16:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:a754:0:0:0:0 with HTTP; Sun, 12 Sep 2021 23:16:38
 -0700 (PDT)
Reply-To: michaelrachid7@gmail.com
From:   Michael Rachid <whoknowsladyjay@gmail.com>
Date:   Mon, 13 Sep 2021 07:16:38 +0100
Message-ID: <CAMhEkO5DvCm0jtB3KdB9H9Q8O+CSrP-SyWp6jFKmmJbyzBXgZQ@mail.gmail.com>
Subject: =?UTF-8?B?UHJvcG9zYWwv0J/RgNC10LTQu9C+0LbQtdC90LjQtSBQcmVkbG96aGVuaXll?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQoNCtCvINC/0LjRiNGDLCDRh9GC0L7QsdGLINC/0YDQ
vtC40L3RhNC+0YDQvNC40YDQvtCy0LDRgtGMINCy0LDRgSDQviDQutC+0LzQvNC10YDRh9C10YHQ
utC+0Lwg0L/RgNC10LTQu9C+0LbQtdC90LjQuCwg0LrQvtGC0L7RgNC+0LUNCtGPINGF0L7RgtC1
0Lsg0LHRiyDQvtCx0YHRg9C00LjRgtGMINGBINCy0LDQvNC4Lg0K0KDQtdGH0Ywg0LjQtNC10YIg
0L4g0L/Rj9GC0LjQtNC10YHRj9GC0Lgg0LzQuNC70LvQuNC+0L3QsNGFINC00L7Qu9C70LDRgNC+
0LIuINCR0YPQtNGM0YLQtSDRg9Cy0LXRgNC10L3Riywg0YfRgtC+INCy0YHQtQ0K0LfQsNC60L7Q
vdC90L4g0Lgg0LHQtdC30L7Qv9Cw0YHQvdC+Lg0K0J/QvtC20LDQu9GD0LnRgdGC0LAsINGD0LrQ
sNC20LjRgtC1INGB0LLQvtC5INC40L3RgtC10YDQtdGBLg0KDQrQnNCw0LnQutC7INCg0LDRiNC4
0LQuDQoNCkRvcm9nb3kgZHJ1ZywNCg0KWUEgcGlzaHUsIGNodG9ieSBwcm9pbmZvcm1pcm92YXQn
IHZhcyBvIGtvbW1lcmNoZXNrb20gcHJlZGxvemhlbmlpLA0Ka290b3JveWUgeWEga2hvdGVsIGJ5
IG9ic3VkaXQnIHMgdmFtaS4NClJlY2gnIGlkZXQgbyBweWF0aWRlc3lhdGkgbWlsbGlvbmFraCBk
b2xsYXJvdi4gQnVkJ3RlIHV2ZXJlbnksIGNodG8NCnZzZSB6YWtvbm5vIGkgYmV6b3Bhc25vLg0K
UG96aGFsdXlzdGEsIHVrYXpoaXRlIHN2b3kgaW50ZXJlcy4NCg0KTWF5a2wgUmFzaGlkLg0KDQoN
Cg0KRGVhciBmcmllbmQsDQoNCkkgd3JpdGUgdG8gaW5mb3JtIHlvdSBhYm91dCBhIGJ1c2luZXNz
IHByb3Bvc2FsIEkgaGF2ZSB3aGljaCBJIHdvdWxkDQpsaWtlIHRvIGhhbmRsZSB3aXRoIHlvdS4N
CkZpZnR5IG1pbGxpb24gZG9sbGFycyBpcyBpbnZvbHZlZC4gQmUgcmVzdCBhc3N1cmVkIHRoYXQg
ZXZlcnl0aGluZyBpcw0KbGVnYWwgYW5kIHJpc2sgZnJlZS4NCktpbmRseSBpbmRpY2F0ZSB5b3Vy
IGludGVyZXN0Lg0KDQpNaWNoYWVsIFJhY2hpZC4NCg==
