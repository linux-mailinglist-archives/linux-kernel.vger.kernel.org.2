Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB9348851
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 06:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCYFXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 01:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYFXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 01:23:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BE5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 22:23:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i26so717843lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 22:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0/X6qmOpTFkflHLwG5Y7CmNtgLZQ02wndvSmkfHAtWc=;
        b=nQs3Zs8kV1VcOEKNyIViTbjetkSr1lw2JxMH52KYHw+l1Y3+WGDC1S5wWSUo8dA3ab
         0klri2Ws6y4fpcgnaw2Th6POagxHv/3GUcBsylAa0iuuvHErvUFbIjkSEgKPkOwILfv7
         q0bkyFclN+aXaZBNXmMMGk3IJ5wNoJNXJ/XdGabOJrIT2yunSRZ6AWtU2Q3eSYIDr40F
         jJpa0D1TZ+CXx8h9QjmXn4+eUkWJEZ9DjVEkIcL2H4wGbDs7KcUQSEYDRmSOtyp1anQI
         E0gmq12o6lKatJpWDeemgoJ27J3Ho5c/kyolvbstBy7g5AQVsSciZGAuEZY8pJzkHmXA
         t3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=0/X6qmOpTFkflHLwG5Y7CmNtgLZQ02wndvSmkfHAtWc=;
        b=DyY9f8KeS11FTYrH991EP8rky12JnB1M9VkhoWllIby+CTd4jZKgED4Id/HdzTAEXk
         xbFjPjetnkAkZuu+/cak1bsFbK2zuBCNHn5YrmHyOiRWvIp/6IQcc5gfseO4UdDybx70
         j+MzPoRUCYni8Kfn3QcK7oTiuOuxxkDnzIgbLywXwDCDN0yHnHgmOqwyUFNcKpfc1IPS
         QieMcP+TrmgWZDDJ2nBW/1IcO8Xe3uGDq/oiz18TESkO8B4W4wsgQ1VCXqyQfYQ0z6vC
         4PPir5LECj7ra2rsxCWgbZlgoXnDHqM7l91Tz5SV9jXYCA9Skwfm7WzfCX14veeLhSsJ
         pTQA==
X-Gm-Message-State: AOAM5339ZEE79Q46/UJf0sNn+lvNp2t3r2xYkJcTGzNvnbQfIkwiC9L/
        ybT91x+0YNO1T9w0Cz1GX1W9RAjoFV8vEBeghl4=
X-Google-Smtp-Source: ABdhPJy4VOm8LLpaEcHMjgM6rs/cOwkLzkO+yQBt5HlLJv1ADI8Dp5qVoSU9TAuiE5taYOULyPWDXfEPC0Qft2MSLyo=
X-Received: by 2002:a19:7d0:: with SMTP id 199mr4157630lfh.390.1616649803017;
 Wed, 24 Mar 2021 22:23:23 -0700 (PDT)
MIME-Version: 1.0
Sender: messaneze@gmail.com
Received: by 2002:ac2:4a8c:0:0:0:0:0 with HTTP; Wed, 24 Mar 2021 22:23:22
 -0700 (PDT)
From:   Kayla Manthey <sgt.kayla12@gmail.com>
Date:   Thu, 25 Mar 2021 05:23:22 +0000
X-Google-Sender-Auth: 38Ecw0PcI1aWrSMvQGfoVuZoAgk
Message-ID: <CAJ0JpXcfp+sj9fw9qAQhkvoEpxMRp4mzpFnEtNhM6EzjGsU70g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej min k=C3=A6re, jeg vil gerne vide, om du har min tidligere besked, tak.
