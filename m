Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF17D38E376
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhEXJkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhEXJkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:40:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47681C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:38:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i17so27810634wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=zHFH7Plck20fV+guAcmidVBsnyZcvavYbuQkUm8U9zI=;
        b=mKRuK76nF+Y6y2U20Pv7Z/CyAKe4Rjy6qHBLniv2W4ZJVtoJEb3rF7qXJ06S7BVrbI
         7yEDNW1NxJLWVjdCqs1qD81bibm3OL4Ld/+xIk8qTUVfW656t/hh9TpKOOfdxOr58CUC
         zM4zEliSMrKeI3r45bC5ieA3Na0ljCUpPYLwepxCk1OzV4w8zSuTyWkGDlT12n/wzzyQ
         OSUUTvyXM49Dk1MexccKaV/8WBZY8siAUtl0D3XiI83+aa0B60FBTd5BVamKgXzjedp6
         eXSeRU3ppcqq1HGxUAPuVSeogXVjng0NtDVzpaaSW0rkG52TcyIJ2HPsIqvrCee6OBVq
         63eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=zHFH7Plck20fV+guAcmidVBsnyZcvavYbuQkUm8U9zI=;
        b=QizolKnt4AhHDPGbG66LdBk3QFhL/vOX435LHPkjdjEYXC137CkhTGz37j/D4Bg4aw
         MtWSOd070+uAU0T6ZvlEgFGeKPpzI37jyNijfeNcCTbyxGmWDakXuEzcC2lzQ6TIRVuB
         gvg/3hvYdCzJO5MwB8bhLeCNXUmhE4HKca/jYJS/AsqLi8sIhNxRmZMZVzqEqwTvm8OD
         l1QEkaSeiMVekwyEh1Me/7zlTP7oyuMCYrpq8EhrZbPcDxaERfWp3kJogyov4pHrdN2u
         hVg4oOJrmfWOTbhuBTBqA4GW/BroDuo5gunT4+zIdGBV+mP1B28dRsdqtkSAEhGaCNSO
         Gbfw==
X-Gm-Message-State: AOAM533yXEDsryS3rcDRNwEvbMNzCqJuaFWYbbGjexvQF0w34e2Ow7jQ
        32vjGi8KE3cgBIoaJqCSFXGQFtHmCxfGNQ==
X-Google-Smtp-Source: ABdhPJwK/tWaJpBRU28y1BG55+5omYls82OT5wCKeAK/at6GNOVMWYAiaT1XZMuaZi9erT7XOfvH5w==
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr20755996wrx.424.1621849112854;
        Mon, 24 May 2021 02:38:32 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id i15sm11445544wru.17.2021.05.24.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 02:38:32 -0700 (PDT)
References: <20210429090325.60970-1-jbrunet@baylibre.com>
 <df839588-1ff2-2d7f-4364-2b0d8942d6ef@baylibre.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: g12a: fix gp0 and hifi ranges
In-reply-to: <df839588-1ff2-2d7f-4364-2b0d8942d6ef@baylibre.com>
Message-ID: <1jv978bhew.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 24 May 2021 11:38:31 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 20 May 2021 at 16:02, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 29/04/2021 11:03, Jerome Brunet wrote:
> Sorry for bothering with the DSI stuff, I'll fix this when we are ready to upstream DSI support for G12A.
>
> I had this patch for a while in my integration branches, so:
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>
>
> Neil

Applied
