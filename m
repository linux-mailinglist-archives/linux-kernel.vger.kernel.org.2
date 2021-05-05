Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC6373CAA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhEENsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232671AbhEENsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620222470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y66UDdCQVyt6iTD3be2pNfjrnjlN1nlgdtRgR8WWsZk=;
        b=EEz2WFJ/t91suY0PGU04xtescAbSj62ELoYOhW4wWN96wL4C1ek0PBGXwchJSzEj8eoFaR
        KICBkW+dACBQJ6EZlSgniXtBBZ5JSukOsCQscxVP7WRkZHtSlK3XWLQMgKOaIVrpFnvVSs
        JLCL8fgNOBRpJejMIBbjwY6XX0nkTaM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-nh-c7lL-PgeNjSVUqGEFcA-1; Wed, 05 May 2021 09:47:48 -0400
X-MC-Unique: nh-c7lL-PgeNjSVUqGEFcA-1
Received: by mail-pf1-f197.google.com with SMTP id o129-20020a6292870000b0290241fe341603so1450774pfd.14
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y66UDdCQVyt6iTD3be2pNfjrnjlN1nlgdtRgR8WWsZk=;
        b=s+2ZHOPRf68VFFrtagedGms/U/qaI5mWbrTM+PM6RxYGuFDAIV0Y7r6dJmYZTljeOV
         SzV2V96Ap9BzxNyIjqDquGY9Sb/0O1LGB/rpEBbOg73SP/m82Ua8B/naEXS98NWgOTSo
         TVNwwGE+FhefBXNg2vfh8g1MO1OXlN3UVr42Y37+VRCs5qpEyHZBYoGXC9dmp/jhjRdc
         0KQka6Ife/Tp9yUpjfitbxhPn18zxFiJawEmFiShs6BmJrjEPKYzSwDYz8dQMFNSEywA
         Imaz0mI6F6/GKIYWnE5bNHJsox71MvNXFkrrqUxInesqotMP11jvyrMd8nL/lAOCqzJ/
         qnEg==
X-Gm-Message-State: AOAM5332iI6U8bWtgkjDVbKqcgGvCeBTy6KbdWQADlrO96CpmK9Lvjcp
        7PL6H9F/f+GHRFW49Rq4bSr2I7whJmNpV3XtvwrAyFoeG/1gNiiEhkP1Hjd1C88GFmg+g0E4BT1
        ZbKSlHPPO/nxzt7b4fDzgM7dpBBymANy6YEGoQYoM
X-Received: by 2002:a62:bd13:0:b029:25c:5ec4:c2f3 with SMTP id a19-20020a62bd130000b029025c5ec4c2f3mr28336997pff.35.1620222467041;
        Wed, 05 May 2021 06:47:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHQnlOigptQ6V8Tb5EPxmwXRqyApalxmcQXnnohdiel63N8xCKjxPUmXIlS3n8uNtO7Mq3xZvHCoCynHhq2LY=
X-Received: by 2002:a62:bd13:0:b029:25c:5ec4:c2f3 with SMTP id
 a19-20020a62bd130000b029025c5ec4c2f3mr28336975pff.35.1620222466853; Wed, 05
 May 2021 06:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210425173353.10231-1-mail@anirudhrb.com> <nycvar.YFH.7.76.2105051442120.28378@cbobk.fhfr.pm>
 <CAO-hwJJ4u5NZ-81Tq3PGu-F9r3iUSCiKp=JUsTfuVsyd-Sxsew@mail.gmail.com> <nycvar.YFH.7.76.2105051528090.28378@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2105051528090.28378@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 5 May 2021 15:47:36 +0200
Message-ID: <CAO-hwJJKyLT4iG4DEhXGREPLVU8UASB8_gOFULmQ7hx2dYG7uw@mail.gmail.com>
Subject: Re: [PATCH] usbhid: fix info leak in hid_submit_ctrl
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+7c2bb71996f95a82524c@syzkaller.appspotmail.com,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 3:28 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Wed, 5 May 2021, Benjamin Tissoires wrote:
>
> > I don't have a reproducer like syzbot has for the exact bug here, as I
> > am relying on one real USB device to check if usbhid is not too broken.
> > However, the test suite should catch if there is an error implied by the
> > hid_report_len() change.
>
> Yes, that was exactly what I wanted to check, sorry for not being verbose
> enough :)
>
> > Anyway, I manually started the job and will report when it is done.
>

Heh, no problems.

"Job succeeded" \o/

Given that you are on a spree:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

