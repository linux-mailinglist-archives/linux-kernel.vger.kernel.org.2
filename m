Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF5D3EA55F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhHLNVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbhHLNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:17:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03D0C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:16:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 203-20020a1c00d40000b02902e6a4e244e4so4542668wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xXMAKYfaHF3y0MYvRXt5YjHnYHrgF9nL14yqbUyBov0=;
        b=eYPakmpru+5u6m0pxnZ9B3nu7DzJp0i6GYICB3QLseBbIoTuJTtJAd2cXWiwHmj9VG
         LWO13iFRhW/g7Hfsd0QGK6TrCeh35pOfg81tWRfAxk4YpSDGWprUgWs9SiupdNloTQMp
         +9bChsW6afHbaCwu/O9EETavw0AUEDZzcN83j6kzRRE3HKNOSKAIF947h+Pjxbs0evw9
         UYUCOoAv+eYHxckn+JVtdiuxjcAz37bqQ9U+M/59OgCKKHFUuLVy1pb3jsb6KkqdNGec
         xIvzb0ODj+fLIMWLl8HzoiXTlOuP9hNXdlwz1HKSV28zjkxCOoQAATKjD6Hfu/qjPsLQ
         1kBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xXMAKYfaHF3y0MYvRXt5YjHnYHrgF9nL14yqbUyBov0=;
        b=ifdnSmpDcRsUxaAxm4RLxGkESjMCMycHqWvzFm8YAPrUgZ2JkTbb+BroTsMh3q2Wb5
         w3U1225GNRwXg0W8w1ANgWI+er0uSgYcaLlt6jCL2stLGLm3YcuTCGQlKfQo0O4tRHNA
         ClmC/Y5OdEIM+4SjBuXF4b7Q0iYHWNt2QgwjZE8qcNq92N/TH1UDHLHI4TXLBeqD7gQW
         66nWwXMQtld0+BKf3FgRRLsnnk5UhnFp4vIJF4JtqHx+4HtqnyzaxQfrU0CHzgcmuz8x
         nmAGIy40tkVf3hYbWUp6VrnMQto45hjdP5pJK9ph7cEgeUJdastwLPXUL/rICmJmbsEm
         pXEg==
X-Gm-Message-State: AOAM532cMjTueUwxVFjuG/7yUVva1p5zZVlxVwG8kCLI5kCNBCi5KZ3Q
        4s4o54N/dZYDmctyXWb7vuwYuqK2MhywDZTb6Hw=
X-Google-Smtp-Source: ABdhPJxp7omyNsIhSSEXKNDspDIf5bwQQ5sClDFkli84BlfxfegXswqiunvqKGLwD3ybe5tlsfoF3IfH18ErTXeYkEA=
X-Received: by 2002:a7b:c206:: with SMTP id x6mr15207837wmi.57.1628774195317;
 Thu, 12 Aug 2021 06:16:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:ce83:0:0:0:0:0 with HTTP; Thu, 12 Aug 2021 06:16:34
 -0700 (PDT)
Reply-To: westuniontogounionpayment@gmail.com
From:   amos ben <ab8914535@gmail.com>
Date:   Thu, 12 Aug 2021 13:16:34 +0000
Message-ID: <CAM8k14DVcpF0w_C9yZg4p7qHxd33tQzp0OS2E4U76Wh3L0DWzQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drogi zwyci=C4=99zco,

Chc=C4=99 Ci pogratulowa=C4=87 tego wspania=C5=82ego zwyci=C4=99stwa, gdzie=
kolwiek
Skontaktowa=C5=82em si=C4=99 z twoim adresem e-mail. Chcesz wiedzie=C4=87, =
czym jest loteria
=C5=9Bwi=C4=99towa=C4=87 co roku (Molottery 2021). To jest strona interneto=
wa, na kt=C3=B3rej mo=C5=BCesz
sprawd=C5=BA to: (https://www.lotteryusa.com/missouri/lotto/year).

(Zwyci=C4=99ski numer: 11 - 22 - 31 - 33 - 42 - 43)

Loteria: 4,1 miliona dolar=C3=B3w

Wszyscy uczestnicy zostali wybrani za pomoc=C4=85 systemu
wybory komputerowe.

zam=C3=B3wi=C5=82 Microsoft AZET.SK / YAHOO / GMAIL / HOTMAIL / INBOX.LV
u=C5=BCytkownicy z ponad 20 000 firm i 3 000 000 adres=C3=B3w
e-mail.
i unikalne nazwy z ca=C5=82ego =C5=9Bwiata.

W rzeczywisto=C5=9Bci Tw=C3=B3j adres e-mail by=C5=82 jednym z
wybrane adresy e-mail
kto wygra=C5=82 t=C4=99 sponsorowan=C4=85 przez ca=C5=82y kraj loteri=C4=99=
 (Molottery 2021)
rok.

Twoje 4,1 miliona dolar=C3=B3w zosta=C5=82o przelane na kart=C4=99 VISA i b=
ankomat
Karta Visa Wszystko, co musisz zrobi=C4=87, aby otrzyma=C4=87 paczk=C4=99,

wy=C5=9Blij wszystkie swoje dane do biura Tony'ego Elumelu na
unikn=C4=85=C4=87 nieprawid=C5=82owej dostawy
e-mail [westuniontogounionpayment@gmail.com]

Pieni=C4=85dze otrzymujesz za pomoc=C4=85 karty bankomatowej VISA w swoim k=
raju
i wyp=C5=82acisz 4,1 miliona dolar=C3=B3w

Wy=C5=9Blij wszystkie informacje do Tony'ego Elumelu, jak pokazano poni=C5=
=BCej

Twoje pe=C5=82ne imi=C4=99 .........
Tw=C3=B3j kraj ......
Twoje miasto ..........
Tw=C3=B3j adres .......
Tw=C3=B3j numer telefonu .....
Tw=C3=B3j kod pocztowy ........
Kopia paszportu .......

Wy=C5=9Blij mu wszystkie swoje informacje

[westuniontogounionpayment@gmail.com]
