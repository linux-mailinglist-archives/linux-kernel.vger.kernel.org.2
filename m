Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60323F6F53
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhHYGTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbhHYGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:19:34 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C62AC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:18:49 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso31839964otv.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pq8QdcgdNxjJmg61r8dPGvWyeowRsap/Qds2NQHbQZA=;
        b=BKcgTZvgXNHK7lRkIgzhas7zlHZYNoye/LJTNjER+8dflsWM1EWEP7htQAQEEoG/9K
         ZwrM5F3AJMvMyJUEHC5S9XI9J6ikQhn3RUUnk8+36fs6+3lCm0D5xW/J+Ipo7TcsQ/lg
         X5tqnkoTJhE/ncMbcOUHh5URLnRtSVQ132Kkv11Yc2PAehRXhPjej8qc6NwKaLMBl7qb
         JtyI1Cp8K776rVnHNBLpFDLzxFPc/C1MaNwp8Mu9dQCq8eERwjeY7qSle8W+89zQvake
         4wvfib63bKZQfEIAzdmrN9w+OimKM2HCSfflucf97NcbyMGAmWH5Ud3g20sMR4BKBXzd
         JtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=pq8QdcgdNxjJmg61r8dPGvWyeowRsap/Qds2NQHbQZA=;
        b=E9PSvY4fMMG8Kw/055OxLM1stpFe7pPaErNDKxpQH50ZSxg9cDEjO5T8tjtIzxK5+2
         N355S2vheIJO6kovbbmXpLOQ5bDtWNk+aMhEiidiZCfb1mqzxs9/ok3IH0czCxIVYJOy
         f7aNzO479U+EBwRZMdX+b9LJgg/9jfKu+5ua3t7kfEFpkUidMCBahS0Tg99Z/lgap8qp
         Dn0jGyVbF+88pEal2iHDI84+fbjMjldiaiStUK/W8vBISRhJLywa6Yn5oF5g6p1+6dw2
         h41ets7sSkXL7DQs5zVAI/IQN5iZZNdXA/JkKzkyUUZ8J3u8F6gIpzMHZBjsbxJGU76R
         p6Ig==
X-Gm-Message-State: AOAM532w0yEho3LYsEAW85qUK8ChV2jeG/UBSjz9P6ESuqpSGLuMd/c5
        8vMTOThOE1QOK0+KbKGiEiYcA7qwdHLR1pDCLQk=
X-Google-Smtp-Source: ABdhPJzl0bmdFd8Zo2aOgR6g8Jl5hevl7Mw0elaNg1T2FqxXsxdQeHtO2JrxhmQ2ZhbQqskIWexrZL6JNhVMN20xClE=
X-Received: by 2002:a9d:de1:: with SMTP id 88mr36729492ots.60.1629872326867;
 Tue, 24 Aug 2021 23:18:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: bouchetb@yandex.com
Sender: cc918561@gmail.com
Received: by 2002:a9d:6854:0:0:0:0:0 with HTTP; Tue, 24 Aug 2021 23:18:46
 -0700 (PDT)
From:   Dr Bryan Bouchet <drbryanbouchet52@gmail.com>
Date:   Wed, 25 Aug 2021 07:18:46 +0100
X-Google-Sender-Auth: aF_P61mz83I2ZZcje_8P5oJlyJ0
Message-ID: <CAL5z9Peh92B8-zYJr2+yemBs4vSphVvkdrru03_AqumcZGrxXQ@mail.gmail.com>
Subject: PLEASE RESPOND VERY URGENTLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

With due respect, i have decided to contact you on a business
transaction that will be beneficial to both of us. At the bank last
account and auditing evaluation, my staffs came across an old account
which was being maintained by a foreign client who we learn was among
the deceased passengers of motor accident on November.2003, the
deceased was unable to run this account since his death. The account
has remained dormant without the knowledge of his family since it was
put in a safe deposit account in the bank for future investment by the clie=
nt.

Since his demise, even the members of his family haven't applied for
claims over this fund and it has been in the safe deposit account
until i discovered that it cannot be claimed since our client is a
foreign national and we are sure that he has no next of kin here to
file claims over the money. As the director of the department, this
discovery was brought to my office so as to decide what is to be done;
I decided to seek ways through which to transfer this money out of the
bank and out of the country too.

The total amount in the account is (18.6 million) with my positions as
a staff of this bank, i am handicapped because i cannot operate
foreign accounts and cannot lay benefice claim over this money. The
client was a foreign national and you will only be asked to act as his
next of kin and i will supply you with all the necessary information
and bank data to assist you in being able to transfer this money to
any bank of your choice where this money could be transferred into.

The total sum will be shared as follows: 50% for me, 50% for you, and
expenses incidental occur during the transfer will be incur by both of
us. The transfer is risk free on both sides hence you are going to
follow my instruction till the fund transfer to your account. Since I
work in this bank that is why you should be confident in the success
of this transaction because you will be updated with information=E2=80=99s =
as
at when desired.

I will wish you to keep this transaction secret and confidential as I
am hoping to retire with my share of this money at the end of
transaction which will be when this money is safety in your account. I
will then come over to your country for sharing according to the
previously agreed percentages. You might even have to advise me on
possibilities of investment in your country or elsewhere of our
choice. May god help you to help me to a restive retirement?

(1) Your full name..............
(2) Your age:................
(3) Sex:.....................
(4) Your telephone number:.................
(5) Your occupation:.....................
(6) Your country:.....................

Yours sincerely,
Dr Bryan Bouchet
