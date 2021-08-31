Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F273FCB9B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbhHaQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240086AbhHaQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:42:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCBC061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:41:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so12230334pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norberthealth-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ofROlvTu1E1hVbZ28WkGRDdjDewSdNfrPBGyLPdKxw=;
        b=eWcbSYm9Ou+SKpzFZH64hU1XB9AQL4hX8f/ozcFkxsFMVmKOVq6EYNCwo3pGkSFeau
         zJvkw5DumscbfX9AbV+Tk2Hvkczt6b+g0Q0SsXCmxg1bZYvJFvQFYEH6EdizEK4Qw6cH
         cWo/lMTvnKMK/wGicv28u4BiwaycKQ6qjFV7T8toBj/eN1VEqaU6kUlIM8rMuhXdmf19
         3ZV1t+2IsqixTsud2p62M9eHiMLU1FV0ozR12unNrQgfEBDItTm+/94DfSA16HElK31L
         hTmK37Llo0y0IpoUtZYk4a0MToXB2sjhRrX0PfcwDrIKCEvYis+/iwzsJH1doZgZU6Db
         1Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ofROlvTu1E1hVbZ28WkGRDdjDewSdNfrPBGyLPdKxw=;
        b=KGPca9o5KyrAFYtBF6qR3Y/HatRiM0+jpPQ9gYRcyaYU8BUm7cFzgx9YZOz3yMbkZv
         9qpWif83R6qxqQ8N5IF0ec5g+c8s58UMUMBTLGMsGY3JkQMXV2BEGYlUZdjYNLcWcxVT
         k+IcKRXTIRcz3R2p+S4LPvUhumK2jqoWQFG3X9B1SZrRHjZZBKYYTTmjZ7RXYHGjYYs7
         LOZyAwwx8hJ9j7BXKaMoUbsaTOKW0XEIhbSULGWKaBkU/aE18p2GrbOARhZGWvMYUi8w
         MB+/q4wWl46k5XIh17pr2CwUTAKAPi6hZry1LIgYKWyroMpCH3YhRiDfGMgHEVff8Ek0
         YLSA==
X-Gm-Message-State: AOAM5300W14Fe37UibTt1ljlw2+tujuaOxeVk/tbogu5yQuh7CDJEWev
        A6pH8JFmD8TeY2TiccmFKXyhGR88Ut9NX8k4KqRcheqA5T9AZg==
X-Google-Smtp-Source: ABdhPJzUUsuFUyfYvCeCod2PWQHXawkudz0iKl+h2TTtZf4NEpXj88CuWJS1uiygyv78DjhoEMXXQ++n0FX+toPhwr4=
X-Received: by 2002:a17:902:a702:b029:12b:aa0f:d553 with SMTP id
 w2-20020a170902a702b029012baa0fd553mr5470508plq.3.1630428070408; Tue, 31 Aug
 2021 09:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210831151125.2401-1-roger@norberthealth.com> <3f26402b-00fd-1da3-0717-e2a6fc254060@infradead.org>
In-Reply-To: <3f26402b-00fd-1da3-0717-e2a6fc254060@infradead.org>
From:   Roger Knecht <roger@norberthealth.com>
Date:   Tue, 31 Aug 2021 18:40:59 +0200
Message-ID: <CAO_iFwoqbajgiKwQeNjTDWYPAjcnQWJFZM7EQLHadumtbJuBQQ@mail.gmail.com>
Subject: Re: [PATCH v4] Trivial comment fix for the CRC ITU-T polynom
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will do, thanks Randy!

Roger
