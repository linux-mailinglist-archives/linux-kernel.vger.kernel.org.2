Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2911343598
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 00:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhCUXBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 19:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCUXB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 19:01:27 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB419C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 16:01:26 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id 94so11117790qtc.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=aVU5qrNlEMP/fIGggLAPloj5cPgD2XWzdOWM8ZQu9qo=;
        b=JkKdgldJQOkHRhkvowVHYXwoucMyuIO2DPg3TkdMu1BC7yzUfz6PYYN2d8QXAmw5OR
         yR7glUEog8jUpEVZzCN6zGnLXXSIVXHX2ZAPYqQULwKmC2muuTqTfd0UbeUcEFcZqb0C
         4pK9NPkYtp12IbSzMCdTnBNS405bIly+91aYeSepcBlh3msGPGHaBDbmmHvC4gU43sJs
         dvNo3l1tQMcRVzLQ6zA3pIBvywconq3uW1aoykTPr9k0llNgRz8c45Rws8/urRaQYb5G
         YUxtqbzq+PJ4ap79e+14/Qo0PeGhaW1JEaO6dZaVr1/aLvu3Vv4I0bnIdGqOAI+CsCrQ
         Ky4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=aVU5qrNlEMP/fIGggLAPloj5cPgD2XWzdOWM8ZQu9qo=;
        b=CAFknMbbtoBzov5iBeGc2WwSkTSnaZOs8Abni4yKLzdriIAFfaZvHrKRuMxjPUAtJs
         qeANc6md47VJ0ptmGOpfB5bEy9Iuy89KBRSNSA/1fnDzPrIdfQntAjrsgXVRk0H3VUmd
         FYNgRnBnCBzJ+zx6l0FqU1Q40Z5CHgK8rIEmZRHM0Y/Zu4Y/vSr5UoCOTkIxNsnzi0sH
         sVMqiyrySl0Ir5FkBpB6BLoYFbMtkkBIygEkYWqawYVWv0r1wLjDThzfQiIBcigv3UhT
         OY3evbj3KdReSCQxCLtYa7L34LQrgNTwuSVoVL48+h2jGU6DcVndYhNkvNDTmtNQ3+oF
         5qHA==
X-Gm-Message-State: AOAM531J97t8UsPLyFVgS8AT5+hQJF6cqNHfrYHWEdFc18hMX0djFuUz
        659XH7KruE0EN1t3Jxa3xz4=
X-Google-Smtp-Source: ABdhPJwi6YWoSC9TPGAsYKQ4/7/6SYnZ11YxxaA20psbU3AhL8/brXeK7rLhSzrE/UO/HT5xdqkBvQ==
X-Received: by 2002:ac8:1385:: with SMTP id h5mr7553626qtj.298.1616367685970;
        Sun, 21 Mar 2021 16:01:25 -0700 (PDT)
Received: from ArchLinux ([37.19.198.54])
        by smtp.gmail.com with ESMTPSA id y19sm9644570qky.111.2021.03.21.16.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 16:01:25 -0700 (PDT)
Date:   Mon, 22 Mar 2021 04:31:15 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/entry: Fix a typo
Message-ID: <YFfQO/5Ectr5fWN/@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210321201345.994577-1-unixbhaskar@gmail.com>
 <cdbd84e4-6099-3ab1-aa44-1f78ab93de1@infradead.org>
 <20210321225555.GB1885130@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CgQjJhBYkbaJxz/m"
Content-Disposition: inline
In-Reply-To: <20210321225555.GB1885130@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CgQjJhBYkbaJxz/m
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 23:55 Sun 21 Mar 2021, Ingo Molnar wrote:
>
>* Randy Dunlap <rdunlap@infradead.org> wrote:
>
>>
>>
>> On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote:
>>
>> >
>> > s/swishes/switch/
>>
>> should be 'switches'
>
>Correct - this patch exchanged a typo for a grammar mistake...
>
Sent a V2 ...check out..
>Thanks,
>
>	Ingo

--CgQjJhBYkbaJxz/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBX0DgACgkQsjqdtxFL
KRVbXAf+PXmfqhnPzzI2ijj2ZUJxikqLzeny1lx24scBIxDUGfxNYYirB2pTEpyb
Jp3wIiMPQi3cB9Sqg8hFqwtnemPu5U3azgoSAj/OxOLiSeEvjIjRalsTra+a0Ita
aD3BkmPtqN523T6YKabAJt7HrS/6DDBs/QCARJ7htyGP9v7tG2Zh3Fz48Y5JAFHC
Nr75GTSrXRpJURFiOMEZtlqCRN/0RnBDRK2rzXc/uXOaX3pgPooRKV6s1+8M3ONz
+GK2bcZ4cT0rmtJSSprBCPyyPvrdjrAOxN9dklnNKMuTLtVwKKN0ls+AkdQxhK14
0gOsuUnxk5CPNJ2Lmg5Pv5tTgW86Mw==
=Hdw3
-----END PGP SIGNATURE-----

--CgQjJhBYkbaJxz/m--
