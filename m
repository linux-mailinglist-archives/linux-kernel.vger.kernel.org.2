Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E87409E13
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243443AbhIMUWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhIMUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:22:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E741C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:21:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h9so23748328ejs.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=i7VPJJGwD8dMYsU/ulXHVANMhme4/Y39FNXOn3qat2k=;
        b=ZjTDU2wSEPtUUEHD7HNE0P+chKuFTXnPuI6bz347eHNqvNunN1Fzh3rThwsOd/CFlH
         uBsw+OgQCUQYRzPfvZ5AXLA1zJtGcsixzBP+OsmTyPTRKb6fwZddopaQnTjo1pCgSwRI
         7DDx6406I1y6aEsfd0bdx0kgncjWLaNkNiT8V85wXSuWTph/pNFNIKgWkvpTPuIoQruD
         7Uwz+PMOkkufjrKpiqD1kBc3y9pi/cF6S7CMSNb+vp+Cro+2CunWANxS57Gg71LBotVZ
         xuTkO0ZzC/wetyAiB2qZomsjP0n3kwtjlhLBklsnwpMu7KeisMQ5fYkufFiNLTbfKSfg
         rB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=i7VPJJGwD8dMYsU/ulXHVANMhme4/Y39FNXOn3qat2k=;
        b=SUWf5LNXWT2TQM24NY+psN0pSA8c6WSqCH4pdnyhgM1X9lS/waWs5kXtjLkIARkPW5
         sgjdpuoB9+5QVJp42i1B7QtUWpyssNpqVAdqxTmqNjhJjqnbhV9DHz7IwAKV/YOwUsSs
         +QBVNQ6YzPMZXk3Lt92U3Y8zBItqsmWE1iFgZWl373yF4h3kQOLiu627w9MGzn7N2VTF
         62GQQ42dtFJUCAm+ZJuH/G71dmMckDQ0cef75OSQfydWVvTTYJmsA5tkyCeUzLfmBkdW
         qqKVhZ01HPG1zQbHvEU9f0jicGSp0cJRbMbMYAeI6gxCSgUMmpfUStXSXROdafDHRMbM
         QIVA==
X-Gm-Message-State: AOAM5301z4C1z8whmNvRwJ2fBIYn4D+4OFGxnXU825k74Ip7WXN28rD/
        lbOqiYsIZ0s0KyUet6n7rk7poBOLJnGpslAhi4M=
X-Google-Smtp-Source: ABdhPJxiRO972Vm8mdcqogkDeZZjLYS4DmEO+UURM8xSNHWWXkD+mgpYBlCrjLka81aV3WltJllEAO8s4zhWOaA0C7o=
X-Received: by 2002:a17:906:90c9:: with SMTP id v9mr12186037ejw.356.1631564476722;
 Mon, 13 Sep 2021 13:21:16 -0700 (PDT)
MIME-Version: 1.0
Reply-To: bouchetb@yandex.com
Sender: shirley.perez.fosgate2015@gmail.com
Received: by 2002:a17:906:17d7:0:0:0:0 with HTTP; Mon, 13 Sep 2021 13:21:15
 -0700 (PDT)
From:   Bryan Bouchet <bryanbouchet0@gmail.com>
Date:   Mon, 13 Sep 2021 21:21:15 +0100
X-Google-Sender-Auth: pWiPzy03okKl4ulJmQM5nhiz4tQ
Message-ID: <CABitoyqc+0oYsK_3p+pcUOC=ecA9C3SuDcc+QRqpYsgBnk=Uog@mail.gmail.com>
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
has remained dormant without the knowledge of his family since it
wasput in a safe deposit account in the bank for future investment by
the client.


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
