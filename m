Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5635E383
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346893AbhDMQJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:09:35 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:45678 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346833AbhDMQJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:09:15 -0400
Received: by mail-lj1-f178.google.com with SMTP id z8so19945705ljm.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/KJyPMByeKfdgT60ieP/d3a94iiS3K1OI1uOetpEesw=;
        b=BnckUcD+kS4ZFWuMtJYd0CnI7njVo/AxMtEgUPbFUcmdtAG4HBwlW4eAOKb5z92Snv
         Y7of1VvASMfo+stu2k0IzIS+DdpL3CjCB/ap7yTsJ3lEGFyrX20Di7nMcBAj0BA1f+Ln
         PN2+B4yuGEYQm9M4VW1lHEmc9HCVrRmr9nN/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/KJyPMByeKfdgT60ieP/d3a94iiS3K1OI1uOetpEesw=;
        b=q3urnBv/icI6Ly0kLxqpBoYxVn8MLryFyQgMc5kN78G6TOJeeZ89pAL+xnD43wuZYu
         RhhLO8zZLUi57zMUmOf2nIkLT60Q0AzgkqfngR4/mpw8lPa0WcgnyqBpTNxoJNo/1msz
         3TlrBLB7RB5F7mTVyzf88CAGaiH3i8N+B8zmKBGBOYq3Zkur6Nxsk5gzDyRH+3cSobwh
         k+YhPdWAIS8oAdl/ot0JyTRNPxVJTVo/XZQPyaFtZYdukVTJDjRWLE05zCmiapnCktyI
         giCZFO3cNaPqw1wiTWUCbxDflXX2uiiujEClBEB8hYYUD0tRvFG/xRNJgyi7/GyFQwZy
         wm5w==
X-Gm-Message-State: AOAM5308sC4WVsUBncDe4GsikJ9kbwY0pYLk0HnwcNWpEJ5xKImaJari
        Ym68vjpt845utOHHNFGggJLiIRgNMHBAmjxLcYFeCA==
X-Google-Smtp-Source: ABdhPJz6dQ6rswRLMTqEF/co3mfu4hP6KC+8VZXJ4JXSVMEzLfKDAkhk1BjgSwPXg6v5SheRe2OT4j27NPJlpyfAdpg=
X-Received: by 2002:a2e:b606:: with SMTP id r6mr21310707ljn.327.1618330074932;
 Tue, 13 Apr 2021 09:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210318051733.2544-1-sargun@sargun.me> <20210318051733.2544-2-sargun@sargun.me>
In-Reply-To: <20210318051733.2544-2-sargun@sargun.me>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Tue, 13 Apr 2021 18:07:18 +0200
Message-ID: <CACaBj2YNmjLarF+zMLghSHFiEGg9ZfcPXZ+9iS3qLPWd=7DreQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] seccomp: Refactor notification handler to prepare for
 new semantics
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch also fixes the bug I reported here:
https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/T/



--=20
Rodrigo Campos
---
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
