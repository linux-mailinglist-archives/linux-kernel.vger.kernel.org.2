Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3574D3DE13A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhHBVIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhHBVId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:08:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336EAC061760
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:08:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so898381pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=r+yCbR4aJp8zyzE2y7OeM0ceDeFwWsVxE9/4Xwnp/zU=;
        b=ms9T2O+C1K/8pNEX6LWIhUFgSQPNjdaCHgQOrWKEpDU/9oG9EbEWsLg2kiId288PjT
         LjDsyFXix1wWkK6HBVasGDr0BtqqQvfSFaY0K9GcfqoWKLS/Hv2zyCQpvEestocUgRy4
         3AeS0NKxe7MXuronwztPt1xCCnzbYqyewJ6jQBXFyKyDkZOFEzZ5054QAZPc4I+vopAX
         Y5I7lrO1sdnyHHrTQacLfxKELNsfFQqhh1uSUkGzhBEOborunEFiTzPH1t3vqFp7XIV4
         vxXmC5Jz7kej15r4Fys/L6QW8Ti9fPAXbyISci/LGUoheMFndp2PXJ1QjRSJ7dZuSXWZ
         7BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=r+yCbR4aJp8zyzE2y7OeM0ceDeFwWsVxE9/4Xwnp/zU=;
        b=L8fqjHhVtERso1lsKuL9LUcOYGbnuRiQ6ZTCTWjTEGDY6OtWqcIB2jbmFjGbGkzeD6
         7R+/lkj1jjBbenNIrI40R9gwEPuvFnk5cmXAPfiEmv6vCJfxFZDhCmhf23O+FYLUl8Ew
         lXyFp0F9PKCGmlW19pleV5WZOV/jU3YAqr3pP7CBNTbE+MLtqpsrJ99St4owPE6nXVxK
         uoETkvaXlNO5SIJ2YvCcApN2LzOmlG37VS7h+aiV1jdeXD96pv/3NE55YGMd8rDLi/Ba
         IpGuKksKSazahMHr5MDHqX5ssOCECt0MNZG6zBvFlF0gFYTbxTMBbt5+eRnBsJ4Rmjsu
         YHkw==
X-Gm-Message-State: AOAM532YDqD4UQjo/O9riEs+/33087Ci0f0F5XwoUezV/ZAoxCavALUo
        h5Mfbdt879yIMQqsSVRFCSntl9Xxp7QjYPYNheM=
X-Google-Smtp-Source: ABdhPJwmr1mmk2ERM9A2Fh7pcBupm9EdpeT20gTcRWBtAFGm/bqn1DMdWaMBE3P+YYdebuG0HrRVDn+760lylFeydNo=
X-Received: by 2002:a17:90b:215:: with SMTP id fy21mr18845502pjb.203.1627938503587;
 Mon, 02 Aug 2021 14:08:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:418c:0:0:0:0 with HTTP; Mon, 2 Aug 2021 14:08:23
 -0700 (PDT)
Reply-To: compaorekone34@gmail.com
From:   Kone Compaore <abbttnab20@gmail.com>
Date:   Mon, 2 Aug 2021 14:08:23 -0700
Message-ID: <CAEKSJ0RgKORyGAWD2o=rdx0Ap5iGjujhJkt5n8_CEQrQtdOpoA@mail.gmail.com>
Subject: Greetings from Kone
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings to you and your family.

My name is Mr. Kone Compaore, the auditing general with the bank,
Africa Develop bank (ADB) Ouagadougou, Burkina Faso, in West Africa. I
am contacting you to seek our honesty and sincere cooperation in
confidential manner to transfer the sum of 15.5 (Fifteen million five
hundred thousand Dollars) to your existing or new bank account.

This money belongs to one of our bank client, a Libyan oil exporter
who was working with the former Libyan government; I learn t that he
was killed by the revolutionary forces since October 2011. Our bank is
planning to transfer this entire fund into the government public
treasury as unclaimed fund if nobody comes to claim the money from our
bank after four years without account activities .

We did not know each other before, but due to the fact that the
deceased is a foreigner, the bank will welcome any claim from a
foreigner without any suspect, that is why I decided to look for
someone whim I can trust to come and claim the fund from our bank.

I will endorse your name in the deceased client file here in my office
which will indicate to that the deceased is your legal joint account
business partner or family member next of kin to the deceased and
officially the bank will transfer the fund to your bank account within
seven working days in accordance to our banking inheritance rules and
fund claim regulation.

I will share 40% for you and 60% for me after the fund is transferred
to your bank account, we need to act fast to complete this transaction
within seven days. I will come to your country to collect my share
after the fund is transferred to your bank account in your country. I
hope that you will not disappoint me after the fund is transferred to
your bank account in your country.

Waiting for your urgent response today
Yours sincerely

Kone Compaore
