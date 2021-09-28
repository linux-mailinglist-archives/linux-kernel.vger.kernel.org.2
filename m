Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EDF41B238
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbhI1Oj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241152AbhI1Oj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:39:56 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4AFC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:38:17 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id k11-20020a4abd8b000000b002b5c622a4ddso1896556oop.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=P6hcjUDgNRVWoQlF2WjLd9MJ396DFb3R2r9u5EtGSlM=;
        b=Lcd9Oa/yqGso0KN3S7AMeLjUNZUK8ujHG6MjIdn2PZB3cFLyB1HYoIUZZ5XWIphTrg
         s2PcTNOHTZ0uE4WbgDPWGsE9JZxGLnj2UfOATua1SKGr8oYdg37SePv1xLohb+NGiseu
         VMFpfOsQiw9Zjak7ULaCq6MiBzqt1R1hUNLHZu3AFOEdf7K5QGGoIjG+3Ds/mRsmFZWR
         wKqX+u2PWBcYoQPxXwu/QRe/c7Q6hJ9HumQOM5ASQT+WPW7kEqC3xxKBPJgkeD7gBTra
         UkV3jvsgPaqFMAxWx59Nzq8KkAuY2cWx7hfnYio+vlMtRoilKHI4otSWRD8DXHjf8aoM
         uJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=P6hcjUDgNRVWoQlF2WjLd9MJ396DFb3R2r9u5EtGSlM=;
        b=KHdVTjmgfZNDYoH6kk3AeK+t7opVS8FBec2776pNnVetaoLYqS7ym3LVHhjPpaA4qi
         kNCWIFhHOe4CI7DFBO+0OMeKcN3ZjbahWAPAEgG0iXvEql2UiEWzX7G6GAutTdUDhwZ/
         kUrdizYNSrpmeqBVtUx0oNI34HBbvBI5/G8kF7NL5edMqFomv8WLwuga7iEYN3vAimX0
         5wiSnwzBoXAPR6jz4aRwyLcyiaAL12VGDAWlBjVYEUh+6Y/hUFgehX4SDp5tmBfvqzPM
         3VurSYdKHE4/jKV6dSnExZonpCvgfqXc2AaikzyA9oH4oV4280E/ZIRA471C3CB0iVw7
         HteQ==
X-Gm-Message-State: AOAM532QUl7IJtXT0PZDoTmKF4Q5HLObkfrxWwfbn3hnYwmRTZGbmIex
        hkSpMf1EUuaUMjog4ktZX/kjwNUH+uiAtDVeO5A=
X-Google-Smtp-Source: ABdhPJxXo9/1xdEglrECGEs/g/7RnfhCFn2NF4DyihnN+gFJGm2s+QEQUI5qVz/ELnSQDWRWbr2j1Fs0uNsoQIV8MvU=
X-Received: by 2002:a4a:9510:: with SMTP id m16mr5236732ooi.14.1632839896511;
 Tue, 28 Sep 2021 07:38:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:98c:0:0:0:0:0 with HTTP; Tue, 28 Sep 2021 07:38:15 -0700 (PDT)
Reply-To: asameraa950@gmail.com
From:   Samera Ali <jeminaali147@gmail.com>
Date:   Tue, 28 Sep 2021 07:38:15 -0700
Message-ID: <CAG2sCxzKeMFz3eb-=jx4zS3QpOwk=Tk+ozU5DQNh=-O+yfz7kA@mail.gmail.com>
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
