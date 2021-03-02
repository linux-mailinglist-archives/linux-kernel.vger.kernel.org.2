Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC6032B700
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhCCKbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhCBWya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:54:30 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B53C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:53:48 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q204so13757213pfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/z6F4q0nipab1hLiFAG3rxUNOetUhhQ94V8PRXZSLYE=;
        b=VA7rEgwMAC87/NM8LF9I9UicMZ2V2HDOIV+vQXEM3JrvM9ZwEixcQGvk0cRdoIYOTl
         DX/KDWFL3roWO0eS64Oz4t+Crwuk4FGjkNBpM1VnAQhPrJ9HFgJ+3VcIjBbA6USX0qLW
         CbtV4syLjz0sEUNiDEDtPnu+89/txdaKg7dXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/z6F4q0nipab1hLiFAG3rxUNOetUhhQ94V8PRXZSLYE=;
        b=Ywr+afGznrs60VniP3WTmNN5xQjAZOuTliSCW6zgXY1MYCi1A9PYDoAaaFTqMdDMkA
         HgHfLeRIDHaiC51V/53+0tjIuxGtOn6nKcH7DLPYpanSxN2cb7kUmEh+DbMJPTzlQGUB
         dXrWrzTuNNRQlCRD/hYqE6nBSIgn/JrpjGxnthZS7tDdLk18ZGMO2Dn7lIkgIbjgjrBn
         fuOkhKkFjGztCtHUrq1zRhYkU7QpzVcJ2beq5BGDgu+AYAbCJnZ1ZzBgJ7LfzUq3OgMF
         BLkZoifhIlJbeYpwhQE1kqPAWPgurNyiWJn2UOnUCZk4TrCTpQ5QubPpijupk2hygOw8
         aKaA==
X-Gm-Message-State: AOAM531xCVe0ZkIImWUcs6qP6hYWrcXpBhQDk7hzAy5SVGNLKgfwQSz3
        wLNPQBnBzzhHnNscp6ufFXeAsQ==
X-Google-Smtp-Source: ABdhPJyDc6Pk3oMkN9Ul9uctmwQbugbEozKhTWzIkbyWPq4uFoDnV2otdwx9dmT4OTX6P3ho/aH3oQ==
X-Received: by 2002:a65:5c8d:: with SMTP id a13mr19866387pgt.63.1614725627676;
        Tue, 02 Mar 2021 14:53:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d73sm23517862pfd.0.2021.03.02.14.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:53:46 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Tony Luck <tony.luck@intel.com>,
        Colin Cross <ccross@android.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pstore/ram: Rate-limit "uncorrectable error in header" message
Date:   Tue,  2 Mar 2021 14:53:40 -0800
Message-Id: <161472561624.3815964.8371153815312776412.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302095850.30894-1-digetx@gmail.com>
References: <20210302095850.30894-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 12:58:50 +0300, Dmitry Osipenko wrote:
> There is a quite huge "uncorrectable error in header" flood in KMSG
> on a clean system boot since there is no pstore buffer saved in RAM.
> Let's silence the redundant noisy messages by rate-limiting the printk
> message. Now there are maximum 10 messages printed repeatedly instead
> of 35+.

Applied to for-next/pstore, thanks!

[1/1] pstore/ram: Rate-limit "uncorrectable error in header" message
      https://git.kernel.org/kees/c/7db688e99c0f

-- 
Kees Cook

