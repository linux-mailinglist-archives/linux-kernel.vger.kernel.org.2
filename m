Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9834636E45C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 06:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhD2E4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 00:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhD2E4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:56:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE43EC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:55:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j28so12926002edy.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9zsc5VqP7ZFRstzMnPtTwsmXOiG7krTO/wBwrEEQqNs=;
        b=hpnNVleirSLGr4umoRdSGkhwiE4ZxO8jpExjOJ+TBy+Nq9PEJ3KcF70Quo32X5Dgoy
         04v3fAHa6IHqxq5gfPQAzAcEAM6dyHEkC0TxXfbMbJKjJyohkVMnFFmiMzgdhgmAhRyz
         W3FYrB/6KHSW0yijKA4FIriJ5tIVD+2a7Dq8pxPF9CyPsU827mYxNPL0kr7R8VuQl5CN
         /kLqkkkDvltuvi6Go26ONyfTTKk778d0XliZAJiOTIk7OKLwnkwDJAPL50wfyk4agRai
         DP+tikKAgE3vtcXpqIJCpdjkv4mn6ETHY6nMT5JwRRvqL9qkMchJQOCjuB9zQ5ux7Ckc
         kzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=9zsc5VqP7ZFRstzMnPtTwsmXOiG7krTO/wBwrEEQqNs=;
        b=hjH0QZffJlWdXZyZWvNWJhZEEyqz2xMrtMznb0O2Xa+SGuNl9uoDIjmvL2Mm1wA8k3
         yyklPcDlFw2z9yi8Ov5HdWvFyWz0oAKAqxshmh5XlSeS7g8repB9+X50nQx0CS7C6NXE
         vMA2LGjvXULTmJAdhQUgTuEwGxgD40Vrwz8s+Szm5fcnRiSABvoORbH7QwZLfQWlaAsr
         25cBHjaHDE6BsGabBYUk7DHRQxQcqAXEld9aWIFx9vBpdGnXBA8v9E3jJMkhlK6zmx6v
         Xf3Nx0hV99ISf7/g2F6p15QMZ7z43KEoz/5WRVbFUfvdyEilJ66QOacttBkgwOfI9EW8
         TWRw==
X-Gm-Message-State: AOAM530rwGk17zfK+m93y/xFGRQ8568VIvykkUh8rechPPKk4hwnAJ3r
        Gw7ItJ9ExOR5iXZYcQ6zwlEjYWVWYRZ0FTTbcd0=
X-Google-Smtp-Source: ABdhPJxvljdMyXJZPfDBAHucIEczrcUma1AJJB5Ekax7lcNoJQHxPgWIsMf6jYf6ySaNA2OjS+E8xXHI5p5xdCAbVaE=
X-Received: by 2002:aa7:cf86:: with SMTP id z6mr8712341edx.120.1619672127742;
 Wed, 28 Apr 2021 21:55:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a6a6:0:0:0:0:0 with HTTP; Wed, 28 Apr 2021 21:55:27
 -0700 (PDT)
Reply-To: vpnchuk@gmail.com
From:   Victor Team <vfcordinator@gmail.com>
Date:   Wed, 28 Apr 2021 21:55:27 -0700
Message-ID: <CAAfYsC721VEvxp+Op88-aM9jU+v8w1fygCVj9dHYJrf5RuhtSQ@mail.gmail.com>
Subject: =?UTF-8?Q?Gl=C3=BCckwunsch=21_Sie_haben_eine_Spende_f=C3=BCr_wohlt=C3=A4tige?=
        =?UTF-8?Q?_Zwecke=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Victor Pinchuk ist ein ukrainischer Milliard=C3=A4r, Gesch=C3=A4ftsmann und
Oligarch. Ein Philanthrop und Gr=C3=BCnder der EastOne Group LLC hat
zugesagt, in diesem Jahr 2021 einen Viertel seines Nettoverm=C3=B6gens zu
verschenken.
Sie sind einer der 5 Beg=C3=BCnstigten weltweit, die im Rahmen des Victor
Pinchuk Charity-Projekts $1,500,000.00 USD erhalten.
Wenn Sie diese E-Mail erhalten haben, best=C3=A4tigen Sie bitte das
Eigentum an Ihrer E-Mail, indem Sie sich an Victor Pinchuk wenden:
vpnchuk@gmail.com, da er daf=C3=BCr verantwortlich ist, die Bank
anzuweisen, Ihr Geld zu =C3=BCberweisen ($1,500,000.00 USD).
Name des Ansprechpartners: Victor Pinchuk
E-Mail: vpnchuk@gmail.com
