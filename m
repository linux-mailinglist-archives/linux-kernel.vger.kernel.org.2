Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7A3AB387
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhFQM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFQM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:28:47 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4977AC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 05:26:39 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id q2so2896683vsr.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kV8rLaTiSJhyKXpIUepUlfI/JDOhp9Ih4A1TyJtbdsU=;
        b=WzyK+Hui+X0pu44S5Y06vy2eMr2Mn7q124z93F/g16vTa9Y52iLHCIDwEXYz90P7xI
         TMoT5lbD/FgHfwfl5X1aGltZSfAvxsHhhCzcSLybxZ+H1TnuVyLD+NKPTlVDQ2ZGvLA2
         ooY4xJNRL6o8RSH8vcZxvYdy33q4++fcoKWGZq9cONuF6YIaMmkdkE4skiQshzNLucfY
         +bciT/4QIwDCuxtuRjkLi6bPjUKz3qIeSlASB05Ww6a5HPGR1l+OuY9ZmS7xxIeCRArP
         ZUjZaYEl+kVBdplWnoSlDCGrqSzirWE/wTzMfprK3ydP276kUWmllmStQhGuVvry+kec
         I9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=kV8rLaTiSJhyKXpIUepUlfI/JDOhp9Ih4A1TyJtbdsU=;
        b=B2gUQUWeuLFIbZr4L/PARmzBebpjm1GAppQ4liMXVlRbFfmfzikQfMML/WGyNqS1Ou
         H9WXp4c0v79BB9TjH6cCGaVUsmZgFyM7hSc3DF2+ewov3q2PXuy+tm7VLkwABkCQO1sv
         hbsZUtvvf7RYA24Kbbq1qvgtG3n0eKkIvx+oldWsUNPA79Tt8RS92P9Oz3fpMNiK3CHp
         5XFGE8bGYEvAWQLtK8cPRMIFquxX1Fu86+lvk7LPQ6JBnAkB9kCMPSqWqWaOdYBIw92X
         iAvMuepAcx3ZdthKaYGT6b9SML/tt39T8KvZR3Yab4S6UMuPCGlqVGfj7r7SXO84cL+9
         uJqQ==
X-Gm-Message-State: AOAM530qwwSkyfYeypzb8VgK6ZgpSwQKN3NcG7wP5E2aKjiWKwqUeVbk
        c6kbzZCp3Fa2Y7hndVypZ4KaBBV13eO/7lkyER4=
X-Google-Smtp-Source: ABdhPJxNJEIXhF47O+wWdjg0+YTvmcQsEhvBPoqPtkxsJPpeUbXVZSJl4U6peH2YjrbRe9TK85ZnlCHUXySH0g+wODA=
X-Received: by 2002:a05:6102:2144:: with SMTP id h4mr3963475vsg.21.1623932798494;
 Thu, 17 Jun 2021 05:26:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6102:372:0:0:0:0 with HTTP; Thu, 17 Jun 2021 05:26:38
 -0700 (PDT)
Reply-To: johnsonchief436@gmail.com
From:   johnson chief <officep250@gmail.com>
Date:   Thu, 17 Jun 2021 05:26:38 -0700
Message-ID: <CAPUHU+c6Nv+WDWgz-f7a008YHEGbO9M=3ifJ9-zO1ePYJBDPbA@mail.gmail.com>
Subject: =?UTF-8?B?T2zDoQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ol=C3=A1, Informamos que este e-mail que chegou =C3=A0 sua caixa de correio
n=C3=A3o =C3=A9 um erro, mas foi especificamente dirigido a voc=C3=AA para =
o seu
considera=C3=A7=C3=A3o. Eu tenho uma proposta de ($ 7.500.000,00) deixada p=
elo
meu atrasado
cliente Engenheiro Carlos que leva o mesmo nome que voc=C3=AA, que
trabalhava e morava aqui em Lom=C3=A9, Togo Meu falecido cliente e fam=C3=
=ADlia
se envolveram em um acidente de carro que tirou suas vidas. Estou
entrando em contato com voc=C3=AA como o parente mais pr=C3=B3ximo do falec=
ido
para que possa receber os fundos em caso de sinistro. Mediante sua
resposta r=C3=A1pida irei inform=C3=A1-lo dos modos de execu=C3=A7=C3=A3o d=
este conv=C3=AAnio,
entre em contato comigo neste e-mail
(johnsonchief436@gmail.com)
