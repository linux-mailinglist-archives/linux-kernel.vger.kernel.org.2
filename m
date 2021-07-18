Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D093CC86A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 12:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhGRKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhGRKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 06:25:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDB0C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:21:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso10333335pjp.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=gIYZ2TqaU3k+Tbd+EUTs1u9DXqn1uwzGvQu7DMTFzevgdKjzG9snWPBsF7XQXGiNLa
         gVvvis3y3FEQ9zc8PqrC7uNvWbBZ/akTosGzlXb1pJy4FgFGYTSUzeOEYELTDPSmDHVw
         yLfxwqFNh8dI4Xe5kJeJZTDIAwYO+3rkRc81SR99zS8CcI5wO1rMP0Oa3/dAVIJIy5HV
         F5cMcHmPkCVz/U8f++MXsPm5SuUtFCVBTpzppSbSpkIx2UJlVC4oBhw6ahfWZzRMO84J
         H/wh/KgMa+vJEK9cEQ8indRWoeH1bvxCHdoEmuQ7+oaIwpxz7exe4KVViowRHUiKX2MD
         4p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=nufrcmXLxCUH121VHV6VKKNcv4H91PTR0ydQ6S1KC0+hDGsq/Kvgi2urEkSaX4ZHvE
         UEI2t6GDnR+ZRGuRSHFUxzmeA2JfOOcsaZyCRyEfJqvb3/ROwaDPEO0/RNSV3+IVwK3Z
         +UWoak49uJxkQJCSDbKZSWFVl2XAIxGScXUlT1fc9mms9iqbD2gUjUbezv+z02iS0Ey5
         qws2JLYe2Op2g6zxPY+ChDMDJIP/3rkkdSh25vruu25QtCPDko9jXWurHFRSG4nZ+BW1
         X7kLsPaDlVoT9H3yR2nnPEboa3ObrVVFB6RgGSPnv1QyEHy30VB+yi8B1mcy2FYauODP
         tXUA==
X-Gm-Message-State: AOAM533rcduEJy/PnAVm1WG2XBwgPOU7uRSBE60nUcLCgZVyF1oj2uQS
        2BpfOaATwdTo4iDtw3a3NU7yoNdW6rr4TlKkjuc=
X-Google-Smtp-Source: ABdhPJy+YL4/42NKScALK2XlvNPXz1Ce4YPbeGwzjGTSCxFjxzcb2NiCeKcQO8byqNAUlbTs6hpqZs13XYA/YVWNqxI=
X-Received: by 2002:a17:90a:f198:: with SMTP id bv24mr18984932pjb.171.1626603716285;
 Sun, 18 Jul 2021 03:21:56 -0700 (PDT)
MIME-Version: 1.0
Sender: diattaalbertsandimon@gmail.com
Received: by 2002:a05:6a10:82b7:0:0:0:0 with HTTP; Sun, 18 Jul 2021 03:21:55
 -0700 (PDT)
In-Reply-To: <CAHg8jJSOqm0Y+e0UnVYdZytR4rjdHWDttWHx5hz=_W9d2stK3g@mail.gmail.com>
References: <CAHg8jJSOqm0Y+e0UnVYdZytR4rjdHWDttWHx5hz=_W9d2stK3g@mail.gmail.com>
From:   zahra omar <hassanomarzahra@gmail.com>
Date:   Sun, 18 Jul 2021 11:21:55 +0100
X-Google-Sender-Auth: Rz63-uG6Fw0_1qZMRxYzK4hN0kU
Message-ID: <CAHg8jJQBXnEUn5WstBDCpPWjeQ6vGd1wWQ7Y-4eEfz=5kZCViA@mail.gmail.com>
Subject: Re: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


