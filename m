Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAEB31D362
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 01:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhBQAUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 19:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhBQAT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:19:27 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5875DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 16:18:47 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u20so12051422iot.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jTVlfIINqTw0v4Efkeelt0x7KWMArOQ/VsKT2nrF4AQ=;
        b=T5/p18DPzvbD7cCwPPlo/f+paDltHHa+jjG7Uqxu2GXeOCUlMKsfz7mQvlsVsbA6t9
         X0zHCPmfcJE9KiVjw/wuQcQofj623t383yQFHh40IXOLiHWvksgwmW8jjsAvQF0XHCe3
         CMMt8cFxZC0bYKmKfSlKOwSvpDGRZ6ZrkD8bSTnVLg0qNOfUgseUBbwi8eGWifzn5dUE
         Q+5RBgsuBahfCWnh0N93R6J/zsx5BHwKnp4U8sALIvcRvEH7GCvfk4dqE2dALhGTd2OQ
         y0XM2wmPqzKNb9zcWyRAk09hbqg8ed6SDPNeSc6H2ISqujIwYYIRNtvy7JpcX4cyAJNA
         ih6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=jTVlfIINqTw0v4Efkeelt0x7KWMArOQ/VsKT2nrF4AQ=;
        b=NirCGVxoBJQxQgVoH2uxzIZm33SOhR9OT8MH7uvkk7V+BE6bZvHdwb/22xl0LnNwDn
         fa5p57Sy6rmF0ciCoJKK92voQckgfRtnAsPvIYav1UsIG+l7gz4eEswfyubKKdE4h9aV
         RFqTCT2HDEiTHU6siT6BgrE8ew7k74AxTiVu5P4GrLfOCIbOSU7+DSOjkwy+l3F3krRU
         Rfouv5cfoYAA8SFunD6061jmmfsT9UlrVuUvj21fagRUTnB3e+jzrNKZXYHKT10NaRW/
         03Wuy647KV2XsJ/ovhjgYTV44T6gutP9J1aUtyzKcfwheEYL+abimQ6umUCXM7q3p7e8
         CotA==
X-Gm-Message-State: AOAM531/doP3looQhP0LsJE/I1jTEcvNyYYphT5ucVrWiAsWnwy2S3eE
        EwJmWTZTaEtf0923gkK3KIACInRSwAQfnnEEVyw=
X-Google-Smtp-Source: ABdhPJxlaQcpyqc4ledhjx2/tZ8P88AqQQDNP+iRP4dAkvm+hPW2/5yGaUe8X0MrNNDHSI1VPjgywFG0RpAbCUdwri8=
X-Received: by 2002:a05:6638:2411:: with SMTP id z17mr11848278jat.29.1613521126766;
 Tue, 16 Feb 2021 16:18:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:9856:0:0:0:0:0 with HTTP; Tue, 16 Feb 2021 16:18:46
 -0800 (PST)
Reply-To: charlesjacksonjrc@gmail.com
From:   Charles Jackson Jr <danjerry1997@gmail.com>
Date:   Tue, 16 Feb 2021 16:18:46 -0800
Message-ID: <CAEJOpTdbtMn2GevZdt+UcioXNk9iaHoj-FFaSxnuv9ESXaNetQ@mail.gmail.com>
Subject: =?UTF-8?Q?Antworte_zur=C3=BCck_f=C3=BCr_die_sofortige_Inanspruchnahme_?=
        =?UTF-8?Q?deiner_gespendeten_Gelder_und_Gl=C3=BCckw=C3=BCnsche_an_dich?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
IHR E-MAIL-KONTO WURDE F=C3=9CR EINE SPENDE VON 3.500.000,00 USD F=C3=9CR
CHARITY AUSGEW=C3=84HLT. Antworten Sie auf die folgende E-Mail, um weitere
Informationen zu erhalten

E-Mail: charlesjacksonjrc@gmail.com
