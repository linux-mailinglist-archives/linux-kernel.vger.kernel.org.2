Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF541AE22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbhI1LwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbhI1LwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:52:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72788C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:50:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v10so77718860edj.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=P6hcjUDgNRVWoQlF2WjLd9MJ396DFb3R2r9u5EtGSlM=;
        b=aJ/g7gRoDmFeqtLxbU680168dEvy4besiL5vpvcYFRNaHB2vg6MxP70FiwUA0RI9hl
         DXnkXdb8AHAC/w9oOy0chZXcqnPOcRqX035v4t0jyZTfIUbMn/8WWiFjBRmv6y5vcTnx
         wjvD5e0xlnT3qkMWRyTUQzws3MusPJ66ZBvGHhHxZM+fa6qaP9zYEIikQRe7ik1qtYiT
         KsU8zfaVJUaT8Cq/yNKtBidGWmGFvImCz2/kyGQFdwif+wdDm51qHLLAZiIt3xL6doyf
         nHst6As1rj+MUuCziyxdjc7dl8nhh0a5p7srTG0cGoNm8Ch4Qtp8BLb1BA30EKvqjSzA
         /JJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=P6hcjUDgNRVWoQlF2WjLd9MJ396DFb3R2r9u5EtGSlM=;
        b=1I+6XkzVKtuZ4PAbgGz3pJHyNx1eLQQxcS1lKxMOfuL7TlJad0hS5QewNGQ65mfwsG
         Z2Q6Zf4X5KATyeHEEHHKWzH77D1/87mDPcbsPM2s43vOyHiuhmg7y5mwsaZqDieyGUCW
         vQHszm+e2xO/boNYQqLmajO/nvR4hsTH0krOaJo8VTxkj2xtR8EBllVMPt+FNO73xvkB
         +a4s099WtkHbdkIV956ZoGd7gi29SwtWcV1h/2x6ue/LZyMWLeN040YJ5lzRgHAGhDOZ
         oX6jS/CbSMfp8zY+/hRXY72SLGEzB8B7fBeJRW1O2voQTZrcLgaJ0JyNltESGfwFzFMw
         i9Aw==
X-Gm-Message-State: AOAM530Q/GGJMucSjBvIk5qEgxpQ2KMQszoz2cOWgWWzJiFqc+oG25GN
        5+kiUV/Yyoqid6w0oWWxrgUBuKOae9DIkB1k6Z4=
X-Google-Smtp-Source: ABdhPJwLRpkSdJ6/ErUi06oRRndtpROWNCtS0JbWce54pYYdelkFn7zowNnetrsWjJ5JyWcfBD+gAn+pDWiskua7y3Q=
X-Received: by 2002:a50:cf87:: with SMTP id h7mr7175831edk.324.1632829825948;
 Tue, 28 Sep 2021 04:50:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a416:0:0:0:0:0 with HTTP; Tue, 28 Sep 2021 04:50:25
 -0700 (PDT)
Reply-To: asameraa950@gmail.com
From:   Samera Ali <hasamuhammad24@gmail.com>
Date:   Tue, 28 Sep 2021 04:50:25 -0700
Message-ID: <CAEsd0f=1gYDNX6kUWkq6hLzi5cfF8xQ-Qa-qUp9_9c159kXwUA@mail.gmail.com>
Subject: =?UTF-8?B?0JfQtNGA0LDQstC10Lkg0YHQutGK0L/QsA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JfQtNGA0LDQstC10Lkg0YHQutGK0L/QsA0KDQrQn9GA0LjRj9GC0L3QviDQvNC4INC1LCBBbSBN
aXNzIHNhbWVyYSDQndCw0LzQtdGA0LjRhSDQuNC80LXQudC70LAg0LLQuCDRgtGD0Log0LIg0YLR
itGA0YHQtdC90LXRgtC+INGBDQpHb29nbGUg0Lgg0LjQt9Cx0YDQsNGFINC40L3RgtC10YDQtdGB
INC00LAg0YHQtSDRgdCy0YrRgNC20LAg0YEg0LLQsNGBLiDQmNC80LDQvCDQvdC10YnQviDQvNC9
0L7Qs9C+INCy0LDQttC90L4sDQrQutC+0LXRgtC+INCx0LjRhSDQuNGB0LrQsNC7INC00LAg0L7Q
sdGB0YrQtNGPINGBINCy0LDRgSDQuCDRidC1INGB0YrQvCDQsdC70LDQs9C+0LTQsNGA0LXQvSwg
0LDQutC+INC80Lgg0L7RgtCz0L7QstC+0YDQuNGC0LUNCtGH0YDQtdC3INC80L7RjyDQuNC80LXQ
udC7INCw0LTRgNC10YEsINC30LAg0LTQsCDQstC4INGA0LDQt9C60LDQttCwINC/0L7QstC10YfQ
tSDQt9CwINC80LXQvSDRgSDQvNC+0LjRgtC1INGB0L3QuNC80LrQuCwNCtC80L7RjyDQu9C40YfQ
tdC9INC40LzQtdC50Lsg0LrQsNGC0L4g0LrQvtC70LXQs9C4ID8/IFthc2FtZXJhYTk1MEBnbWFp
bC5jb21dDQoNCtCe0YIsIHNhbWVyYSBhbGkNCg==
