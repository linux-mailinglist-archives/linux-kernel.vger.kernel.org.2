Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D030739C940
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 16:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFEOyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 10:54:05 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:38519 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhFEOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 10:54:04 -0400
Received: by mail-ua1-f53.google.com with SMTP id d13so6273047uav.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EaYMRz5FnMODqFyqdlRK0aeJzGq0sU+8h7rdTmyh4FI=;
        b=OnLDaNMeg+Jz5REkQr9/Veu+4UVm+yAQAcq935Z1UmoEeCG94DnXjE4xEFtyQvNPln
         pcTDLgySGaaUode2vpolq8a58/KcOgXYZFeDQCy3KBRXPdRwUdxkkT8PI0pAFrggTJkR
         jStRMBOW5G4vs75HpdwRW6qUskE9dAYC0i5BB6AHLlfSFM3kjp1EqEr9zp4LBtkZ8+7z
         LgkxaK6SsB4eo1xG0JPzOZvFyZt/TL+LZXWvgJOhWbB42zFD2i0xOBvqyKfDLxvj1NaV
         tSH7AVn2Kzpzr+CjDSJXSkfdtNX+b/i9xB+BhFhoBHfblvSCA5yDxF0Cl63yPaFBMosx
         GdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EaYMRz5FnMODqFyqdlRK0aeJzGq0sU+8h7rdTmyh4FI=;
        b=rFpdxBICT8fNSUj+OwznklWB5RSHML77K6JLWziWizdNCYuOXC4D2EjlwD4e/zEBZy
         vGDTOkKM88Jj08aynIJcOWAgHVSfJzqHbE7czs3h/xS2cLI03IX+Mrzabc/zrBvJ4bRi
         LHG2pQFsMRh9K5axfzlixWanLxHZLTHOQx1Q4hz2wGLtyzu8zS7sASmZpo6ZkLQiTozx
         qBw7KMh7wYcPccfLjoM7lemOaH848PfCq16pHrB/DgZAIBGY+uM7tjqexWLDxIZVzwmf
         zTEDGU9yfi9QjH1dNRQIhLyWFsCnWV6CQ4/+eUN06NW4zYlVTsjJ/KOL1kdWwGUpsxTf
         xI7w==
X-Gm-Message-State: AOAM5316URyDvwdTUK/Lzan3mVohsrGr6u4i0QWmdI1RB9z6NhkJ9wD3
        8WS+OjHJwKKe7Vjn7j5PwW8lGSLNKOvVp0YpxsiCNY7B1LXjcw==
X-Google-Smtp-Source: ABdhPJxR+RZZiKqyMSS5ZrW0TyrriuzYpeu3BcY0o581d89sWGIvLZmNDSxpDSdS33OiMDbdZQX1DD8KCCcjAT6Us+4=
X-Received: by 2002:a1f:a681:: with SMTP id p123mr5234215vke.22.1622904665047;
 Sat, 05 Jun 2021 07:51:05 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Sat, 5 Jun 2021 08:50:39 -0600
Message-ID: <CAJfuBxxo5hQLK36J1yL2MV3Zkfdnk=OmGh6Fms1adjB0GWULqA@mail.gmail.com>
Subject: how to return a chunk of kernel .data to free mem ?
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jason Baron <jbaron@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have convinced DYNAMIC_DEBUG code to not need
about 15% of its __dyndbg section, about 30kb on my test kernel.

This memory is not kmalloc'd, so krealloc wont work.
(I tried anyway, on a loaded module, it panicd)

Is there a way to return a chunk of init .data memory to general use ?

heres the patchset;
https://lore.kernel.org/lkml/20210529200029.205306-1-jim.cromie@gmail.com/
