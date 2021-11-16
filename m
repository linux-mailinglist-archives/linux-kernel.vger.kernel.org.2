Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D3445388A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbhKPRc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbhKPRc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:32:56 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35562C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 09:29:59 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id w15so21231718ill.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=CzJiuox7YJIzq/UfIdsmaYppnZCQ7C5vaCe5SXOdzslfxNWJp8EYFWiKIAjkj6wPWo
         eTypot+UPXvNKSpUauJNY3mtAjHRIvC71GW/M8dbzd6+B6fI/10J/Ugz2E+Dg8HuR8ud
         Fz8+PaGLC2/UU0tVZqY4X7Bn9PZpKp/ZJv9gEw/OFPRy/Cxm+hE7X8z/649skzXzZ6BU
         QZQbWzL6/ZI9xyoBCpRIlJvNkg/Wro2EWvzz5cxXwdUQDZd8sSkbnApi0X3Xv/goDD5A
         ekEA+Y8nxgoVUe69vQGWVOTr2tylPFA0blRug1jCfg7DuFGbxDIsVmhrN/dgW3LSDt0x
         4Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=wVg0MZIl1vn15gLyiy31NYqgTT5W2aT7qyCC24O5qLtfqJu5OFAtG7aHielGC5LCdG
         Jk8XyJE9Jyae4qwgKhj6Pv3UORhc6K1epP1/XH0EVRZjXSVaHVTyhGcPAHignT1X87IG
         tRHGnaGXLCumLgi87Lg8mJ5a1/eyWelStE7pCWRzSs6hRbWmTJDEeqxonHF2OEiW7XeQ
         xXOwzbN4YejlHbHPGIdH2eotkO/NRWbwTXNYGInUXcmDmNXOiJRmYMWAHVUqY6G8dq5N
         aFzqW7M+fWBsD3jxCe+6a+pJdCCjgwWbnxOR08fotnN7LBNkxj9DaFZgj8K3pAe1EXZh
         ip8Q==
X-Gm-Message-State: AOAM531XYSk0XL4UQzkQEqIWBzhh1ZIvMB7JS5P8ItXDMn7SbWIvAdA2
        jJ//DsWYIf0lgNivb1DrZYUMdUwQZ9HWBQQMFyo=
X-Google-Smtp-Source: ABdhPJzDWUTZzgIejgFiMPT654Qf63UiZSEhCxXnuhAeC5uSg4X8Cj9Zq22rf2MkepUJ2arsccp6XODWZCxvBQNojoo=
X-Received: by 2002:a05:6e02:18cd:: with SMTP id s13mr5825662ilu.58.1637083798682;
 Tue, 16 Nov 2021 09:29:58 -0800 (PST)
MIME-Version: 1.0
Sender: residonn000@gmail.com
Received: by 2002:a5d:8988:0:0:0:0:0 with HTTP; Tue, 16 Nov 2021 09:29:58
 -0800 (PST)
From:   "t::" <mnclbrwn@gmail.com>
Date:   Tue, 16 Nov 2021 17:29:58 +0000
X-Google-Sender-Auth: GCZ2mFaBCIq65PyDf_5QaEs-M4Y
Message-ID: <CAA2rHC2LT8nWimZYog6mjYXNDRAhmLap2mC2qfvk8p_4Z-x47A@mail.gmail.com>
Subject: =?UTF-8?B?4LiJ4Lix4LiZ4Lij4Lit4LmD4Lir4LmJ4LiE4Li44LiT4LiV4Lit4Lia4LiC4LmJ4Lit?=
        =?UTF-8?B?4LiE4Lin4Liy4Lih4LmB4Lij4LiB4LiC4Lit4LiH4LiJ4Lix4LiZICwgRG8geW91IHJlYWQgRW5nbGlz?=
        =?UTF-8?B?aCA/?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


