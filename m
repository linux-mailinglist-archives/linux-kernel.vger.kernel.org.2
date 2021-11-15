Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70042450168
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbhKOJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhKOJcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:32:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9300C0613B9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:29:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d24so29363482wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wemttcpB8qRVZjoDeMFbFx9gpf+d7pUwbUjdqvfUavQ=;
        b=pS04qFqaJr37QRQFe0Px3b1LzUEcwy3bjlk7Dqu5WpGuuYw1bU24JhDUK6e8RvBxUU
         xxU2WWlbW4T42PPTw8Y4hWDVOZ+xqn8+9TGlNtktpJc6aB3ACBIGIwbcGOe62EhV5JtX
         gtvPrWpFLs3wMtDDuuTkOrpOXuEaMmvn94y6Rd4JfAJGOm5wgDcEwCkVsA5okfnCbJE5
         STTZ5YMuhtFT2fgUribMRSijIOW35HR0VcOuD1/itOP2MVxsewnulzK9W56ghHMpzGqE
         Bzbm5KcG7bySa+tau5TFFhhPZfW0heTrKYSV02X58r1BFrRHosVf7EDvHI52wCECR7yY
         7c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wemttcpB8qRVZjoDeMFbFx9gpf+d7pUwbUjdqvfUavQ=;
        b=SfLBHY7ypfxj5MR1wmkPW4BGAJ/mgLRBfq+O+XhEr37sihfApg6z+5qSr/whbNhGQp
         RuY6Z3s/8gq2RwM4o67qDEMDclxYv3JngqU6vUSCKxlc83s65QLBaaUfSzNpLZfOd3Ck
         LhPzpyuRefKuN0rF1KGmUTAl0upRS0f33m6kgiq+x71rb7C7N+w7uFpJwPt3IERdF2wJ
         ZFz3U295fy0BgU1l6nQnMbKCFPK3uXFRIA5rVdR+yftsgMPU7aPzifmGZFvJkUWUsi+4
         DTZ7XigzTT2J1WUPamMWtJa8Yp2qmK4E+91jZOTl6L79DFathiD4S9I9qSB4Qcs8/IVs
         XXEQ==
X-Gm-Message-State: AOAM5334bIvGMZ7NRH2jZqF7W+UCxJ2qXTD4bgzjaQx485K0QJupvzf1
        uwZLuCjdm4oWrmWnhdYWOT6EEHSi7pnAHuqb
X-Google-Smtp-Source: ABdhPJwfQsQlr42IbbgnL2l/mo+O1GtgjA9tgx4hdO6HnVLmfFKJ8G+PkJHJA2xGaCOxHLJ8ubVv/w==
X-Received: by 2002:adf:d0c2:: with SMTP id z2mr44917815wrh.330.1636968551390;
        Mon, 15 Nov 2021 01:29:11 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f56f:2409:301:93ad])
        by smtp.gmail.com with ESMTPSA id u2sm15871407wrs.17.2021.11.15.01.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 01:29:11 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, Dmitry Shmidt <dimitrysh@google.com>,
        martin.blumenstingl@googlemail.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-sm1-odroid: add cec nodes
Date:   Mon, 15 Nov 2021 10:29:05 +0100
Message-Id: <163696851316.448838.10307717773400137681.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007180130.805401-1-dimitrysh@google.com>
References: <20211007180130.805401-1-dimitrysh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Oct 2021 11:01:30 -0700, Dmitry Shmidt wrote:
> Enable CEC in same way it is done for other meson odroid devices
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.17/dt64)

[1/1] arm64: dts: meson-sm1-odroid: add cec nodes
      https://git.kernel.org/amlogic/c/83c9eee72603adbaaf0420eb2c4d537a9d65d5fe

-- 
Neil
