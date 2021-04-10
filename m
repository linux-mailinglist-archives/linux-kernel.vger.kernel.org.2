Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0035AD8B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhDJNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhDJNWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:22:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FB3C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:22:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l14so6812748ljb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=8z6k0nvfMeU4+kk1Rlj4CMcpU7JmVD+ziX5/+jJBhDQ=;
        b=N7GnLitV5N196BCTqGxrqXFzXSdskAuCGsI3KifrK8ySfQOIN7EcZEdAIX/tPf/kA5
         Rkaf0NXtK5kVz2+NxvIU23ibAol/WspYlEmvjv9WAwfORpEaMLNAOkZYmLnPla37BcAO
         IjbsVd7GmPvqZeDP4DUeAQ3EuMmZtHhmipkdXDekPncpLZ7A1Wzi1khMud3XjwmwN8m3
         uYWLjZzhl6FtgD1E0RRn+sa73gQpL9LSvSLlInoUfEHckrcvNwT58MAchntNKhHFQn+3
         A/Zs4aeDxGfWv0TeSjACP3SSTr7C7cqnTbYS1TQAzOJ6T1FNBdwUN1PhIoCeduAjUXOL
         IuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=8z6k0nvfMeU4+kk1Rlj4CMcpU7JmVD+ziX5/+jJBhDQ=;
        b=tIrLsSVDQ5oqE3hQetDNicoSfdz+U9wGivkyxnr2Hs+2m9ewmcg59p8f9PIYcGlWb8
         pp2xgAahIUDEjgvzWEBeXCk4IRYdaJQzxx4XK6NPa1lsxZD7/0XJkAAh+GAGE4zxDMnh
         iDsnbRO4SDW9CJyTKsAIQQ5KJb38qk59qnx8ZiHihX95xKTZmWFWgSqRsQoFCjh02eTU
         zRgBOeOz0DUkJdBH8Cwk29H6lXD9aff2gM9KUqEoBg3u+/hiSgShh1eE5aAFbakJRPkE
         gn/4L2in0M8gb5miwsTOUfRC0p50PU8zN6DdbBvJ3jkhAeJq1DQ4Ww3DSGhw6hWjvo1d
         dZNA==
X-Gm-Message-State: AOAM530NEn6W0szhXfVc3jGTC5cE0suy25rBFyLS0Y0eDuSgwSdwuzkd
        PVj0lvOzkB9rhpac0DOjrDyDYpJGsMwb4NuhIA==
X-Google-Smtp-Source: ABdhPJxeaqqnVniyxjUnOfIUpHBXzBWiC7cXIhXDSioi6j+A7kjk0ywtWutCU8VOSE7mDAMdqiHpxRThORHvVqA0VVE=
X-Received: by 2002:a2e:580c:: with SMTP id m12mr1966023ljb.429.1618060926800;
 Sat, 10 Apr 2021 06:22:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:1211:0:0:0:0:0 with HTTP; Sat, 10 Apr 2021 06:22:05
 -0700 (PDT)
Reply-To: moneygramdepromo@gmail.com
In-Reply-To: <CAP2Ytb=syLK=0ttNTfbczBHYvEcwc-yqEJMxOjAWBVnX8ajKyw@mail.gmail.com>
References: <CAP2Ytb=bdyZG1-Gev7Hmd0Ax_cxRnBdxLtkHLQ_xzkRweVherQ@mail.gmail.com>
 <CAP2YtbnJNHYDDUbnnirr=riHhr5x93gmWLa5HOyDSnjHhYoDXQ@mail.gmail.com>
 <CAP2YtbnxTamMdG+P3xYaN69+DVCEWcsLKLTQBn-tWgjCxAUd=Q@mail.gmail.com>
 <CAP2Ytbm_vLn9oYwQ-+bxyQQC_SiPceG9=grTKKtzMNQ-E+Cacw@mail.gmail.com>
 <CAP2Ytb=vTim3NY1Ce1AHWTPgrE9rdwUfpPrn2RACjeiKRVkDDg@mail.gmail.com>
 <CAP2Ytbk1yYBxO-vq5hYFbrOJGYon+yFQoLqyuq1O5YwA2Qgodw@mail.gmail.com>
 <CAP2YtbmAf1T6ZwvWiLJHkXDYuNLsDd8pbZ3YxyeKHzWKXseCyg@mail.gmail.com>
 <CAP2Ytb=fRYKAwrbsYVaO1j0scBieALu8WF_FQfmvk4cPeNTszQ@mail.gmail.com> <CAP2Ytb=syLK=0ttNTfbczBHYvEcwc-yqEJMxOjAWBVnX8ajKyw@mail.gmail.com>
From:   Alexander Holmes <chineduomor6@gmail.com>
Date:   Sat, 10 Apr 2021 14:22:05 +0100
Message-ID: <CAP2YtbmZtQQbiBN3E_Kg1G-ehqQ8F=WpVekVUg2qfSRjAPFL4g@mail.gmail.com>
Subject: GOOD
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you today?

This is MoneyGram International Inc. we are contacting you concerning
your winning fund $1.500, 000.00 USD; your e-mail won $1.500, 000.00
dollars through Internet contest, and lottery bonus under MoneyGram
International Inc. Worldwide. The lottery bonus is contesting once in
a year, and we are doing it to promote this company MoneyGram
International Inc. The last contest was made through the internet by
people=E2=80=99s email worldwide, for example. USA, CANADA, RUSSIA, EUROPE,
ASIA, AFRICA, UNITED KINGDOM, GERMANY, TOGO, SOUTH AFRICA, UAE,
ETC...........................

We are contacting you because you are among the winning people and
your winning code is [XHMG02639]. We have programmed your daily
transfer payment at the minimum of =E2=82=AC4,500 Euros daily. Therefore yo=
u
are advised to contact branch office Togo, with your complete info,
such as below.

Your surname......................
Your middle name..................
Your name........................
Your home address...............
Your country........................
Your phone number.................
Your occupation/ your work...................
Your passport or Identity Card copy.......................

Kindly contact the MoneyGram Agent Mr. DENIS KODJO, Phone: +228
79541985, via this email ( moneygramdepromo@gmail.com ) to release
your first payment pick up information.

Regards
CEO: W. Alexander Holmes
