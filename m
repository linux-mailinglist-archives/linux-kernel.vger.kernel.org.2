Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696BE44C1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhKJM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:59:53 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C7FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:57:06 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so3770774otf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=paxB1/wWWyIp2Y0BtAVpvHOaUECmqz1e1PTgb8fL46k=;
        b=kUNtQu92epeKroivnAitG+rG/KaPECc6uGamRNaImZTOKx0RuZwSjrQZPfZqByjl2s
         lIGWrj+B8QraAbBX/IsWfDm15qp2N1jOnEuZeZjvkpf2VB/Eu1krmBoehk5XMKhM5G0b
         g0IJG6emuv/x2U5olTqFWaYFk4HsM4vXHOnRncP1Kg2c0nmycVAne0RAIEelE3ktS+Z9
         ay0H4MYKc6zANjQ5UL2fDtIcX+yssgIla5Ii5YT7JCkpoqTG/r31DnAewgdlbV8EDke4
         26dxDjuUXr+u5GUZKB4ZKpx9oLhHJ8CYzDaXqKWOTcKc2LzHvUJb7NSFbzPs8xibuN3n
         lY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=paxB1/wWWyIp2Y0BtAVpvHOaUECmqz1e1PTgb8fL46k=;
        b=qDzUISI0dOdsb2YZdmgaHgM9d2Pc231n5f4UfMlDptXCFuNuLDwugwZSQ7P6dRdhep
         P8AVlH+cFJgQYWjYRTzRYEJSnuKh1B1/egZjruMjWpiv6ePyFOQEPkHifgsPZtrnNzN7
         wWqEr7mOQIA1Zv6obYk7kuVjwrozuiRf1R0eojzh0aHzbFLE8HLTY3eiSe5q4aKVaeV7
         egntkDsTMhD3Ey38vdaE7FKo6IyIAdoay/7CEXSdacBaZ5uip3UqHcf5i9BPOrz9se3m
         IKIjV68kDw3FODMq5g+wKahLo61t4GmLGvuJSp3WPo8sSzC4QNADGpqYHZQykIi7NwnE
         1q4w==
X-Gm-Message-State: AOAM533rYRT1AHwjy/mpzuHxs86zahupSoXCS0qX8eTijAnrqVJPJU4r
        oGnjM9JlcLrg2yLctq/AWKly4aVFTTed8JtGUKM=
X-Google-Smtp-Source: ABdhPJwR+/Lf0ZKvzWXmee9wA1Cb+5lb5UaBOdZvjIFWKQBXuMa3djSKlMqM7JGEh213ywLIfuj8q4k4J5ntUHbIxUU=
X-Received: by 2002:a05:6830:4104:: with SMTP id w4mr12879387ott.292.1636549024973;
 Wed, 10 Nov 2021 04:57:04 -0800 (PST)
MIME-Version: 1.0
Sender: charityvangal@gmail.com
Received: by 2002:a4a:d4c1:0:0:0:0:0 with HTTP; Wed, 10 Nov 2021 04:57:04
 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Wed, 10 Nov 2021 12:57:04 +0000
X-Google-Sender-Auth: gtvMY9V9vQIYPAo3WuXnHbKV0nA
Message-ID: <CABTbXjJ2aX2gb2_hyTcXcMQCHTYBv5SKd9=TGPeNKLNbTq5hEQ@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Mckenna Howley, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina Mckenna..
