Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5173B4CC9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 07:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFZFQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 01:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFZFQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 01:16:16 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E41DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 22:13:53 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id f20so8385410qtk.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 22:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oL0VWeLcL1HKgqvlMASPMbo6J1fwR3ScwXjOaAm+RJM=;
        b=Ep8Zr5M/eX40xXMOI+LxzKZaNbBBb69UiLn0UOCEGf1Bcgvj5Z7UNtKWIcG82Cn2Lx
         8LxqVfuTnqMqyZO1UZfYQ1f7F0EreRQ5eUDzoIR/ArwnT41sZe4dJp6bO6/3ZIucfpc9
         XlXHtbjsxkDsfQBS8go1tVjRi0BuY+QrJFTMCLjGqZr9zEy9vNFb2nK6Fm8vdYNelMsq
         m5OfReBInuSUY23NR5DiJYKkEiKQVq9X1H9KfyF/bSluGLAhX666s4PxKdESIptAJS/1
         CETHOPnH5DlNhLU5tIH7Rkr1Xp0ZYo2WuSal5WlPOg6uvkMCg4dD2deNpU5jreS8xcxm
         iZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=oL0VWeLcL1HKgqvlMASPMbo6J1fwR3ScwXjOaAm+RJM=;
        b=uXDID635PTPflH8N9rMSd2M797jAjxYB4dkgPGYVtM4UQLr7YlUsqEk+FB8ah21R8v
         R68jaUF33d6sVYKr3SL0z4gE59Vvy+x0L0zGEsSHI2dG9vbO/DtuJk0RoUa6R5l9Rkby
         SbhIWr76CjzyoigjiMl5W88wLOuwBDRCfAu+4kBT4e8qNMvAmY+9oVkKJrqZWI2DnQfu
         aa6lWPv691Fzmi0rXevpBsOUdVkQKYePCmGtyXGUbvGAdAwh0cvt8Jy86SXnGHLnu7BL
         vT+bWsunqjN4j0VSQ6Xa1FSZv/KK5tUCfIrTtQpkFpk/BMKWU4liGGqJAKC7sDBIn8sh
         ag7A==
X-Gm-Message-State: AOAM530jWEHjFL+6alr99ViUwXDGpKAlxCpCAz1WBxBBrPJAhuyMGNVW
        yyQKhIHFaYiR9ptIXzRGb+ZZ/DqQkAhLmFTyDZA=
X-Google-Smtp-Source: ABdhPJwhh5a7ugRrwpgV/LvChRwg4owZwDnA+UB29iU2ipbYcywJ0bAJFmH/vUN7qHX3L/c1JCuDANp0ez+dX11ZVtg=
X-Received: by 2002:ac8:604:: with SMTP id d4mr12604971qth.304.1624684431223;
 Fri, 25 Jun 2021 22:13:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7b2c:0:0:0:0:0 with HTTP; Fri, 25 Jun 2021 22:13:50
 -0700 (PDT)
Reply-To: borowskishirley@yahoo.com
From:   Borowski shirley <morousokode1@gmail.com>
Date:   Sat, 26 Jun 2021 06:13:50 +0100
Message-ID: <CAH+1UrNqLoqSSSo47ROY9CPF_E3pAvPL0075912NWZfzyOr7RA@mail.gmail.com>
Subject: =?UTF-8?B?0LTQtdC90Yw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JTQvtCx0YDRi9C5INC00LXQvdGMDQrQryDQsdCw0YDRgNC40YHRgtC10YAg0JHQvtGA0L7QstGB
0LrQuCDQqNC40YDQu9C4LiDQryDRgdCy0Y/Qt9Cw0LvRgdGPINGBINCy0LDQvNC4INC/0L4g0Y3R
gtC+0LzRgyDQv9C+0LLQvtC00YMuDQrRhNC+0L3QtCAkIDgsNSDQvNC40LvQu9C40L7QvdCwINC0
0L7Qu9C70LDRgNC+0LIsINC00LXQv9C+0L3QuNGA0L7QstCw0L3QvdGL0YUg0LIg0LHQsNC90LrQ
tSDQt9C00LXRgdGMINC80L7QuNC8DQrQv9C+0LrQvtC50L3Ri9C8INC60LvQuNC10L3RgtC+0LwN
CtC60L7RgtC+0YDRi9C1INC90L7RgdGP0YIg0YLQviDQttC1INC40LzRjyDRgSDQstCw0LzQuC4g
0L7RgtCy0LXRgtGM0YLQtSwg0YfRgtC+0LHRiyDRg9C30L3QsNGC0Ywg0L/QvtC00YDQvtCx0L3Q
vtGB0YLQuCwNCtCh0L/QsNGB0LjQsdC+INCy0LDQvCwNCtCR0LDRgNGA0LjRgdGC0LXRgCDQkdC+
0YDQvtCy0YHQutC4INCo0LjRgNC70LguDQpib3Jvd3NraXNoaXJsZXlAeWFob28uY29tDQo=
