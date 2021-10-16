Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E20E4300D5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 09:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbhJPH2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:28:39 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:33105 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbhJPH2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:28:37 -0400
Date:   Sat, 16 Oct 2021 07:26:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634369186;
        bh=aIrr95/EeMWr3cJZp6ihk2Ajlq8KVCvoG37jEN6ZDoY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=xQ5omPakBhVX5S/2eEi1OeOuQJC1/NcsT2H+wxSApfDW14huttws/45js7TOT1h/B
         +my26e1wuZy3FXFz0r1YE/PdRovgnQHhDdvhaJ9TR2j8GnCOWhn9K+tgApe4zgL1ft
         wwgJ/i8fRPeBI9HOD2C5zqpGYm5EvIAJfb1wj9pk=
To:     Borislav Petkov <bp@alien8.de>
From:   Ser Olmy <ser.olmy@protonmail.com>
Cc:     =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Ser Olmy <ser.olmy@protonmail.com>
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking out of reserved MXCSR bits")
Message-ID: <jrf08svYO7V3wrXiL9wLzsLx74V4QmXRdlfLeeL2zEmta8REOAVFwpEt8npiWRfbrCf_WEfQxJyg45H-VGa83bFfnhTYYe1R7iWao4Y9wRg=@protonmail.com>
In-Reply-To: <YWlgPJwxmFL5nX4c@zn.tnic>
References: <YWgYIYXLriayyezv@intel.com> <YWhCAqDxAuTh1YwE@intel.com> <YWhFOJCF1pxIBANv@zn.tnic> <YWhG0kv/d/hddf+t@intel.com> <YWhsvSM5tAvwqprN@intel.com> <YWhwdDI5ECoMZQzU@zn.tnic> <YWh7GgCgdtwRj3GU@intel.com> <YWiAPQCRm4RnOiCd@zn.tnic> <YWlgPJwxmFL5nX4c@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 15th, 2021 at 1:04 PM, Borislav Petkov <bp@alien8.de> wr=
ote:

> Ok, here it is.
>
> Ser, I'd appreciate you running it too, to make sure your box is still ok=
.

Tested-by: ser.olmy@protonmail.com

Working fine here with the patch applied to a stock 5.14.12 kernel.

Regards,

Olmy
