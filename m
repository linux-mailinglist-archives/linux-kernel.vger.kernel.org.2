Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1582A3F58EB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhHXHYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbhHXHYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:24:44 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84D4C061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:24:00 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Gv0wF4bXlzQkJ9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:23:57 +0200 (CEST)
Received: from spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123])
        by smtp202.mailbox.org (Postfix) with ESMTP id CD57826B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629789835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SAe9W/B7mClrHqegpKIh4pdjy//TfWI68VVL5gEkMRM=;
        b=S9Qi9ucTbq552ACGczE7+B2OUNaPxojpaxgk+il+qHIcbAVyRJwdvHBAYBG2vyx3V9PcNW
        KcBCC21EoGtcDkzKJApmiKtxMj2Yr2+ivMsn9rqtIR/GumnZR0NS+btbZHGaCr/TEv10BV
        bQA3XYmZocQgWmNmNRdXKhJFXEtGXh/qofdM+m3hTJwdh8/0oAAVmlFaK5YLbqNn2q+ZUw
        ps1QIgFcDp8zCcKjHeCBUK6a231DaGTTEmRwHRjlKZwrcIpuidE0BhRi2SENrewPlKf7m6
        rNz8co3gZw2ZWX89F51GF1ClVpEaI4POS9OMwESZ6s4uwFeO8DLGiLMivS9EOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:message-id:from:from:date:date:received
        :received; s=mail20150812; t=1629789834; bh=SAe9W/B7mClrHqegpKIh
        4pdjy//TfWI68VVL5gEkMRM=; b=jvJ9cD+MyfIfyZ+lKsl+W9nUeI1pPPWfBwnU
        Wbi6kDnPx9+L5lhABB9R4LDgi6lF5/klNcfOlrYT5sMK862aEzzH7LAZfAE56s+A
        zHaJd07iwLfcGnXmqIhX+YgTG8TJWduKljpr/wc96cQmUY9DtmBsBmxFFbFblCXL
        pqWQDDDMq+wNyI8O3Vm9k6E599qjBEgtgYsmVOWo4mvVvLwU6gHNyXgy/YF9nMx/
        yJuCwi8al65zO35nLPUsOxvIXm2nMrdsHOAxjF+12p64DtaUsyn7XNxXU+5K9uok
        0nHOkc+IzioA7sj0eFFbHCgsIkLcfZFvCq4pqNTzdWQ7e0xSxA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp202.mailbox.org ([80.241.60.245])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id IU9n0WSGbOFx for <linux-kernel@vger.kernel.org>;
        Tue, 24 Aug 2021 09:23:54 +0200 (CEST)
Received: from ox77.mailbox.org (ox77.mailbox.org [10.192.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp202.mailbox.org (Postfix) with ESMTPSA id EBB5726A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:23:54 +0200 (CEST)
Date:   Tue, 24 Aug 2021 09:23:54 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <711627393.145278.1629789834855@office.mailbox.org>
Subject: [Question] 5.14-rc7 not in stable tree?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: CD57826B
X-Rspamd-UID: 4e8674
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is it normal that 5.14-rc7 is not available in the master
branch of kernel/git/stable/linux.git?
Master is still at rc6, just wondering.

Thx,
Tor
