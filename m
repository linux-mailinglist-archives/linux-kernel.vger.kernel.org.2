Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA145F38E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbhKZSO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbhKZSMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 13:12:54 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F754C0613FA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:56:21 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id m15so8832578pgu.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Rr7CaX6DzdZBzOY1AjPV5lyxY5re3sflAQo3BgYQbR4=;
        b=UmirU6ZEJlZaH7uQlZwzynJkNbodGzgqnQImbt7GjMdMAz34zN8BNJAIi2D/nmsfpS
         DmjF1bVWLkCprBUDrWyTsQkHpM9YahCGCnDaKcBIkOlUxsiGcs6OD82bDenlwUskX7k3
         VapoHsQHgWa9OjvDOgYPMdd1GEnprfni3LWkj+cV5T0hrwoArLFXiFg4M8ZlDD6BVlkM
         X/ZpmY+x5+wUeySgHgVOjlsi5eNFGjOzKzmy66kKL9/p83mb2TNokHr4jUqyf02Qbbiv
         e+136kVx544zq7eg1ZJsoB26SR7GMsTk4Zwep6HbmoWh/SFv1hHpMmWoltu/aAVd2K0o
         wN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Rr7CaX6DzdZBzOY1AjPV5lyxY5re3sflAQo3BgYQbR4=;
        b=KROaKbwUmyRMeLkSceHfEJ7142s2EAfg/oKTmS00eO3vX34KENIChIyJPH5jxaDTnV
         2uFRx9dkbHjLp4L13/0KKkQ7NKQ8re0oT/y31cpEUZBXrxrWmRW5+pkUG9CceNa6Hu3L
         ebKh47AptPHZtsYcdcARF5T6K5DjGvxVCGaQdV/x1qqLRdpnjWe6QgDDkrq4rkvWHT9/
         bDvlpM4R39tf4yplQBciIZWPTwt87+mCza/ZniKH2J+4Xdw3eIdaDnHG9ZeaEeVbSMI6
         QeJDl503gQ4w3ElFOCV0H7rVM848AXA+VZZ/0LSm48mL8d0T7i3K1c6Ky78nBlHDTs7I
         42Uw==
X-Gm-Message-State: AOAM533oQliu3w5jxpPnYbUOxkLsyky0IohMBLZ0PMGzdWB1kVkLLxC+
        p/bJzahGjRVcbgllGKK8nKOVzSBYJrTU7M8LreM=
X-Google-Smtp-Source: ABdhPJxfYXu0ANmyCe8ZQFi5AnxTRoP4jFNoQDusf8nmv8txdN1UHrtzKnuc/Yh3GP91ZRE4RkBFYi6MEG0WvoBXMj8=
X-Received: by 2002:a05:6a00:1a4f:b0:4a3:3c4a:b708 with SMTP id
 h15-20020a056a001a4f00b004a33c4ab708mr22286749pfv.29.1637949380625; Fri, 26
 Nov 2021 09:56:20 -0800 (PST)
MIME-Version: 1.0
Reply-To: carolined45wardg@gmail.com
Sender: abrodrigomorann12@gmail.com
Received: by 2002:a05:6a20:3ca9:b0:5f:29a2:3b74 with HTTP; Fri, 26 Nov 2021
 09:56:20 -0800 (PST)
From:   "Mrs.Caroline Edward General" <carolined45wardg@gmail.com>
Date:   Fri, 26 Nov 2021 09:56:20 -0800
X-Google-Sender-Auth: __a9FynsBbOEP8RvpZo_e-a2fxY
Message-ID: <CAG3TQM3_VCOsr4Dfjw7Ger_nx6mU8wQeTtifh+R63zxru1Or2Q@mail.gmail.com>
Subject: Good Day Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day Dear Friend,

Am Mrs.Caroline.Edward, a staff general in the US Army presently
serving in Syria as a combat instructor, I sincerely apologize for
intruding into your privacy, this might come as a surprise to you, but
nothing is more distressing to me at this time as i find myself forced
by events beyond my control, i have summoned courage to contact you. I
am a 45 years old lady, am a widow and I had a son who is now 16 years
of age.

Some money in various currencies where discovered in barrels at a farm
house in the middle East during a rescue operation in Iraq War,and it
was agreed by Staff Sergeant Muftan Mosoh Buff and myself that some
part of these money be shared between both of us, I was given a total
of ($7 Million US Dollars) as my own share , I kept this money in a
consignment for a long while with a security Company which i declared
and deposit as my personal effects and it has been secured and
protected for years now with the diplomatic Delivery Service.

Now, the WAR in Iraq is over, and all possible problems that could
have emanated from the shared money has been totally cleaned up and
all file closed, all what was discovered in the Middle East is no more
discussed, am now ready to retire from active services by the end of
this month, but, i need a trustworthy person that can help me take
possession of this funds and keep it safe while i work on my relief
letters to join you so that we could discuss possible business
partnership together with the money. But I tell you what! No
compensation can make up for the risk we are taken with our lives.You
can confirm the genuineness of the findings
by clicking on this web site: http://news.bbc.co.uk/2/hi/middle_east/298845=
5.stm

I=E2=80=99m seeking your kind assistance to move the sum of $7Million US
Dollars to you as far as I can be assured that the money will be safe
in your care until I  complete my service here in (SYRIA). The most
important thing is; =E2=80=9CCan I Trust you=E2=80=9D?,As an officer on ACT=
IVE DUTY am
not allowed access to money, therefore, i have declared the content of
the consignment as personal effect that i would like to be delivered
to a friend. You will be rewarded with 30% of this funds for your
help, all that is required is your trust between us till the money
gets to you.

And Please Have It In Your Heart That Before The Process Of The Funds
The Both Of Us Will Had A Blood Oath So As To Avoid Any Betray From
Each Others,Be Warnd Also That If You Are Not Intrested In This
Deal,Quite Off Don=E2=80=99t Try Anything To Black Mail Me Or Exspose Our
Discuss This Deal To Anyone,Have It In Mind That If This Secrete Is
Link Out I Will Also Get You Here Is My Private Email
Address(carolined45wardg@gmail.com )

Yours Sincerely,

Mrs.Caroline.Edward.General.
