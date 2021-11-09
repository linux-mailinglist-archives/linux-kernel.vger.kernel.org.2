Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3577244AA8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 10:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244886AbhKIJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 04:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244806AbhKIJ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:28:12 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF59C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 01:25:26 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id y5so8645130pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 01:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FN8gmeeFosyEMCwP+9T5Qcxe++S6hreeBk1oxhzKQmg=;
        b=Sl8wYCy8kYu7D9vAHAOvPiYkQYPU75CVJR3RmoPZNLuJze7+GA/MmMiD1S44K3Gswy
         fodkBDmvJx/olb7kTNK/3KVrf3wc07A+JjXTEwB9J/lYwuwKTw9aA2rTBqFHOEd47Zfk
         R5OKCOBpjVMap6Y74nnzOs/9IYPrARxfiMvZ3biS58PrhALvGgCLYWRB7Jf8hNE+58I8
         W4wK6xAn4FQRzBh81g491tcnO2SEoVDs1PJmBnhmTmc5jYz/xF+5sjkGRag1lUNQv7FH
         14nsJWPAdCPWo4OPXm23EomMNstK34vyHAYrZfOhFsyiDfyxbt99AKe7chgu9E3Pp8vm
         WR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=FN8gmeeFosyEMCwP+9T5Qcxe++S6hreeBk1oxhzKQmg=;
        b=ghxeLONukdRCoWj46RdsHoeoC6SfVGBTtTop9pn8EqzvELEuO9SkBm2czVBua/WjAa
         sI0DE90amVtAo8WGSIug4ZznrjC1l9Jtb6xFM/S+ZM669VKmhT8edgQfrKPKTVK45Ikd
         NJLI0tWnpWSlUwSMPLbmVtdPz4WF0hdZdr7JY6wA5beWKFGUEqwIwe/zx50Wh0mJ/mdC
         AN/k5Rs4aJ75MRLcvQLT+Z7vmgdEMBcvlCyItPnTYeKAGn3i14LsDMAQHzWfNQhRwLXI
         r2ISkTIDcaJwZbTUUTvDaOqRLa5gD6S//WqfjShO4x9oEKmq0yb+KksOsrf8X+GF5/P1
         DkOw==
X-Gm-Message-State: AOAM5300wiFspkKwj6b+PkSXfiiPykNzx8mBmkTwcxk9g7arfEqvHxct
        w66O4g+cjGMVK7wED6vrPslEETiT5RNI+e/EyLE=
X-Google-Smtp-Source: ABdhPJy5JLvhq6LzZjxzyN+CKSbERa2NPMEsj/LDCi+rAdM56Z4mvhjpuwTTuB7XKFLgopkg1QQkYBkRiySf4l2GCjE=
X-Received: by 2002:a05:6a00:cc8:b0:49f:c4a9:b9f1 with SMTP id
 b8-20020a056a000cc800b0049fc4a9b9f1mr6617929pfv.32.1636449925223; Tue, 09 Nov
 2021 01:25:25 -0800 (PST)
MIME-Version: 1.0
Reply-To: oliviaingra343@gmail.com
Sender: simtondji@gmail.com
Received: by 2002:a05:6a10:cacc:0:0:0:0 with HTTP; Tue, 9 Nov 2021 01:25:24
 -0800 (PST)
From:   Ingram Olivia <oliviaingra@gmail.com>
Date:   Tue, 9 Nov 2021 09:25:24 +0000
X-Google-Sender-Auth: pFEDnayqP8zA4f8bYSMg2Oljl7A
Message-ID: <CAGg0eJzRVMe_6xL42nmYQcHag+1Fhhoys3y2+gw3HXh2hNANmA@mail.gmail.com>
Subject: I wish you read my mail in a good heart
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

I am Mrs. Ingram Olivia, I have decided to donate what I have to
Motherless babies/ Less privileged/ Widows' because I am dying and
diagnosed for cancer for about 10 years ago. I have been touched by
God Almighty to donate from what I have inherited from my late husband
to you for good work of God Almighty. I have asked Almighty God to
forgive me and believe he has, because he is a Merciful God, I'm
presently suffering from Leukemia.

My health condition has gotten worse and just two weeks ago my doctor
informed me that my condition has reach a critical stage, that I have
just 5 months left. This confirmation from my doctor was and still is
devastating news; it is hard to know that you have just a little time
left to live here.

After the doctor=E2=80=99s medical pronunciation that I have just few month=
s
to live, I decided to divide my wealth to contribute to your country.
I want to assist you with the funds to do great charity works in your
country, this is my last wish. I selected you after searching few
websites; I prayed and was led to you. I am willing to donate the sum
of ($8.1million ) to the less privileged through you.

Please I want to transfer this money to you, If you can handle this
fund and very sure to do charity works on my behalf and from there I
will travel to meet a specialist as I want to be buried alongside my
late husband when I passed on.

Note that this fund is in the financial institution and upon my
instruction; I will file in an application for the transfer of the
money into your account for the said purpose.

Lastly, I honestly pray that this money when transferred will be used
for the said purpose even though I might be late then. I have come to
find out that wealth is vanity and I made a promise to God that my
wealth will be used to support the poor and the assist the sick. Do
let me know

if you will be able to handle this fund and use it for the said
purpose so that I will inform my bank on my decision, If you are
interested in carrying out this task, get back to me for more details
on this noble project of mine.
1: Full name:
2: Country:
3:Occupation/position:
4:Phone/s:
5: Age:
6: Sex:
7: Address:
God bless you
Mrs.Ingram Olivia
