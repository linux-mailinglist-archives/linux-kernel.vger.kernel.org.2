Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4035360C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbhDDAtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 20:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbhDDAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 20:48:58 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE2C061756
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 17:48:55 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i6so5918233pgs.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=n0vLUHcJY9qlxonB+ok0V07BefT216FHYQcrnvrVkVc=;
        b=FWePUfi+4Dssm/JWagrPqvzla2jqzv0UnAttloXU0vHaGcxy38ss5mqXPmJqaioL8o
         IXQLU4ijuO+TKEcr3QJWo12rkEn/7Zpt5xxk7g1dDoIEGC0IJQwq9JQwe72GDnZuepuI
         Id1HqGliv0xcKyUAJwFwr5BXGN/RaKhAd32hKZqOScCq+Ti6wyBiicmsmyJ27fkqXn4O
         hWU30HIAhLN4u894Dt3tWjEXA5E+gBzioxPwj/lCGklMfuA8o1VzxqBNS8ARuoVhthfR
         tCt1GKoVhfnXnnNEX62yc4UuuPy/63CDSJUzlPD37K75OF0/Y+pDnUj5hyxumdd87kcZ
         yoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=n0vLUHcJY9qlxonB+ok0V07BefT216FHYQcrnvrVkVc=;
        b=teloYVY43NNTXHicABukyoiA1LPXpHwUJZb51+n0avA+GVqXgVy40GS2z9UByv7rLu
         kwWTMLOqS6gmpQj+FUSuKonBstfoe/NGRsrAZInWRAgjQL4i3u/pDmVprGj2tpHjYO7h
         VWl51ozOfSJiKDZGqZNKS+2Z9xOwaEkdqSi0XBQfX/PLrKlfmdKgFsKOjsxM1NP0aIts
         cBmuTcIwYYOh4MDxeLaz53qSNX3E1fDfoQjX/TFmrh90WO98CtDSKK50aOcBnsd6tg72
         //BFR8CMFUqi8+O1Y0pcYY8p8T9zhXNK9hECrE8UsWbfR2OonwPsj1Xt1c0gBAhFUyso
         XkWQ==
X-Gm-Message-State: AOAM530Fy8I09biWqonzCp8W7rhtdQrudr4SPzkDlVMv1omwb5h7GRdv
        z/DXeMyM+LKYQd4AOg6dNStMFW7qz2G1bx8Tg5k=
X-Google-Smtp-Source: ABdhPJyBPR8syAtgCukc0TtEBdQrFkBGDOJFqAcVQZLSOZUyES+5n2WQYcC6LUKd7+0hM0hlMBM5+vpnY03YjyxImO4=
X-Received: by 2002:aa7:9f90:0:b029:204:99fa:3374 with SMTP id
 z16-20020aa79f900000b029020499fa3374mr17936558pfr.11.1617497334802; Sat, 03
 Apr 2021 17:48:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:1a12:0:0:0:0 with HTTP; Sat, 3 Apr 2021 17:48:54
 -0700 (PDT)
From:   Lillian Windrope <lillianwnwindrope@gmail.com>
Date:   Sun, 4 Apr 2021 01:48:54 +0100
Message-ID: <CAA4ebrfmPtm+hKrK+qDOS0cE7m4EShZBmo3AyenBC3TewXBUfQ@mail.gmail.com>
Subject: Hi,
To:     lillianwnwindrope <lillianwnwindrope@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gZGVhciBob3cgYXJlIHlvdSB0b2RheT8gSSBob3BlIHlvdSBkaWQgcmVjZWl2ZSB0aGUg
bWVzc2FnZSBJDQpzZW50IHRvIHlvdSBMYXN0IHRpbWU/LiBJIGFtIHdhaXRpbmcuDQrQn9GA0LjQ
stC10YIg0LTQvtGA0L7Qs9Cw0Y8sINC60LDQuiDRgtGLINGB0LXQs9C+0LTQvdGPPyDQndCw0LTQ
tdGO0YHRjCwg0LLRiyDQv9C+0LvRg9GH0LjQu9C4INGB0L7QvtCx0YnQtdC90LjQtSwNCtC60L7R
gtC+0YDQvtC1INGPINC+0YLQv9GA0LDQstC40Lsg0LLQsNC8INCyINC/0YDQvtGI0LvRi9C5INGA
0LDQtz8g0K8g0L7QttC40LTQsNGOLg0K
