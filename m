Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFA63CBAA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhGPQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPQn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:43:56 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAD4C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:41:00 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d15so7489372qte.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=s9HW2RMba62RaYUFy8rI3e2x4Ua8X2oJj4sli91s8Ow=;
        b=Nt792LXzdbHe95jSTYavlTgOhJe29tpHPsYtg1Q5I8ZHf+YI6FgyukxyNhOh9N+xa4
         G5+07FhUforqmw35BGiGgP/U9x+B5xngjZpNB/0AJo8k420BCvzwjB862XLrETBPFDlq
         8I52kAdbv0ViryNh1iYFv/L+3b/jYCWa5z4qSdN+wVVVCPq1R+i08BrRbYxKuZZGybsv
         ZWDG7oLb0RH1DqRmv6ciDKKRpMxI9pFPdYEFylF3TCtPW6Qf2kHQeW+wYwv+buqE7VzG
         GPMTcpv2dqUWTTI6xb3fJrl2Wmg4jZlfWFRAgriIwp2+144Coa2x2zePpvvZwNkGjRMs
         aCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=s9HW2RMba62RaYUFy8rI3e2x4Ua8X2oJj4sli91s8Ow=;
        b=odPPC6f7Yow2YhGZ5msD34e/0inkuY354UtMzBc+7Y8qvQJwUwCKEtqAk9hbaLVUf5
         Fxpy+LxVAf+XLlh7rVJ3Uvy8Q7Y/16HZ/UnmvJ3NzJ1s4ojH4HbXLojIg7WaAmxMXYml
         KSaDGlGXfGmujKjwzkXa1jv1WvgVZR63ziXnR5y0gpcdzU/XWS+vyjgOK3+2O6NxxROa
         3Elu3ftlePoi3rBsrkZl6gJlBfy8xZBWe+5DRtjqDcECPPf2OSz2dUZG75ZatY6PIgLN
         ck180Df6Bgrbdm80BxsqPf0pcNGTdw7CQ30Hu4JQ3NgGIdiUdaQyxmHKysn3+e0Z8rUZ
         shzw==
X-Gm-Message-State: AOAM533ajphhZ38s66mF8Gbvc+8BirJ3nmz2Hp0/Sj2Ct1OdUSZ4BXbP
        dydclX/Tr715pb54HPZdyK5TcI2x6+I7lJ8xP1E=
X-Google-Smtp-Source: ABdhPJzvi2ZNgvAR9USkMa6UhFt/lA45AM6eLlA0OHSp8CXPyOcN6+7CitHzxZWlSjVcBMkgD7nNNvdaepy7/PaIVZo=
X-Received: by 2002:ac8:4e93:: with SMTP id 19mr10098481qtp.202.1626453660168;
 Fri, 16 Jul 2021 09:41:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:1048:0:0:0:0 with HTTP; Fri, 16 Jul 2021 09:40:59
 -0700 (PDT)
Reply-To: gabrieledgal76@gmail.com
From:   Gabriel Edgal <nkutiulama103@gmail.com>
Date:   Fri, 16 Jul 2021 09:40:59 -0700
Message-ID: <CAJvQRk7=yKiWLwoSGx+-uHxzrota1L8_6-vhBrEWJifMNeBrDQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Estimado amigo.

Soy el se?or Gabriel Edgal, soy el auditor interno jefe del banco Btci, tengo
un fondo abandonado $ 9.5 millones de d?lares para transferirle, que estamos
voy a compartir 50:50. Solo ser?s el pariente m?s cercano de mi difunto
cliente que lleva el mismo apellido que usted, el fondo fue depositado
en nuestra
banco hace tantos a?os por mi difunto cliente que muri? con todo su
familia en un accidente automovil?stico en 2010. Quiero invitarte como
extranjero
socio para ser el pariente m?s cercano del cliente fallecido, de modo
que podamos
har? un reclamo sobre el fondo depositado y lo compartir? entre los dos
nosotros 50:50 cada uno. Quiero que me responda de inmediato para
obtener m?s detalles.

Atentamente,
Sr. Gabriel Edgal
