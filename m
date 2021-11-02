Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239F94430B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKBOqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhKBOqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:46:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02824C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:43:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so43447238lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=4X4RhSneoidKGhykRwCITv5Sky7bOf6yK41I9DNzjPU=;
        b=EQ76RxfnSAucd/nsoa3Z040m5b1TQO8xK8JLlszFuKqmTNbMrazOOMyEmchzmgyuB+
         vD15xB7nqDVpatjZwQS44TMeaMDEbzNd2wrhIvmIrsvztyqvTssS9RuXERE0j6b4RXNl
         d54j9aX1VZMarnpmGQhM/jAhcfJBhGNzhTPqU5y/TiEF7JvjHRoUt1pMX7YkFHDIcrW5
         UkKBVoEsZaZZu0xSvJzkrxkVUAvgY6MJ1fJ7g42yMEXyzhlwQPQIQ59OMfsLJDBwspiZ
         7N9KlxuPszozIXI21Zn4Ku+ozEn5Fxv8SFeYSEYC5kV323UlZn5EIZEm6G+GsiN37zjQ
         +Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=4X4RhSneoidKGhykRwCITv5Sky7bOf6yK41I9DNzjPU=;
        b=ZNLbyuAORXuF/gRnmjf179sytcXsEFhhjkiXtSX/ezF/CorT0hw0oYCOVOU8K/1SeK
         KuBHC9RoAuemSQptkvzVe1qFlSn600WOjec7EXGp3uulw/aEj7STbetR8BF9KZBJFBcK
         nUiB4G+6e24EmCEmgzI1CKA1Bp7Z1sQrusppyNxrOK0BNNuZPPrRqr68GmSJ77gDRtkX
         F76uLG2wDZ0Hz5ou+2s1H+EU7AyuVc5Ee2EXzzLDjibOMYWX0N2j64LzBylVjTSJVESw
         QhJ/agike6ko28zcFIXv2sLhHTVMEFNi/Hs+zCuwz0Oh1qv6xkiGWRxH8AXOBdWi7eZ5
         HGzQ==
X-Gm-Message-State: AOAM530m3Sfh7JYB2t7WSg+QxC4GZHZ3rl4coF2LLj6BICHmBlqcIbNj
        mjBxtJayb6O/e+puIy1GEnSonIQAqnpmzsaxmr4=
X-Google-Smtp-Source: ABdhPJxc3WrI0zE5gXvCxdTloBL3fKFWO3Ygu8H7pexmuK8nL1gizVTRqkR63uaNLKUP0tqRrML86lWsFHXyFW8OxPI=
X-Received: by 2002:a05:6512:b1f:: with SMTP id w31mr34650840lfu.164.1635864204866;
 Tue, 02 Nov 2021 07:43:24 -0700 (PDT)
MIME-Version: 1.0
Reply-To: drabidibelloemailid@gmail.com
Sender: drabidibellophdid@gmail.com
Received: by 2002:a05:6504:a08:0:0:0:0 with HTTP; Tue, 2 Nov 2021 07:43:23
 -0700 (PDT)
From:   "Dr. Abidi Bello" <drabidibelloemailid1@gmail.com>
Date:   Tue, 2 Nov 2021 14:43:23 +0000
X-Google-Sender-Auth: EAyRjZMyuv3drHeiFEh_nQ9c2Es
Message-ID: <CABg9VyB9EtOZxwgdo7M2z0++bxjW1WgefiLs1Ywic9vDHr-G6g@mail.gmail.com>
Subject: Urgent!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Urgent!

I am Dr. Abidi Bello, the director in charge of auditing and accounting
section of Eco-bank, Ouagadougou Burkina Faso West Africa. With due respect
and regard, I have decided to contact you on a business transaction that
will be very beneficial to both of us at the end of the transaction.

During our investigation and auditing in this bank, my department came
across a very huge sum of money belonging to a deceased person who died on
31rst Junly 2000 in a plane crash and the fund has been dormant in his
account with this Bank without any claim of the fund in our custody either
from his family or relation before our discovery to this development. The
said amount was (EIGHTEEN MILLION UNITED STATE DOLLARS.
($18,000,000.00)Meanwhile all the whole arrangement to put the claim over
this fund as the bonafide next of kin to the deceased, get the required
approval and transfer this money to a foreign account has been put in place
and directives and needed information will be relayed to you as soon as you
indicate your interest and willingness to assist me and also benefit
yourself to this great business opportunity.

Infact I could have done this deal alone but because of my position in this
country as a civil servant (A Banker) we are not allowed to operate a
foreign account and would eventually raise an eye brow on my side during
the time of transfer because I work in this bank. This is the reason why it
will require a second party or fellow who will forward claims as the next
of kin to the bank and also present a foreign account where he will need
the money to be retransferred into on his request as it may be after due
verification and clarification by the correspondent branch of the bank
where the money will be remitted from to your own designation bank account.

I will not fail to inform you that this transaction is 100% risk free. On
smooth conclusion of this transaction, you will be entitled to 40% of the
total sum as gratification, while 60% will be for me. Please, you have been
advised to keep top secret as I am still in service and intend to retire
from service after I conclude this deal with you.

I will be monitoring the whole situation here in this bank until you
confirm the money in your account and ask me to come down to your country
for subsequent sharing of the fund according to percentages previously
indicated and further investment, either in your country or any country you
advice us to invest.

All other necessary vital information will be sent to you when I hear from
you.

I look forward to receive your email and please also send your direct
mobile telephone number in your reply for easy communication.

Yours faithfully,
Dr. Abidi Bello
