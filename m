Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C856318502
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhBKFug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 00:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKFub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:50:31 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16D2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:49:51 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id i3so1382871uai.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XJgAGWiOeO1vdUAY5XfRVtuFg6DJm1z6DFg5goqsUSc=;
        b=EcvoMAFohZNOOqbs3I05yv+edXeqcpDzal+TI8f7CHFv5M7dpSSlBezvUEM8VgYdKL
         bcd2M5NDVuPHsvci/fJ8U1EJz4BCOeueDOJr5qf4uMgzjcFCQBF6jdGFdD3/MIY+qopk
         8MP0xFVCj/+TATfONx8XNnwCvkg7L7RLIjLc648pFlh7unfzxs4qdiYxLXkfRwEtxVrR
         TuY2lDXd9J9LPr2iKEDXIw4lfxoIH8Y3WzKyddpGj1kTFZ3ryYbrVjvtwxt1UuGTmqIN
         kr7XkukYPx6CMKij46zchzePi5SCcMBpayGdNm8AUbkTgZSePDMU5l3XDzMez3eQSnzr
         7ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=XJgAGWiOeO1vdUAY5XfRVtuFg6DJm1z6DFg5goqsUSc=;
        b=JwnVNo4sXweJmAST/IQ7py+yoP1i4jLUPXY54QU+a5OmPrDVM+q+5076HvpfEt9kRd
         WqJ6iz+0sYuVAcUU7Q+VCa/0vuP2KrL59dl4qzA/7aUNTvcdc1KcA+qVpjFof363MRAc
         e1Dnkhy1ZV+5IRDI1F669L2HfvPPFpP6EpACmTlC96HsXIBIn5H0bVmtFlKJCgoSKSIM
         Yvb4tlItTHC5OnNXuOMtBaEx0ZioBg3SuzQpx/Q+IawSzkALOMdtZWiUO9uTTYIc4258
         XDjNCt1gaOaNDoyLlPVtDi3Li4vmYukTbiZBvsg+XyVjZ0mP/y6CGNIukNNAm9oYGVvT
         RTSA==
X-Gm-Message-State: AOAM532HNjIqLXAwu+dAzOHqgTLbb3mhs6qBgLDpZzU6WDYd0eVN6lPy
        GVMBoIujPdMiC1ZC7Jl6lGXZf+QYETQA51ttEV8pNvKvmuhsLQ==
X-Google-Smtp-Source: ABdhPJz8nEnIWgBCP8AyJ3UKOdAzJh930Q7Vo5DjCbziwIJkBwq3e1ZIcKAAKFLvIIf12Mp15yRupYdwzzJvWgWeCWQ=
X-Received: by 2002:ab0:6f10:: with SMTP id r16mr4023624uah.116.1613022590765;
 Wed, 10 Feb 2021 21:49:50 -0800 (PST)
MIME-Version: 1.0
References: <CAKNdpdS9kBoAdvFXVArdKJMcBFzd+4yueQjT-Qv8BtcaZinyKA@mail.gmail.com>
In-Reply-To: <CAKNdpdS9kBoAdvFXVArdKJMcBFzd+4yueQjT-Qv8BtcaZinyKA@mail.gmail.com>
From:   =?UTF-8?Q?GRUPO_VIDA_OFICIAL_CENTRAL_DE_INTERNA=C3=87=C3=95ES?= 
        <grupovidapublicidade@gmail.com>
Date:   Thu, 11 Feb 2021 02:49:38 -0300
Message-ID: <CAKNdpdRayY-SdJkD5bKs2Y0XGxuQf3T965QvoR55qqTswxRp6A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Cl=C3=ADnica_de_Recupera=C3=A7=C3=A3o_para_Dependentes_Qu=C3=ADm?=
        =?UTF-8?Q?icos_e_Alco=C3=B3latras?=
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O Grupo ViDA =C3=A9 uma Cl=C3=ADnica de Recupera=C3=A7=C3=A3o e Reabilita=
=C3=A7=C3=A3o para
dependentes qu=C3=ADmicos e alco=C3=B3latras.

O Grupo ViDA oferece tratamentos contra a depend=C3=AAncia qu=C3=ADmica e o
alcoolismo. Interna=C3=A7=C3=A3o involunt=C3=A1ria, resgate 24 horas para u=
su=C3=A1rios de
drogas e o tratamento com iboga=C3=ADna. Desde 1988, recuperamos vidas e
restauramos fam=C3=ADlias.

Nossos tratamentos para dependentes qu=C3=ADmicos ou alco=C3=B3latras s=C3=
=A3o
ministrados no Hospital Terap=C3=AAutico do Grupo ViDA, que possui as
condi=C3=A7=C3=B5es apropriadas e adequadas para a recupera=C3=A7=C3=A3o e =
reabilita=C3=A7=C3=A3o
integral do dependente. Al=C3=A9m de um espa=C3=A7o exclusivo, os m=C3=A9to=
dos de
tratamentos s=C3=A3o elaborados especialmente para resolver com efic=C3=A1c=
ia
todas as particularidades que envolvem os pacientes, tendo como foco a
raiz do problema, n=C3=A3o tratando de forma superficial o uso das drogas
ou =C3=A1lcool.

Nossa cl=C3=ADnica de recupera=C3=A7=C3=A3o est=C3=A1 localizada em Sorocab=
a, interior de S=C3=A3o Paulo.

https://www.grupovidasorocaba.com.br/

Em qui., 11 de fev. de 2021 =C3=A0s 02:47, GRUPO VIDA OFICIAL CENTRAL DE
INTERNA=C3=87=C3=95ES <grupovidapublicidade@gmail.com> escreveu:
>
> O Grupo ViDA =C3=A9 uma Cl=C3=ADnica de Recupera=C3=A7=C3=A3o e Reabilita=
=C3=A7=C3=A3o para dependentes qu=C3=ADmicos e alco=C3=B3latras.
>
> O Grupo ViDA oferece tratamentos contra a depend=C3=AAncia qu=C3=ADmica e=
 o alcoolismo. Interna=C3=A7=C3=A3o involunt=C3=A1ria, resgate 24 horas par=
a usu=C3=A1rios de drogas e o tratamento com iboga=C3=ADna. Desde 1988, rec=
uperamos vidas e restauramos fam=C3=ADlias.
>
> Nossos tratamentos para dependentes qu=C3=ADmicos ou alco=C3=B3latras s=
=C3=A3o ministrados no Hospital Terap=C3=AAutico do Grupo ViDA, que possui =
as condi=C3=A7=C3=B5es apropriadas e adequadas para a recupera=C3=A7=C3=A3o=
 e reabilita=C3=A7=C3=A3o integral do dependente. Al=C3=A9m de um espa=C3=
=A7o exclusivo, os m=C3=A9todos de tratamentos s=C3=A3o elaborados especial=
mente para resolver com efic=C3=A1cia todas as particularidades que envolve=
m os pacientes, tendo como foco a raiz do problema, n=C3=A3o tratando de fo=
rma superficial o uso das drogas ou =C3=A1lcool.
>
> Nossa cl=C3=ADnica de recupera=C3=A7=C3=A3o est=C3=A1 localizada em Soroc=
aba, interior de S=C3=A3o Paulo.
>
> https://www.grupovidasorocaba.com.br/
