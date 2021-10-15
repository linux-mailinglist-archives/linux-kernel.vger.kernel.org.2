Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17442F403
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhJONnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbhJONm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:42:59 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 06:40:53 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id q13so18087489uaq.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=E+U/IowwoZe3AMFCmYvB8eH8+CVRwwWABPbOdlsT6MY=;
        b=fTwP4PuDVu0jeoP2YNb0aQL76az9ehPfb+GC4rKrfmKPRtpgr3aXT8n9zjCCRSvVY+
         YYjBzp+ll4pbKgpackZ0GFcleBWIxKsfpJS7Wi01rPOThvfGk2TVjZ+jUt2PSptKqadC
         La/t0XB6MKmO8Fq7/ngPGon5+bJj5JLpSMxjnt0Ee5R+f6S/diH9Gc/bR8J+grzSdSKn
         +lNtmKFVYVivpkJkRZrGLkuMiku6GMFE4O1xiCc5iV1aPZvV+GcZLr585r/hxUq32Y5p
         h0Azk16jGVJAPbCWwu5rwIv1/Rxi1R4/dwQSSRqZ30ico7agiyVp890vp4XWMQgX4yLG
         EQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=E+U/IowwoZe3AMFCmYvB8eH8+CVRwwWABPbOdlsT6MY=;
        b=xMilZdKZY4DJ5gxeabiYlQEJ/J46nTx8vMoVUP5ezQYCsFHW/z9DfG75LpzF+btBLZ
         LMA5WZKXxi5gL37JrAjnWOHfM+UpcUm+IehyxFusBC51qdzO265dkey8GZDyoIwMT01m
         4XhSBhM2e4GcY2U1xhzx9W6ylgAvqpzKxzUC/Y9MVDW83mslduV/Br1ZPYhBd2wiskci
         7PAjh2CpTv8dRUy3YuClNhIWCHB16rWdpLtbEUSnGsfEPj9AL/4dkgID+6S5uq7urK50
         MIolaqDx9gW/wev5nN1h2z69oulzhRQHDTPxMVNLIf59SB+uunIJaZycgXVhTsLyKmK6
         x+5g==
X-Gm-Message-State: AOAM533XEEeq9Vh/JW6xTMNeDrgdrdyWoGzRjyeaz5VqlYv+Dc+Mvs+a
        hoQVBdrl9qG4dZ9IOHml7HvQgWHTMC5B24rV2rQ=
X-Google-Smtp-Source: ABdhPJwla01RM9AAyxEZaVdT4o+lvT7aHJCNKGIxT7KPscU8h7HsgKzFg+3sAG4AorwYN6w/2ThLMUy0s+flBK2/AIg=
X-Received: by 2002:a67:d81a:: with SMTP id e26mr13873997vsj.8.1634305252230;
 Fri, 15 Oct 2021 06:40:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:e0d4:0:0:0:0:0 with HTTP; Fri, 15 Oct 2021 06:40:51
 -0700 (PDT)
Reply-To: barrmarkbarret@gmail.com
From:   Mark Barret <ledy19709@gmail.com>
Date:   Fri, 15 Oct 2021 06:40:51 -0700
Message-ID: <CAAW7AC9j_JDJWD_yHTdhyso2D+TFOKb-Ve6UbWei1XjHAmMtKA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lieber Freund,

Mein Name ist Mr. Mark Barret, ein Rechtsanwalt in unserer
Niederlassung hier in der Republik Togo in Westafrika. Ein
verstorbener Kunde von mir, Gesch=C3=A4ftsmann und Inhaber einer
Goldbergbaugesellschaft, aus Ihrem Land ist vor vielen Jahren mit
seiner Familie ohne Testament oder Hinterbliebene gestorben.

Er hatte ein Festgeld im Wert der Geldsumme, die ihm =C3=BCbrig geblieben
war, bevor er sein Ende fand. Ich habe Sie kontaktiert, damit ich Sie
als meinen verstorbenen Kunden als n=C3=A4chsten Verwandten vorstellen
kann, damit das Geld auf Ihr Konto =C3=BCberwiesen werden kann und wir das
Geld zu gleichen Teilen zu 50/50% auf beide Parteien aufteilen.

Gr=C3=BC=C3=9Fe,
Mark Barret
