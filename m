Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B1B3EA971
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbhHLR2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhHLR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:28:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:28:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c5so5832038qtp.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=AX8QGNVLcySis6GHVJ7sYjomjduq5M/gHF4YtKprC6g=;
        b=URsWBW9ykyas/fyM01OIPjyb7A7C4mP+YLj675izYibtEd9WFjdGY1+C+98ZvL5g1m
         Ufx66bzq+tzvh3P40Q/bSUAnGSxXCmXfDdS9W4HfRxQK1Ofb5aZPBa2HT7Lr0eFetpPd
         cK8yUBJ1j+PInus4joM9km5ERz3TqTzf9WJ0gIZb3v3PKPaOL0KvsX6upgnOVjDtVm0L
         dWU1ktOl7kXZcsxIQlZ767YX6qWqbSNV8+xtuIfVgX+c0onyPFjJxf2lFus+r8qZ6dj3
         TleKstZpX01/yUOquPwbzp+DQ75TpsnuGArntlgus1BfglHhI3YMk9G96nS2gmV5HGdm
         bPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=AX8QGNVLcySis6GHVJ7sYjomjduq5M/gHF4YtKprC6g=;
        b=No3nLHhSDqfWqaTbITvm8L4r35s1hXjPk9itVoVQisZ5e2uK2Ol9KuOW3EqxToKGsn
         dJHKFWUPUUth8l4obLO9SxIWWAgzRe8jRQhTTY9XAKNZo3E9UiJEy2RmJzg48JmdJaZY
         UiRUS2l5ySl8EVubSkihCJyIN1ODtcd2rsoO8ErIWzpVsydM+E16zZbISgcxdEPhzgmQ
         Cdx4f3/bVZkDFa1JnXWRX/m/RsnNwz1lhGZlJXW/7ET9gxRBeVOz92AcgI6oiXc1Zy/S
         +lz0IN5tiDllIb18LptQc+oT9bGQ1qaNx+mNiWHBD7vk7pmkpz5MEnZYx4khSO594pkr
         B0Ig==
X-Gm-Message-State: AOAM532gypsQCd5Ec1+JQ1rmcBrdbb1/YjK1ej/oBJva3ngfj4TnvaWt
        d1/VZRGIglO9IC+tl+Y8k6GXyg==
X-Google-Smtp-Source: ABdhPJx8f7vytNV4a8tZrn7GfZVm8iswDDALotQJujtTHX3bvQcZfxCtIUGmAdAdwdSy+djoiLlNeA==
X-Received: by 2002:ac8:6e82:: with SMTP id c2mr4901783qtv.277.1628789295153;
        Thu, 12 Aug 2021 10:28:15 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id 37sm1478039qtf.33.2021.08.12.10.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 10:28:14 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     SeongJae Park <sjpark@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210812094240.4492-1-sjpark@amazon.de>
References: <20210812094240.4492-1-sjpark@amazon.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1628789293_131750P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Aug 2021 13:28:13 -0400
Message-ID: <167751.1628789293@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1628789293_131750P
Content-Type: text/plain; charset=us-ascii

On Thu, 12 Aug 2021 09:42:40 -0000, SeongJae Park said:

> -         This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
> -         Accessed bit writers can set the state of the bit in the flags to let
> -         other PTE Accessed bit readers don't disturbed.
> +         This feature adds 'PG_idle' and 'PG_young' flags in 'struct page'.
> +         PTE Accessed bit writers can save the state of the bit in the flags
> +         to let other PTE Accessed bit readers don't get disturbed.

Well, better English would be "to let other ... not be disturbed'.

But I was rather hoping for an explanation of what "don't get disturbed" actually means.

If you are "save the state of the bit", are you saving the *previous* value (in
which case, other readers of the bit may or may not encounter changed behavior),
or are you saving a shadow copy that may have different values than the original
flags, and only used by a few routines?

Or are you creating two new status flags that are only used by several
optimized/fastpath routines and ignored by the other readers of the various
flag bits?

So a better description would be something like

This feature adds two new status bits PG_idle and PG_young to 'struct page'.
This allows passing additional information to certain users of PTE Accessed so
they can use an optimized codepath bypassing expensive checks for certain
common cases.

or "so they can provide <describe different behavior>"

or whatever this option is doing.

--==_Exmh_1628789293_131750P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJhFVosAAoJEI0DS38y7CIcUrMH+QGFFKac8B0RfegkCazdDLtN
p7d9cijWcXq1d4Tye/w8Sb+lUJwKOZcnz4mk5sUHwjVku9ZTJLB25T8ufpOjh/Em
4ZwuLP1CJzuMnZL2PMTbLIkqZiAKXrH/vXNv/RTiYX0Fg33e38cKxBnyWtcZHiPh
5b8BocR8VkmqD9aNsMCH7M8HMgqZMXBG9ohsMAi8NyZC2EWUEXWr899HmbAAfZH5
LoKG/wqCN8PnDLH0XFTdHjIyVPH03TOfqXU1YaIWoBla7TGcBitP9/PflQ57xWHc
bYYrxoU6khL2vRXvKwWXWiti3Ug4NlpTfpy7mqt/JtomqkrHCsPVIXVgRKlSe7g=
=EoUy
-----END PGP SIGNATURE-----

--==_Exmh_1628789293_131750P--
