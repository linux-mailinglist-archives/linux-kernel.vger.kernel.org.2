Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B918E42CEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhJMWxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhJMWxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:53:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA14BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:51:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so3397143pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=XYCO9K2z20trHg1Tdi9Bnb5Asig2IkwBEdxVkkKkXMU=;
        b=qLCAebxXpkqnV8LZjbKBGUNFz5UxVk5AeDeK/NEjbjS1WfSqyFw/IkTcz+LDb9a9e7
         fL+qrniIL14msXxDRSaLt6XTK5Nu10HAXVNTPp9LGpl08g3vF672TVG0f0RinHCA206K
         H10D2PDK2hrofwFjDHiQUGNsG14Tr663fLzxFd1LxMJmY+gcw4jYGuhCSIHktX8r1Sx8
         noc077eFafLhouqYUIanKxwqfmPWMrCfFr8S59Cdcy8fMKPoTl4e+RT5STG6z/NZ4FQK
         xneqQAIcbQPRFUKsmCP2aV9u8bprCtTBWFgVZ3+y/4KTKIup+ttZ2pLdMPTqC+CuKMcS
         YBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=XYCO9K2z20trHg1Tdi9Bnb5Asig2IkwBEdxVkkKkXMU=;
        b=V92+Lenl3kKN07bU1hsP6vmx+AZy3nZyAf4B4PJQvspjujGCgKdHIzmvRatcxuEfIZ
         xV6EXNwtxyDtcuW8pql4KLiIsMLFhdrgE8yq8F3weizr8ymVfP8HWh0Iskaw35wAePxK
         SacJgQE7fj5KkfQqqIySGPNzgadqhdl2k2tCBUOb4d7UwPqgQ8mcw61ctqzl8GCqNAXv
         8mgBnMufj4Rj+1bRE8BDOw0+8Ms4cLjU0dbRyPhYEnRpTM10zL0C3ShXDm81yqAD7l4z
         aIGGq5R1OoRIReWExxQZb5M0jQY0Cz4Z8s20Da0QceAj0Sg2lGIaA0RzAM+otG4SQmSG
         I1KQ==
X-Gm-Message-State: AOAM531sodApWDLbmRYbF2sAW1WBXdEJ/JiTVnGo+OcwmiIT6uNRFSl5
        PKYfnN222adpwEZJIIor1YBsOCl+W/N8Y2pZ/rU=
X-Google-Smtp-Source: ABdhPJzruduEaxT34qdIN9HmDI4NWF4hXlO4TZebjSqrMau2qRYaGwQqyX1NzK5PMpTgtF5vvoENn0LIQEh9oBKeGfQ=
X-Received: by 2002:a17:902:a604:b029:12c:dda2:30c4 with SMTP id
 u4-20020a170902a604b029012cdda230c4mr1770468plq.73.1634165492181; Wed, 13 Oct
 2021 15:51:32 -0700 (PDT)
MIME-Version: 1.0
Sender: bra427679@gmail.com
Received: by 2002:a05:6a11:4d0c:0:0:0:0 with HTTP; Wed, 13 Oct 2021 15:51:31
 -0700 (PDT)
From:   "Mrs. Rita Hassan" <ritahassan02@gmail.com>
Date:   Wed, 13 Oct 2021 22:51:31 +0000
X-Google-Sender-Auth: LDET7GCpRr2-XKTGx6Ulmp8uu1c
Message-ID: <CALJduGefsk_g8qeDXp2CY-3zRNMT8AcdG3PDQtSHvMFuJ8YMsw@mail.gmail.com>
Subject: Very Urgent.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please forgive me for stressing you with my predicaments as I know
that this letter may come to you as big surprise. Actually, I came
across your E-mail from my personal search afterward I decided to
email you directly believing that you will be honest to fulfill my
final wish before i die.

Meanwhile, I am Mrs. Rita Hassan,  62 years old,I am suffering from a
long time cancer and from all indication my condition is really
deteriorating As a matter of fact, registered nurse by profession
while my husband was dealing on Gold Dust and Gold Dory Bars till his
sudden death the year 2019 then I took over his business till date. In
fact,at this moment I have a deposit sum of $5.5million dollars with
one of the leading bank.

Therefore, I want you to receive the money and take 30% to take care
of yourself and family while 70% should be use basically on
humanitarian purposes mostly to orphanages home, Motherless babies
home,contact me for more details on this email.
(ritahassan02@gmail.com )

Yours Faithfully

Mrs. Rita Hassan.
