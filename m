Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC99369015
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbhDWKJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhDWKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:09:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D7AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 03:09:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z23so8631633lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=j0Yn+fffceoMrdXtrE2qupvSQF7lHbeTvel/pOpEJDE=;
        b=bQCp8iEhZ0hUEEPwPlvH03VXT9P/0BGDHW5Mj5p7SfAKdWPY7mRSH0seGB11iu5Hyy
         nwmdd0ymFrzOrrRza/Kik2Ap3r4Madqxl7C8gQDkNVcZUkc7HW+abULq/1gpP1trg21p
         ny/dbEF/ZlidRAjX8fglVA49u4j0NqC5TyAKGSe37Bmr9E9L7UVzXr6u5szEgKH6yn10
         i/BVNn6X+fbZbnUyBY5Jzl+PSbaBWh4ZQAo9nIwApylcpRd36FZC0s4lnoofphRZglAP
         ATrjok379ctmp9FTzYS7qckbRz6MX54UySb/H51iaBUGqpLNK6I/w0q3z/3qXcj/5n8a
         T4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=j0Yn+fffceoMrdXtrE2qupvSQF7lHbeTvel/pOpEJDE=;
        b=nzQ5LnOC/be4Bjyv/q/fUA+gcGhqILnkLrqCk6FvD0PBTdruuPkxPLHqZJxExLEoCA
         EM6jfZLddR6QS7NDAyawIJpeXbnIYoF+BtllnD5wl/7lXHRFFAcl+58wZs6oIgvC1DhO
         KwJKzkbSbjAYAOou0SIFPMefsqXOE/yh8jWAO+vAVAP8VYbgIXKqUdUus17wMgAtUlT7
         ap0hLNWNfj7VYgvMHVXhzYQjintItsrrsalBni67bMZB0t8o0Hki4De2uBZP5XLTbrvi
         nNlUp7QQfMsvbVSZ/pCsH3keQhneb7JdQ6nUpLzABv8gtmm11aMnwPFxH6VZj1mApy5H
         gKAg==
X-Gm-Message-State: AOAM532j96qQPwlBQMNat/eQ/s/FrBFLFNXwFBgBqb/Do2qZbDZ+Dszo
        2TJBsYfAtsxO2QfgDE9APMjnmtrr5A4lJrY+ZF0=
X-Google-Smtp-Source: ABdhPJxert5b8fhrU7vUSkpN4xePGPJRhcc+ghd0P++yRwrVMpN//8DhTkGIE1FEnLyGVv46fbwmXPC89i00PbKtbok=
X-Received: by 2002:a05:651c:604:: with SMTP id k4mr2227610lje.254.1619172555755;
 Fri, 23 Apr 2021 03:09:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:555:0:0:0:0 with HTTP; Fri, 23 Apr 2021 03:09:15
 -0700 (PDT)
Reply-To: georgemike7031@gmail.com
From:   george mike <brichardjohnson02@gmail.com>
Date:   Fri, 23 Apr 2021 12:09:15 +0200
Message-ID: <CAOZWaH8iD3=5uodBG2BGEZ--W31K_-j4VSekddemt9yyFdx5UQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16nXnNeV150NCg0K16nXnteZINeSJ9eV16jXkiAn157XmdeZ16cg15DXoNeZINei15XXqNeaINeT
15nXnyDXkdee16fXpteV16LXmS4g15DXoNeZINeo15XXpteUINec15TXpteZ16Ig15zXmg0K16fX
qNeV15Eg15TXntep16TXl9eUINec15zXp9eV15cg16nXnNeZLiDXqteZ16jXqSDXkNeqINeU16HX
m9eV150g16nXnCAoOC41INee15nXnNeZ15XXnyDXk9eV15zXqCkNCteT15XXnNeo15nXnSDXqdeU
15zXp9eV15cg16nXnNeZINeU16nXkNeZ16gg15HXkdeg16cg15zXpNeg15kg157Xldeq15UuDQoN
CteU15zXp9eV15cg16nXnNeZINeU15XXkCDXkNeW16jXlyDXkdee15PXmdeg16rXmiDXqdee16og
15HXqteQ15XXoNeqINeT16jXm9eZ150g16LXnSDXkNep16rXlQ0K15XXlNeR158g15TXmdeX15nX
ky4g15DXoNeZINeQ15TXmdeUINeW15vXkNeZINei150gNTAlINee16HXmiDXlNen16jXnyDXldeQ
15nXnNeVIDUwJSDXmdeU15nXlA0K15zXlNeZ15XXqiDXkdep15HXmdec15ouDQrXkNeg15Ag16bX
qNeVINen16nXqCDXotedINeU157XmdeZ15wg15TXpNeo15jXmSDXqdec15kg15vXkNefINec16TX
qNeY15nXnSDXoNeV16HXpNeZ1506IGdlb3JnZW1pa2U3MDMxQGdtYWlsLmNvbQ0KDQrXqNeRINeq
15XXk9eV16og157XqNeQ16ksDQrXnteoINeSJ9eV16jXkiAn157XmdeZ16csDQo=
