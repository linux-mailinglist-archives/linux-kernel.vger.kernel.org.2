Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C833BEA52
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhGGPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhGGPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:08:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47177C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 08:05:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb6so3781536ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=u1IzONw26QP5sCOd0P854/9p5rS35inSOS8bKyo+D+8=;
        b=UAA/kgd1v3uokHkJK1KL5e4+Lig6rp8VYn4gu65nAPgwWfGMkndVV0nWzaS6mTcT5X
         FtbzbzvBgPYil94ZtlB9TgoL8eAucS9UEQ4ZpN2AHa9m6dIihww20Rs+yL0tdUC8dgy+
         /W7cJGVjjyScwQTqYzcPk1i9NNBwYSzgvaCI1r3PWg+FJAmMnIg7twOqDVvUCjrFnLIx
         5Wb1zcIsumwEoWoZadKktHC16JzdkdiU4YUMem6oQIb5t6+HCbR1nGAYSmJKgtzYaZBP
         qADRsW8sh8oc0g2uv35QvA5FLWTcNo+VDFOC3n8+wYxdcVHWeOYEj7rX1VQZUR8wagrF
         4XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=u1IzONw26QP5sCOd0P854/9p5rS35inSOS8bKyo+D+8=;
        b=nb7Qa0JQ2Is5wj9dcd1oYs0FNYIigyOa4/vDulb8EhkQ79MQh/yCzeEVp8sRkPWbia
         eOanXp2EUNf5WLB9NT5nXZKkLxztCx7X1nEUQUn5A8YIOpdTBjDVOnGmcFkgPCSRqU6E
         8psusnj3afRfqzd/1DVMhsOhLNPEkcA+Fg331S1vxP9twEpuRAeFrmTn8gLvRrruJX8I
         yZKMYVFru4g/4/PWalk6hlDTpFLKRATrlvtlqkXEyGQ7Wp1GVuN38H7tPElVT/MV2XdR
         jGviNQfvHONSKpZ9YnilnBOCLLoApodS7O4173K2ke1nkHQB/+K61XZ/KJjpl8OwN8iS
         U1ow==
X-Gm-Message-State: AOAM531xjnaUM0y/BNDqVnMnEJJUs0eCVYWe3/FOLFyF4R3ZrSiQiCeS
        tIwiWJNR6oDD11zaG2BV3PSRsc/rUEJD6F4kQnQ=
X-Google-Smtp-Source: ABdhPJyjAVALdmjtOE8nvYumWrXIuN8a2pfguCiXQW2eKkrEDqMJDV3VCo13J+AQK+hagncqswkJp6UzrtkjNeXIzNw=
X-Received: by 2002:a17:906:ca17:: with SMTP id jt23mr25098702ejb.334.1625670329126;
 Wed, 07 Jul 2021 08:05:29 -0700 (PDT)
MIME-Version: 1.0
Reply-To: drbryanbouchet@yandex.com
Sender: mrhassanahmed27@gmail.com
Received: by 2002:a17:906:3c4f:0:0:0:0 with HTTP; Wed, 7 Jul 2021 08:05:28
 -0700 (PDT)
From:   Dr Bryan Bouchet <bryanbouchet0@gmail.com>
Date:   Wed, 7 Jul 2021 08:05:28 -0700
X-Google-Sender-Auth: fbLNG467qJE6axTf-f3mj5LASe8
Message-ID: <CADUbOoETeCxgoo2U_mThVbeKANABNCo2p4yHVknxm1iPmQjpTA@mail.gmail.com>
Subject: PLEASE RESPOND VERY URGENTLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Dr Bryan Bouche
