Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AE7422A42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhJEOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:10:07 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39148
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235190AbhJEOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:09:38 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 27A3B402CC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633442867;
        bh=xBfMLbhXq3eqWTn+wDo6cmI1h3D2Mfg/sPt1KAGGlNU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=PxP4I0TnAlqY9SdMqwu6DvYTvY8vKOhs+EFBig5MFB21Rcsh9t0qIIH4j1UNBPRxk
         QD0sv5KksBDrPsiiTvJgnV8ry2WR0nOyTQ0KJqtjrVbtQ3pkU8d17PXkLjbJR6ttOy
         f0tjUGIdLPhTzFKlzCmPir8WDb88nyaviab0WLfTmNcHV/OVB6kpC0eRx/6sCB9/w1
         5H5/PV04iZX7W1RFo0CFXCJHnkf2Y/HZfia3sP7Y7ot8RSB97GAhsIkEehvGUJVJRy
         0cqDSoZ/1Tmt5bVYMGY4ZvWPrqlxsWDBxHF0JRQfNU7E3jbYvBcc1Q9pvNoExKHkPk
         Nycyue/WYXVHQ==
Received: by mail-ed1-f70.google.com with SMTP id z6-20020a50cd06000000b003d2c2e38f1fso20745049edi.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 07:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBfMLbhXq3eqWTn+wDo6cmI1h3D2Mfg/sPt1KAGGlNU=;
        b=fYODZFUmNoCQB6p3X35+87M+50/SGS3i98J4SRKpWaeAl+epH90ACd38h5fr1w6qwa
         ERS4g+UMdGe9H+STL2m/BR1VMFFccAK9JjcK6t0jI6cEp/AFpJLszgTeNeypzAuyoWId
         0j4CQY96X/1nOU0q77cEfpMtX2X6uBNAYyBZeLvjKPvAqoqGdG0RV+BawfFAGlipH9Ej
         DzQKNdwa6+FpGBVPqn5uoSN7h8OAZSGzTw4cw7gZOFb/nnMhqL+CtvxXH17W+7MQjrvN
         MU7QgbxSYMQoZInJ3yFY7FZwyckHnUr6UmW1hsjSZG1vyxXtccjZvSIC+WF9v2jX1KLX
         D2Vw==
X-Gm-Message-State: AOAM533e6m/bT4F2k6YTN328U5mHwi03sl7kUq0Lm3aT30QLxoCHAx6x
        pFBWCvtHHcP0bg3vGPxABXiat+8Zg54Rwbq8vq1/jgX8BhcdLX97f8saoWsCd+0GXeaI/fT4m3Y
        HOx8A8xCSk0rJ2jqLJOygKSALyKTNawe9bnQzKScFlzusOsxEplne+7fjPg==
X-Received: by 2002:a17:906:5a8d:: with SMTP id l13mr13690153ejq.95.1633442863169;
        Tue, 05 Oct 2021 07:07:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7sw8lhaBJqQHKil175VR7+etb4keiU6vVzzat7S5H7BpHrVJ6AEaiYDY9bNlTwuViwa/ijPLx7oVatk9t45I=
X-Received: by 2002:a17:906:5a8d:: with SMTP id l13mr13689815ejq.95.1633442859265;
 Tue, 05 Oct 2021 07:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
In-Reply-To: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Tue, 5 Oct 2021 16:07:27 +0200
Message-ID: <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alexandre ghiti <alex@ghiti.fr>, rppt@kernel.org,
        geert+renesas@glider.be,
        Stephano Cetola <scetola@linuxfoundation.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 2:15 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> Hello all,
>
> I've uploaded my kexec-tools patches for riscv on github for
> testing/review before sending them upstream.
> https://github.com/riscv-collab/kexec-tools/tree/riscv
>
> Both kexec and kdump were tested on latest rv64 qemu, using for-next
> branch with this patch applied:
> https://patchwork.kernel.org/project/linux-riscv/patch/20211002122026.1451269-1-mick@ics.forth.gr/
>

I'll test that asap and review your patch too.

Thanks for your time Nick!

Alex

> Regards,
> Nick
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
